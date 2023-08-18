import Cards from "../Components/Cards"
import Navbar from "../Components/Navbar"

export default function Landing(){
    return (
        <div className="bg-white h-screen">
            <Navbar />
            <div className="grid grid-cols-4 gap-2">
                <Cards />
                <Cards />
                <Cards />
                <Cards />
            </div>
        </div>
    )
}