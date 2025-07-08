import '@hotwired/turbo-rails'
import { Application } from '@hotwired/stimulus'

let application

if (typeof window.Stimulus === "undefined") {
  application = Application.start()
  application.debug = false
  window.Stimulus = application
} else {
  application = window.Stimulus
}

import SpreeGenikiTaxydromikiController from 'spree_geniki_taxydromiki/controllers/spree_geniki_taxydromiki_controller' 

application.register('spree_geniki_taxydromiki', SpreeGenikiTaxydromikiController)