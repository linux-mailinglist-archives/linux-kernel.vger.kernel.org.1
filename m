Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FBE2FEC57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbhAUNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:53:30 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:49423 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbhAUNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:52:44 -0500
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 08:51:59 EST
From:   Meelis Roos <mroos@linux.ee>
Subject: 5.11-rc4+git: Shortest NUMA path spans too many nodes
To:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <3ec17983-7959-eccd-af25-400056a5877d@linux.ee>
Date:   Thu, 21 Jan 2021 15:41:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This happens on Sun Fire X4600 M2 - 32 cores in 8 CPU slots. 5.10 was silent. Current git and
5.10.0-13256-g5814bc2d4cc2 exhibit this message in dmesg but otherwise seem to work fine
(kernel compilation succeeds).

[    2.810027] smp: Bringing up secondary CPUs ...
[    2.810027] x86: Booting SMP configuration:
[    2.810027] .... node  #0, CPUs:        #1  #2  #3
[    2.816380] .... node  #1, CPUs:    #4  #5  #6  #7
[    2.906453] .... node  #2, CPUs:    #8  #9 #10 #11
[    2.998491] .... node  #3, CPUs:   #12 #13 #14 #15
[    3.090470] .... node  #4, CPUs:   #16 #17 #18 #19
[    3.182453] .... node  #5, CPUs:   #20 #21 #22 #23
[    3.274472] .... node  #6, CPUs:   #24 #25 #26 #27
[    3.366496] .... node  #7, CPUs:   #28 #29 #30 #31
[    3.458319] smp: Brought up 8 nodes, 32 CPUs
[    3.458319] smpboot: Max logical packages: 8
[    3.458319] smpboot: Total of 32 processors activated (147138.09 BogoMIPS)
[    3.463111] ------------[ cut here ]------------
[    3.463127] Shortest NUMA path spans too many nodes
[    3.463139] WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:753 cpu_attach_domain+0x3f0/0x510
[    3.463161] Modules linked in:
[    3.463167] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc4-00015-g45dfb8a5659a #54
[    3.463173] Hardware name: Sun Microsystems     Sun Fire X4600 M2/Sun Fire X4600 M2, BIOS 0ABIT132 12/03/2009
[    3.463176] RIP: 0010:cpu_attach_domain+0x3f0/0x510
[    3.463182] Code: 0f b6 05 1b e8 0a 01 3c 01 0f 87 9d 99 63 00 a8 01 0f 85 9f fd ff ff 48 c7 c7 d8 66 bb af c6 05 fd e7 0a 01 01 e8 38 71 63 00 <0f> 0b e9 85 fd ff ff 44 8b 74 24 04 45 31 ed b8 01 00 00 00 e9 fd
[    3.463187] RSP: 0018:ffff98ee46273e10 EFLAGS: 00010282
[    3.463191] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff98ee46273c98
[    3.463193] RDX: 00000000ffffdfff RSI: 0000000000000003 RDI: 0000000000000000
[    3.463195] RBP: 0000000000020ec0 R08: 0000000000000003 R09: 0000000000000001
[    3.463197] R10: 0000000000002000 R11: 0000000000000001 R12: ffff970901303c00
[    3.463200] R13: ffff970c17c20ec0 R14: ffff970901306cc0 R15: ffff97182923d800
[    3.463202] FS:  0000000000000000(0000) GS:ffff970c17c00000(0000) knlGS:0000000000000000
[    3.463205] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.463207] CR2: ffff97186b801000 CR3: 000000106b20a000 CR4: 00000000000006f0
[    3.463210] Call Trace:
[    3.463220]  build_sched_domains+0x1115/0x14a0
[    3.463227]  sched_init_smp+0x1d/0x5d
[    3.463236]  kernel_init_freeable+0xb7/0x233
[    3.463241]  ? rest_init+0xcd/0xcd
[    3.466034]  kernel_init+0x6/0x113
[    3.466038]  ? rest_init+0xcd/0xcd
[    3.466040]  ret_from_fork+0x22/0x30
[    3.466050] ---[ end trace abb3d1a04f45130f ]---


