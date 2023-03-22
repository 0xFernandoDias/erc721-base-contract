import {
	ThirdwebNftMedia,
	Web3Button,
	useContract,
	useContractRead,
	useNFTs,
} from "@thirdweb-dev/react"
import type { NextPage } from "next"
import Link from "next/link"

const Home: NextPage = () => {
	const { contract } = useContract("0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848")

	// The name of the smart contract
	const { data: contractName } = useContractRead(contract, "name")
	// Another way to do it:
	// contract?.call("name", "0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848")

	// Write and read the contract from the dashboard https://thirdweb.com/goerli/0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848/explorer

	// const { mutateAsync: setContractName } = useContractWrite(contract, "setName")

	// console.log("Hello Metaverse, the contract name is:", contractName)
	// Hello Metaverse, the contract name is: Awesome NFTs

	const { data: nfts, isLoading, error } = useNFTs(contract)

	return (
		<div
			style={{
				minHeight: "100vh",
				padding: "4rem 0",
				flex: "1",
				display: "flex",
				flexDirection: "column",
				justifyContent: "center",
				alignItems: "center",
			}}
		>
			<>
				Contract:{" "}
				<Link href="https://thirdweb.com/goerli/0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848">
					0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848
				</Link>
			</>
			{isLoading ? (
				<>Loading...</>
			) : (
				<div
					style={{
						display: "flex",
						flexDirection: "row",
						flexWrap: "wrap",
						minWidth: "80%",
						gap: "10%",
						justifyContent: "center",
						margin: "16px",
					}}
				>
					{nfts?.map((nft) => {
						return (
							<div
								style={{ display: "flex", flexDirection: "column" }}
								key={nft.metadata.id.toString()}
							>
								<ThirdwebNftMedia
									metadata={nft.metadata}
									style={{ width: 200 }}
								/>
								<p>{nft.metadata.name}</p>
							</div>
						)
					})}
				</div>
			)}

			<div style={{ maxWidth: 200 }}>
				{/* <ConnectWallet /> */}
				<Web3Button
					contractAddress="0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848"
					// Same thing as going to https://thirdweb.com/goerli/0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848/nfts and click on "+ Mint", the name, description, and the image are required
					action={(contract) =>
						contract.erc721.mint({
							name: "My NFT",
							description: "This is my NFT",
							image:
								"https://portal.thirdweb.com/img/thirdweb-logo-transparent-white.svg",
						})
					}
					// contractAbi={[{ ... }]}
					// overrides={{}}
					// onSuccess={(result) => alert("Success!")}
					// onError={(error) => alert("Something went wrong!")}
					// onSubmit={() => console.log("Transaction submitted")}
					// isDisabled
					// className="my-custom-class"
				>
					Mint an NFT
				</Web3Button>
			</div>
		</div>
	)
}

export default Home
