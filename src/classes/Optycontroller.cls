public class Optycontroller{

public set<id> optyIds= new set<id>();
public boolean isselected{get;set;}
public list<wrapperOpty> wrapList = new list<wrapperOpty>();
public list<wrapperOpty> wrapList1 = new list<wrapperOpty>();
public list<Quote> quoteList = new list<Quote>();
public boolean listsize{get;set;}
public Optycontroller()
{}
public List<wrapperOpty> getOptyList()
{
List<Opportunity> optylist = [select id,name,StageName from Opportunity limit 10];
for(Opportunity oppObj : optyList)
{
wrapList.add(new wrapperOpty(oppObj));
optyIds.add(oppObj.id);
}
system.debug('@@'+optyIds);
return wrapList;
}
public pagereference QuoteList()
{
listsize = false;
//if(isselected== true){

if(quotelist.size()>0){
listsize = true;
for(Quote quoteOb: quoteList)
{
wrapList1.add(new wrapperOpty(quoteOb));
}
}
//}
system.debug('###'+quoteList);
return null;
}
public list<Quote> getretQotelist()
{
quoteList = [select id,name,Opportunityid from quote where id in : optyIds]; 
return quotelist;
}
public class wrapperOpty{

public boolean isselected{get;set;}
public Opportunity optyObj{get;set;}
public quote quotewrapObj{get;set;}

public wrapperOpty(Opportunity OpObj)
{
isselected = false;
optyObj = OpObj;
}
public wrapperOpty(quote quotObj)
{

quotewrapObj = quotObj;
}
}
}