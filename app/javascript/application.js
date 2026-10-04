// Configure your import map in config/importmap.rb

import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

// Confirm when the user is about to submit a purchase
document.addEventListener("turbo:load", () => {
  const buyForms = document.querySelectorAll("form .buy-button")

  buyForms.forEach((button) => {
    button.addEventListener("click", (event) => {
      const confirmed = window.confirm(
        "Are you sure you want to buy this product?"
      )

      if (!confirmed) {
        event.preventDefault()
      }
    })
  })
})