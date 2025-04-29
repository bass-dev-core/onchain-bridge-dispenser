'use client';

import React from 'react';
import { ConnectButton } from '@rainbow-me/rainbowkit';
import { useAccount } from 'wagmi';
import dynamic from 'next/dynamic';

const DispenserForm = dynamic(() => import('../components/DispenserForm'), { ssr: false });

export default function Home(): JSX.Element | null {
  const { isConnected } = useAccount();
  const [isMounted, setIsMounted] = React.useState(false);

  React.useEffect(() => {
    setIsMounted(true);
  }, []);

  if (!isMounted) return null;

  return (
    <main className="min-h-screen py-12 bg-background">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-8">
          <h1 className="text-4xl font-bold text-foreground mb-4">Zero Knowledge Dispenser</h1>
          <p className="text-lg text-gray-600 mb-8">
            Secure and anonymous token transfer across various bridges
          </p>
          <div className="flex justify-center mb-8">
            <ConnectButton label="Connect Wallet" />
          </div>
        </div>

        {isConnected ? (
          <DispenserForm />
        ) : (
          <div className="text-center text-gray-600">Please connect your wallet to continue</div>
        )}
      </div>
    </main>
  );
}
