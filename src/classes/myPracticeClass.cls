public class myPracticeClass {

public string oput;
    public String getOput() {
        return oput;
    }


    


   /* public List < Contact > conlist {
        get;
        set;
    }
    public List < wrapperclas > wrapList {
        get;
        set;
    }
    public myPracticeClass(ApexPages.StandardController controller) {
     wrapList = new List < wrapperclas > ();
        system.debug('@@@@' + Apexpages.currentpage().getparameters().get('id'));
        for (Contact convar: [select id, lastname, firstname from Contact where accountid = : Apexpages.currentpage().getparameters().get('id')]) {
            wrapList.add(new wrapperclas(convar));
            system.debug('@@@'+wrapList);
        }

    }

   

    public void getseleecteed() {

        List < contact > selectedAccount = new List < Contact > ();
        system.debug('@@@'+wrapList);
        for (wrapperclas wrapObj: wrapList) {
            if (wrapObj.isselected == true) {
                selectedAccount.add(wrapObj.conObj);
            }
        }

    }*/
    
    public myPracticeClass(){
        
        oput = 'test1';
    }
    public void setoput()
    {
        oput= 'test2';    
    }
 /*   public class wrapperclas {

        public contact conObj {
            get;
            set;
        }
        public boolean isselected {
            get;
            set;
        }

        public wrapperclas(contact conObj) {

            this.conObj = conObj;
            this.isselected = false;

        }
    }*/

}