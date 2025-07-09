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

import GenikiTaxydromikiController from 'spree_geniki_taxydromiki/controllers/geniki_taxydromiki_controller'

application.register('geniki-taxydromiki', GenikiTaxydromikiController)
