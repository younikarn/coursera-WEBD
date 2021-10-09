#include<iostream>
using namespace std;
struct ds
{
    int num;
    ds *prev;
    ds *next;
};
ds *head=NULL;
ds *temp;
void add_new_node()
{
    cout<<"Enter the value"<<endl;
    if(head==NULL)
    {
        ds* new_node = new ds;
        cin>>new_node->num;
        head=new_node;
        temp=head;
        temp->prev=NULL;
        temp->next=NULL;
    }
    else
    {
        ds *new_node = new ds;
        cin>>new_node->num;
        temp->next=new_node;
        new_node->prev=temp;
        temp=new_node;
        temp->next=NULL;
    }
}
void insert_node(int count)
{
    unsigned int position;
    int b=count+1;
    cout<<"Enter the position you want to enter"<<endl;
    cin>>position;
    cout<<"Enter the value"<<endl;
    ds *temp3= new ds;
    ds *temp2=head;
    cin>>temp3->num;
    int d=b/2;
    if(position>b)
    {
        cout<<"Please enter valid position"<<endl;
    }
    else if(position==1)
    {
        temp3->next=temp2;
        temp2->prev=temp3;
        temp3->prev=NULL;
        head=temp3;
    }
    else if(position==b)
    {
        temp->next=temp3;
        temp3->prev=temp;
        temp3->next=NULL;
        temp=temp3;
    }
    else if(position<=d)
    {
        for(int i=1;i<(position-1);i++)
       {
         temp2=temp2->next;
       }
       ds *temp4=temp2->next;
       temp2->next=temp3;
       temp3->prev=temp2;
       temp3->next=temp4;
       temp4->prev=temp3;
    }
    else
    {
        position=count+2-position;
        ds *temp4=temp;
        temp2=temp;
        for(int i=1;i<(position-1);i++)
        {
            temp2=temp2->prev;
        }
        temp4=temp2->prev;
        temp4->next=temp3;
        temp3->prev=temp4;
        temp3->next=temp2;
        temp2->prev=temp3;
    }
}
void display(int count)
{
    ds *temp2=head;
    if(temp2==NULL)
    {
        cout<<"There is no data to be displayed"<<endl;
    }
    else
    {
        for(int i=0;i<count;i++)
        {
            cout<<temp2->num<<endl;
            temp2=temp2->next;
        }
    }
}
void delete_node(int count)
{
    int position;
    cout<<"Enter the position of the node you want to delete"<<endl;
    cin>>position;
    ds *temp2;
    int b=(count+1)/2;
    if(position>count || head==NULL)
    {
        cout<<"Invalid entry"<<endl;
        return;

    }
    else if(position==1)
    {
        temp2=head;
        head=temp2->next;
        delete temp2;
        head->prev=NULL;
        return;
    }
    else if(position==count)
    {
        temp2=temp;
        temp=temp2->prev;
        delete temp2;
        temp->next=NULL;
    }
    else if(position<=b)
    {
        temp2=head;
        for(int i=1;i<(position-1);i++)
         {
         temp2=temp2->next;
         }
        ds *temp3=temp2->next;
        ds *temp4=temp3->next;
        temp2->next=temp4;
        temp4->prev=temp2;
        delete temp3;
    }
    else
    {
        position=count-position;
        temp2=temp;
        for(int i=1;i<position;i++)
        {
            temp2=temp2->prev;
        }
        ds *temp3=temp2->prev;
        ds *temp4=temp3->prev;
        temp2->prev=temp4;
        temp4->next=temp2;
        delete temp3;
    }
}
void reverse_list()
{
    ds *temp4=NULL;
    ds *temp5=head;
    while(temp5!=NULL)
    {
        temp4=temp5->next;
        temp5->next=temp5->prev;
        temp5->prev=temp4;
        temp5=temp4;
    }
    temp5=head;
    head=temp;
    temp=temp5;
}
int main()
{
    add_new_node();
    int count=1;
    int a=0;
    //cout<<"a";
    while(a!=5)
 {
    cout<<"Enter 1 if you want to add new element"<<endl;
    cout<<"Enter 2 if you want to delete any element"<<endl;
    cout<<"Enter 3 if you want to enter element at any position"<<endl;
    cout<<"Enter 4 if you want to display all the elements"<<endl;
    cout<<"Enter 5 if you want to quit"<<endl;
    cout<<"Enter 6 if you want to reverse the list"<<endl;
    cin>>a;
    switch (a)
    {
        case 1:
               add_new_node();
               count++;
               break;
        case 2:
               delete_node(count);
               count--;
               break;
        case 3:
               insert_node(count);
               count++;
               break;
        case 4:
               display(count);
               //cout<<"Reached here";
               break;
        case 5:
               break;
        case 6:
               reverse_list();
               break;
        default:
               cout<<"Invalid entry"<<endl;
    }
 }
 cout<<"The total no. of nodes are "<<count<<endl;
}
