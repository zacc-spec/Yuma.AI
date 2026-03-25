import { useState } from 'react'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <div className="App">
      <header>
        <h1>🤖 Yuma.AI</h1>
        <p>Powered by Claude AI</p>
      </header>
      
      <main>
        <section className="hero">
          <h2>Welcome to Yuma.AI</h2>
          <p>Your AI-powered assistant for intelligent features</p>
          <button onClick={() => setCount(count + 1)}>
            Count: {count}
          </button>
        </section>

        <section className="features">
          <h3>Features</h3>
          <ul>
            <li>Claude AI Integration</li>
            <li>Real-time Processing</li>
            <li>Modern React Interface</li>
          </ul>
        </section>
      </main>

      <footer>
        <p>&copy; 2026 Yuma.AI. All rights reserved.</p>
      </footer>
    </div>
  )
}

export default App
