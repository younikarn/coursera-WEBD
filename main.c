#include <stdio.h>
#define N 5
int deque[N];
int front=-1;
int rear=-1;
void enqueatfront(int x)
{
    if((rear+1)%N==front)
    {
        printf("The queue is full.\n");
    }
    else if(front==-1 && rear==-1)
    {
        front=rear=0;
        deque[front]=x;
    }
    else if(front==0)
    {
        front=N-1;
        deque[front]=x;
    }
    else
    {
        front--;
        deque[front]=x;
    }
}
void enqueatrear(int x)
{
  if((rear+1)%N==front)
  {
      printf("The queue is full.\n");
  }
  else if(front==-1 && rear==-1)
  {
      front=rear=0;
      deque[rear]=x;
  }
  else if(rear==N-1)
  {
      rear=0;
      deque[rear]=x;
  }
  else
  {
      rear++;
      deque[rear]=x;
  }
}
void display()
{
    int i=front;
    if(front==-1 && rear==-1)
    {
        printf("The queue is empty.\n");
    }
    else
    {
        while(i!=rear)
    {
        printf("%d", deque[i]);
        i=(i+1)%N;
    }
    printf("%d\n", deque[rear]);
    }}
    void getfront()
    {
        if(front==-1 && rear==-1)
        {
            printf("The queue is empty.\n");
        }
        else
        printf("%d", deque[front]);
    }
    void getrear()
    {
        if(front==-1 && rear==-1)
        {
            printf("The queue is empty.\n");
        }
        else
            printf("%d", deque[rear]);
    }
    void dequeatfront()
    {
        if(front==-1 && rear==-1)
        {
           printf("The queue is empty.\n");
        }
        else if(front==rear)
        {
            printf("dequed element is %d.", deque[rear]);
            front=rear=-1;
        }
        else if(front==N-1)
        {
            printf("%d is the dequed element.\n", deque[front]);
            front=0;
        }
        else
        {
            printf("%d is the dequed element.\n", deque[front]);
            front++;
        }

    }
    void dequeatrear()
    {
        if(front==-1 && rear==-1)
        {
            printf("The queue is empty.\n");
        }
        else if(front==rear)
        {
            printf("dequed element is %d.", deque[rear]);
            front=rear=-1;
        }
        else if(rear==0)
        {
           printf("%d is the dequed element.\n", deque[rear]);
           rear=N-1;
        }
        else
        {
           printf("%d is the dequed element.\n", deque[rear]);
           rear--;
        }
    }
    int main()
    {
      enqueatfront(2);
      display();
      enqueatfront(5);
      display();
      enqueatrear(-1);
      display();
      enqueatrear(0);
      display();
      enqueatfront(7);
      display();
      enqueatfront(4);
      display();
      dequeatfront();
      display();
      dequeatrear();
      display();
      dequeatfront();
      display();
      return 0;
    }




