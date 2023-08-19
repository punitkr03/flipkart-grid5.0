//Sample Navbar component
import {Link} from 'react-router-dom'

export default function Navbar() {
    return (
        <nav className="bg-blue-600 z-50 fixed w-full border-gray-200">
            <div className="flex justify-between items-center mx-auto p-4">
                <a className="flex items-center text-white font-bold italic text-2xl">
                    Flipkart
                </a>
                <ul className="flex flex-row justify-center w-full gap-20 -ml-20 text-xl font-bold text-white">
                    <li> <Link to="/" className="hover:text-green-500 hover:rounded  p-2">Shop</Link> </li>
                    <li> <Link to="/rewards" className="hover:text-green-500 hover:rounded  p-2">Rewards</Link> </li>
                </ul>
            </div>
        </nav>
    )

}