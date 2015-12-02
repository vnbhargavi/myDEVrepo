public class My1Controller {



    public Account getAccount() {

        return [SELECT id, name FROM Account

                WHERE id = :ApexPages.currentPage().getParameters().get('id')];

    }



}