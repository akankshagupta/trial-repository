trigger PtoException on Schedule__c (before insert, before update) {
	for (Schedule__c schedule : Trigger.NEW) {
		Id trainerId = schedule.Trainer__c;
		Date trainingDate = schedule.Training_Date__c;
		List<PTO__c> ptoList = [select PTO_Start_Date__c, PTO_End_Date__c from
		PTO__c where Practitioner__c = :trainerId];
		for (PTO__c pto : ptoList) {
			if (
				pto.PTO_Start_Date__c <= trainingDate &&
				trainingDate <= pto.PTO_End_Date__c) {
				schedule.addError('Trainer is Unavailable');	
			}
		}
	}
}