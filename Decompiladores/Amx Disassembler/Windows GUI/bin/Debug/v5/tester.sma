
#include default

new str[] = "test multid arrays"

new ver[] = "2.6.0"

new myarray[2][2][2] = 
{
	{
 		{ 0xaa , ... } ,
 		{ 0xbb , ... }
  	}
  	, 
  	{
  		{ 0xcc , ... },
  		{ 0xdd , ... }
  	}
}

main()
{
	str[0]='a'
	ver[0]='b'
	myarray[0][0][0]=1
	//printf("hello")
}