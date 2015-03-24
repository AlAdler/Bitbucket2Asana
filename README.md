#Bitbucket2Asana

##Push your commits to Bitbucket and automatically create comments in Asana tasks.

When you commit some code, put somewhere in the commit comment a # followed by the Asana task id or the complete Asana task URL. For example: git commit -m "fixed ugly bug #12345678". Or git commit -m "fixed ugly bug https://app.asana.com/123123/0/12345678" Your commit will appear in the task as a comment when you push it.
The task id in Asana is the last part of the URL in the Asana web app.

