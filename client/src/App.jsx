import {Route, Routes} from "react-router-dom"
import Home from "./Pages/Home"
import Rewards from "./Pages/Rewards"


export default function App() {
  return (
    <div>
        <Routes>
          <Route path="/" element={<Home />}/>
          <Route path="/rewards" element={<Rewards />}/>
        </Routes>
    </div>
  )
}