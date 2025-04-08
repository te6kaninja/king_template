import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import General from './components/General'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <General />
  </StrictMode>,
)
