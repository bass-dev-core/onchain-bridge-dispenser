import React from 'react';
import { Listbox, ListboxButton, ListboxOptions, ListboxOption } from '@headlessui/react';
import Image from 'next/image';

const BRIDGE_OPTIONS = [
  { id: 'lifi', name: 'LiFi Bridge', icon: '/icons/LifiIcon.svg' },
  { id: 'across', name: 'Across Bridge', icon: '/icons/AcrossIcon.svg' },
  { id: 'bungee', name: 'Bungee', icon: '/icons/BungeeIcon.svg' },
  { id: 'rhino', name: 'Rhino Bridge', icon: '/icons/RhinoIcon.svg' },
];

export default function BridgeSelect({
  value,
  onChange,
}: {
  value: string;
  onChange: (val: string) => void;
}): JSX.Element {
  const selected = BRIDGE_OPTIONS.find(b => b.id === value) || BRIDGE_OPTIONS[0];
  return (
    <Listbox value={value} onChange={onChange}>
      <div className="relative mt-1">
        <ListboxButton className="relative w-full cursor-pointer rounded-md bg-white py-2 pl-3 pr-10 text-left shadow-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 sm:text-sm flex items-center">
          <Image src={selected.icon} width={20} height={20} alt="" className="mr-2" />
          {selected.name}
        </ListboxButton>
        <ListboxOptions className="absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-md bg-white py-1 text-base shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none sm:text-sm">
          {BRIDGE_OPTIONS.map(bridge => (
            <ListboxOption
              key={bridge.id}
              value={bridge.id}
              className={({ selected }) =>
                `relative cursor-pointer select-none py-2 pl-10 pr-4 flex items-center ${selected ? 'bg-blue-100 text-blue-900' : 'text-gray-900'}`
              }
            >
              <Image src={bridge.icon} width={20} height={20} alt="" className="mr-2" />
              {bridge.name}
            </ListboxOption>
          ))}
        </ListboxOptions>
      </div>
    </Listbox>
  );
}