Full dmesg:
[    0.000000] Linux version 5.11.0-rc4-00015-g45dfb8a5659a (mroos@x4600m2) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1) #54 SMP Wed Jan 20 21:51:48 EET 2021
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
[    0.000000] tsc: Detected 2293.901 MHz processor
[    0.005877] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.005882] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.011599] AGP: No AGP bridge found
[    0.011735] last_pfn = 0x2028000 max_arch_pfn = 0x400000000
[    0.011758] MTRR default type: uncachable
[    0.011761] MTRR fixed ranges enabled:
[    0.011763]   00000-9FFFF write-back
[    0.011767]   A0000-EFFFF uncachable
[    0.011769]   F0000-FFFFF write-protect
[    0.011770] MTRR variable ranges enabled:
[    0.011772]   0 base 000000000000 mask FFFF80000000 write-back
[    0.011776]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.011779]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.011782]   3 base 0000D0000000 mask FFFFF8000000 write-back
[    0.011785]   4 disabled
[    0.011786]   5 disabled
[    0.011787]   6 disabled
[    0.011789]   7 disabled
[    0.011790] TOM2: 0000002028000000 aka 131712M
[    0.012826] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.013142] e820: update [mem 0xd8000000-0xffffffff] usable ==> reserved
[    0.013175] last_pfn = 0xd7fa0 max_arch_pfn = 0x400000000
[    0.018491] found SMP MP-table at [mem 0x000ff780-0x000ff78f]
[    0.018545] Using GB pages for direct mapping
[    0.019097] ACPI: Early table checksum verification disabled
[    0.019106] ACPI: RSDP 0x00000000000F9EE0 000024 (v02 SUN   )
[    0.019115] ACPI: XSDT 0x00000000D7FB0100 00009C (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.019126] ACPI: FACP 0x00000000D7FB0290 0000F4 (v03 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.019136] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 64/32 (20201113/tbfadt-564)
[    0.019142] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe1Block: 128/64 (20201113/tbfadt-564)
[    0.019147] ACPI: DSDT 0x00000000D7FB0710 007DF7 (v01 SUN    X4600 M2 00000132 INTL 20051117)
[    0.019153] ACPI: FACS 0x00000000D7FBE000 000040
[    0.019156] ACPI: FACS 0x00000000D7FBE000 000040
[    0.019160] ACPI: APIC 0x00000000D7FB0390 000170 (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.019165] ACPI: SPCR 0x00000000D7FB0500 000050 (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.019169] ACPI: MCFG 0x00000000D7FB0550 00003C (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.019173] ACPI: SLIT 0x00000000D7FB064C 00006C (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.019178] ACPI: SPMI 0x00000000D7FB06C0 000041 (v05 SUN    OEMSPMI  00000132 MSFT 00000097)
[    0.019182] ACPI: OEMB 0x00000000D7FBE040 000063 (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.019187] ACPI: SRAT 0x00000000D7FB8510 0003C0 (v01 AMD    FAM_F_10 00000002 AMD  00000001)
[    0.019191] ACPI: HPET 0x00000000D7FB88D0 000038 (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.019195] ACPI: IPET 0x00000000D7FB8910 000038 (v01 SUN    X4600 M2 00000132 MSFT 00000097)
[    0.019200] ACPI: EINJ 0x00000000D7FB8950 000130 (v01 AMIER  AMI_EINJ 12000903 MSFT 00000097)
[    0.019205] ACPI: BERT 0x00000000D7FB8AE0 000030 (v01 AMIER  AMI_BERT 12000903 MSFT 00000097)
[    0.019209] ACPI: ERST 0x00000000D7FB8B10 0001B0 (v01 AMIER  AMI_ERST 12000903 MSFT 00000097)
[    0.019214] ACPI: HEST 0x00000000D7FB8CC0 0000A8 (v01 AMIER  ABC_HEST 12000903 MSFT 00000097)
[    0.019218] ACPI: SSDT 0x00000000D7FB8D70 005084 (v01 A M I  POWERNOW 00000001 AMD  00000001)
[    0.019234] ACPI: Local APIC address 0xfee00000
[    0.019342] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.019345] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.019347] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.019348] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.019350] SRAT: PXM 1 -> APIC 0x08 -> Node 1
[    0.019352] SRAT: PXM 1 -> APIC 0x09 -> Node 1
[    0.019354] SRAT: PXM 1 -> APIC 0x0a -> Node 1
[    0.019356] SRAT: PXM 1 -> APIC 0x0b -> Node 1
[    0.019357] SRAT: PXM 2 -> APIC 0x0c -> Node 2
[    0.019359] SRAT: PXM 2 -> APIC 0x0d -> Node 2
[    0.019360] SRAT: PXM 2 -> APIC 0x0e -> Node 2
[    0.019362] SRAT: PXM 2 -> APIC 0x0f -> Node 2
[    0.019364] SRAT: PXM 3 -> APIC 0x10 -> Node 3
[    0.019365] SRAT: PXM 3 -> APIC 0x11 -> Node 3
[    0.019367] SRAT: PXM 3 -> APIC 0x12 -> Node 3
[    0.019369] SRAT: PXM 3 -> APIC 0x13 -> Node 3
[    0.019371] SRAT: PXM 4 -> APIC 0x14 -> Node 4
[    0.019372] SRAT: PXM 4 -> APIC 0x15 -> Node 4
[    0.019374] SRAT: PXM 4 -> APIC 0x16 -> Node 4
[    0.019375] SRAT: PXM 4 -> APIC 0x17 -> Node 4
[    0.019377] SRAT: PXM 5 -> APIC 0x18 -> Node 5
[    0.019379] SRAT: PXM 5 -> APIC 0x19 -> Node 5
[    0.019380] SRAT: PXM 5 -> APIC 0x1a -> Node 5
[    0.019382] SRAT: PXM 5 -> APIC 0x1b -> Node 5
[    0.019384] SRAT: PXM 6 -> APIC 0x1c -> Node 6
[    0.019385] SRAT: PXM 6 -> APIC 0x1d -> Node 6
[    0.019387] SRAT: PXM 6 -> APIC 0x1e -> Node 6
[    0.019388] SRAT: PXM 6 -> APIC 0x1f -> Node 6
[    0.019390] SRAT: PXM 7 -> APIC 0x20 -> Node 7
[    0.019391] SRAT: PXM 7 -> APIC 0x21 -> Node 7
[    0.019393] SRAT: PXM 7 -> APIC 0x22 -> Node 7
[    0.019395] SRAT: PXM 7 -> APIC 0x23 -> Node 7
[    0.019399] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.019402] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xd7ffffff]
[    0.019404] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x427ffffff]
[    0.019406] ACPI: SRAT: Node 1 PXM 1 [mem 0x428000000-0x827ffffff]
[    0.019409] ACPI: SRAT: Node 2 PXM 2 [mem 0x828000000-0xc27ffffff]
[    0.019411] ACPI: SRAT: Node 3 PXM 3 [mem 0xc28000000-0x1027ffffff]
[    0.019413] ACPI: SRAT: Node 4 PXM 4 [mem 0x1028000000-0x1427ffffff]
[    0.019415] ACPI: SRAT: Node 5 PXM 5 [mem 0x1428000000-0x1827ffffff]
[    0.019417] ACPI: SRAT: Node 6 PXM 6 [mem 0x1828000000-0x1c27ffffff]
[    0.019419] ACPI: SRAT: Node 7 PXM 7 [mem 0x1c28000000-0x2027ffffff]
[    0.019425] NUMA: Initialized distance table, cnt=8
[    0.019429] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xd7ffffff] -> [mem 0x00000000-0xd7ffffff]
[    0.019433] NUMA: Node 0 [mem 0x00000000-0xd7ffffff] + [mem 0x100000000-0x427ffffff] -> [mem 0x00000000-0x427ffffff]
[    0.019445] NODE_DATA(0) allocated [mem 0x427ffd000-0x427ffffff]
[    0.019452] NODE_DATA(1) allocated [mem 0x827ffd000-0x827ffffff]
[    0.019458] NODE_DATA(2) allocated [mem 0xc27ffd000-0xc27ffffff]
[    0.019465] NODE_DATA(3) allocated [mem 0x1027ffd000-0x1027ffffff]
[    0.019472] NODE_DATA(4) allocated [mem 0x1427ffd000-0x1427ffffff]
[    0.019479] NODE_DATA(5) allocated [mem 0x1827ffd000-0x1827ffffff]
[    0.019485] NODE_DATA(6) allocated [mem 0x1c27ffd000-0x1c27ffffff]
[    0.019492] NODE_DATA(7) allocated [mem 0x2027ffc000-0x2027ffefff]
[    0.019769] Zone ranges:
[    0.019771]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.019774]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.019777]   Normal   [mem 0x0000000100000000-0x0000002027ffffff]
[    0.019780] Movable zone start for each node
[    0.019781] Early memory node ranges
[    0.019782]   node   0: [mem 0x0000000000001000-0x0000000000098fff]
[    0.019785]   node   0: [mem 0x0000000000100000-0x00000000d7f9ffff]
[    0.019787]   node   0: [mem 0x0000000100000000-0x0000000427ffffff]
[    0.019790]   node   1: [mem 0x0000000428000000-0x0000000827ffffff]
[    0.019793]   node   2: [mem 0x0000000828000000-0x0000000c27ffffff]
[    0.019797]   node   3: [mem 0x0000000c28000000-0x0000001027ffffff]
[    0.019800]   node   4: [mem 0x0000001028000000-0x0000001427ffffff]
[    0.019803]   node   5: [mem 0x0000001428000000-0x0000001827ffffff]
[    0.019806]   node   6: [mem 0x0000001828000000-0x0000001c27ffffff]
[    0.019809]   node   7: [mem 0x0000001c28000000-0x0000002027ffffff]
[    0.019826] Zeroed struct page in unavailable ranges: 200 pages
[    0.019828] Initmem setup node 0 [mem 0x0000000000001000-0x0000000427ffffff]
[    0.019833] On node 0 totalpages: 4194104
[    0.019836]   DMA zone: 64 pages used for memmap
[    0.019838]   DMA zone: 21 pages reserved
[    0.019840]   DMA zone: 3992 pages, LIFO batch:0
[    0.019968]   DMA32 zone: 13759 pages used for memmap
[    0.019970]   DMA32 zone: 880544 pages, LIFO batch:63
[    0.048459]   Normal zone: 51712 pages used for memmap
[    0.048466]   Normal zone: 3309568 pages, LIFO batch:63
[    0.154146] Initmem setup node 1 [mem 0x0000000428000000-0x0000000827ffffff]
[    0.154153] On node 1 totalpages: 4194304
[    0.154156]   Normal zone: 65536 pages used for memmap
[    0.154159]   Normal zone: 4194304 pages, LIFO batch:63
[    0.296569] Initmem setup node 2 [mem 0x0000000828000000-0x0000000c27ffffff]
[    0.296577] On node 2 totalpages: 4194304
[    0.296579]   Normal zone: 65536 pages used for memmap
[    0.296581]   Normal zone: 4194304 pages, LIFO batch:63
[    0.457530] Initmem setup node 3 [mem 0x0000000c28000000-0x0000001027ffffff]
[    0.457537] On node 3 totalpages: 4194304
[    0.457539]   Normal zone: 65536 pages used for memmap
[    0.457541]   Normal zone: 4194304 pages, LIFO batch:63
[    0.632336] Initmem setup node 4 [mem 0x0000001028000000-0x0000001427ffffff]
[    0.632343] On node 4 totalpages: 4194304
[    0.632345]   Normal zone: 65536 pages used for memmap
[    0.632348]   Normal zone: 4194304 pages, LIFO batch:63
[    0.792877] Initmem setup node 5 [mem 0x0000001428000000-0x0000001827ffffff]
[    0.792884] On node 5 totalpages: 4194304
[    0.792887]   Normal zone: 65536 pages used for memmap
[    0.792889]   Normal zone: 4194304 pages, LIFO batch:63
[    0.951184] Initmem setup node 6 [mem 0x0000001828000000-0x0000001c27ffffff]
[    0.951191] On node 6 totalpages: 4194304
[    0.951194]   Normal zone: 65536 pages used for memmap
[    0.951196]   Normal zone: 4194304 pages, LIFO batch:63
[    1.109349] Initmem setup node 7 [mem 0x0000001c28000000-0x0000002027ffffff]
[    1.109356] On node 7 totalpages: 4194304
[    1.109359]   Normal zone: 65536 pages used for memmap
[    1.109361]   Normal zone: 4194304 pages, LIFO batch:63
[    1.288969] ACPI: PM-Timer IO Port: 0xe008
[    1.288976] ACPI: Local APIC address 0xfee00000
[    1.288999] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    1.289006] IOAPIC[1]: apic_id 1, version 17, address 0xfe7fd000, GSI 48-54
[    1.289012] IOAPIC[2]: apic_id 2, version 17, address 0xfe7fc000, GSI 56-62
[    1.289020] IOAPIC[3]: apic_id 3, version 17, address 0xfeaff000, GSI 24-47
[    1.289024] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    1.289029] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    1.289032] ACPI: IRQ0 used by override.
[    1.289035] ACPI: IRQ9 used by override.
[    1.289037] Using ACPI (MADT) for SMP configuration information
[    1.289040] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    1.289048] ACPI: SPCR: SPCR table version 1
[    1.289052] ACPI: SPCR: console: uart,io,0x3f8,9600
[    1.289056] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    1.289093] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    1.289097] PM: hibernation: Registered nosave memory: [mem 0x00099000-0x00099fff]
[    1.289099] PM: hibernation: Registered nosave memory: [mem 0x0009a000-0x0009ffff]
[    1.289101] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000e5fff]
[    1.289102] PM: hibernation: Registered nosave memory: [mem 0x000e6000-0x000fffff]
[    1.289105] PM: hibernation: Registered nosave memory: [mem 0xd7fa0000-0xd7fadfff]
[    1.289107] PM: hibernation: Registered nosave memory: [mem 0xd7fae000-0xd7faffff]
[    1.289109] PM: hibernation: Registered nosave memory: [mem 0xd7fb0000-0xd7fbdfff]
[    1.289110] PM: hibernation: Registered nosave memory: [mem 0xd7fbe000-0xd7feffff]
[    1.289112] PM: hibernation: Registered nosave memory: [mem 0xd7ff0000-0xd7ffffff]
[    1.289113] PM: hibernation: Registered nosave memory: [mem 0xd8000000-0xdbffffff]
[    1.289115] PM: hibernation: Registered nosave memory: [mem 0xdc000000-0xefffffff]
[    1.289117] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfebfffff]
[    1.289118] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    1.289120] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
[    1.289121] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    1.289123] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xff6fffff]
[    1.289125] PM: hibernation: Registered nosave memory: [mem 0xff700000-0xffffffff]
[    1.289129] [mem 0xf0000000-0xfebfffff] available for PCI devices
[    1.289135] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    1.294074] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:8
[    1.304962] percpu: Embedded 44 pages/cpu s139544 r8192 d32488 u524288
[    1.304980] pcpu-alloc: s139544 r8192 d32488 u524288 alloc=1*2097152
[    1.304986] pcpu-alloc: [0] 00 01 02 03 [1] 04 05 06 07
[    1.304997] pcpu-alloc: [2] 08 09 10 11 [3] 12 13 14 15
[    1.305006] pcpu-alloc: [4] 16 17 18 19 [5] 20 21 22 23
[    1.305018] pcpu-alloc: [6] 24 25 26 27 [7] 28 29 30 31
[    1.305100] Built 8 zonelists, mobility grouping on.  Total pages: 33029924
[    1.305103] Policy zone: Normal
[    1.305107] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc4-00015-g45dfb8a5659a root=/dev/sda1 ro quiet
[    1.305179] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    1.305181] printk: log_buf_len total cpu_extra contributions: 126976 bytes
[    1.305183] printk: log_buf_len min size: 131072 bytes
[    1.306071] printk: log_buf_len: 262144 bytes
[    1.306078] printk: early log buf free: 116912(89%)
[    1.306433] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.335519] AGP: Checking aperture...
[    1.341226] AGP: No AGP bridge found
[    1.341253] AGP: Node 0: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.341258] AGP: Node 1: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.341262] AGP: Node 2: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.341265] AGP: Node 3: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.341268] AGP: Node 4: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.341270] AGP: Node 5: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.341273] AGP: Node 6: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    1.341276] AGP: Node 7: aperture [bus addr 0xdc000000-0xdfffffff] (64MB)
[    2.611862] Memory: 132023920K/134216928K available (10243K kernel code, 1493K rwdata, 2480K rodata, 984K init, 1316K bss, 2192748K reserved, 0K cma-reserved)
[    2.612606] rcu: Hierarchical RCU implementation.
[    2.612611] 	Tracing variant of Tasks RCU enabled.
[    2.612613] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    2.612670] NR_IRQS: 4352, nr_irqs: 1343, preallocated irqs: 16
[    2.613165] random: get_random_bytes called from start_kernel+0x314/0x460 with crng_init=0
[    2.613255] spurious 8259A interrupt: IRQ7.
[    2.617233] Console: colour VGA+ 80x25
[    2.617291] printk: console [tty0] enabled
[    2.617634] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    2.617644] ACPI: Core revision 20201113
[    2.617977] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
[    2.618011] APIC: Switch to symmetric I/O mode setup
[    2.618013] Switched APIC routing to physical flat.
[    2.618701] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    2.638019] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2110b3d692c, max_idle_ns: 440795319259 ns
[    2.638030] Calibrating delay loop (skipped), value calculated using timer frequency.. 4587.80 BogoMIPS (lpj=9175604)
[    2.638038] pid_max: default: 32768 minimum: 301
[    2.638463] LSM: Security Framework initializing
[    2.638606] AppArmor: AppArmor initialized
[    2.677893] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc)
[    2.697301] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, vmalloc)
[    2.698107] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    2.698693] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    2.699966] LVT offset 0 assigned for vector 0xf9
[    2.699977] process: using AMD E400 aware idle routine
[    2.699981] Last level iTLB entries: 4KB 512, 2MB 16, 4MB 8
[    2.699984] Last level dTLB entries: 4KB 512, 2MB 128, 4MB 64, 1GB 0
[    2.699996] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    2.700000] Spectre V2 : Mitigation: Full AMD retpoline
[    2.700003] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    2.700190] Freeing SMP alternatives memory: 28K
[    2.808986] smpboot: CPU0: Quad-Core AMD Opteron(tm) Processor 8356 (family: 0x10, model: 0x2, stepping: 0x3)
[    2.809310] Performance Events: AMD PMU driver.
[    2.809320] ... version:                0
[    2.809321] ... bit width:              48
[    2.809323] ... generic registers:      4
[    2.809325] ... value mask:             0000ffffffffffff
[    2.809327] ... max period:             00007fffffffffff
[    2.809328] ... fixed-purpose events:   0
[    2.809330] ... event mask:             000000000000000f
[    2.809510] rcu: Hierarchical SRCU implementation.
[    2.810021] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    2.810027] smp: Bringing up secondary CPUs ...
[    2.810027] x86: Booting SMP configuration:
[    2.810027] .... node  #0, CPUs:        #1  #2  #3
[    2.816380] .... node  #1, CPUs:    #4  #5  #6  #7
[    2.906453] .... node  #2, CPUs:    #8  #9 #10 #11
[    2.998491] .... node  #3, CPUs:   #12 #13 #14 #15
[    3.090470] .... node  #4, CPUs:   #16 #17 #18 #19
[    3.182453] .... node  #5, CPUs:   #20 #21 #22 #23
[    3.274472] .... node  #6, CPUs:   #24 #25 #26 #27
[    3.366496] .... node  #7, CPUs:   #28 #29 #30 #31
[    3.458319] smp: Brought up 8 nodes, 32 CPUs
[    3.458319] smpboot: Max logical packages: 8
[    3.458319] smpboot: Total of 32 processors activated (147138.09 BogoMIPS)
[    3.463111] ------------[ cut here ]------------
[    3.463127] Shortest NUMA path spans too many nodes
[    3.463139] WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:753 cpu_attach_domain+0x3f0/0x510
[    3.463161] Modules linked in:
[    3.463167] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc4-00015-g45dfb8a5659a #54
[    3.463173] Hardware name: Sun Microsystems     Sun Fire X4600 M2/Sun Fire X4600 M2, BIOS 0ABIT132 12/03/2009
[    3.463176] RIP: 0010:cpu_attach_domain+0x3f0/0x510
[    3.463182] Code: 0f b6 05 1b e8 0a 01 3c 01 0f 87 9d 99 63 00 a8 01 0f 85 9f fd ff ff 48 c7 c7 d8 66 bb af c6 05 fd e7 0a 01 01 e8 38 71 63 00 <0f> 0b e9 85 fd ff ff 44 8b 74 24 04 45 31 ed b8 01 00 00 00 e9 fd
[    3.463187] RSP: 0018:ffff98ee46273e10 EFLAGS: 00010282
[    3.463191] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff98ee46273c98
[    3.463193] RDX: 00000000ffffdfff RSI: 0000000000000003 RDI: 0000000000000000
[    3.463195] RBP: 0000000000020ec0 R08: 0000000000000003 R09: 0000000000000001
[    3.463197] R10: 0000000000002000 R11: 0000000000000001 R12: ffff970901303c00
[    3.463200] R13: ffff970c17c20ec0 R14: ffff970901306cc0 R15: ffff97182923d800
[    3.463202] FS:  0000000000000000(0000) GS:ffff970c17c00000(0000) knlGS:0000000000000000
[    3.463205] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.463207] CR2: ffff97186b801000 CR3: 000000106b20a000 CR4: 00000000000006f0
[    3.463210] Call Trace:
[    3.463220]  build_sched_domains+0x1115/0x14a0
[    3.463227]  sched_init_smp+0x1d/0x5d
[    3.463236]  kernel_init_freeable+0xb7/0x233
[    3.463241]  ? rest_init+0xcd/0xcd
[    3.466034]  kernel_init+0x6/0x113
[    3.466038]  ? rest_init+0xcd/0xcd
[    3.466040]  ret_from_fork+0x22/0x30
[    3.466050] ---[ end trace abb3d1a04f45130f ]---
[    3.484046] devtmpfs: initialized
[    3.484046] PM: Registering ACPI NVS region [mem 0xd7fbe000-0xd7feffff] (204800 bytes)
[    3.484046] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    3.484046] futex hash table entries: 8192 (order: 7, 524288 bytes, vmalloc)
[    3.486349] NET: Registered protocol family 16
[    3.486533] audit: initializing netlink subsys (disabled)
[    3.486547] audit: type=2000 audit(1611172719.868:1): state=initialized audit_enabled=0 res=1
[    3.486547] thermal_sys: Registered thermal governor 'step_wise'
[    3.486547] cpuidle: using governor ladder
[    3.486547] cpuidle: using governor menu
[    3.486547] node 0 link 2: io port [8000, bfff]
[    3.486547] node 7 link 2: io port [c000, cfff]
[    3.486547] node 0 link 2: io port [e000, efff]
[    3.486547] node 7 link 2: io port [f000, ffff]
[    3.486547] TOM: 00000000d8000000 aka 3456M
[    3.486547] Fam 10h mmconf [mem 0xe0000000-0xefffffff]
[    3.486547] node 0 link 2: mmio [fbf00000, fe8fffff]
[    3.486547] node 7 link 2: mmio [fe900000, febfffff]
[    3.486547] node 7 link 2: mmio [fed10000, fed1ffff]
[    3.486547] node 7 link 2: mmio [e8000000, efffffff] ==> none
[    3.486547] node 0 link 2: mmio [a0000, bffff]
[    3.486547] node 0 link 2: mmio [e0000000, e7ffffff] ==> none
[    3.486547] TOM2: 0000002028000000 aka 131712M
[    3.486547] bus: [bus 00-06] on node 0 link 2
[    3.486547] bus: 00 [io  0x0000-0xbfff]
[    3.486547] bus: 00 [io  0xd000-0xefff]
[    3.486547] bus: 00 [mem 0xf0000000-0xfe8fffff]
[    3.486547] bus: 00 [mem 0x000a0000-0x000bffff]
[    3.486547] bus: 00 [mem 0xd8000000-0xdfffffff]
[    3.486547] bus: 00 [mem 0xfec00000-0xfed0ffff]
[    3.486547] bus: 00 [mem 0xfed20000-0xffffffff]
[    3.486547] bus: 00 [mem 0x2028000000-0xfcffffffff]
[    3.486547] bus: [bus 80-83] on node 7 link 2
[    3.486547] bus: 80 [io  0xc000-0xcfff]
[    3.486547] bus: 80 [io  0xf000-0xffff]
[    3.486547] bus: 80 [mem 0xfe900000-0xfebfffff]
[    3.486547] bus: 80 [mem 0xfed10000-0xfed1ffff]
[    3.486547] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    3.486547] ACPI: bus type PCI registered
[    3.486547] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.486547] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    3.486547] PCI: AMD Family 10h NB with MMCONFIG support
[    3.486547] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    3.486547] PCI: Using configuration type 1 for base access
[    3.491599] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    3.491599] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    3.491599] ACPI: Added _OSI(Module Device)
[    3.491599] ACPI: Added _OSI(Processor Device)
[    3.491599] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.491599] ACPI: Added _OSI(Processor Aggregator Device)
[    3.491599] ACPI: Added _OSI(Linux-Dell-Video)
[    3.491599] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    3.491599] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    3.508474] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    3.512482] ACPI: Interpreter enabled
[    3.512513] ACPI: (supports S0 S1 S5)
[    3.512517] ACPI: Using IOAPIC for interrupt routing
[    3.512659] HEST: Table parsing has been initialized.
[    3.512664] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.513314] ACPI: Enabled 4 GPEs in block 00 to 1F
[    3.558858] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-06])
[    3.558881] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    3.559143] acpi PNP0A03:00: _OSC: platform does not support [LTR DPC]
[    3.559385] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    3.559388] acpi PNP0A03:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.568207] PCI host bridge to bus 0000:00
[    3.568210] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    3.568215] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    3.568217] pci_bus 0000:00: root bus resource [io  0x03bc-0x03bf window]
[    3.568220] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    3.568223] pci_bus 0000:00: root bus resource [io  0x03e0-0xbfff window]
[    3.568226] pci_bus 0000:00: root bus resource [io  0xd000-0xefff window]
[    3.568228] pci_bus 0000:00: root bus resource [mem 0xd8000000-0xe7ffffff window]
[    3.568232] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfe8fffff window]
[    3.568234] pci_bus 0000:00: root bus resource [mem 0xfec00000-0xfed0ffff window]
[    3.568237] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.568240] pci_bus 0000:00: root bus resource [mem 0xfed20000-0xffffffff window]
[    3.568243] pci_bus 0000:00: root bus resource [bus 00-06]
[    3.568270] pci 0000:00:00.0: [10de:005e] type 00 class 0x058000
[    3.568491] pci 0000:00:01.0: [10de:0051] type 00 class 0x060100
[    3.568663] pci 0000:00:01.1: [10de:0052] type 00 class 0x0c0500
[    3.568709] pci 0000:00:01.1: reg 0x10: [io  0xee00-0xee1f]
[    3.568724] pci 0000:00:01.1: reg 0x20: [io  0xed00-0xed3f]
[    3.568739] pci 0000:00:01.1: reg 0x24: [io  0xed40-0xed7f]
[    3.568785] pci 0000:00:01.1: PME# supported from D3hot D3cold
[    3.568923] pci 0000:00:02.0: [10de:005a] type 00 class 0x0c0310
[    3.568935] pci 0000:00:02.0: reg 0x10: [mem 0xfe7ff000-0xfe7fffff]
[    3.568992] pci 0000:00:02.0: supports D1 D2
[    3.569008] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.569126] pci 0000:00:02.1: [10de:005b] type 00 class 0x0c0320
[    3.569135] pci 0000:00:02.1: reg 0x10: [mem 0xfe7fec00-0xfe7fecff]
[    3.569224] pci 0000:00:02.1: supports D1 D2
[    3.569234] pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot D3cold
[    3.569390] pci 0000:00:06.0: [10de:0053] type 00 class 0x01018a
[    3.569426] pci 0000:00:06.0: reg 0x20: [io  0xefa0-0xefaf]
[    3.569464] pci 0000:00:06.0: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    3.569475] pci 0000:00:06.0: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    3.569478] pci 0000:00:06.0: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    3.569480] pci 0000:00:06.0: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    3.569641] pci 0000:00:09.0: [10de:005c] type 01 class 0x060401
[    3.569838] pci 0000:00:0c.0: [10de:005d] type 01 class 0x060400
[    3.569945] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.570100] pci 0000:00:0d.0: [10de:005d] type 01 class 0x060400
[    3.570193] pci 0000:00:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.570343] pci 0000:00:0e.0: [10de:005d] type 01 class 0x060400
[    3.570415] pci 0000:00:0e.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.570576] pci 0000:00:10.0: [1022:7458] type 01 class 0x060400
[    3.570622] pci 0000:00:10.0: Enabling HT MSI Mapping
[    3.570752] pci 0000:00:10.1: [1022:7459] type 00 class 0x080010
[    3.570765] pci 0000:00:10.1: reg 0x10: [mem 0xfe7fd000-0xfe7fdfff 64bit]
[    3.570924] pci 0000:00:11.0: [1022:7458] type 01 class 0x060400
[    3.570960] pci 0000:00:11.0: Enabling HT MSI Mapping
[    3.571116] pci 0000:00:11.1: [1022:7459] type 00 class 0x080010
[    3.571130] pci 0000:00:11.1: reg 0x10: [mem 0xfe7fc000-0xfe7fcfff 64bit]
[    3.571325] pci 0000:00:18.0: [1022:1200] type 00 class 0x060000
[    3.571468] pci 0000:00:18.1: [1022:1201] type 00 class 0x060000
[    3.571595] pci 0000:00:18.2: [1022:1202] type 00 class 0x060000
[    3.571712] pci 0000:00:18.3: [1022:1203] type 00 class 0x060000
[    3.571831] pci 0000:00:18.4: [1022:1204] type 00 class 0x060000
[    3.571953] pci 0000:00:19.0: [1022:1200] type 00 class 0x060000
[    3.572063] pci 0000:00:19.1: [1022:1201] type 00 class 0x060000
[    3.572167] pci 0000:00:19.2: [1022:1202] type 00 class 0x060000
[    3.572284] pci 0000:00:19.3: [1022:1203] type 00 class 0x060000
[    3.572443] pci 0000:00:19.4: [1022:1204] type 00 class 0x060000
[    3.572584] pci 0000:00:1a.0: [1022:1200] type 00 class 0x060000
[    3.572700] pci 0000:00:1a.1: [1022:1201] type 00 class 0x060000
[    3.572841] pci 0000:00:1a.2: [1022:1202] type 00 class 0x060000
[    3.572977] pci 0000:00:1a.3: [1022:1203] type 00 class 0x060000
[    3.573105] pci 0000:00:1a.4: [1022:1204] type 00 class 0x060000
[    3.573228] pci 0000:00:1b.0: [1022:1200] type 00 class 0x060000
[    3.573352] pci 0000:00:1b.1: [1022:1201] type 00 class 0x060000
[    3.573494] pci 0000:00:1b.2: [1022:1202] type 00 class 0x060000
[    3.573620] pci 0000:00:1b.3: [1022:1203] type 00 class 0x060000
[    3.573737] pci 0000:00:1b.4: [1022:1204] type 00 class 0x060000
[    3.573867] pci 0000:00:1c.0: [1022:1200] type 00 class 0x060000
[    3.574014] pci 0000:00:1c.1: [1022:1201] type 00 class 0x060000
[    3.574147] pci 0000:00:1c.2: [1022:1202] type 00 class 0x060000
[    3.574277] pci 0000:00:1c.3: [1022:1203] type 00 class 0x060000
[    3.574407] pci 0000:00:1c.4: [1022:1204] type 00 class 0x060000
[    3.574530] pci 0000:00:1d.0: [1022:1200] type 00 class 0x060000
[    3.574663] pci 0000:00:1d.1: [1022:1201] type 00 class 0x060000
[    3.574801] pci 0000:00:1d.2: [1022:1202] type 00 class 0x060000
[    3.574933] pci 0000:00:1d.3: [1022:1203] type 00 class 0x060000
[    3.575068] pci 0000:00:1d.4: [1022:1204] type 00 class 0x060000
[    3.575224] pci 0000:00:1e.0: [1022:1200] type 00 class 0x060000
[    3.575378] pci 0000:00:1e.1: [1022:1201] type 00 class 0x060000
[    3.575507] pci 0000:00:1e.2: [1022:1202] type 00 class 0x060000
[    3.575661] pci 0000:00:1e.3: [1022:1203] type 00 class 0x060000
[    3.575794] pci 0000:00:1e.4: [1022:1204] type 00 class 0x060000
[    3.575915] pci 0000:00:1f.0: [1022:1200] type 00 class 0x060000
[    3.576038] pci 0000:00:1f.1: [1022:1201] type 00 class 0x060000
[    3.576171] pci 0000:00:1f.2: [1022:1202] type 00 class 0x060000
[    3.576293] pci 0000:00:1f.3: [1022:1203] type 00 class 0x060000
[    3.576429] pci 0000:00:1f.4: [1022:1204] type 00 class 0x060000
[    3.576580] pci_bus 0000:01: extended config space not accessible
[    3.576616] pci 0000:01:06.0: [1002:4752] type 00 class 0x030000
[    3.576633] pci 0000:01:06.0: reg 0x10: [mem 0xfd000000-0xfdffffff]
[    3.576654] pci 0000:01:06.0: reg 0x14: [io  0x8800-0x88ff]
[    3.576665] pci 0000:01:06.0: reg 0x18: [mem 0xfcfff000-0xfcffffff]
[    3.576700] pci 0000:01:06.0: reg 0x30: [mem 0xfcfc0000-0xfcfdffff pref]
[    3.576772] pci 0000:01:06.0: supports D1 D2
[    3.576874] pci 0000:00:09.0: PCI bridge to [bus 01] (subtractive decode)
[    3.576905] pci 0000:00:09.0:   bridge window [io  0x8000-0x8fff]
[    3.576908] pci 0000:00:09.0:   bridge window [mem 0xfbf00000-0xfdffffff]
[    3.576913] pci 0000:00:09.0:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    3.576916] pci 0000:00:09.0:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
[    3.576919] pci 0000:00:09.0:   bridge window [io  0x03bc-0x03bf window] (subtractive decode)
[    3.576922] pci 0000:00:09.0:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
[    3.576925] pci 0000:00:09.0:   bridge window [io  0x03e0-0xbfff window] (subtractive decode)
[    3.576928] pci 0000:00:09.0:   bridge window [io  0xd000-0xefff window] (subtractive decode)
[    3.576930] pci 0000:00:09.0:   bridge window [mem 0xd8000000-0xe7ffffff window] (subtractive decode)
[    3.576933] pci 0000:00:09.0:   bridge window [mem 0xf0000000-0xfe8fffff window] (subtractive decode)
[    3.576936] pci 0000:00:09.0:   bridge window [mem 0xfec00000-0xfed0ffff window] (subtractive decode)
[    3.576939] pci 0000:00:09.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    3.576942] pci 0000:00:09.0:   bridge window [mem 0xfed20000-0xffffffff window] (subtractive decode)
[    3.576987] pci 0000:00:0c.0: PCI bridge to [bus 02]
[    3.577044] pci 0000:03:00.0: [1077:2432] type 00 class 0x0c0400
[    3.577074] pci 0000:03:00.0: reg 0x10: [io  0x9800-0x98ff]
[    3.577105] pci 0000:03:00.0: reg 0x14: [mem 0xfe0fc000-0xfe0fffff 64bit]
[    3.577149] pci 0000:03:00.0: reg 0x30: [mem 0xfe080000-0xfe0bffff pref]
[    3.586052] pci 0000:00:0d.0: PCI bridge to [bus 03]
[    3.586057] pci 0000:00:0d.0:   bridge window [io  0x9000-0x9fff]
[    3.586060] pci 0000:00:0d.0:   bridge window [mem 0xfe000000-0xfe0fffff]
[    3.586097] pci 0000:00:0e.0: PCI bridge to [bus 04]
[    3.586120] pci_bus 0000:05: extended config space not accessible
[    3.586146] pci 0000:05:01.0: [8086:1010] type 00 class 0x020000
[    3.586157] pci 0000:05:01.0: reg 0x10: [mem 0xfe1e0000-0xfe1fffff 64bit]
[    3.586183] pci 0000:05:01.0: reg 0x20: [io  0xac00-0xac3f]
[    3.586248] pci 0000:05:01.0: PME# supported from D0 D3hot
[    3.586315] pci 0000:05:01.1: [8086:1010] type 00 class 0x020000
[    3.586326] pci 0000:05:01.1: reg 0x10: [mem 0xfe1c0000-0xfe1dffff 64bit]
[    3.586356] pci 0000:05:01.1: reg 0x20: [io  0xa800-0xa83f]
[    3.586420] pci 0000:05:01.1: PME# supported from D0 D3hot
[    3.586498] pci 0000:05:02.0: [8086:1010] type 00 class 0x020000
[    3.586527] pci 0000:05:02.0: reg 0x10: [mem 0xfe1a0000-0xfe1bffff 64bit]
[    3.586553] pci 0000:05:02.0: reg 0x20: [io  0xa400-0xa43f]
[    3.586605] pci 0000:05:02.0: PME# supported from D0 D3hot
[    3.586670] pci 0000:05:02.1: [8086:1010] type 00 class 0x020000
[    3.586681] pci 0000:05:02.1: reg 0x10: [mem 0xfe180000-0xfe19ffff 64bit]
[    3.586701] pci 0000:05:02.1: reg 0x20: [io  0xa000-0xa03f]
[    3.586754] pci 0000:05:02.1: PME# supported from D0 D3hot
[    3.586818] pci 0000:00:10.0: PCI bridge to [bus 05]
[    3.586832] pci 0000:00:10.0:   bridge window [io  0xa000-0xafff]
[    3.586844] pci 0000:00:10.0:   bridge window [mem 0xfe100000-0xfe1fffff]
[    3.586860] pci_bus 0000:06: extended config space not accessible
[    3.586917] pci 0000:06:04.0: [1000:0050] type 00 class 0x010000
[    3.586930] pci 0000:06:04.0: reg 0x10: [io  0xb800-0xb8ff]
[    3.586939] pci 0000:06:04.0: reg 0x14: [mem 0xfe6fc000-0xfe6fffff 64bit]
[    3.586950] pci 0000:06:04.0: reg 0x1c: [mem 0xfe6e0000-0xfe6effff 64bit]
[    3.586962] pci 0000:06:04.0: reg 0x30: [mem 0xfe400000-0xfe5fffff pref]
[    3.587002] pci 0000:06:04.0: supports D1 D2
[    3.587068] pci 0000:00:11.0: PCI bridge to [bus 06]
[    3.587090] pci 0000:00:11.0:   bridge window [io  0xb000-0xbfff]
[    3.587118] pci 0000:00:11.0:   bridge window [mem 0xfe200000-0xfe6fffff]
[    3.594671] ACPI: PCI Root Bridge [PCIB] (domain 0000 [bus 80-83])
[    3.594681] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    3.594930] acpi PNP0A03:03: _OSC: platform does not support [LTR DPC]
[    3.595171] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    3.595174] acpi PNP0A03:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.595186] acpi PNP0A03:03: [Firmware Bug]: no _PXM; falling back to node 7 from hardware (may be inconsistent with ACPI node numbers)
[    3.600527] PCI host bridge to bus 0000:80
[    3.600530] pci_bus 0000:80: root bus resource [io  0xc000-0xcfff window]
[    3.600534] pci_bus 0000:80: root bus resource [io  0xf000-0xffff window]
[    3.600537] pci_bus 0000:80: root bus resource [mem 0xfe900000-0xfebfffff window]
[    3.600540] pci_bus 0000:80: root bus resource [mem 0xfed10000-0xfed1ffff window]
[    3.600543] pci_bus 0000:80: root bus resource [mem 0xe8000000-0xefffffff window]
[    3.600545] pci_bus 0000:80: root bus resource [bus 80-83]
[    3.600566] pci 0000:80:00.0: [10de:005e] type 00 class 0x058000
[    3.600752] pci 0000:80:01.0: [10de:00d3] type 00 class 0x058000
[    3.600767] pci 0000:80:01.0: reg 0x14: [mem 0xfeaff000-0xfeafffff]
[    3.600976] pci 0000:80:0c.0: [10de:005d] type 01 class 0x060400
[    3.601020] pci 0000:80:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.601153] pci 0000:80:0d.0: [10de:005d] type 01 class 0x060400
[    3.601214] pci 0000:80:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.601363] pci 0000:80:0e.0: [10de:005d] type 01 class 0x060400
[    3.601436] pci 0000:80:0e.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.601635] pci 0000:80:0c.0: PCI bridge to [bus 81]
[    3.601699] pci 0000:82:00.0: [1077:2432] type 00 class 0x0c0400
[    3.601727] pci 0000:82:00.0: reg 0x10: [io  0xc800-0xc8ff]
[    3.601759] pci 0000:82:00.0: reg 0x14: [mem 0xfe9fc000-0xfe9fffff 64bit]
[    3.601807] pci 0000:82:00.0: reg 0x30: [mem 0xfe980000-0xfe9bffff pref]
[    3.610041] pci 0000:80:0d.0: PCI bridge to [bus 82]
[    3.610046] pci 0000:80:0d.0:   bridge window [io  0xc000-0xcfff]
[    3.610049] pci 0000:80:0d.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    3.610092] pci 0000:80:0e.0: PCI bridge to [bus 83]
[    3.610420] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *10
[    3.610601] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *7
[    3.610767] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *5
[    3.610936] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *15
[    3.611099] ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 19) *0, disabled.
[    3.611304] ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *11
[    3.611479] ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0, disabled.
[    3.611638] ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *5
[    3.611824] ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22) *0, disabled.
[    3.611983] ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22) *0, disabled.
[    3.612159] ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22) *0, disabled.
[    3.612337] ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22) *0, disabled.
[    3.612512] ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0, disabled.
[    3.612671] ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22) *0, disabled.
[    3.612858] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22) *14
[    3.613039] ACPI: PCI Interrupt Link [LN2A] (IRQs 40 41 42 43) *10
[    3.613229] ACPI: PCI Interrupt Link [LN2B] (IRQs 40 41 42 43) *7
[    3.613399] ACPI: PCI Interrupt Link [LN2C] (IRQs 40 41 42 43) *5
[    3.613566] ACPI: PCI Interrupt Link [LN2D] (IRQs 40 41 42 43) *15
[    3.614136] ACPI: PCI Interrupt Link [LN4A] (IRQs 40 41 42 43) *15
[    3.614313] ACPI: PCI Interrupt Link [LN4B] (IRQs 40 41 42 43) *15
[    3.614475] ACPI: PCI Interrupt Link [LN4C] (IRQs 40 41 42 43) *15
[    3.614641] ACPI: PCI Interrupt Link [LN4D] (IRQs 40 41 42 43) *15
[    3.614828] ACPI: PCI Interrupt Link [LN6A] (IRQs 40 41 42 43) *15
[    3.614984] ACPI: PCI Interrupt Link [LN6B] (IRQs 40 41 42 43) *15
[    3.615164] ACPI: PCI Interrupt Link [LN6C] (IRQs 40 41 42 43) *15
[    3.615330] ACPI: PCI Interrupt Link [LN6D] (IRQs 40 41 42 43) *15
[    3.615529] ACPI: PCI Interrupt Link [LK2N] (IRQs 44 45 46 47) *0, disabled.
[    3.615689] ACPI: PCI Interrupt Link [LK4N] (IRQs 44 45 46 47) *15
[    3.615840] ACPI: PCI Interrupt Link [LK6N] (IRQs 44 45 46 47) *15
[    3.616007] ACPI: PCI Interrupt Link [LT3D] (IRQs 44 45 46 47) *0, disabled.
[    3.616188] ACPI: PCI Interrupt Link [LT2E] (IRQs 44 45 46 47) *0, disabled.
[    3.616548] iommu: Default domain type: Passthrough
[    3.616581] pci 0000:01:06.0: vgaarb: setting as boot VGA device
[    3.616581] pci 0000:01:06.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    3.616581] pci 0000:01:06.0: vgaarb: bridge control possible
[    3.616581] vgaarb: loaded
[    3.616581] SCSI subsystem initialized
[    3.616581] PCI: Using ACPI for IRQ routing
[    3.623068] PCI: pci_cache_line_size set to 64 bytes
[    3.623179] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    3.623182] e820: reserve RAM buffer [mem 0x00099c00-0x0009ffff]
[    3.623188] e820: reserve RAM buffer [mem 0xd7fa0000-0xd7ffffff]
[    3.623202] hpet: 3 channels of 0 reserved for per-cpu timers
[    3.623202] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    3.623202] hpet0: 3 comparators, 32-bit 25.000000 MHz counter
[    3.624759] clocksource: Switched to clocksource tsc-early
[    3.624759] AppArmor: AppArmor Filesystem Enabled
[    3.624759] pnp: PnP ACPI init
[    3.624759] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    3.624759] pnp 00:01: [dma 0 disabled]
[    3.624759] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.624759] system 00:02: [io  0x0190-0x0193] has been reserved
[    3.624759] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    3.624759] system 00:02: [io  0xe000-0xe0ff window] has been reserved
[    3.624759] system 00:02: [io  0xe400-0xe4ff window] has been reserved
[    3.624759] system 00:02: [io  0xe800-0xe8ff window] has been reserved
[    3.624759] system 00:02: [mem 0xffb80000-0xfffffffe] has been reserved
[    3.624759] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.624759] system 00:03: [io  0x0cf8-0x0cff] could not be reserved
[    3.624759] system 00:03: [io  0x0ca0-0x0ca5] could not be reserved
[    3.624759] system 00:03: [io  0x0ca8-0x0caf] has been reserved
[    3.624759] system 00:03: [mem 0xfec00000-0xfec00fff] could not be reserved
[    3.624759] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
[    3.624759] system 00:03: [mem 0xfefff000-0xfeffffff] has been reserved
[    3.624759] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.624794] system 00:04: [io  0x0680-0x06ff] has been reserved
[    3.624804] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.624974] system 00:05: [mem 0xe0000000-0xefffffff] could not be reserved
[    3.624983] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.625259] system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
[    3.625264] system 00:06: [mem 0x000c0000-0x000dffff] could not be reserved
[    3.625267] system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved
[    3.625271] system 00:06: [mem 0x00100000-0xd7ffffff] could not be reserved
[    3.625279] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
[    3.626751] pnp: PnP ACPI: found 7 devices
[    3.633712] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.633928] NET: Registered protocol family 2
[    3.634419] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
[    3.635436] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
[    3.638070] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
[    3.638741] TCP: Hash tables configured (established 524288 bind 65536)
[    3.639194] UDP hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    3.640850] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    3.642785] NET: Registered protocol family 1
[    3.642871] pci 0000:00:09.0: PCI bridge to [bus 01]
[    3.642880] pci 0000:00:09.0:   bridge window [io  0x8000-0x8fff]
[    3.642887] pci 0000:00:09.0:   bridge window [mem 0xfbf00000-0xfdffffff]
[    3.642893] pci 0000:00:0c.0: PCI bridge to [bus 02]
[    3.642901] pci 0000:00:0d.0: PCI bridge to [bus 03]
[    3.642904] pci 0000:00:0d.0:   bridge window [io  0x9000-0x9fff]
[    3.642908] pci 0000:00:0d.0:   bridge window [mem 0xfe000000-0xfe0fffff]
[    3.642913] pci 0000:00:0e.0: PCI bridge to [bus 04]
[    3.642921] pci 0000:00:10.0: PCI bridge to [bus 05]
[    3.642924] pci 0000:00:10.0:   bridge window [io  0xa000-0xafff]
[    3.642927] pci 0000:00:10.0:   bridge window [mem 0xfe100000-0xfe1fffff]
[    3.642934] pci 0000:00:11.0: PCI bridge to [bus 06]
[    3.642936] pci 0000:00:11.0:   bridge window [io  0xb000-0xbfff]
[    3.642940] pci 0000:00:11.0:   bridge window [mem 0xfe200000-0xfe6fffff]
[    3.642975] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    3.642978] pci_bus 0000:00: resource 5 [io  0x03b0-0x03bb window]
[    3.642981] pci_bus 0000:00: resource 6 [io  0x03bc-0x03bf window]
[    3.642984] pci_bus 0000:00: resource 7 [io  0x03c0-0x03df window]
[    3.642987] pci_bus 0000:00: resource 8 [io  0x03e0-0xbfff window]
[    3.642989] pci_bus 0000:00: resource 9 [io  0xd000-0xefff window]
[    3.642992] pci_bus 0000:00: resource 10 [mem 0xd8000000-0xe7ffffff window]
[    3.642995] pci_bus 0000:00: resource 11 [mem 0xf0000000-0xfe8fffff window]
[    3.642998] pci_bus 0000:00: resource 12 [mem 0xfec00000-0xfed0ffff window]
[    3.643001] pci_bus 0000:00: resource 13 [mem 0x000a0000-0x000bffff window]
[    3.643004] pci_bus 0000:00: resource 14 [mem 0xfed20000-0xffffffff window]
[    3.643007] pci_bus 0000:01: resource 0 [io  0x8000-0x8fff]
[    3.643009] pci_bus 0000:01: resource 1 [mem 0xfbf00000-0xfdffffff]
[    3.643012] pci_bus 0000:01: resource 4 [io  0x0000-0x03af window]
[    3.643015] pci_bus 0000:01: resource 5 [io  0x03b0-0x03bb window]
[    3.643017] pci_bus 0000:01: resource 6 [io  0x03bc-0x03bf window]
[    3.643020] pci_bus 0000:01: resource 7 [io  0x03c0-0x03df window]
[    3.643022] pci_bus 0000:01: resource 8 [io  0x03e0-0xbfff window]
[    3.643024] pci_bus 0000:01: resource 9 [io  0xd000-0xefff window]
[    3.643027] pci_bus 0000:01: resource 10 [mem 0xd8000000-0xe7ffffff window]
[    3.643030] pci_bus 0000:01: resource 11 [mem 0xf0000000-0xfe8fffff window]
[    3.643032] pci_bus 0000:01: resource 12 [mem 0xfec00000-0xfed0ffff window]
[    3.643034] pci_bus 0000:01: resource 13 [mem 0x000a0000-0x000bffff window]
[    3.643037] pci_bus 0000:01: resource 14 [mem 0xfed20000-0xffffffff window]
[    3.643041] pci_bus 0000:03: resource 0 [io  0x9000-0x9fff]
[    3.643043] pci_bus 0000:03: resource 1 [mem 0xfe000000-0xfe0fffff]
[    3.643047] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
[    3.643049] pci_bus 0000:05: resource 1 [mem 0xfe100000-0xfe1fffff]
[    3.643052] pci_bus 0000:06: resource 0 [io  0xb000-0xbfff]
[    3.643055] pci_bus 0000:06: resource 1 [mem 0xfe200000-0xfe6fffff]
[    3.643158] pci 0000:80:0c.0: PCI bridge to [bus 81]
[    3.643166] pci 0000:80:0d.0: PCI bridge to [bus 82]
[    3.643169] pci 0000:80:0d.0:   bridge window [io  0xc000-0xcfff]
[    3.643172] pci 0000:80:0d.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    3.643178] pci 0000:80:0e.0: PCI bridge to [bus 83]
[    3.643185] pci_bus 0000:80: resource 4 [io  0xc000-0xcfff window]
[    3.643187] pci_bus 0000:80: resource 5 [io  0xf000-0xffff window]
[    3.643190] pci_bus 0000:80: resource 6 [mem 0xfe900000-0xfebfffff window]
[    3.643193] pci_bus 0000:80: resource 7 [mem 0xfed10000-0xfed1ffff window]
[    3.643195] pci_bus 0000:80: resource 8 [mem 0xe8000000-0xefffffff window]
[    3.643199] pci_bus 0000:82: resource 0 [io  0xc000-0xcfff]
[    3.643201] pci_bus 0000:82: resource 1 [mem 0xfe900000-0xfe9fffff]
[    3.643744] PCI Interrupt Link [LUS0] enabled at IRQ 22
[    3.662189] pci 0000:00:02.0: quirk_usb_early_handoff+0x0/0x7a0 took 18477 usecs
[    3.662509] PCI Interrupt Link [LUS2] enabled at IRQ 21
[    3.662667] pci 0000:00:0c.0: Found disabled HT MSI Mapping
[    3.662681] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.662720] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.662737] pci 0000:00:0d.0: Found disabled HT MSI Mapping
[    3.662745] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.662787] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.662804] pci 0000:00:0e.0: Found disabled HT MSI Mapping
[    3.662811] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.662846] pci 0000:00:00.0: Found enabled HT MSI Mapping
[    3.663030] pci 0000:01:06.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    3.663077] pci 0000:80:0c.0: Found disabled HT MSI Mapping
[    3.663088] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.663117] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.663133] pci 0000:80:0d.0: Found disabled HT MSI Mapping
[    3.663141] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.663168] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.663207] pci 0000:80:0e.0: Found disabled HT MSI Mapping
[    3.663232] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.663262] pci 0000:80:00.0: Found enabled HT MSI Mapping
[    3.663295] PCI: CLS 64 bytes, default 64
[    3.665388] PCI-DMA: Disabling AGP.
[    3.665734] PCI-DMA: aperture base @ dc000000 size 65536 KB
[    3.665753] PCI-DMA: using GART IOMMU.
[    3.665757] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    3.670270] LVT offset 1 assigned for vector 0x400
[    3.670354] LVT offset 1 assigned
[    3.670887] perf: AMD IBS detected (0x00000007)
[    3.672682] workingset: timestamp_bits=42 max_order=25 bucket_order=0
[    3.674185] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    3.678652] ERST: Failed to get Error Log Address Range.
[    3.678756] [Firmware Warn]: GHES: Poll interval is 0 for generic hardware error source: 1, disabled.
[    3.678965] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    3.679048] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.679279] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.679817] hpet_acpi_add: no address or irqs in _CRS
[    3.679852] Linux agpgart interface v0.103
[    3.684216] Fusion MPT base driver 3.04.20
[    3.684218] Copyright (c) 1999-2008 LSI Corporation
[    3.684226] Fusion MPT SAS Host driver 3.04.20
[    3.684652] mptbase: ioc0: Initiating bringup
[    4.678045] ioc0: LSISAS1064 A3: Capabilities={Initiator}
[    4.694048] tsc: Refined TSC clocksource calibration: 2293.905 MHz
[    4.694117] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2110b79338c, max_idle_ns: 440795266793 ns
[    4.694281] clocksource: Switched to clocksource tsc
[   15.446327] scsi host0: ioc0: LSISAS1064 A3, FwRev=011b0000h, Ports=1, MaxQ=478, IRQ=24
[   15.469233] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 0, phy 0, sas_addr 0x5000c50003d7f551
[   15.470681] scsi 0:0:0:0: Direct-Access     SEAGATE  ST973402SSUN72G  0400 PQ: 0 ANSI: 5
[   15.477284] i8042: PNP: No PS/2 controller found.
[   15.477287] i8042: Probing ports directly.
[   15.480428] serio: i8042 KBD port at 0x60,0x64 irq 1
[   15.480436] serio: i8042 AUX port at 0x60,0x64 irq 12
[   15.480515] rtc_cmos 00:00: RTC can wake from S4
[   15.480952] rtc_cmos 00:00: registered as rtc0
[   15.481043] rtc_cmos 00:00: setting system clock to 2021-01-20T19:58:52 UTC (1611172732)
[   15.481081] rtc_cmos 00:00: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[   15.481448] sd 0:0:0:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.4 GiB)
[   15.482600] sd 0:0:0:0: [sda] Write Protect is off
[   15.482604] sd 0:0:0:0: [sda] Mode Sense: e3 00 10 08
[   15.482730] NET: Registered protocol family 10
[   15.484424] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   15.484618] Segment Routing with IPv6
[   15.484653] mip6: Mobile IPv6
[   15.484658] NET: Registered protocol family 17
[   15.485751]  sda: sda1
[   15.487402] microcode: CPU0: patch_level=0x01000083
[   15.487414] microcode: CPU1: patch_level=0x01000083
[   15.487425] microcode: CPU2: patch_level=0x01000083
[   15.487437] microcode: CPU3: patch_level=0x01000083
[   15.487452] microcode: CPU4: patch_level=0x01000083
[   15.487475] microcode: CPU5: patch_level=0x01000083
[   15.487499] microcode: CPU6: patch_level=0x01000083
[   15.487522] microcode: CPU7: patch_level=0x01000083
[   15.487545] microcode: CPU8: patch_level=0x01000083
[   15.487566] microcode: CPU9: patch_level=0x01000083
[   15.487587] microcode: CPU10: patch_level=0x01000083
[   15.487609] microcode: CPU11: patch_level=0x01000083
[   15.487632] microcode: CPU12: patch_level=0x01000083
[   15.487653] microcode: CPU13: patch_level=0x01000083
[   15.487676] microcode: CPU14: patch_level=0x01000083
[   15.487698] microcode: CPU15: patch_level=0x01000083
[   15.487720] microcode: CPU16: patch_level=0x01000083
[   15.487741] microcode: CPU17: patch_level=0x01000083
[   15.487761] microcode: CPU18: patch_level=0x01000083
[   15.487782] microcode: CPU19: patch_level=0x01000083
[   15.487803] microcode: CPU20: patch_level=0x01000083
[   15.487827] microcode: CPU21: patch_level=0x01000083
[   15.487851] microcode: CPU22: patch_level=0x01000083
[   15.487876] microcode: CPU23: patch_level=0x01000083
[   15.487899] microcode: CPU24: patch_level=0x01000083
[   15.487922] microcode: CPU25: patch_level=0x01000083
[   15.487945] microcode: CPU26: patch_level=0x01000083
[   15.487969] microcode: CPU27: patch_level=0x01000083
[   15.487993] microcode: CPU28: patch_level=0x01000083
[   15.488019] microcode: CPU29: patch_level=0x01000083
[   15.488047] microcode: CPU30: patch_level=0x01000083
[   15.488075] microcode: CPU31: patch_level=0x01000083
[   15.488145] microcode: Microcode Update Driver: v2.2.
[   15.488153] IPI shorthand broadcast: enabled
[   15.488172] sched_clock: Marking stable (15483223032, 4912110)->(15618938565, -130803423)
[   15.488484] registered taskstats version 1
[   15.488512] AppArmor: AppArmor sha1 policy hashing enabled
[   15.489420] APEI: Can not request [mem 0xd7fb8a80-0xd7fb8ad3] for APEI BERT registers
[   15.493697] sd 0:0:0:0: [sda] Attached SCSI disk
[   15.818292] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: disabled.
[   15.818330] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[   15.826799] devtmpfs: mounted
[   15.827662] Freeing unused kernel image (initmem) memory: 984K
[   15.827675] Write protecting the kernel read-only data: 16384k
[   15.829490] Freeing unused kernel image (text/rodata gap) memory: 2044K
[   15.830791] Freeing unused kernel image (rodata/data gap) memory: 1616K
[   15.881096] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   15.881111] Run /sbin/init as init process
[   15.881114]   with arguments:
[   15.881117]     /sbin/init
[   15.881119]   with environment:
[   15.881120]     HOME=/
[   15.881122]     TERM=linux
[   15.881123]     BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc4-00015-g45dfb8a5659a
[   16.683645] random: fast init done
[   18.861591] random: systemd: uninitialized urandom read (16 bytes read)
[   18.864729] random: systemd: uninitialized urandom read (16 bytes read)
[   18.865371] random: systemd: uninitialized urandom read (16 bytes read)
[   19.096926] fuse: init (API version 7.33)
[   19.447299] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro. Quota mode: disabled.
[   20.782073] random: crng init done
[   20.782086] random: 7 urandom warning(s) missed due to ratelimiting
[   21.660297] acpi_cpufreq: overriding BIOS provided _PSD data
[   21.671293] IPMI message handler: version 39.2
[   21.691274] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input4
[   21.706115] ACPI: Power Button [PWRB]
[   21.706270] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[   21.706363] ACPI: Power Button [PWRF]
[   21.731298] ipmi device interface
[   21.795815] ipmi_si: IPMI System Interface driver
[   21.795873] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[   21.795881] ipmi_platform: ipmi_si: SMBIOS: io 0xca4 regsize 1 spacing 1 irq 0
[   21.795890] ipmi_si: Adding SMBIOS-specified kcs state machine
[   21.796055] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[   21.796131] ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca6-0x0ca7] regsize 1 spacing 1 irq 0
[   21.840923] ipmi_si: Adding ACPI-specified kcs state machine
[   21.841125] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca4, slave address 0x20, irq 0
[   22.091118] input: PC Speaker as /devices/platform/pcspkr/input/input6
[   22.091510] ACPI Warning: SystemIO range 0x000000000000ED00-0x000000000000ED3F conflicts with OpRegion 0x000000000000ED00-0x000000000000ED04 (\_SB.PCI0.SMBU.SMRG) (20201113/utaddress-204)
[   22.091550] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   22.125401] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   22.126061] i2c i2c-0: Unrecognized stepping 0x45. Defaulting to ADM1026.
[   22.269125] ipmi_si dmi-ipmi-si.0: IPMI message handler: Found new BMC (man_id: 0x00002a, prod_id: 0x4701, dev_id: 0x20)
[   22.300412] e1000: Intel(R) PRO/1000 Network Driver
[   22.300426] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   22.302229] i2c i2c-0: Unrecognized stepping 0x45. Defaulting to ADM1026.
[   22.304118] libata version 3.00 loaded.
[   22.305959] pata_amd 0000:00:06.0: version 0.4.1
[   22.307443] scsi host1: pata_amd
[   22.307686] scsi host2: pata_amd
[   22.307751] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xefa0 irq 14
[   22.307757] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xefa8 irq 15
[   22.468580] ata1.00: ATAPI: MATSHITACD-RW  CW-8124, DZ13, max UDMA/33
[   22.468607] ata1: nv_mode_filter: 0x739f&0x739f->0x739f, BIOS=0x7000 (0xc0000000) ACPI=0x701f (54:900:0x11)
[   22.471706] ipmi_si dmi-ipmi-si.0: IPMI kcs interface initialized
[   22.478492] i2c i2c-0: Found version/stepping 0x46. Assuming generic ADM1026.
[   22.503612] scsi 1:0:0:0: CD-ROM            MATSHITA CD-RW  CW-8124   DZ13 PQ: 0 ANSI: 5
[   22.513899] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[   22.514125] ata2: port disabled--ignoring
[   22.533671] ipmi_ssif: IPMI SSIF Interface driver
[   22.534011] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.02.00.104-k.
[   22.584324] PCI Interrupt Link [LNKD] enabled at IRQ 19
[   22.584464] qla2xxx [0000:00:00.0]-001d: : Found an ISP2432 irq 19 iobase 0x00000000e8dfa86e.
[   22.592930] ACPI: bus type USB registered
[   22.593031] usbcore: registered new interface driver usbfs
[   22.593053] usbcore: registered new interface driver hub
[   22.593122] usbcore: registered new device driver usb
[   22.595935] kvm: Nested Virtualization enabled
[   22.595991] SVM: kvm: Nested Paging enabled
[   22.612832] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   22.627747] e1000 0000:05:01.0 eth0: (PCI-X:133MHz:64-bit) 00:14:4f:d1:d2:fc
[   22.627759] e1000 0000:05:01.0 eth0: Intel(R) PRO/1000 Network Connection
[   22.640004] ehci-pci: EHCI PCI platform driver
[   22.640008] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   22.653701] qla2xxx [0000:03:00.0]-ffff:3: FC4 priority set to FCP
[   22.654710] ehci-pci 0000:00:02.1: EHCI Host Controller
[   22.654725] ehci-pci 0000:00:02.1: new USB bus registered, assigned bus number 1
[   22.654739] ehci-pci 0000:00:02.1: debug port 1
[   22.654801] ehci-pci 0000:00:02.1: irq 21, io mem 0xfe7fec00
[   22.655327] EDAC MC: Ver: 3.0.0
[   22.665830] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda caddy
[   22.665850] cdrom: Uniform CD-ROM driver Revision: 3.20
[   22.670068] ehci-pci 0000:00:02.1: USB 2.0 started, EHCI 1.00
[   22.670168] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[   22.670173] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   22.670176] usb usb1: Product: EHCI Host Controller
[   22.670179] usb usb1: Manufacturer: Linux 5.11.0-rc4-00015-g45dfb8a5659a ehci_hcd
[   22.670181] usb usb1: SerialNumber: 0000:00:02.1
[   22.670498] hub 1-0:1.0: USB hub found
[   22.670509] hub 1-0:1.0: 7 ports detected
[   22.699546] ohci-pci: OHCI PCI platform driver
[   22.700965] MCE: In-kernel MCE decoding enabled.
[   22.740295] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   22.836691] EDAC amd64: F10h detected (node 0).
[   22.836773] EDAC amd64: Node 0: DRAM ECC enabled.
[   22.837232] EDAC MC0: Giving out device to module amd64_edac controller F10h: DEV 0000:00:18.3 (INTERRUPT)
[   22.837239] EDAC MC: DCT0 chip selects:
[   22.837242] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   22.837247] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   22.837251] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   22.837254] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   22.837257] EDAC MC: DCT1 chip selects:
[   22.837259] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   22.837263] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   22.837266] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   22.837269] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   22.837272] EDAC amd64: using x4 syndromes.
[   22.837276] EDAC amd64: F10h detected (node 1).
[   22.837346] EDAC amd64: Node 1: DRAM ECC enabled.
[   22.837696] EDAC MC1: Giving out device to module amd64_edac controller F10h: DEV 0000:00:19.3 (INTERRUPT)
[   22.837701] EDAC MC: DCT0 chip selects:
[   22.837703] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   22.837707] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   22.837710] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   22.837713] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   22.837716] EDAC MC: DCT1 chip selects:
[   22.837718] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   22.837721] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   22.837724] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   22.837728] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   22.837731] EDAC amd64: using x4 syndromes.
[   22.837735] EDAC amd64: F10h detected (node 2).
[   22.837802] EDAC amd64: Node 2: DRAM ECC enabled.
[   22.838252] EDAC MC2: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1a.3 (INTERRUPT)
[   22.838259] EDAC MC: DCT0 chip selects:
[   22.838261] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   22.838264] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   22.838268] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   22.838271] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   22.838277] EDAC MC: DCT1 chip selects:
[   22.838279] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   22.838282] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   22.838286] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   22.838289] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   22.838292] EDAC amd64: using x4 syndromes.
[   22.838296] EDAC amd64: F10h detected (node 3).
[   22.838343] EDAC amd64: Node 3: DRAM ECC enabled.
[   22.838687] EDAC MC3: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1b.3 (INTERRUPT)
[   22.838694] EDAC MC: DCT0 chip selects:
[   22.838697] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   22.838700] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   22.838704] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   22.838707] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   22.838710] EDAC MC: DCT1 chip selects:
[   22.838712] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   22.838715] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   22.838718] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   22.838722] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   22.838725] EDAC amd64: using x4 syndromes.
[   22.838728] EDAC amd64: F10h detected (node 4).
[   22.838782] EDAC amd64: Node 4: DRAM ECC enabled.
[   22.839121] EDAC MC4: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1c.3 (INTERRUPT)
[   22.839127] EDAC MC: DCT0 chip selects:
[   22.839129] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   22.839132] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   22.839136] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   22.839139] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   22.839142] EDAC MC: DCT1 chip selects:
[   22.839144] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   22.839147] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   22.839152] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   22.839155] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   22.839158] EDAC amd64: using x4 syndromes.
[   22.839165] EDAC amd64: F10h detected (node 5).
[   22.839233] EDAC amd64: Node 5: DRAM ECC enabled.
[   22.839575] EDAC MC5: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1d.3 (INTERRUPT)
[   22.839580] EDAC MC: DCT0 chip selects:
[   22.839582] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   22.839586] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   22.839589] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   22.839592] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   22.839595] EDAC MC: DCT1 chip selects:
[   22.839598] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   22.839601] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   22.839604] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   22.839607] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   22.839610] EDAC amd64: using x4 syndromes.
[   22.839614] EDAC amd64: F10h detected (node 6).
[   22.839666] EDAC amd64: Node 6: DRAM ECC enabled.
[   22.840007] EDAC MC6: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1e.3 (INTERRUPT)
[   22.840012] EDAC MC: DCT0 chip selects:
[   22.840016] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   22.840020] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   22.840023] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   22.840026] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   22.840029] EDAC MC: DCT1 chip selects:
[   22.840032] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   22.840035] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   22.840038] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   22.840042] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   22.840045] EDAC amd64: using x4 syndromes.
[   22.840049] EDAC amd64: F10h detected (node 7).
[   22.840117] EDAC amd64: Node 7: DRAM ECC enabled.
[   22.840456] EDAC MC7: Giving out device to module amd64_edac controller F10h: DEV 0000:00:1f.3 (INTERRUPT)
[   22.840461] EDAC MC: DCT0 chip selects:
[   22.840463] EDAC amd64: MC: 0:  2048MB 1:  2048MB
[   22.840467] EDAC amd64: MC: 2:  2048MB 3:  2048MB
[   22.840470] EDAC amd64: MC: 4:  2048MB 5:  2048MB
[   22.840473] EDAC amd64: MC: 6:  2048MB 7:  2048MB
[   22.840477] EDAC MC: DCT1 chip selects:
[   22.840479] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[   22.840482] EDAC amd64: MC: 2:  1024MB 3:  1024MB
[   22.840485] EDAC amd64: MC: 4:  1024MB 5:  1024MB
[   22.840488] EDAC amd64: MC: 6:  1024MB 7:  1024MB
[   22.840494] EDAC amd64: using x4 syndromes.
[   22.840524] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[   22.840529] AMD64 EDAC driver v3.5.0
[   22.935484] ohci-pci 0000:00:02.0: OHCI PCI host controller
[   22.935515] ohci-pci 0000:00:02.0: new USB bus registered, assigned bus number 2
[   22.935598] ohci-pci 0000:00:02.0: irq 22, io mem 0xfe7ff000
[   22.980051] e1000 0000:05:01.1 eth1: (PCI-X:133MHz:64-bit) 00:14:4f:d1:d2:fd
[   22.980069] e1000 0000:05:01.1 eth1: Intel(R) PRO/1000 Network Connection
[   22.996128] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.11
[   22.996135] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   22.996138] usb usb2: Product: OHCI PCI host controller
[   22.996141] usb usb2: Manufacturer: Linux 5.11.0-rc4-00015-g45dfb8a5659a ohci_hcd
[   22.996143] usb usb2: SerialNumber: 0000:00:02.0
[   22.996375] hub 2-0:1.0: USB hub found
[   22.996388] hub 2-0:1.0: 7 ports detected
[   23.028444] scsi host3: qla2xxx
[   23.041378] qla2xxx [0000:03:00.0]-00fb:3: QLogic QLE2460 - SG-(X)PCIE1FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Express Single Channel.
[   23.041394] qla2xxx [0000:03:00.0]-00fc:3: ISP2432: PCIe (2.5GT/s x4) @ 0000:03:00.0 hdma+ host#=3 fw=8.07.00 (9496).
[   23.042147] PCI Interrupt Link [LN2D] enabled at IRQ 43
[   23.042335] qla2xxx [0000:00:00.0]-001d: : Found an ISP2432 irq 30 iobase 0x000000008cf4ace8.
[   23.052168] lm75 0-0049: hwmon3: sensor 'lm75'
[   23.100086] qla2xxx [0000:82:00.0]-ffff:4: FC4 priority set to FCP
[   23.123834] i2c i2c-0: nForce2 SMBus adapter at 0xed40
[   23.254957] audit: type=1400 audit(1611172740.271:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=465 comm="apparmor_parser"
[   23.254986] audit: type=1400 audit(1611172740.271:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=465 comm="apparmor_parser"
[   23.282983] audit: type=1400 audit(1611172740.299:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=467 comm="apparmor_parser"
[   23.283474] audit: type=1400 audit(1611172740.299:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=466 comm="apparmor_parser"
[   23.283484] audit: type=1400 audit(1611172740.299:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=466 comm="apparmor_parser"
[   23.283492] audit: type=1400 audit(1611172740.299:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=466 comm="apparmor_parser"
[   23.303539] e1000 0000:05:02.0 eth2: (PCI-X:133MHz:64-bit) 00:14:4f:d1:d2:fe
[   23.303551] e1000 0000:05:02.0 eth2: Intel(R) PRO/1000 Network Connection
[   23.438368] scsi host4: qla2xxx
[   23.441503] qla2xxx [0000:82:00.0]-00fb:4: QLogic QLE2460 - SG-(X)PCIE1FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Express Single Channel.
[   23.441524] qla2xxx [0000:82:00.0]-00fc:4: ISP2432: PCIe (2.5GT/s x4) @ 0000:82:00.0 hdma+ host#=4 fw=8.07.00 (9496).
[   23.627499] e1000 0000:05:02.1 eth3: (PCI-X:133MHz:64-bit) 00:14:4f:d1:d2:ff
[   23.627508] e1000 0000:05:02.1 eth3: Intel(R) PRO/1000 Network Connection
[   23.730069] usb 2-3: new full-speed USB device number 2 using ohci-pci
[   23.963096] usb 2-3: New USB device found, idVendor=046b, idProduct=ff10, bcdDevice= 1.00
[   23.963120] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   23.963127] usb 2-3: Product: Virtual Keyboard and Mouse
[   23.963132] usb 2-3: Manufacturer: American Megatrends Inc.
[   24.113675] e1000 0000:05:01.1 enp5s1f1: renamed from eth1
[   24.130462] e1000 0000:05:02.0 enp5s2f0: renamed from eth2
[   24.170384] e1000 0000:05:01.0 enp5s1f0: renamed from eth0
[   24.206581] e1000 0000:05:02.1 enp5s2f1: renamed from eth3
[   24.206629] hid: raw HID events driver (C) Jiri Kosina
[   24.294072] usb 1-6: new high-speed USB device number 3 using ehci-pci
[   24.307409] usbcore: registered new interface driver usbhid
[   24.307426] usbhid: USB HID core driver
[   24.366592] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:02.0/usb2/2-3/2-3:1.0/0003:046B:FF10.0001/input/input7
[   24.366786] hid-generic 0003:046B:FF10.0001: input,hidraw0: USB HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:02.0-3/input0
[   24.367142] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:02.0/usb2/2-3/2-3:1.1/0003:046B:FF10.0002/input/input8
[   24.367258] hid-generic 0003:046B:FF10.0002: input,hidraw1: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:02.0-3/input1
[   24.450460] usb 1-6: New USB device found, idVendor=04b4, idProduct=6560, bcdDevice= 0.0b
[   24.450472] usb 1-6: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   24.450910] hub 1-6:1.0: USB hub found
[   24.451077] hub 1-6:1.0: 4 ports detected
[   26.998466] e1000: enp5s1f0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   26.998656] IPv6: ADDRCONF(NETDEV_CHANGE): enp5s1f0: link becomes ready
[   44.534115] qla2xxx [0000:03:00.0]-8038:3: Cable is unplugged...
[   44.950130] qla2xxx [0000:82:00.0]-8038:4: Cable is unplugged...


Kernel config:

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 5.11.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (Debian 10.2.1-6) 10.2.1 20210110"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=100201
CONFIG_LD_VERSION=235010000
CONFIG_CLANG_VERSION=0
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_PROFILING is not set
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
# CONFIG_HYPERVISOR_GUEST is not set
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=4
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_LEGACY_VSYSCALL_EMULATE is not set
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
CONFIG_LEGACY_VSYSCALL_NONE=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=m
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
# CONFIG_ACPI_TINY_POWER_BUTTON is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=m
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_EXTLOG=m
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
CONFIG_X86_X32=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_INTEL is not set
CONFIG_KVM_AMD=m
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_IOCOST=y
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=y
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_ASN1=m
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_PTE_DEVMAP=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_USER=m
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
CONFIG_TCP_CONG_CDG=m
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
# CONFIG_NFT_FLOW_OFFLOAD is not set
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=m
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
# CONFIG_NFT_FIB_INET is not set
CONFIG_NFT_XFRM=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_OSF=m
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
# CONFIG_NFT_FIB_NETDEV is not set
CONFIG_NFT_REJECT_NETDEV=m
# CONFIG_NF_FLOW_TABLE_INET is not set
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=m

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_MH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_SRH=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
CONFIG_NFT_BRIDGE_META=m
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
CONFIG_NF_CONNTRACK_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=m
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
CONFIG_PCIE_BW=y
CONFIG_PCIE_EDR=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_PVPANIC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
CONFIG_SCSI_FC_ATTRS=m
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_MV is not set
CONFIG_SATA_NV=m
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
CONFIG_PATA_AMD=m
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=m
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=m
# CONFIG_RAW_DRIVER is not set
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=m
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_AMD_ENERGY is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DRIVETEMP=m
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# end of Backlight & LCD device support

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=m
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
# CONFIG_USB_OTG_FSM is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=m
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
# CONFIG_AMD_IOMMU_V2 is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="utf8"
CONFIG_FAT_DEFAULT_UTF8=y
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
# CONFIG_CONFIGFS_FS is not set
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=m
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=m
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=m
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=m
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=m
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# CONFIG_CRYPTO_XXHASH is not set
# CONFIG_CRYPTO_BLAKE2B is not set
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=m
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=m
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=m
CONFIG_CRYPTO_JITTERENTROPY=m
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set

#
# Certificates for signature checking
#
# end of Certificates for signature checking

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
# CONFIG_CRC8 is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
# CONFIG_IRQ_POLL is not set
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x0ffff
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE="s"
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
CONFIG_UBSAN_DIV_ZERO=y
CONFIG_UBSAN_SIGNED_OVERFLOW=y
CONFIG_UBSAN_BOOL=y
CONFIG_UBSAN_ENUM=y
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_STACKTRACE is not set
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

