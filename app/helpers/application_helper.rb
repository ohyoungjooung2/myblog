module ApplicationHelper
 #Create a submit button with the vgiven name with a cancel link
 #Accepts two arguments: Form object and the cancel link name
 def admin?
   current_user.admin?
 end



 def submit_or_cancel(form,name='Cancel')
    form.submit + " or " +
         link_to(name,'javascript:history.go(-1);',:remote => true,:class => 'Cancel')
 end

 def vacant
   "No articles created"
 end

 def home_category_provide_title
   if request.original_fullpath == "/"
      provide(:title,"Home")
   else
      provide(:title, request.original_fullpath().split("/").last)
   end
 end

 #Category name from request.original_fullpath().split("/").last method
 def c_name
    name=request.original_fullpath().split("/").last
    if name == nil
       "." 
    else
       return " on #{name}."
    end 
 end

end
