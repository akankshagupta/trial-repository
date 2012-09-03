trigger LimitSessions on Schedule__c (before insert) {
	//This trigger is to limit the sessions to maximum of three.
	List<Schedule__c> sch=new List<Schedule__c>();
	Set<Id> newschedules=new Set<Id>();
	sch=Trigger.new;
	
	Map<Id,Practitioner__c> mapOfTrainerIdandSchedule=new Map<Id,Practitioner__c>([Select  Id, (Select Id,  Name, Training_Name__c,Trainer__c From Schedules__r) From Practitioner__c ]);
	system.debug('MAP DEBUG'+mapOfTrainerIdandSchedule);
   
    	for(Schedule__c s:sch){
		Practitioner__c prac=mapOfTrainerIdandSchedule.get(s.Trainer__c);
		List<Schedule__c>lstschedules=prac.Schedules__r;
		System.debug('$$$$$$'+lstschedules);
		if(lstschedules.size()>=3){
			s.Trainer__c.adderror('The Trainer has already been assigned Three Sessions');
		}	
	}
    
}