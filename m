Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EDF2FF230
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbhAURlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:41:39 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:49581 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388914AbhAURkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:40:11 -0500
Subject: Re: 5.11-rc4+git: Shortest NUMA path spans too many nodes
To:     Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <3ec17983-7959-eccd-af25-400056a5877d@linux.ee>
 <jhjmtx22uv7.mognet@arm.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <8797fd78-4367-bc5c-3a35-43c544c745e4@linux.ee>
Date:   Thu, 21 Jan 2021 19:39:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <jhjmtx22uv7.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Could you paste the output of the below?
> 
>    $ cat /sys/devices/system/node/node*/distance

10 12 12 14 14 14 14 16
12 10 14 12 14 14 12 14
12 14 10 14 12 12 14 14
14 12 14 10 12 12 14 14
14 14 12 12 10 14 12 14
14 14 12 12 14 10 14 12
14 12 14 14 12 14 10 12
16 14 14 14 14 12 12 10


> Additionally, booting your system with CONFIG_SCHED_DEBUG=y and
> appending 'sched_debug' to your cmdline should yield some extra data.

[    0.000000] Linux version 5.11.0-rc4-00015-g45dfb8a5659a (mroos@x4600m2) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1) #55 SMP Thu Jan 21 19:23:10 EET 2021
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc4-00015-g45dfb8a5659a root=/dev/sda1 ro quiet
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000099bff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000099c00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e6000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000d7f9ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d7fae000-0x00000000d7faffff] type 9
[    0.000000] BIOS-e820: [mem 0x00000000d7fb0000-0x00000000d7fbdfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000d7fbe000-0x00000000d7feffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000d7ff0000-0x00000000d7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dc000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff700000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000002027ffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: Sun Microsystems     Sun Fire X4600 M2/Sun Fire X4600 M2, BIOS 0ABIT132 12/03/2009
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2293.794 MHz processor
[    0.005734] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.005740] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.011432] AGP: No AGP bridge found
[    0.011578] last_pfn = 0x2028000 max_arch_pfn = 0x400000000
[    0.011601] MTRR default type: uncachable
[    0.011604] MTRR fixed ranges enabled:
[    0.011607]   00000-9FFFF write-back
[    0.011610]   A0000-EFFFF uncachable
[    0.011612]   F0000-FFFFF write-protect
[    0.011614] MTRR variable ranges enabled:
[    0.011616]   0 base 000000000000 mask FFFF80000000 write-back
[    0.011620]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.011623]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.011626]   3 base 0000D0000000 mask FFFFF8000000 write-back
[    0.011629]   4 disabled
[    0.011630]   5 disabled
[    0.011632]   6 disabled
[    0.011633]   7 disabled
[    0.011634] TOM2: 0000002028000000 aka 131712M
[    0.012697] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.013048] e820: update [mem 0xd8000000-0xffffffff] usable ==> reserved
[    0.013083] last_pfn = 0xd7fa0 max_arch_pfn = 0x400000000
[    0.018157] found SMP MP-table at [mem 0x000ff780-0x000ff78f]
[    0.018215] Using GB pages for direct mapping
[    0.018603] ACPI: Early table checksum verification disabled
[    0.018613] ACPI: RSDP 0x00000000000F9EE0 000024 (v02 SUN   )
[    0.018623] ACPI: XSDT 0x00000000D7FB0100 00009C (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.018635] ACPI: FACP 0x00000000D7FB0290 0000F4 (v03 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.018645] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 64/32 (20201113/tbfadt-564)
[    0.018652] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe1Block: 128/64 (20201113/tbfadt-564)
[    0.018658] ACPI: DSDT 0x00000000D7FB0710 007DF7 (v01 SUN    X4600 M2 00000132 INTL 20051117)
[    0.018664] ACPI: FACS 0x00000000D7FBE000 000040
[    0.018667] ACPI: FACS 0x00000000D7FBE000 000040
[    0.018671] ACPI: APIC 0x00000000D7FB0390 000170 (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.018676] ACPI: SPCR 0x00000000D7FB0500 000050 (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.018681] ACPI: MCFG 0x00000000D7FB0550 00003C (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.018686] ACPI: SLIT 0x00000000D7FB064C 00006C (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.018691] ACPI: SPMI 0x00000000D7FB06C0 000041 (v05 SUN    OEMSPMI  00000132 MSFT 00000097)
[    0.018695] ACPI: OEMB 0x00000000D7FBE040 000063 (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.018700] ACPI: SRAT 0x00000000D7FB8510 0003C0 (v01 AMD    FAM_F_10 00000002 AMD  00000001)
[    0.018705] ACPI: HPET 0x00000000D7FB88D0 000038 (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.018709] ACPI: IPET 0x00000000D7FB8910 000038 (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.018714] ACPI: EINJ 0x00000000D7FB8950 000130 (v01 AMIER  AMI_EINJ 12000903 MSFT 00000097)
[    0.018719] ACPI: BERT 0x00000000D7FB8AE0 000030 (v01 AMIER  AMI_BERT 12000903 MSFT 00000097)
[    0.018724] ACPI: ERST 0x00000000D7FB8B10 0001B0 (v01 AMIER  AMI_ERST 12000903 MSFT 00000097)
[    0.018729] ACPI: HEST 0x00000000D7FB8CC0 0000A8 (v01 AMIER  ABC_HEST 12000903 MSFT 00000097)
[    0.018734] ACPI: SSDT 0x00000000D7FB8D70 005084 (v01 A M I  POWERNOW 00000001 AMD  00000001)
[    0.018750] ACPI: Local APIC address 0xfee00000
[    0.018861] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.018864] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.018866] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.018868] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.018870] SRAT: PXM 1 -> APIC 0x08 -> Node 1
[    0.018871] SRAT: PXM 1 -> APIC 0x09 -> Node 1
[    0.018873] SRAT: PXM 1 -> APIC 0x0a -> Node 1
[    0.018875] SRAT: PXM 1 -> APIC 0x0b -> Node 1
[    0.018876] SRAT: PXM 2 -> APIC 0x0c -> Node 2
[    0.018878] SRAT: PXM 2 -> APIC 0x0d -> Node 2
[    0.018880] SRAT: PXM 2 -> APIC 0x0e -> Node 2
[    0.018881] SRAT: PXM 2 -> APIC 0x0f -> Node 2
[    0.018883] SRAT: PXM 3 -> APIC 0x10 -> Node 3
[    0.018884] SRAT: PXM 3 -> APIC 0x11 -> Node 3
[    0.018886] SRAT: PXM 3 -> APIC 0x12 -> Node 3
[    0.018888] SRAT: PXM 3 -> APIC 0x13 -> Node 3
[    0.018889] SRAT: PXM 4 -> APIC 0x14 -> Node 4
[    0.018891] SRAT: PXM 4 -> APIC 0x15 -> Node 4
[    0.018893] SRAT: PXM 4 -> APIC 0x16 -> Node 4
[    0.018894] SRAT: PXM 4 -> APIC 0x17 -> Node 4
[    0.018896] SRAT: PXM 5 -> APIC 0x18 -> Node 5
[    0.018898] SRAT: PXM 5 -> APIC 0x19 -> Node 5
[    0.018900] SRAT: PXM 5 -> APIC 0x1a -> Node 5
[    0.018902] SRAT: PXM 5 -> APIC 0x1b -> Node 5
[    0.018903] SRAT: PXM 6 -> APIC 0x1c -> Node 6
[    0.018905] SRAT: PXM 6 -> APIC 0x1d -> Node 6
[    0.018906] SRAT: PXM 6 -> APIC 0x1e -> Node 6
[    0.018908] SRAT: PXM 6 -> APIC 0x1f -> Node 6
[    0.018910] SRAT: PXM 7 -> APIC 0x20 -> Node 7
[    0.018911] SRAT: PXM 7 -> APIC 0x21 -> Node 7
[    0.018913] SRAT: PXM 7 -> APIC 0x22 -> Node 7
[    0.018915] SRAT: PXM 7 -> APIC 0x23 -> Node 7
[    0.018919] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.018923] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xd7ffffff]
[    0.018925] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x427ffffff]
[    0.018927] ACPI: SRAT: Node 1 PXM 1 [mem 0x428000000-0x827ffffff]
[    0.018930] ACPI: SRAT: Node 2 PXM 2 [mem 0x828000000-0xc27ffffff]
[    0.018932] ACPI: SRAT: Node 3 PXM 3 [mem 0xc28000000-0x1027ffffff]
[    0.018934] ACPI: SRAT: Node 4 PXM 4 [mem 0x1028000000-0x1427ffffff]
[    0.018936] ACPI: SRAT: Node 5 PXM 5 [mem 0x1428000000-0x1827ffffff]
[    0.018939] ACPI: SRAT: Node 6 PXM 6 [mem 0x1828000000-0x1c27ffffff]
[    0.018941] ACPI: SRAT: Node 7 PXM 7 [mem 0x1c28000000-0x2027ffffff]
[    0.018948] NUMA: Initialized distance table, cnt=8
[    0.018952] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xd7ffffff] -> [mem 0x00000000-0xd7ffffff]
[    0.018956] NUMA: Node 0 [mem 0x00000000-0xd7ffffff] + [mem 0x100000000-0x427ffffff] -> [mem 0x00000000-0x427ffffff]
[    0.018968] NODE_DATA(0) allocated [mem 0x427ffd000-0x427ffffff]
[    0.018975] NODE_DATA(1) allocated [mem 0x827ffd000-0x827ffffff]
[    0.018981] NODE_DATA(2) allocated [mem 0xc27ffd000-0xc27ffffff]
[    0.018987] NODE_DATA(3) allocated [mem 0x1027ffd000-0x1027ffffff]
[    0.018994] NODE_DATA(4) allocated [mem 0x1427ffd000-0x1427ffffff]
[    0.019001] NODE_DATA(5) allocated [mem 0x1827ffd000-0x1827ffffff]
[    0.019008] NODE_DATA(6) allocated [mem 0x1c27ffd000-0x1c27ffffff]
[    0.019015] NODE_DATA(7) allocated [mem 0x2027ffc000-0x2027ffefff]
[    0.019313] Zone ranges:
[    0.019315]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.019319]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.019321]   Normal   [mem 0x0000000100000000-0x0000002027ffffff]
[    0.019324] Movable zone start for each node
[    0.019326] Early memory node ranges
[    0.019327]   node   0: [mem 0x0000000000001000-0x0000000000098fff]
[    0.019329]   node   0: [mem 0x0000000000100000-0x00000000d7f9ffff]
[    0.019331]   node   0: [mem 0x0000000100000000-0x0000000427ffffff]
[    0.019334]   node   1: [mem 0x0000000428000000-0x0000000827ffffff]
[    0.019338]   node   2: [mem 0x0000000828000000-0x0000000c27ffffff]
[    0.019341]   node   3: [mem 0x0000000c28000000-0x0000001027ffffff]
[    0.019344]   node   4: [mem 0x0000001028000000-0x0000001427ffffff]
[    0.019347]   node   5: [mem 0x0000001428000000-0x0000001827ffffff]
[    0.019350]   node   6: [mem 0x0000001828000000-0x0000001c27ffffff]
[    0.019354]   node   7: [mem 0x0000001c28000000-0x0000002027ffffff]
[    0.019369] Zeroed struct page in unavailable ranges: 200 pages
[    0.019371] Initmem setup node 0 [mem 0x0000000000001000-0x0000000427ffffff]
[    0.019376] On node 0 totalpages: 4194104
[    0.019379]   DMA zone: 64 pages used for memmap
[    0.019381]   DMA zone: 21 pages reserved
[    0.019383]   DMA zone: 3992 pages, LIFO batch:0
[    0.019512]   DMA32 zone: 13759 pages used for memmap
[    0.019514]   DMA32 zone: 880544 pages, LIFO batch:63
[    0.047925]   Normal zone: 51712 pages used for memmap
[    0.047930]   Normal zone: 3309568 pages, LIFO batch:63
[    0.153384] Initmem setup node 1 [mem 0x0000000428000000-0x0000000827ffffff]
[    0.153390] On node 1 totalpages: 4194304
[    0.153393]   Normal zone: 65536 pages used for memmap
[    0.153395]   Normal zone: 4194304 pages, LIFO batch:63
[    0.295485] Initmem setup node 2 [mem 0x0000000828000000-0x0000000c27ffffff]
[    0.295491] On node 2 totalpages: 4194304
[    0.295494]   Normal zone: 65536 pages used for memmap
[    0.295496]   Normal zone: 4194304 pages, LIFO batch:63
[    0.455966] Initmem setup node 3 [mem 0x0000000c28000000-0x0000001027ffffff]
[    0.455973] On node 3 totalpages: 4194304
[    0.455976]   Normal zone: 65536 pages used for memmap
[    0.455978]   Normal zone: 4194304 pages, LIFO batch:63
[    0.630301] Initmem setup node 4 [mem 0x0000001028000000-0x0000001427ffffff]
[    0.630308] On node 4 totalpages: 4194304
[    0.630310]   Normal zone: 65536 pages used for memmap
[    0.630312]   Normal zone: 4194304 pages, LIFO batch:63
[    0.790592] Initmem setup node 5 [mem 0x0000001428000000-0x0000001827ffffff]
[    0.790599] On node 5 totalpages: 4194304
[    0.790601]   Normal zone: 65536 pages used for memmap
[    0.790603]   Normal zone: 4194304 pages, LIFO batch:63
[    0.948962] Initmem setup node 6 [mem 0x0000001828000000-0x0000001c27ffffff]
[    0.948968] On node 6 totalpages: 4194304
[    0.948971]   Normal zone: 65536 pages used for memmap
[    0.948973]   Normal zone: 4194304 pages, LIFO batch:63
[    1.107195] Initmem setup node 7 [mem 0x0000001c28000000-0x0000002027ffffff]
[    1.107202] On node 7 totalpages: 4194304
[    1.107205]   Normal zone: 65536 pages used for memmap
[    1.107206]   Normal zone: 4194304 pages, LIFO batch:63
[    1.287146] ACPI: PM-Timer IO Port: 0xe008
[    1.287152] ACPI: Local APIC address 0xfee00000
[    1.287178] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    1.287184] IOAPIC[1]: apic_id 1, version 17, address 0xfe7fd000, GSI 48-54
[    1.287190] IOAPIC[2]: apic_id 2, version 17, address 0xfe7fc000, GSI 56-62
[    1.287197] IOAPIC[3]: apic_id 3, version 17, address 0xfeaff000, GSI 24-47
[    1.287205] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    1.287210] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    1.287213] ACPI: IRQ0 used by override.
[    1.287216] ACPI: IRQ9 used by override.
[    1.287219] Using ACPI (MADT) for SMP configuration information
[    1.287222] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    1.287228] ACPI: SPCR: SPCR table version 1
[    1.287232] ACPI: SPCR: console: uart,io,0x3f8,9600
[    1.287236] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    1.287273] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    1.287277] PM: hibernation: Registered nosave memory: [mem 0x00099000-0x00099fff]
[    1.287279] PM: hibernation: Registered nosave memory: [mem 0x0009a000-0x0009ffff]
[    1.287281] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000e5fff]
[    1.287282] PM: hibernation: Registered nosave memory: [mem 0x000e6000-0x000fffff]
[    1.287285] PM: hibernation: Registered nosave memory: [mem 0xd7fa0000-0xd7fadfff]
[    1.287287] PM: hibernation: Registered nosave memory: [mem 0xd7fae000-0xd7faffff]
[    1.287289] PM: hibernation: Registered nosave memory: [mem 0xd7fb0000-0xd7fbdfff]
[    1.287290] PM: hibernation: Registered nosave memory: [mem 0xd7fbe000-0xd7feffff]
[    1.287292] PM: hibernation: Registered nosave memory: [mem 0xd7ff0000-0xd7ffffff]
[    1.287293] PM: hibernation: Registered nosave memory: [mem 0xd8000000-0xdbffffff]
[    1.287295] PM: hibernation: Registered nosave memory: [mem 0xdc000000-0xefffffff]
[    1.287297] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfebfffff]
[    1.287298] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    1.287300] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
[    1.287302] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    1.287304] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xff6fffff]
[    1.287305] PM: hibernation: Registered nosave memory: [mem 0xff700000-0xffffffff]
[    1.287310] [mem 0xf0000000-0xfebfffff] available for PCI devices
[    1.287316] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    1.292433] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:8
[    1.303323] percpu: Embedded 44 pages/cpu s139544 r8192 d32488 u524288
[    1.303342] pcpu-alloc: s139544 r8192 d32488 u524288 alloc=1*2097152
[    1.303347] pcpu-alloc: [0] 00 01 02 03 [1] 04 05 06 07
[    1.303358] pcpu-alloc: [2] 08 09 10 11 [3] 12 13 14 15
[    1.303371] pcpu-alloc: [4] 16 17 18 19 [5] 20 21 22 23
[    1.303380] pcpu-alloc: [6] 24 25 26 27 [7] 28 29 30 31
[    1.303469] Built 8 zonelists, mobility grouping on.  Total pages: 33029924
[    1.303473] Policy zone: Normal
[    1.303477] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc4-00015-g45dfb8a5659a root=/dev/sda1 ro quiet
[    1.303552] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    1.303555] printk: log_buf_len total cpu_extra contributions: 126976 bytes
[    1.303556] printk: log_buf_len min size: 131072 bytes
[    1.304451] printk: log_buf_len: 262144 bytes
[    1.304455] printk: early log buf free: 116912(89%)
[    1.304779] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.333818] AGP: Checking aperture...
[    1.339520] AGP: No AGP bridge found
[    1.339547] AGP: Node 0: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.339552] AGP: Node 1: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.339556] AGP: Node 2: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.339559] AGP: Node 3: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.339562] AGP: Node 4: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.339564] AGP: Node 5: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.339567] AGP: Node 6: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.339570] AGP: Node 7: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    2.610093] Memory: 132023920K/134216928K available (10243K kernel code, 1497K rwdata, 2488K rodata, 980K init, 1308K bss, 2192748K reserved, 0K cma-reserved)
[    2.610843] rcu: Hierarchical RCU implementation.
[    2.610848] 	Tracing variant of Tasks RCU enabled.
[    2.610850] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    2.610907] NR_IRQS: 4352, nr_irqs: 1343, preallocated irqs: 16
[    2.611430] random: get_random_bytes called from start_kernel+0x314/0x460 with crng_init=0
[    2.611526] spurious 8259A interrupt: IRQ7.
[    2.615441] Console: colour VGA+ 80x25
[    2.615492] printk: console [tty0] enabled
[    2.615835] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    2.615846] ACPI: Core revision 20201113
[    2.616180] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
[    2.616216] APIC: Switch to symmetric I/O mode setup
[    2.616219] Switched APIC routing to physical flat.
[    2.616895] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    2.636226] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x21104eadfe3, max_idle_ns: 440795259470 ns
[    2.636238] Calibrating delay loop (skipped), value calculated using timer frequency.. 4587.58 BogoMIPS (lpj=9175176)
[    2.636245] pid_max: default: 32768 minimum: 301
[    2.636675] LSM: Security Framework initializing
[    2.636824] AppArmor: AppArmor initialized
[    2.676319] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc)
[    2.695809] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, vmalloc)
[    2.696621] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    2.697208] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    2.698516] LVT offset 0 assigned for vector 0xf9
[    2.698527] process: using AMD E400 aware idle routine
[    2.698531] Last level iTLB entries: 4KB 512, 2MB 16, 4MB 8
[    2.698534] Last level dTLB entries: 4KB 512, 2MB 128, 4MB 64, 1GB 0
[    2.698546] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    2.698551] Spectre V2 : Mitigation: Full AMD retpoline
[    2.698553] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    2.698756] Freeing SMP alternatives memory: 28K
[    2.807561] smpboot: CPU0: Quad-Core AMD Opteron(tm) Processor 8356 (family: 0x10, model: 0x2, stepping: 0x3)
[    2.807894] Performance Events: AMD PMU driver.
[    2.807905] ... version:                0
[    2.807907] ... bit width:              48
[    2.807908] ... generic registers:      4
[    2.807910] ... value mask:             0000ffffffffffff
[    2.807912] ... max period:             00007fffffffffff
[    2.807914] ... fixed-purpose events:   0
[    2.807916] ... event mask:             000000000000000f
[    2.808101] rcu: Hierarchical SRCU implementation.
[    2.808234] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    2.808234] smp: Bringing up secondary CPUs ...
[    2.808234] x86: Booting SMP configuration:
[    2.808234] .... node  #0, CPUs:        #1  #2  #3
[    2.814703] .... node  #1, CPUs:    #4  #5  #6  #7
[    2.904657] .... node  #2, CPUs:    #8  #9 #10 #11
[    2.996697] .... node  #3, CPUs:   #12 #13 #14 #15
[    3.088672] .... node  #4, CPUs:   #16 #17 #18 #19
[    3.180663] .... node  #5, CPUs:   #20 #21 #22 #23
[    3.272683] .... node  #6, CPUs:   #24 #25 #26 #27
[    3.364708] .... node  #7, CPUs:   #28 #29 #30 #31
[    3.456517] smp: Brought up 8 nodes, 32 CPUs
[    3.456517] smpboot: Max logical packages: 8
[    3.456517] smpboot: Total of 32 processors activated (146847.24 BogoMIPS)
[    3.461374] ------------[ cut here ]------------
[    3.461391] Shortest NUMA path spans too many nodes
[    3.461406] WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:753 cpu_attach_domain+0x44a/0x560
[    3.461430] Modules linked in:
[    3.461438] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc4-00015-g45dfb8a5659a #55
[    3.461443] Hardware name: Sun Microsystems     Sun Fire X4600 M2/Sun Fire X4600 M2, BIOS 0ABIT132 12/03/2009
[    3.461447] RIP: 0010:cpu_attach_domain+0x44a/0x560
[    3.461453] Code: bd 0a 01 41 80 ff 01 0f 87 aa de 63 00 41 83 e7 01 0f 85 4c fd ff ff 48 c7 c7 f0 78 5b 9d c6 05 4b bd 0a 01 01 e8 ae a7 63 00 <0f> 0b e9 32 fd ff ff 48 89 de 48 c7 c7 60 d0 84 9d e8 10 72 31 00
[    3.461458] RSP: 0018:ffffa8a4c6273dc8 EFLAGS: 00010282
[    3.461462] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffa8a4c6273c50
[    3.461465] RDX: 00000000ffffdfff RSI: 0000000000000003 RDI: 0000000000000000
[    3.461467] RBP: 0000000000020ec0 R08: 0000000000000003 R09: 0000000000000001
[    3.461469] R10: 0000000000002000 R11: 0000000000000001 R12: ffffa33f41303c00
[    3.461471] R13: 0000000000000000 R14: ffffa34257c20ec0 R15: 0000000000000000
[    3.461474] FS:  0000000000000000(0000) GS:ffffa34257c00000(0000) knlGS:0000000000000000
[    3.461477] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.461479] CR2: ffffa34d6e601000 CR3: 0000000f2e00a000 CR4: 00000000000006f0
[    3.461482] Call Trace:
[    3.461492]  ? cpumask_next+0x15/0x20
[    3.461502]  ? update_group_capacity+0xc5/0x240
[    3.461506]  build_sched_domains+0x1117/0x14c0
[    3.461512]  sched_init_domains+0x62/0x90
[    3.461517]  sched_init_smp+0x1d/0x5d
[    3.461528]  kernel_init_freeable+0xb7/0x233
[    3.461538]  ? rest_init+0xcd/0xcd
[    3.464242]  kernel_init+0x6/0x113
[    3.464246]  ? rest_init+0xcd/0xcd
[    3.464249]  ret_from_fork+0x22/0x30
[    3.464260] ---[ end trace fe71f7b954f970a9 ]---
[    3.483427] devtmpfs: initialized
[    3.484272] PM: Registering ACPI NVS region [mem 0xd7fbe000-0xd7feffff] (204800 bytes)
[    3.484396] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    3.484495] futex hash table entries: 8192 (order: 7, 524288 bytes, vmalloc)
[    3.485355] NET: Registered protocol family 16
[    3.485547] audit: initializing netlink subsys (disabled)
[    3.485564] audit: type=2000 audit(1611250490.868:1): state=initialized audit_enabled=0 res=1
[    3.485564] thermal_sys: Registered thermal governor 'step_wise'
[    3.485564] cpuidle: using governor ladder
[    3.485564] cpuidle: using governor menu
[    3.485564] node 0 link 2: io port [8000, bfff]
[    3.485564] node 7 link 2: io port [c000, cfff]
[    3.485564] node 0 link 2: io port [e000, efff]
[    3.485564] node 7 link 2: io port [f000, ffff]
[    3.485564] TOM: 00000000d8000000 aka 3456M
[    3.485564] Fam 10h mmconf [mem 0xe0000000-0xefffffff]
[    3.485564] node 0 link 2: mmio [fbf00000, fe8fffff]
[    3.485564] node 7 link 2: mmio [fe900000, febfffff]
[    3.485564] node 7 link 2: mmio [fed10000, fed1ffff]
[    3.485564] node 7 link 2: mmio [e8000000, efffffff] ==> none
[    3.485564] node 0 link 2: mmio [a0000, bffff]
[    3.485564] node 0 link 2: mmio [e0000000, e7ffffff] ==> none
[    3.485564] TOM2: 0000002028000000 aka 131712M
[    3.485564] bus: [bus 00-06] on node 0 link 2
[    3.485564] bus: 00 [io  0x0000-0xbfff]
[    3.485564] bus: 00 [io  0xd000-0xefff]
[    3.485564] bus: 00 [mem 0xf0000000-0xfe8fffff]
[    3.485564] bus: 00 [mem 0x000a0000-0x000bffff]
[    3.485564] bus: 00 [mem 0xd8000000-0xdfffffff]
[    3.485564] bus: 00 [mem 0xfec00000-0xfed0ffff]
[    3.485564] bus: 00 [mem 0xfed20000-0xffffffff]
[    3.485564] bus: 00 [mem 0x2028000000-0xfcffffffff]
[    3.485564] bus: [bus 80-83] on node 7 link 2
[    3.485564] bus: 80 [io  0xc000-0xcfff]
[    3.485564] bus: 80 [io  0xf000-0xffff]
[    3.485564] bus: 80 [mem 0xfe900000-0xfebfffff]
[    3.485564] bus: 80 [mem 0xfed10000-0xfed1ffff]
[    3.485564] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    3.485564] ACPI: bus type PCI registered
[    3.485564] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.485564] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    3.485564] PCI: AMD Family 10h NB with MMCONFIG support
[    3.485564] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    3.485564] PCI: Using configuration type 1 for base access
[    3.490510] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    3.490510] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    3.492385] ACPI: Added _OSI(Module Device)
[    3.492388] ACPI: Added _OSI(Processor Device)
[    3.492390] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.492391] ACPI: Added _OSI(Processor Aggregator Device)
[    3.492394] ACPI: Added _OSI(Linux-Dell-Video)
[    3.492397] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    3.492399] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    3.507349] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    3.511313] ACPI: Interpreter enabled
[    3.511345] ACPI: (supports S0 S1 S5)
[    3.511349] ACPI: Using IOAPIC for interrupt routing
[    3.511498] HEST: Table parsing has been initialized.
[    3.511505] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.512232] ACPI: Enabled 4 GPEs in block 00 to 1F
[    3.558543] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-06])
[    3.558568] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    3.558836] acpi PNP0A03:00: _OSC: platform does not support [LTR DPC]
[    3.559066] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    3.559069] acpi PNP0A03:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.567966] PCI host bridge to bus 0000:00
[    3.567970] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    3.567974] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    3.567977] pci_bus 0000:00: root bus resource [io  0x03bc-0x03bf window]
[    3.567980] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    3.567982] pci_bus 0000:00: root bus resource [io  0x03e0-0xbfff window]
[    3.567985] pci_bus 0000:00: root bus resource [io  0xd000-0xefff window]
[    3.567987] pci_bus 0000:00: root bus resource [mem 0xd8000000-0xe7ffffff window]
[    3.567990] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfe8fffff window]
[    3.567993] pci_bus 0000:00: root bus resource [mem 0xfec00000-0xfed0ffff window]
[    3.567996] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.567998] pci_bus 0000:00: root bus resource [mem 0xfed20000-0xffffffff window]
[    3.568002] pci_bus 0000:00: root bus resource [bus 00-06]
[    3.568031] pci 0000:00:00.0: [10de:005e] type 00 class 0x058000
[    3.568271] pci 0000:00:01.0: [10de:0051] type 00 class 0x060100
[    3.568472] pci 0000:00:01.1: [10de:0052] type 00 class 0x0c0500
[    3.568484] pci 0000:00:01.1: reg 0x10: [io  0xee00-0xee1f]
[    3.568503] pci 0000:00:01.1: reg 0x20: [io  0xed00-0xed3f]
[    3.568518] pci 0000:00:01.1: reg 0x24: [io  0xed40-0xed7f]
[    3.568543] pci 0000:00:01.1: PME# supported from D3hot D3cold
[    3.568683] pci 0000:00:02.0: [10de:005a] type 00 class 0x0c0310
[    3.568694] pci 0000:00:02.0: reg 0x10: [mem 0xfe7ff000-0xfe7fffff]
[    3.568755] pci 0000:00:02.0: supports D1 D2
[    3.568769] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.568888] pci 0000:00:02.1: [10de:005b] type 00 class 0x0c0320
[    3.568920] pci 0000:00:02.1: reg 0x10: [mem 0xfe7fec00-0xfe7fecff]
[    3.568965] pci 0000:00:02.1: supports D1 D2
[    3.568981] pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot D3cold
[    3.569130] pci 0000:00:06.0: [10de:0053] type 00 class 0x01018a
[    3.569159] pci 0000:00:06.0: reg 0x20: [io  0xefa0-0xefaf]
[    3.569188] pci 0000:00:06.0: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    3.569192] pci 0000:00:06.0: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    3.569194] pci 0000:00:06.0: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    3.569196] pci 0000:00:06.0: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    3.569363] pci 0000:00:09.0: [10de:005c] type 01 class 0x060401
[    3.569515] pci 0000:00:0c.0: [10de:005d] type 01 class 0x060400
[    3.569613] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.569758] pci 0000:00:0d.0: [10de:005d] type 01 class 0x060400
[    3.569831] pci 0000:00:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.569972] pci 0000:00:0e.0: [10de:005d] type 01 class 0x060400
[    3.570042] pci 0000:00:0e.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.570208] pci 0000:00:10.0: [1022:7458] type 01 class 0x060400
[    3.570275] pci 0000:00:10.0: Enabling HT MSI Mapping
[    3.570430] pci 0000:00:10.1: [1022:7459] type 00 class 0x080010
[    3.570440] pci 0000:00:10.1: reg 0x10: [mem 0xfe7fd000-0xfe7fdfff 64bit]
[    3.570624] pci 0000:00:11.0: [1022:7458] type 01 class 0x060400
[    3.570683] pci 0000:00:11.0: Enabling HT MSI Mapping
[    3.570839] pci 0000:00:11.1: [1022:7459] type 00 class 0x080010
[    3.570858] pci 0000:00:11.1: reg 0x10: [mem 0xfe7fc000-0xfe7fcfff 64bit]
[    3.571012] pci 0000:00:18.0: [1022:1200] type 00 class 0x060000
[    3.571172] pci 0000:00:18.1: [1022:1201] type 00 class 0x060000
[    3.571310] pci 0000:00:18.2: [1022:1202] type 00 class 0x060000
[    3.571426] pci 0000:00:18.3: [1022:1203] type 00 class 0x060000
[    3.571601] pci 0000:00:18.4: [1022:1204] type 00 class 0x060000
[    3.571712] pci 0000:00:19.0: [1022:1200] type 00 class 0x060000
[    3.571880] pci 0000:00:19.1: [1022:1201] type 00 class 0x060000
[    3.572011] pci 0000:00:19.2: [1022:1202] type 00 class 0x060000
[    3.572142] pci 0000:00:19.3: [1022:1203] type 00 class 0x060000
[    3.572281] pci 0000:00:19.4: [1022:1204] type 00 class 0x060000
[    3.572407] pci 0000:00:1a.0: [1022:1200] type 00 class 0x060000
[    3.572549] pci 0000:00:1a.1: [1022:1201] type 00 class 0x060000
[    3.572665] pci 0000:00:1a.2: [1022:1202] type 00 class 0x060000
[    3.572790] pci 0000:00:1a.3: [1022:1203] type 00 class 0x060000
[    3.572911] pci 0000:00:1a.4: [1022:1204] type 00 class 0x060000
[    3.573027] pci 0000:00:1b.0: [1022:1200] type 00 class 0x060000
[    3.573181] pci 0000:00:1b.1: [1022:1201] type 00 class 0x060000
[    3.573308] pci 0000:00:1b.2: [1022:1202] type 00 class 0x060000
[    3.573458] pci 0000:00:1b.3: [1022:1203] type 00 class 0x060000
[    3.573594] pci 0000:00:1b.4: [1022:1204] type 00 class 0x060000
[    3.573710] pci 0000:00:1c.0: [1022:1200] type 00 class 0x060000
[    3.573848] pci 0000:00:1c.1: [1022:1201] type 00 class 0x060000
[    3.573978] pci 0000:00:1c.2: [1022:1202] type 00 class 0x060000
[    3.574110] pci 0000:00:1c.3: [1022:1203] type 00 class 0x060000
[    3.574222] pci 0000:00:1c.4: [1022:1204] type 00 class 0x060000
[    3.574388] pci 0000:00:1d.0: [1022:1200] type 00 class 0x060000
[    3.574520] pci 0000:00:1d.1: [1022:1201] type 00 class 0x060000
[    3.574653] pci 0000:00:1d.2: [1022:1202] type 00 class 0x060000
[    3.574757] pci 0000:00:1d.3: [1022:1203] type 00 class 0x060000
[    3.574895] pci 0000:00:1d.4: [1022:1204] type 00 class 0x060000
[    3.575020] pci 0000:00:1e.0: [1022:1200] type 00 class 0x060000
[    3.575145] pci 0000:00:1e.1: [1022:1201] type 00 class 0x060000
[    3.575284] pci 0000:00:1e.2: [1022:1202] type 00 class 0x060000
[    3.575440] pci 0000:00:1e.3: [1022:1203] type 00 class 0x060000
[    3.575595] pci 0000:00:1e.4: [1022:1204] type 00 class 0x060000
[    3.575718] pci 0000:00:1f.0: [1022:1200] type 00 class 0x060000
[    3.575867] pci 0000:00:1f.1: [1022:1201] type 00 class 0x060000
[    3.576001] pci 0000:00:1f.2: [1022:1202] type 00 class 0x060000
[    3.576135] pci 0000:00:1f.3: [1022:1203] type 00 class 0x060000
[    3.576281] pci 0000:00:1f.4: [1022:1204] type 00 class 0x060000
[    3.576442] pci_bus 0000:01: extended config space not accessible
[    3.576478] pci 0000:01:06.0: [1002:4752] type 00 class 0x030000
[    3.576501] pci 0000:01:06.0: reg 0x10: [mem 0xfd000000-0xfdffffff]
[    3.576538] pci 0000:01:06.0: reg 0x14: [io  0x8800-0x88ff]
[    3.576548] pci 0000:01:06.0: reg 0x18: [mem 0xfcfff000-0xfcffffff]
[    3.576579] pci 0000:01:06.0: reg 0x30: [mem 0xfcfc0000-0xfcfdffff pref]
[    3.576623] pci 0000:01:06.0: supports D1 D2
[    3.576691] pci 0000:00:09.0: PCI bridge to [bus 01] (subtractive decode)
[    3.576717] pci 0000:00:09.0:   bridge window [io  0x8000-0x8fff]
[    3.576721] pci 0000:00:09.0:   bridge window [mem 0xfbf00000-0xfdffffff]
[    3.576725] pci 0000:00:09.0:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    3.576729] pci 0000:00:09.0:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
[    3.576732] pci 0000:00:09.0:   bridge window [io  0x03bc-0x03bf window] (subtractive decode)
[    3.576734] pci 0000:00:09.0:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
[    3.576737] pci 0000:00:09.0:   bridge window [io  0x03e0-0xbfff window] (subtractive decode)
[    3.576740] pci 0000:00:09.0:   bridge window [io  0xd000-0xefff window] (subtractive decode)
[    3.576742] pci 0000:00:09.0:   bridge window [mem 0xd8000000-0xe7ffffff window] (subtractive decode)
[    3.576745] pci 0000:00:09.0:   bridge window [mem 0xf0000000-0xfe8fffff window] (subtractive decode)
[    3.576748] pci 0000:00:09.0:   bridge window [mem 0xfec00000-0xfed0ffff window] (subtractive decode)
[    3.576751] pci 0000:00:09.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    3.576753] pci 0000:00:09.0:   bridge window [mem 0xfed20000-0xffffffff window] (subtractive decode)
[    3.576797] pci 0000:00:0c.0: PCI bridge to [bus 02]
[    3.576861] pci 0000:03:00.0: [1077:2432] type 00 class 0x0c0400
[    3.576894] pci 0000:03:00.0: reg 0x10: [io  0x9800-0x98ff]
[    3.576926] pci 0000:03:00.0: reg 0x14: [mem 0xfe0fc000-0xfe0fffff 64bit]
[    3.576973] pci 0000:03:00.0: reg 0x30: [mem 0xfe080000-0xfe0bffff pref]
[    3.588269] pci 0000:00:0d.0: PCI bridge to [bus 03]
[    3.588274] pci 0000:00:0d.0:   bridge window [io  0x9000-0x9fff]
[    3.588277] pci 0000:00:0d.0:   bridge window [mem 0xfe000000-0xfe0fffff]
[    3.588321] pci 0000:00:0e.0: PCI bridge to [bus 04]
[    3.588351] pci_bus 0000:05: extended config space not accessible
[    3.588380] pci 0000:05:01.0: [8086:1010] type 00 class 0x020000
[    3.588391] pci 0000:05:01.0: reg 0x10: [mem 0xfe1e0000-0xfe1fffff 64bit]
[    3.588417] pci 0000:05:01.0: reg 0x20: [io  0xac00-0xac3f]
[    3.588468] pci 0000:05:01.0: PME# supported from D0 D3hot
[    3.588538] pci 0000:05:01.1: [8086:1010] type 00 class 0x020000
[    3.588548] pci 0000:05:01.1: reg 0x10: [mem 0xfe1c0000-0xfe1dffff 64bit]
[    3.588564] pci 0000:05:01.1: reg 0x20: [io  0xa800-0xa83f]
[    3.588618] pci 0000:05:01.1: PME# supported from D0 D3hot
[    3.588680] pci 0000:05:02.0: [8086:1010] type 00 class 0x020000
[    3.588690] pci 0000:05:02.0: reg 0x10: [mem 0xfe1a0000-0xfe1bffff 64bit]
[    3.588706] pci 0000:05:02.0: reg 0x20: [io  0xa400-0xa43f]
[    3.588751] pci 0000:05:02.0: PME# supported from D0 D3hot
[    3.588812] pci 0000:05:02.1: [8086:1010] type 00 class 0x020000
[    3.588825] pci 0000:05:02.1: reg 0x10: [mem 0xfe180000-0xfe19ffff 64bit]
[    3.588845] pci 0000:05:02.1: reg 0x20: [io  0xa000-0xa03f]
[    3.588909] pci 0000:05:02.1: PME# supported from D0 D3hot
[    3.588981] pci 0000:00:10.0: PCI bridge to [bus 05]
[    3.588987] pci 0000:00:10.0:   bridge window [io  0xa000-0xafff]
[    3.588991] pci 0000:00:10.0:   bridge window [mem 0xfe100000-0xfe1fffff]
[    3.589006] pci_bus 0000:06: extended config space not accessible
[    3.589048] pci 0000:06:04.0: [1000:0050] type 00 class 0x010000
[    3.589057] pci 0000:06:04.0: reg 0x10: [io  0xb800-0xb8ff]
[    3.589074] pci 0000:06:04.0: reg 0x14: [mem 0xfe6fc000-0xfe6fffff 64bit]
[    3.589099] pci 0000:06:04.0: reg 0x1c: [mem 0xfe6e0000-0xfe6effff 64bit]
[    3.589111] pci 0000:06:04.0: reg 0x30: [mem 0xfe400000-0xfe5fffff pref]
[    3.589145] pci 0000:06:04.0: supports D1 D2
[    3.589220] pci 0000:00:11.0: PCI bridge to [bus 06]
[    3.589242] pci 0000:00:11.0:   bridge window [io  0xb000-0xbfff]
[    3.589258] pci 0000:00:11.0:   bridge window [mem 0xfe200000-0xfe6fffff]
[    3.596752] ACPI: PCI Root Bridge [PCIB] (domain 0000 [bus 80-83])
[    3.596761] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    3.597023] acpi PNP0A03:03: _OSC: platform does not support [LTR DPC]
[    3.597249] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    3.597251] acpi PNP0A03:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.597260] acpi PNP0A03:03: [Firmware Bug]: no _PXM; falling back to node 7 from hardware (may be inconsistent with ACPI node numbers)
[    3.602724] PCI host bridge to bus 0000:80
[    3.602728] pci_bus 0000:80: root bus resource [io  0xc000-0xcfff window]
[    3.602731] pci_bus 0000:80: root bus resource [io  0xf000-0xffff window]
[    3.602734] pci_bus 0000:80: root bus resource [mem 0xfe900000-0xfebfffff window]
[    3.602737] pci_bus 0000:80: root bus resource [mem 0xfed10000-0xfed1ffff window]
[    3.602740] pci_bus 0000:80: root bus resource [mem 0xe8000000-0xefffffff window]
[    3.602743] pci_bus 0000:80: root bus resource [bus 80-83]
[    3.602766] pci 0000:80:00.0: [10de:005e] type 00 class 0x058000
[    3.602928] pci 0000:80:01.0: [10de:00d3] type 00 class 0x058000
[    3.602940] pci 0000:80:01.0: reg 0x14: [mem 0xfeaff000-0xfeafffff]
[    3.603162] pci 0000:80:0c.0: [10de:005d] type 01 class 0x060400
[    3.603222] pci 0000:80:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.603352] pci 0000:80:0d.0: [10de:005d] type 01 class 0x060400
[    3.603407] pci 0000:80:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.603546] pci 0000:80:0e.0: [10de:005d] type 01 class 0x060400
[    3.603606] pci 0000:80:0e.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.603798] pci 0000:80:0c.0: PCI bridge to [bus 81]
[    3.603862] pci 0000:82:00.0: [1077:2432] type 00 class 0x0c0400
[    3.603887] pci 0000:82:00.0: reg 0x10: [io  0xc800-0xc8ff]
[    3.603914] pci 0000:82:00.0: reg 0x14: [mem 0xfe9fc000-0xfe9fffff 64bit]
[    3.603958] pci 0000:82:00.0: reg 0x30: [mem 0xfe980000-0xfe9bffff pref]
[    3.612254] pci 0000:80:0d.0: PCI bridge to [bus 82]
[    3.612259] pci 0000:80:0d.0:   bridge window [io  0xc000-0xcfff]
[    3.612263] pci 0000:80:0d.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    3.612313] pci 0000:80:0e.0: PCI bridge to [bus 83]
[    3.612630] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *10
[    3.612800] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *7
[    3.612978] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *5
[    3.613161] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *15
[    3.613326] ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 19) *0, disabled.
[    3.613496] ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *11
[    3.613651] ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0, disabled.
[    3.613822] ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *5
[    3.614018] ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22) *0, disabled.
[    3.614183] ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22) *0, disabled.
[    3.614342] ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22) *0, disabled.
[    3.614512] ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22) *0, disabled.
[    3.614688] ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0, disabled.
[    3.614868] ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22) *0, disabled.
[    3.615081] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22) *14
[    3.615262] ACPI: PCI Interrupt Link [LN2A] (IRQs 40 41 42 43) *10
[    3.615419] ACPI: PCI Interrupt Link [LN2B] (IRQs 40 41 42 43) *7
[    3.615595] ACPI: PCI Interrupt Link [LN2C] (IRQs 40 41 42 43) *5
[    3.615746] ACPI: PCI Interrupt Link [LN2D] (IRQs 40 41 42 43) *15
[    3.615924] ACPI: PCI Interrupt Link [LN4A] (IRQs 40 41 42 43) *15
[    3.616091] ACPI: PCI Interrupt Link [LN4B] (IRQs 40 41 42 43) *15
[    3.616268] ACPI: PCI Interrupt Link [LN4C] (IRQs 40 41 42 43) *15
[    3.616450] ACPI: PCI Interrupt Link [LN4D] (IRQs 40 41 42 43) *15
[    3.616635] ACPI: PCI Interrupt Link [LN6A] (IRQs 40 41 42 43) *15
[    3.616797] ACPI: PCI Interrupt Link [LN6B] (IRQs 40 41 42 43) *15
[    3.616963] ACPI: PCI Interrupt Link [LN6C] (IRQs 40 41 42 43) *15
[    3.617112] ACPI: PCI Interrupt Link [LN6D] (IRQs 40 41 42 43) *15
[    3.617307] ACPI: PCI Interrupt Link [LK2N] (IRQs 44 45 46 47) *0, disabled.
[    3.617473] ACPI: PCI Interrupt Link [LK4N] (IRQs 44 45 46 47) *15
[    3.617632] ACPI: PCI Interrupt Link [LK6N] (IRQs 44 45 46 47) *15
[    3.617801] ACPI: PCI Interrupt Link [LT3D] (IRQs 44 45 46 47) *0, disabled.
[    3.618008] ACPI: PCI Interrupt Link [LT2E] (IRQs 44 45 46 47) *0, disabled.
[    3.618388] iommu: Default domain type: Passthrough
[    3.618421] pci 0000:01:06.0: vgaarb: setting as boot VGA device
[    3.618421] pci 0000:01:06.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    3.618421] pci 0000:01:06.0: vgaarb: bridge control possible
[    3.618421] vgaarb: loaded
[    3.618421] SCSI subsystem initialized
[    3.618421] PCI: Using ACPI for IRQ routing
[    3.624765] PCI: pci_cache_line_size set to 64 bytes
[    3.624866] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    3.624869] e820: reserve RAM buffer [mem 0x00099c00-0x0009ffff]
[    3.624875] e820: reserve RAM buffer [mem 0xd7fa0000-0xd7ffffff]
[    3.624890] hpet: 3 channels of 0 reserved for per-cpu timers
[    3.624890] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    3.624890] hpet0: 3 comparators, 32-bit 25.000000 MHz counter
[    3.626877] clocksource: Switched to clocksource tsc-early
[    3.626877] AppArmor: AppArmor Filesystem Enabled
[    3.626877] pnp: PnP ACPI init
[    3.626877] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    3.626877] pnp 00:01: [dma 0 disabled]
[    3.626877] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.626877] system 00:02: [io  0x0190-0x0193] has been reserved
[    3.626877] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    3.626877] system 00:02: [io  0xe000-0xe0ff window] has been reserved
[    3.626877] system 00:02: [io  0xe400-0xe4ff window] has been reserved
[    3.626877] system 00:02: [io  0xe800-0xe8ff window] has been reserved
[    3.626877] system 00:02: [mem 0xffb80000-0xfffffffe] has been reserved
[    3.626877] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.627113] system 00:03: [io  0x0cf8-0x0cff] could not be reserved
[    3.627118] system 00:03: [io  0x0ca0-0x0ca5] could not be reserved
[    3.627121] system 00:03: [io  0x0ca8-0x0caf] has been reserved
[    3.627125] system 00:03: [mem 0xfec00000-0xfec00fff] could not be reserved
[    3.627129] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
[    3.627134] system 00:03: [mem 0xfefff000-0xfeffffff] has been reserved
[    3.627142] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.627418] system 00:04: [io  0x0680-0x06ff] has been reserved
[    3.627428] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.627619] system 00:05: [mem 0xe0000000-0xefffffff] could not be reserved
[    3.627628] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.627946] system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
[    3.627950] system 00:06: [mem 0x000c0000-0x000dffff] could not be reserved
[    3.627954] system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved
[    3.627958] system 00:06: [mem 0x00100000-0xd7ffffff] could not be reserved
[    3.627967] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
[    3.629335] pnp: PnP ACPI: found 7 devices
[    3.636319] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.636539] NET: Registered protocol family 2
[    3.637190] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
[    3.638407] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
[    3.641116] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
[    3.641739] TCP: Hash tables configured (established 524288 bind 65536)
[    3.642122] UDP hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    3.643735] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    3.645670] NET: Registered protocol family 1
[    3.645756] pci 0000:00:09.0: PCI bridge to [bus 01]
[    3.645765] pci 0000:00:09.0:   bridge window [io  0x8000-0x8fff]
[    3.645772] pci 0000:00:09.0:   bridge window [mem 0xfbf00000-0xfdffffff]
[    3.645779] pci 0000:00:0c.0: PCI bridge to [bus 02]
[    3.645787] pci 0000:00:0d.0: PCI bridge to [bus 03]
[    3.645790] pci 0000:00:0d.0:   bridge window [io  0x9000-0x9fff]
[    3.645794] pci 0000:00:0d.0:   bridge window [mem 0xfe000000-0xfe0fffff]
[    3.645800] pci 0000:00:0e.0: PCI bridge to [bus 04]
[    3.645809] pci 0000:00:10.0: PCI bridge to [bus 05]
[    3.645811] pci 0000:00:10.0:   bridge window [io  0xa000-0xafff]
[    3.645815] pci 0000:00:10.0:   bridge window [mem 0xfe100000-0xfe1fffff]
[    3.645822] pci 0000:00:11.0: PCI bridge to [bus 06]
[    3.645824] pci 0000:00:11.0:   bridge window [io  0xb000-0xbfff]
[    3.645828] pci 0000:00:11.0:   bridge window [mem 0xfe200000-0xfe6fffff]
[    3.645863] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    3.645866] pci_bus 0000:00: resource 5 [io  0x03b0-0x03bb window]
[    3.645869] pci_bus 0000:00: resource 6 [io  0x03bc-0x03bf window]
[    3.645872] pci_bus 0000:00: resource 7 [io  0x03c0-0x03df window]
[    3.645875] pci_bus 0000:00: resource 8 [io  0x03e0-0xbfff window]
[    3.645878] pci_bus 0000:00: resource 9 [io  0xd000-0xefff window]
[    3.645880] pci_bus 0000:00: resource 10 [mem 0xd8000000-0xe7ffffff window]
[    3.645884] pci_bus 0000:00: resource 11 [mem 0xf0000000-0xfe8fffff window]
[    3.645887] pci_bus 0000:00: resource 12 [mem 0xfec00000-0xfed0ffff window]
[    3.645890] pci_bus 0000:00: resource 13 [mem 0x000a0000-0x000bffff window]
[    3.645892] pci_bus 0000:00: resource 14 [mem 0xfed20000-0xffffffff window]
[    3.645895] pci_bus 0000:01: resource 0 [io  0x8000-0x8fff]
[    3.645898] pci_bus 0000:01: resource 1 [mem 0xfbf00000-0xfdffffff]
[    3.645901] pci_bus 0000:01: resource 4 [io  0x0000-0x03af window]
[    3.645903] pci_bus 0000:01: resource 5 [io  0x03b0-0x03bb window]
[    3.645906] pci_bus 0000:01: resource 6 [io  0x03bc-0x03bf window]
[    3.645908] pci_bus 0000:01: resource 7 [io  0x03c0-0x03df window]
[    3.645911] pci_bus 0000:01: resource 8 [io  0x03e0-0xbfff window]
[    3.645913] pci_bus 0000:01: resource 9 [io  0xd000-0xefff window]
[    3.645916] pci_bus 0000:01: resource 10 [mem 0xd8000000-0xe7ffffff window]
[    3.645918] pci_bus 0000:01: resource 11 [mem 0xf0000000-0xfe8fffff window]
[    3.645921] pci_bus 0000:01: resource 12 [mem 0xfec00000-0xfed0ffff window]
[    3.645924] pci_bus 0000:01: resource 13 [mem 0x000a0000-0x000bffff window]
[    3.645927] pci_bus 0000:01: resource 14 [mem 0xfed20000-0xffffffff window]
[    3.645930] pci_bus 0000:03: resource 0 [io  0x9000-0x9fff]
[    3.645932] pci_bus 0000:03: resource 1 [mem 0xfe000000-0xfe0fffff]
[    3.645935] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
[    3.645938] pci_bus 0000:05: resource 1 [mem 0xfe100000-0xfe1fffff]
[    3.645941] pci_bus 0000:06: resource 0 [io  0xb000-0xbfff]
[    3.645944] pci_bus 0000:06: resource 1 [mem 0xfe200000-0xfe6fffff]
[    3.646049] pci 0000:80:0c.0: PCI bridge to [bus 81]
[    3.646058] pci 0000:80:0d.0: PCI bridge to [bus 82]
[    3.646061] pci 0000:80:0d.0:   bridge window [io  0xc000-0xcfff]
[    3.646064] pci 0000:80:0d.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    3.646070] pci 0000:80:0e.0: PCI bridge to [bus 83]
[    3.646077] pci_bus 0000:80: resource 4 [io  0xc000-0xcfff window]
[    3.646080] pci_bus 0000:80: resource 5 [io  0xf000-0xffff window]
[    3.646083] pci_bus 0000:80: resource 6 [mem 0xfe900000-0xfebfffff window]
[    3.646085] pci_bus 0000:80: resource 7 [mem 0xfed10000-0xfed1ffff window]
[    3.646088] pci_bus 0000:80: resource 8 [mem 0xe8000000-0xefffffff window]
[    3.646091] pci_bus 0000:82: resource 0 [io  0xc000-0xcfff]
[    3.646094] pci_bus 0000:82: resource 1 [mem 0xfe900000-0xfe9fffff]
[    3.646649] PCI Interrupt Link [LUS0] enabled at IRQ 22
[    3.664398] pci 0000:00:02.0: quirk_usb_early_handoff+0x0/0x7a0 took 17807 usecs
[    3.664713] PCI Interrupt Link [LUS2] enabled at IRQ 21
[    3.664868] pci 0000:00:0c.0: Found disabled HT MSI Mapping
[    3.664881] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.664911] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.664936] pci 0000:00:0d.0: Found disabled HT MSI Mapping
[    3.664944] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.664977] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.665001] pci 0000:00:0e.0: Found disabled HT MSI Mapping
[    3.665008] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.665044] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.665239] pci 0000:01:06.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    3.665293] pci 0000:80:0c.0: Found disabled HT MSI Mapping
[    3.665304] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.665325] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.665347] pci 0000:80:0d.0: Found disabled HT MSI Mapping
[    3.665354] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.665381] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.665414] pci 0000:80:0e.0: Found disabled HT MSI Mapping
[    3.665422] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.665451] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.665472] PCI: CLS 64 bytes, default 64
[    3.667680] PCI-DMA: Disabling AGP.
[    3.668028] PCI-DMA: aperture base @ dc000000 size 65536 KB
[    3.668046] PCI-DMA: using GART IOMMU.
[    3.668050] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    3.672570] LVT offset 1 assigned for vector 0x400
[    3.672656] LVT offset 1 assigned
[    3.673207] perf: AMD IBS detected (0x00000007)
[    3.674902] workingset: timestamp_bits=42 max_order=25 bucket_order=0
[    3.676380] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    3.680806] ERST: Failed to get Error Log Address Range.
[    3.680911] [Firmware Warn]: GHES: Poll interval is 0 for generic hardware error source: 1, disabled.
[    3.681124] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    3.681210] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.681470] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.682008] hpet_acpi_add: no address or irqs in _CRS
[    3.682047] Linux agpgart interface v0.103
[    3.686389] Fusion MPT base driver 3.04.20
[    3.686391] Copyright (c) 1999-2008 LSI Corporation
[    3.686399] Fusion MPT SAS Host driver 3.04.20
[    3.686826] mptbase: ioc0: Initiating bringup
[    4.680253] ioc0: LSISAS1064 A3: Capabilities={Initiator}
[    4.692258] tsc: Refined TSC clocksource calibration: 2293.905 MHz
[    4.692322] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2110b79338c, max_idle_ns: 440795266793 ns
[    4.692473] clocksource: Switched to clocksource tsc
[   15.448565] scsi host0: ioc0: LSISAS1064 A3, FwRev=011b0000h, Ports=1, MaxQ=478, IRQ=24
[   15.471418] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 0, phy 0, sas_addr 0x5000c50003d7f551
[   15.472881] scsi 0:0:0:0: Direct-Access     SEAGATE  ST973402SSUN72G  0400 PQ: 0 ANSI: 5
[   15.479486] i8042: PNP: No PS/2 controller found.
[   15.479490] i8042: Probing ports directly.
[   15.482681] serio: i8042 KBD port at 0x60,0x64 irq 1
[   15.482689] serio: i8042 AUX port at 0x60,0x64 irq 12
[   15.482768] rtc_cmos 00:00: RTC can wake from S4
[   15.483195] rtc_cmos 00:00: registered as rtc0
[   15.483313] rtc_cmos 00:00: setting system clock to 2021-01-21T17:35:03 UTC (1611250503)
[   15.483352] rtc_cmos 00:00: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[   15.483678] sd 0:0:0:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.4 GiB)
[   15.484834] sd 0:0:0:0: [sda] Write Protect is off
[   15.484837] sd 0:0:0:0: [sda] Mode Sense: e3 00 10 08
[   15.484978] NET: Registered protocol family 10
[   15.486652] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   15.486791] Segment Routing with IPv6
[   15.486845] mip6: Mobile IPv6
[   15.486850] NET: Registered protocol family 17
[   15.488004]  sda: sda1
[   15.489586] microcode: CPU0: patch_level=0x01000083
[   15.489601] microcode: CPU1: patch_level=0x01000083
[   15.489614] microcode: CPU2: patch_level=0x01000083
[   15.489625] microcode: CPU3: patch_level=0x01000083
[   15.489639] microcode: CPU4: patch_level=0x01000083
[   15.489663] microcode: CPU5: patch_level=0x01000083
[   15.489686] microcode: CPU6: patch_level=0x01000083
[   15.489709] microcode: CPU7: patch_level=0x01000083
[   15.489732] microcode: CPU8: patch_level=0x01000083
[   15.489756] microcode: CPU9: patch_level=0x01000083
[   15.489779] microcode: CPU10: patch_level=0x01000083
[   15.489803] microcode: CPU11: patch_level=0x01000083
[   15.489826] microcode: CPU12: patch_level=0x01000083
[   15.489847] microcode: CPU13: patch_level=0x01000083
[   15.489868] microcode: CPU14: patch_level=0x01000083
[   15.489889] microcode: CPU15: patch_level=0x01000083
[   15.489910] microcode: CPU16: patch_level=0x01000083
[   15.489933] microcode: CPU17: patch_level=0x01000083
[   15.489955] microcode: CPU18: patch_level=0x01000083
[   15.489977] microcode: CPU19: patch_level=0x01000083
[   15.490000] microcode: CPU20: patch_level=0x01000083
[   15.490022] microcode: CPU21: patch_level=0x01000083
[   15.490044] microcode: CPU22: patch_level=0x01000083
[   15.490065] microcode: CPU23: patch_level=0x01000083
[   15.490088] microcode: CPU24: patch_level=0x01000083
[   15.490113] microcode: CPU25: patch_level=0x01000083
[   15.490138] microcode: CPU26: patch_level=0x01000083
[   15.490162] microcode: CPU27: patch_level=0x01000083
[   15.490187] microcode: CPU28: patch_level=0x01000083
[   15.490212] microcode: CPU29: patch_level=0x01000083
[   15.490238] microcode: CPU30: patch_level=0x01000083
[   15.490263] microcode: CPU31: patch_level=0x01000083
[   15.490331] microcode: Microcode Update Driver: v2.2.
[   15.490338] IPI shorthand broadcast: enabled
[   15.490360] sched_clock: Marking stable (15485458515, 4862245)->(15621092516, -130771756)
[   15.490674] registered taskstats version 1
[   15.490710] AppArmor: AppArmor sha1 policy hashing enabled
[   15.491645] APEI: Can not request [mem 0xd7fb8a80-0xd7fb8ad3] for APEI BERT registers
[   15.495876] sd 0:0:0:0: [sda] Attached SCSI disk
[   16.813734] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: disabled.
[   16.813773] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[   16.824251] devtmpfs: mounted
[   16.825146] Freeing unused kernel image (initmem) memory: 980K
[   16.836269] Write protecting the kernel read-only data: 16384k
[   16.838171] Freeing unused kernel image (text/rodata gap) memory: 2044K
[   16.839518] Freeing unused kernel image (rodata/data gap) memory: 1608K
[   16.889864] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   16.889883] Run /sbin/init as init process
[   16.889886]   with arguments:
[   16.889890]     /sbin/init
[   16.889892]   with environment:
[   16.889893]     HOME=/
[   16.889895]     TERM=linux
[   16.889896]     BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc4-00015-g45dfb8a5659a
[   17.790459] random: fast init done
[   18.121715] systemd[1]: Inserted module 'autofs4'
[   18.295642] systemd[1]: systemd 247.2-5 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
[   18.295821] systemd[1]: Detected architecture x86-64.
[   18.315760] systemd[1]: Set hostname to <x4600m2>.
[   18.707229] systemd-sysv-generator[283]: SysV service '/etc/init.d/openipmi' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
[   20.133207] systemd[1]: Queued start job for default target Graphical Interface.
[   20.133722] random: systemd: uninitialized urandom read (16 bytes read)
[   20.136720] systemd[1]: Created slice system-getty.slice.
[   20.136912] random: systemd: uninitialized urandom read (16 bytes read)
[   20.137526] systemd[1]: Created slice system-modprobe.slice.
[   20.137555] random: systemd: uninitialized urandom read (16 bytes read)
[   20.138487] systemd[1]: Created slice system-postfix.slice.
[   20.138981] systemd[1]: Created slice User and Session Slice.
[   20.139194] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   20.139259] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   20.139617] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   20.139658] systemd[1]: Reached target Local Encrypted Volumes.
[   20.139735] systemd[1]: Reached target Paths.
[   20.139768] systemd[1]: Reached target Remote File Systems.
[   20.139792] systemd[1]: Reached target Slices.
[   20.139838] systemd[1]: Reached target Swap.
[   20.161514] systemd[1]: Listening on Syslog Socket.
[   20.161645] systemd[1]: Listening on fsck to fsckd communication Socket.
[   20.161739] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   20.161987] systemd[1]: Listening on Journal Audit Socket.
[   20.162102] systemd[1]: Listening on Journal Socket (/dev/log).
[   20.162249] systemd[1]: Listening on Journal Socket.
[   20.162424] systemd[1]: Listening on udev Control Socket.
[   20.162517] systemd[1]: Listening on udev Kernel Socket.
[   20.164201] systemd[1]: Mounting Huge Pages File System...
[   20.165925] systemd[1]: Mounting POSIX Message Queue File System...
[   20.167678] systemd[1]: Mounting Kernel Debug File System...
[   20.167876] systemd[1]: Condition check resulted in Kernel Trace File System being skipped.
[   20.169713] systemd[1]: Starting Set the console keyboard layout...
[   20.172369] systemd[1]: Starting Create list of static device nodes for the current kernel...
[   20.174311] systemd[1]: Starting Load Kernel Module configfs...
[   20.176424] systemd[1]: Starting Load Kernel Module drm...
[   20.178568] systemd[1]: Starting Load Kernel Module fuse...
[   20.201735] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[   20.203679] systemd[1]: Starting File System Check on Root Device...
[   20.207574] systemd[1]: Starting Journal Service...
[   20.214120] systemd[1]: Starting Load Kernel Modules...
[   20.215887] systemd[1]: Starting Coldplug All udev Devices...
[   20.218778] systemd[1]: Mounted Huge Pages File System.
[   20.218954] systemd[1]: Mounted POSIX Message Queue File System.
[   20.219045] systemd[1]: Mounted Kernel Debug File System.
[   20.219531] systemd[1]: Finished Create list of static device nodes for the current kernel.
[   20.219976] systemd[1]: modprobe@configfs.service: Succeeded.
[   20.220303] systemd[1]: Finished Load Kernel Module configfs.
[   20.220659] systemd[1]: modprobe@drm.service: Succeeded.
[   20.220946] systemd[1]: Finished Load Kernel Module drm.
[   20.221246] systemd[1]: Condition check resulted in Kernel Configuration File System being skipped.
[   20.241931] systemd[1]: Started File System Check Daemon to report status.
[   20.467746] systemd[1]: Started Journal Service.
[   20.537627] fuse: init (API version 7.33)
[   20.780409] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro. Quota mode: disabled.
[   22.033123] random: crng init done
[   22.033132] random: 7 urandom warning(s) missed due to ratelimiting
[   23.628876] acpi_cpufreq: overriding BIOS provided _PSD data
[   23.901375] libata version 3.00 loaded.
[   23.901832] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   23.904622] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   23.909838] IPMI message handler: version 39.2
[   23.930987] ipmi device interface
[   23.964974] pata_amd 0000:00:06.0: version 0.4.1
[   23.967150] scsi host1: pata_amd
[   23.967478] scsi host2: pata_amd
[   23.967564] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xefa0 irq 14
[   23.967571] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xefa8 irq 15
[   23.978463] ACPI Warning: SystemIO range 0x000000000000ED00-0x000000000000ED3F conflicts with OpRegion 0x000000000000ED00-0x000000000000ED04 (\_SB.PCI0.SMBU.SMRG) (20201113/utaddress-204)
[   23.978482] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   24.016284] i2c i2c-0: Unrecognized stepping 0x45. Defaulting to ADM1026.
[   24.038425] ACPI: bus type USB registered
[   24.038523] usbcore: registered new interface driver usbfs
[   24.038545] usbcore: registered new interface driver hub
[   24.038618] usbcore: registered new device driver usb
[   24.098727] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input5
[   24.116351] ACPI: Power Button [PWRB]
[   24.116507] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input6
[   24.116601] ACPI: Power Button [PWRF]
[   24.126933] ata1.00: ATAPI: MATSHITACD-RW  CW-8124, DZ13, max UDMA/33
[   24.126970] ata1: nv_mode_filter: 0x739f&0x739f->0x739f, BIOS=0x7000 (0xc0000000) ACPI=0x701f (54:900:0x11)
[   24.158654] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   24.158688] ipmi_si: IPMI System Interface driver
[   24.158725] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[   24.158731] ipmi_platform: ipmi_si: SMBIOS: io 0xca4 regsize 1 spacing 1 irq 0
[   24.158738] ipmi_si: Adding SMBIOS-specified kcs state machine
[   24.158870] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[   24.158933] ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca6-0x0ca7] regsize 1 spacing 1 irq 0
[   24.161399] scsi 1:0:0:0: CD-ROM            MATSHITA CD-RW  CW-8124   DZ13 PQ: 0 ANSI: 5
[   24.171631] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[   24.171772] ata2: port disabled--ignoring
[   24.175770] ehci-pci: EHCI PCI platform driver
[   24.176392] ehci-pci 0000:00:02.1: EHCI Host Controller
[   24.176415] ehci-pci 0000:00:02.1: new USB bus registered, assigned bus number 1
[   24.176433] ehci-pci 0000:00:02.1: debug port 1
[   24.176519] ehci-pci 0000:00:02.1: irq 21, io mem 0xfe7fec00
[   24.189623] ipmi_si: Adding ACPI-specified kcs state machine
[   24.189925] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca4, slave address 0x20, irq 0
[   24.192370] kvm: Nested Virtualization enabled
[   24.192417] SVM: kvm: Nested Paging enabled
[   24.197039] ehci-pci 0000:00:02.1: USB 2.0 started, EHCI 1.00
[   24.197165] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[   24.197169] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.197173] usb usb1: Product: EHCI Host Controller
[   24.197176] usb usb1: Manufacturer: Linux 5.11.0-rc4-00015-g45dfb8a5659a ehci_hcd
[   24.197178] usb usb1: SerialNumber: 0000:00:02.1
[   24.197565] hub 1-0:1.0: USB hub found
[   24.197579] hub 1-0:1.0: 7 ports detected
[   24.204288] i2c i2c-0: Unrecognized stepping 0x45. Defaulting to ADM1026.
[   24.345928] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   24.384273] i2c i2c-0: Found version/stepping 0x46. Assuming generic ADM1026.
[   24.429359] ohci-pci: OHCI PCI platform driver
[   24.429833] ohci-pci 0000:00:02.0: OHCI PCI host controller
[   24.429859] ohci-pci 0000:00:02.0: new USB bus registered, assigned bus number 2
[   24.429959] ohci-pci 0000:00:02.0: irq 22, io mem 0xfe7ff000
[   24.470648] EDAC MC: Ver: 3.0.0
[   24.494374] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.11
[   24.494385] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.494390] usb usb2: Product: OHCI PCI host controller
[   24.494393] usb usb2: Manufacturer: Linux 5.11.0-rc4-00015-g45dfb8a5659a ohci_hcd
[   24.494397] usb usb2: SerialNumber: 0000:00:02.0
[   24.494803] hub 2-0:1.0: USB hub found
[   24.494905] hub 2-0:1.0: 7 ports detected
[   24.574501] MCE: In-kernel MCE decoding enabled.
[   24.604343] e1000: Intel(R) PRO/1000 Network Driver
[   24.604355] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   24.628875] ipmi_si dmi-ipmi-si.0: IPMI message handler: Found new BMC (man_id: 0x00002a, prod_id: 0x4701, dev_id: 0x20)
[   24.630004] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.02.00.104-k.
[   24.630576] PCI Interrupt Link [LNKD] enabled at IRQ 19
[   24.630659] qla2xxx [0000:00:00.0]-001d: : Found an ISP2432 irq 19 iobase 0x00000000c7814279.
[   24.687897] ipmi_si dmi-ipmi-si.0: IPMI kcs interface initialized
[   24.687939] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda caddy
[   24.687962] cdrom: Uniform CD-ROM driver Revision: 3.20
[   24.698620] EDAC amd64: F10h detected (node 0).
[   24.698700] EDAC amd64: Node 0: DRAM ECC enabled.
[   24.699034] EDAC MC0: Giving out device to module amd64_edac controller F10h: DEV 0000:00:18.3 (INTERRUPT)
[   24.699040] EDAC MC: DCT0 chip selects:
[   24.699042] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   24.699046] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   24.699048] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   24.699051] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   24.699053] EDAC MC: DCT1 chip selects:
[   24.699055] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   24.699057] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   24.699059] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   24.699062] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   24.699064] EDAC amd64: using x4 syndromes.
[   24.699068] EDAC amd64: F10h detected (node 1).
[   24.699106] EDAC amd64: Node 1: DRAM ECC enabled.
[   24.699368] EDAC MC1: Giving out device to module amd64_edac controller F10h: DEV 0000:00:19.3 (INTERRUPT)
[   24.699372] EDAC MC: DCT0 chip selects:
[   24.699373] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   24.699376] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   24.699379] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   24.699381] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   24.699383] EDAC MC: DCT1 chip selects:
[   24.699385] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   24.699387] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   24.699390] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   24.699392] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   24.699394] EDAC amd64: using x4 syndromes.
[   24.699398] EDAC amd64: F10h detected (node 2).
[   24.699439] EDAC amd64: Node 2: DRAM ECC enabled.
[   24.699688] EDAC MC2: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1a.3 (INTERRUPT)
[   24.699691] EDAC MC: DCT0 chip selects:
[   24.699693] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   24.699695] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   24.699698] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   24.699700] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   24.699702] EDAC MC: DCT1 chip selects:
[   24.699704] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   24.699706] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   24.699708] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   24.699711] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   24.699713] EDAC amd64: using x4 syndromes.
[   24.699716] EDAC amd64: F10h detected (node 3).
[   24.699758] EDAC amd64: Node 3: DRAM ECC enabled.
[   24.700024] EDAC MC3: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1b.3 (INTERRUPT)
[   24.700027] EDAC MC: DCT0 chip selects:
[   24.700029] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   24.700032] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   24.700034] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   24.700036] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   24.700039] EDAC MC: DCT1 chip selects:
[   24.700040] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   24.700043] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   24.700045] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   24.700047] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   24.700050] EDAC amd64: using x4 syndromes.
[   24.700052] EDAC amd64: F10h detected (node 4).
[   24.700095] EDAC amd64: Node 4: DRAM ECC enabled.
[   24.700498] EDAC MC4: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1c.3 (INTERRUPT)
[   24.700503] EDAC MC: DCT0 chip selects:
[   24.700505] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   24.700507] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   24.700509] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   24.700518] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   24.700535] EDAC MC: DCT1 chip selects:
[   24.700540] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   24.700543] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   24.700546] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   24.700548] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   24.700550] EDAC amd64: using x4 syndromes.
[   24.700554] EDAC amd64: F10h detected (node 5).
[   24.700624] EDAC amd64: Node 5: DRAM ECC enabled.
[   24.700723] ipmi_ssif: IPMI SSIF Interface driver
[   24.701004] EDAC MC5: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1d.3 (INTERRUPT)
[   24.701009] EDAC MC: DCT0 chip selects:
[   24.701011] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   24.701013] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   24.701016] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   24.701018] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   24.701021] EDAC MC: DCT1 chip selects:
[   24.701022] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   24.701024] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   24.701027] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   24.701029] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   24.701031] EDAC amd64: using x4 syndromes.
[   24.701036] EDAC amd64: F10h detected (node 6).
[   24.701081] EDAC amd64: Node 6: DRAM ECC enabled.
[   24.701385] EDAC MC6: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1e.3 (INTERRUPT)
[   24.701390] EDAC MC: DCT0 chip selects:
[   24.701391] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   24.701394] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   24.701397] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   24.701399] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   24.701401] EDAC MC: DCT1 chip selects:
[   24.701404] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   24.701410] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   24.701412] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   24.701415] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   24.701417] EDAC amd64: using x4 syndromes.
[   24.701420] EDAC amd64: F10h detected (node 7).
[   24.701515] EDAC amd64: Node 7: DRAM ECC enabled.
[   24.701779] EDAC MC7: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1f.3 (INTERRUPT)
[   24.701784] EDAC MC: DCT0 chip selects:
[   24.701785] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   24.701788] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   24.701790] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   24.701793] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   24.701795] EDAC MC: DCT1 chip selects:
[   24.701797] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   24.701799] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   24.701802] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   24.701804] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   24.701810] EDAC amd64: using x4 syndromes.
[   24.701835] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[   24.701839] AMD64 EDAC driver v3.5.0
[   24.740153] qla2xxx [0000:03:00.0]-ffff:3: FC4 priority set to FCP
[   24.746514] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   24.948998] audit: type=1400 audit(1611250512.963:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=344 comm="apparmor_parser"
[   24.949029] audit: type=1400 audit(1611250512.963:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=344 comm="apparmor_parser"
[   24.977938] e1000 0000:05:01.0 eth0: (PCI-X:133MHz:64-bit) 00:14:4f:d1:d2:fc
[   24.977960] e1000 0000:05:01.0 eth0: Intel(R) PRO/1000 Network Connection
[   24.978634] audit: type=1400 audit(1611250512.991:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=345 comm="apparmor_parser"
[   24.978646] audit: type=1400 audit(1611250512.991:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=345 comm="apparmor_parser"
[   24.978654] audit: type=1400 audit(1611250512.991:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=345 comm="apparmor_parser"
[   25.004859] audit: type=1400 audit(1611250513.019:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=346 comm="apparmor_parser"
[   25.076617] i2c i2c-0: nForce2 SMBus adapter at 0xed40
[   25.126802] usb 2-3: new full-speed USB device number 2 using ohci-pci
[   25.202360] scsi host3: qla2xxx
[   25.211599] qla2xxx [0000:03:00.0]-00fb:3: QLogic QLE2460 - SG-(X)PCIE1FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Express Single Channel.
[   25.211616] qla2xxx [0000:03:00.0]-00fc:3: ISP2432: PCIe (2.5GT/s x4) @ 0000:03:00.0 hdma+ host#=3 fw=8.07.00 (9496).
[   25.212301] PCI Interrupt Link [LN2D] enabled at IRQ 43
[   25.212504] qla2xxx [0000:00:00.0]-001d: : Found an ISP2432 irq 29 iobase 0x000000008ee626d2.
[   25.270683] qla2xxx [0000:82:00.0]-ffff:4: FC4 priority set to FCP
[   25.301834] e1000 0000:05:01.1 eth1: (PCI-X:133MHz:64-bit) 00:14:4f:d1:d2:fd
[   25.301846] e1000 0000:05:01.1 eth1: Intel(R) PRO/1000 Network Connection
[   25.379490] usb 2-3: New USB device found, idVendor=046b, idProduct=ff10, bcdDevice= 1.00
[   25.379500] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   25.379507] usb 2-3: Product: Virtual Keyboard and Mouse
[   25.379511] usb 2-3: Manufacturer: American Megatrends Inc.
[   25.448479] usb 1-6: new high-speed USB device number 3 using ehci-pci
[   25.608664] usb 1-6: New USB device found, idVendor=04b4, idProduct=6560, bcdDevice= 0.0b
[   25.608670] usb 1-6: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   25.608961] hub 1-6:1.0: USB hub found
[   25.609038] hub 1-6:1.0: 4 ports detected
[   25.620521] scsi host4: qla2xxx
[   25.623569] qla2xxx [0000:82:00.0]-00fb:4: QLogic QLE2460 - SG-(X)PCIE1FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Express Single Channel.
[   25.623591] qla2xxx [0000:82:00.0]-00fc:4: ISP2432: PCIe (2.5GT/s x4) @ 0000:82:00.0 hdma+ host#=4 fw=8.07.00 (9496).
[   25.625753] e1000 0000:05:02.0 eth2: (PCI-X:133MHz:64-bit) 00:14:4f:d1:d2:fe
[   25.625764] e1000 0000:05:02.0 eth2: Intel(R) PRO/1000 Network Connection
[   25.878793] hid: raw HID events driver (C) Jiri Kosina
[   25.915624] usbcore: registered new interface driver usbhid
[   25.915641] usbhid: USB HID core driver
[   25.949837] e1000 0000:05:02.1 eth3: (PCI-X:133MHz:64-bit) 00:14:4f:d1:d2:ff
[   25.949849] e1000 0000:05:02.1 eth3: Intel(R) PRO/1000 Network Connection
[   26.041168] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:02.0/usb2/2-3/2-3:1.0/0003:046B:FF10.0001/input/input7
[   26.041389] hid-generic 0003:046B:FF10.0001: input,hidraw0: USB HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:02.0-3/input0
[   26.041728] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:02.0/usb2/2-3/2-3:1.1/0003:046B:FF10.0002/input/input8
[   26.041919] hid-generic 0003:046B:FF10.0002: input,hidraw1: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:02.0-3/input1
[   26.076038] e1000 0000:05:01.1 enp5s1f1: renamed from eth1
[   26.108627] e1000 0000:05:02.0 enp5s2f0: renamed from eth2
[   26.148629] e1000 0000:05:02.1 enp5s2f1: renamed from eth3
[   26.200769] e1000 0000:05:01.0 enp5s1f0: renamed from eth0
[   28.788689] e1000: enp5s1f0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   28.789087] IPv6: ADDRCONF(NETDEV_CHANGE): enp5s1f0: link becomes ready
[   46.708312] qla2xxx [0000:03:00.0]-8038:3: Cable is unplugged...
[   47.124314] qla2xxx [0000:82:00.0]-8038:4: Cable is unplugged...
