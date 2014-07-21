# Sinatra CRUD Reference

This is a reference app for CRUD applications with Sinatra

## Routes

1. GET /trees/new - get the new tree form
1. POST /trees - create a new tree
1. GET /trees/:id/edit - get the edit tree form
1. PATCH /trees/:id - update a tree
1. DELETE /trees/:id - delete a tree

## Method Overriding

HTML forms cannot send PATCH or DELETE requests. In Sinatra, we get around
that shortcoming by sending a hidden parameter along with our forms:

Sending a PATCH request

    <form action="/trees/<%= tree["id"] %>" method="post">
      <input type="hidden" name="_method" value="patch"/>
      <ul>
        <li>
          <label for="name">Name</label>
          <input type="text" name="name" id="name" value="<%= tree["name"] %>"/>
        </li>
        <li>
          <label for="species">Species</label>
          <input type="text" name="species" id="species" value="<%= tree["species"] %>"/>
        </li>
        <li>
          <label for="country">Country</label>
          <input type="text" name="country" id="country" value="<%= tree["country"] %>"/>
        </li>
        <li>
          <label for="image">Image</label>
          <input type="text" name="image" id="image" value="<%= tree["image"] %>"/>
        </li>
        <li>
          <input type="submit" value="Update Tree"/>
        </li>
      </ul>
    </form>

The "_method" hidden field is set to "patch". This tells Sinatra to interpret
this as a PATCH request. This would map to a Sinatra action that looks like this:

      patch "/trees/:id" do
        ...
      end

Sending a DELETE request:

    <form method="post" action="/trees/<%= tree["id"] %>">
      <input type="hidden" name="_method" value="delete"/>
      <input type="submit" value="Delete Tree"/>
    </form>

The "_method" hidden field here is set to "delete". This tells Sinatra to interpret
this as a DELETE request. This would map to a Sinatra action that looks like this:

    delete "/trees/:id" do
      @trees_table.delete(params[:id])

      flash[:notice] = "Tree deleted"

      redirect "/"
    end
