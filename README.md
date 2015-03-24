Vaultize Dockerfile collection
=====


Basic initial model
---
<pre>
Base CentOS Image (Factory image)  
	|  
	|  
	 \  
      \____ Common Base Image (Vaultize Appliance, contains imp tools, libs, etc.)  
				|  
				|                        
				|\____ Nginx Image -\----> UI handler  
				|                    \---> API handler  
				|                     \--> EventHub handler   
				|  
				|\____ MongoDB Image  
				|  
				|  
				 \____ Codebase Image  
  

</pre>

	
