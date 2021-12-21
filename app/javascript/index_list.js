window.addEventListener('load', function(){
  if (document.getElementById("current-list")){
    const dropdownItem = document.querySelectorAll(".dropdown-item")
    const currentList = document.getElementById("current-list")

    dropdownItem.forEach(function(item){
      item.addEventListener('click', function(){
        const value = item.innerHTML
        currentList.innerHTML = value
      })
    })
  }
})