# frozen_string_literal: true

app = proc { [200, { 'content-type' => 'text/html' }, ['hello!']] }

run app
