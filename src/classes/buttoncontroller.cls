public class buttoncontroller
{
public pagereference gototmerge(){
       // String leadpage = '/lead/leadmergewizard.jsp?goNext=+Next+&cid='+accrecordid +'&cid=' +idstr1 + '&cid=' +idstr2;    
        PageReference CDHSearchPage1 = new PageReference('https://www.google.co.in');
        CDHSearchPage1.setRedirect(true);
        return CDHSearchPage1;
    }

}