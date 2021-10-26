#include <bits/stdc++.h>
using namespace std;
//doubly linked list node
struct Node {
   int info;
   int priority;
   struct Node *prev, *next;
};
//inserting a new Node
void push(Node** fr, Node** rr, int n, int p) {
   Node* news = (Node*)malloc(sizeof(Node));
   news->info = n;
   news->priority = p;
   // if the linked list is empty
   if (*fr == NULL) {
      *fr = news;
      *rr = news;
      news->next = NULL;
   } else {
      // If p is less than or equal front
      // node's priority, then insert the node
      // at front.
      if (p <= (*fr)->priority) {
         news->next = *fr;
         (*fr)->prev = news->next;
         *fr = news;
      } else if (p > (*rr)->priority) {
         news->next = NULL;
         (*rr)->next = news;
         news->prev = (*rr)->next;
         *rr = news;
      } else {
         // Finding the position where we need to
         // insert the new node.
         Node* start = (*fr)->next;
         while (start->priority > p)
         start = start->next;
         (start->prev)->next = news;
         news->next = start->prev;
         news->prev = (start->prev)->next;
         start->prev = news->next;
      }
   }
}
//the last value
int peek(Node *fr) {
   return fr->info;
}
bool isEmpty(Node *fr) {
   return (fr == NULL);
}
int pop(Node** fr, Node** rr) {
   Node* temp = *fr;
   int res = temp->info;
   (*fr) = (*fr)->next;
   free(temp);
   if (*fr == NULL)
   *rr = NULL;
   return res;
}
// main function
int main() {
   Node *front = NULL, *rear = NULL;
   push(&front, &rear, 4, 3);
   push(&front, &rear, 3, 2);
   push(&front, &rear, 5, 2);
   push(&front, &rear, 5, 7);
   push(&front, &rear, 2, 6);
   push(&front, &rear, 1, 4);
   printf("%d\n", pop(&front, &rear));
   printf("%d\n", peek(front));
   return 0;
}
