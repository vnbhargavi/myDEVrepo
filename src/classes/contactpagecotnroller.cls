Public class contactpagecotnroller{

    public String cnlist { get; set; }

    public String cotactlist { get; set; }

public list<Contact> cotactlist()
{
list<Contact> cntctlist = [select id,phone,name from contact where phone!=null];
return cntctlist;

}



}