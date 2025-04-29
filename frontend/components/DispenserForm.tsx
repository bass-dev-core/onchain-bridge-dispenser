'use client';
import React, { useState } from 'react';
import { useAccount, useWriteContract, useChainId, useConfig } from 'wagmi';
import { parseEther } from 'viem';
import dynamic from 'next/dynamic';

const BridgeSelect = dynamic(() => import('./BridgeSelect'), { ssr: false });

const BRIDGE_OPTIONS = [
  { id: 'lifi', name: 'LiFi Bridge' },
  { id: 'across', name: 'Across Bridge' },
  { id: 'bungee', name: 'Bungee' },
];

export default function DispenserForm(): JSX.Element {
  const { address } = useAccount();
  const chainId = useChainId();
  const config = useConfig();
  const [recipientAddress, setRecipientAddress] = useState('');
  const [amount, setAmount] = useState('');
  const [selectedBridge, setSelectedBridge] = useState(BRIDGE_OPTIONS[0].id);
  const [amountType, setAmountType] = useState('random');

  const { writeContract, isPending } = useWriteContract();

  const handleSubmit = async (e: React.FormEvent): Promise<void> => {
    e.preventDefault();
    if (!address || !recipientAddress || !amount || !chainId) return;

    const chain = config.chains.find(c => c.id === chainId);
    if (!chain) return;

    try {
      // TODO: Add contract address and ABI
      await writeContract({
        address: '0x0000000000000000000000000000000000000000', // Stub
        abi: [
          {
            inputs: [
              { internalType: 'string', name: 'recipient', type: 'string' },
              { internalType: 'string', name: 'bridge', type: 'string' },
              { internalType: 'string', name: 'amountType', type: 'string' },
            ],
            name: 'dispense',
            outputs: [],
            stateMutability: 'payable',
            type: 'function',
          },
        ],
        functionName: 'dispense',
        args: [recipientAddress, selectedBridge, amountType],
        value: parseEther(amount),
        chain,
        account: address,
      });
    } catch (error) {
      console.error('Error:', error);
    }
  };

  return (
    <form
      onSubmit={handleSubmit}
      className="space-y-6 max-w-lg mx-auto p-6 bg-white rounded-lg shadow-md"
    >
      <div>
        <label htmlFor="recipient" className="block text-sm font-medium text-gray-700">
          Recipient addresses:
        </label>
        <input
          id="recipient"
          type="text"
          value={recipientAddress}
          onChange={e => setRecipientAddress(e.target.value)}
          className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm"
          placeholder="0x..."
          required
        />
      </div>

      <div>
        <label htmlFor="amount" className="block text-sm font-medium text-gray-700">
          Amount (ETH)
        </label>
        <input
          id="amount"
          type="number"
          step="0.000000000000000001"
          value={amount}
          onChange={e => setAmount(e.target.value)}
          className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm"
          placeholder="0.1"
          required
        />
        <div className="mt-2 flex gap-4">
          <label className="inline-flex items-center">
            <input
              type="radio"
              className="form-radio"
              name="amountType"
              value="random"
              checked={amountType === 'random'}
              onChange={() => setAmountType('random')}
            />
            <span className="ml-2">Random target amount</span>
          </label>
          <label className="inline-flex items-center">
            <input
              type="radio"
              className="form-radio"
              name="amountType"
              value="equal"
              checked={amountType === 'equal'}
              onChange={() => setAmountType('equal')}
            />
            <span className="ml-2">Equal target amounts</span>
          </label>
        </div>
      </div>

      <div>
        <label htmlFor="bridge" className="block text-sm font-medium text-gray-700">
          Bridge
        </label>
        <BridgeSelect value={selectedBridge} onChange={setSelectedBridge} />
      </div>

      <button
        type="submit"
        disabled={isPending}
        className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
      >
        {isPending ? 'Sending...' : 'Dispense'}
      </button>
    </form>
  );
}
