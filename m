Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482762C03E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgKWLPO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 06:15:14 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:42291 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgKWLPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:15:13 -0500
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 23 Nov 2020 20:15:06 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 23 Nov 2020 20:15:06 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 23 Nov 2020 20:13:32 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: [RFC] Dept(Dependency Tracker) Report Example
Message-ID: <20201123111332.GC9464@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201111050559.GA24438@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Search the following dmesg for the reports with "Dept".

Of course, it's not real but fake to show you how Dept reports multiple
problems. This is FYI. Feel free to ask me if you have questions.

--->8---
[    0.000000] Linux version 5.9.0+ (byungchul.park@X58A-UD3R) (gcc (Ubuntu 6.5.0-2ubuntu1~14.04.1) 6.5.0 20181026, GNU ld (GNU Binutils for Ubuntu) 2.24) #8 SMP Mon Nov 23 18:47:03 KST 2020
[    0.000000] Command line: root=/dev/sda1 text console=ttyS0 nokaslr
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfffdfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfffe000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3197.604 MHz processor
[    0.000752] last_pfn = 0x140000 max_arch_pfn = 0x400000000
[    0.000819] x86/PAT: PAT not supported by the CPU.
[    0.000830] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000834] last_pfn = 0xbfffe max_arch_pfn = 0x400000000
[    0.001462] found SMP MP-table at [mem 0x000f0ae0-0x000f0aef]
[    0.001488] check: Scanning 1 areas for low memory corruption
[    0.002605] ACPI: Early table checksum verification disabled
[    0.002612] ACPI: RSDP 0x00000000000F08B0 000014 (v00 BOCHS )
[    0.002618] ACPI: RSDT 0x00000000BFFFFCFC 000034 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.002626] ACPI: FACP 0x00000000BFFFF1C0 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.002634] ACPI: DSDT 0x00000000BFFFE040 001180 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.002640] ACPI: FACS 0x00000000BFFFE000 000040
[    0.002645] ACPI: SSDT 0x00000000BFFFF234 000A00 (v01 BOCHS  BXPCSSDT 00000001 BXPC 00000001)
[    0.002651] ACPI: APIC 0x00000000BFFFFC34 000090 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.002657] ACPI: HPET 0x00000000BFFFFCC4 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.002900] No NUMA configuration found
[    0.002904] Faking a node at [mem 0x0000000000000000-0x000000013fffffff]
[    0.002910] NODE_DATA(0) allocated [mem 0x13fff9000-0x13fffcfff]
[    0.002936] Zone ranges:
[    0.002939]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002943]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002947]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.002951] Movable zone start for each node
[    0.002955] Early memory node ranges
[    0.002958]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.002962]   node   0: [mem 0x0000000000100000-0x00000000bfffdfff]
[    0.002966]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.003444] Zeroed struct page in unavailable ranges: 100 pages
[    0.003446] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
[    0.017534] ACPI: PM-Timer IO Port: 0xb008
[    0.017550] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.017583] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.017589] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.017593] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.017597] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.017601] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.017604] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.017621] Using ACPI (MADT) for SMP configuration information
[    0.017625] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.017635] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.017653] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.017657] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.017661] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.017664] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.017668] PM: hibernation: Registered nosave memory: [mem 0xbfffe000-0xbfffffff]
[    0.017671] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfeffbfff]
[    0.017674] PM: hibernation: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.017678] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.017681] PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.017690] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.017695] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.022235] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.023359] percpu: Embedded 54 pages/cpu s182080 r8192 d30912 u524288
[    0.023418] Built 1 zonelists, mobility grouping on.  Total pages: 1032071
[    0.023426] Policy zone: Normal
[    0.023438] Kernel command line: root=/dev/sda1 text console=ttyS0 nokaslr
[    0.028817] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.029379] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.029436] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.082983] Memory: 4014012K/4193904K available (14340K kernel code, 1973K rwdata, 4560K rodata, 1184K init, 10680K bss, 179636K reserved, 0K cma-reserved)
[    0.083161] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.083194] Kernel/User page tables isolation: enabled
[    0.083738] rcu: Hierarchical RCU implementation.
[    0.083748] rcu: 	RCU event tracing is enabled.
[    0.083758] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.083767] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.083777] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.084125] NR_IRQS: 4352, nr_irqs: 456, preallocated irqs: 16
[    0.084669] random: get_random_bytes called from start_kernel+0x367/0x533 with crng_init=0
[    0.087902] Console: colour VGA+ 80x25
[    0.141251] printk: console [ttyS0] enabled
[    0.141659] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.142413] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.142811] ... MAX_LOCK_DEPTH:          48
[    0.143217] ... MAX_LOCKDEP_KEYS:        8192
[    0.143645] ... CLASSHASH_SIZE:          4096
[    0.144069] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.144498] ... MAX_LOCKDEP_CHAINS:      65536
[    0.144928] ... CHAINHASH_SIZE:          32768
[    0.145357]  memory used by lock dependency info: 3573 kB
[    0.145875]  per task-struct memory footprint: 1920 bytes
[    0.146403] DEPendency Tracker: Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
[    0.147163] ... DEPT_MAX_STACK_ENTRY: 16
[    0.147546] ... DEPT_MAX_WAIT_HIST  : 16
[    0.147929] ... DEPT_MAX_ECXT_HELD  : 48
[    0.148316] ... DEPT_MAX_SUBCLASSES : 16
[    0.148701] ... memory used by dep: 416 KB
[    0.149101] ... memory used by class: 608 KB
[    0.149517] ... memory used by stack: 2304 KB
[    0.149942] ... memory used by ecxt: 416 KB
[    0.150355] ... memory used by wait: 384 KB
[    0.150762] ... hash list head used by dep: 32 KB
[    0.151216] ... hash list head used by class: 32 KB
[    0.151687] ... total memory used by objects and hashs: 4192 KB
[    0.152253] ... per task memory footprint: 1864 bytes
[    0.152770] ACPI: Core revision 20200717
[    0.153363] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.154350] APIC: Switch to symmetric I/O mode setup
[    0.156041] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.161359] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e1772a46d9, max_idle_ns: 440795370507 ns
[    0.162659] Calibrating delay loop (skipped), value calculated using timer frequency.. 6395.20 BogoMIPS (lpj=3197604)
[    0.163660] pid_max: default: 32768 minimum: 301
[    0.164729] LSM: Security Framework initializing
[    0.165294] SELinux:  Initializing.
[    0.165741] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.166668] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.168426] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.168664] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.169668] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.170660] Spectre V2 : Mitigation: Full generic retpoline
[    0.171299] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.172580] Speculative Store Bypass: Vulnerable
[    0.172668] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.173947] Freeing SMP alternatives memory: 40K
[    0.174836] ------------[ cut here ]------------
[    0.175392] DEPT_WARN_ONCE: Need to expand the ring buffer.
[    0.175650] WARNING: CPU: 0 PID: 0 at kernel/dependency/dept.c:1365 dept_event+0x3b7/0x580
[    0.175650] Modules linked in:
[    0.175650] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0+ #8
[    0.175650] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    0.175650] RIP: 0010:dept_event+0x3b7/0x580
[    0.175650] Code: 85 c0 75 32 80 3d e6 3f 6e 01 00 75 29 48 c7 c7 68 f9 31 82 4c 89 4c 24 20 44 89 44 24 18 c6 05 cc 3f 6e 01 01 e8 59 cd f7 ff <0f> 0b 44 8b 44 24 18 4c 8b 4c 24 20 41 83 ff ff 0f 84 d4 fd ff ff
[    0.175650] RSP: 0000:ffffffff82603e58 EFLAGS: 00010096
[    0.175650] RAX: 000000000000002f RBX: ffffffff82d22968 RCX: 0000000000000001
[    0.175650] RDX: 0000000000000000 RSI: ffffffff810c7d2c RDI: ffffffff826801e0
[    0.175650] RBP: 0000000000000000 R08: ffffffff8200c310 R09: ffffffff8200c310
[    0.175650] R10: 0000000000000000 R11: ffffffff82603cf5 R12: ffffffff8263a8c0
[    0.175650] R13: ffffffff8200bf58 R14: ffffffff82d22980 R15: 0000000000000008
[    0.175650] FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
[    0.175650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.175650] CR2: ffff88813ffff000 CR3: 0000000002632000 CR4: 00000000000006f0
[    0.175650] Call Trace:
[    0.175650]  ? rest_init+0x107/0x120
[    0.175650]  ? find_held_lock+0x2d/0x90
[    0.175650]  ? __noinstr_text_end+0x1/0x1
[    0.175650]  complete+0x28/0x60
[    0.175650]  rest_init+0x107/0x120
[    0.175650]  start_kernel+0x523/0x533
[    0.175650]  secondary_startup_64+0xb6/0xc0
[    0.175650] ---[ end trace 6e44938380d9db2c ]---
[    0.278002] smpboot: CPU0: Intel QEMU Virtual CPU version 2.0.0 (family: 0x6, model: 0x6, stepping: 0x3)
[    0.279295] Performance Events: PMU not available due to virtualization, using software events only.
[    0.279837] rcu: Hierarchical SRCU implementation.
[    0.281787] smp: Bringing up secondary CPUs ...
[    0.282962] x86: Booting SMP configuration:
[    0.283465] .... node  #0, CPUs:      #1
[    0.072074] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.346270]  #2
[    0.072074] smpboot: CPU 2 Converting physical 0 to logical die 2
[    0.410303]  #3
[    0.072074] smpboot: CPU 3 Converting physical 0 to logical die 3
[    0.471795] smp: Brought up 1 node, 4 CPUs
[    0.472195] smpboot: Max logical packages: 4
[    0.472670] smpboot: Total of 4 processors activated (25579.89 BogoMIPS)
[    0.474099] devtmpfs: initialized
[    0.476925] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.477675] futex hash table entries: 1024 (order: 5, 196608 bytes, linear)
[    0.478852] PM: RTC time: 09:47:17, date: 2020-11-23
[    0.479693] NET: Registered protocol family 16
[    0.481116] audit: initializing netlink subsys (disabled)
[    0.481719] audit: type=2000 audit(1606124837.326:1): state=initialized audit_enabled=0 res=1
[    0.482752] thermal_sys: Registered thermal governor 'step_wise'
[    0.482757] thermal_sys: Registered thermal governor 'user_space'
[    0.483518] cpuidle: using governor menu
[    0.484738] ACPI: bus type PCI registered
[    0.485493] PCI: Using configuration type 1 for base access
[    0.512937] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.513847] cryptomgr_test (35) used greatest stack depth: 15104 bytes left
[    0.519990] ACPI: Added _OSI(Module Device)
[    0.520418] ACPI: Added _OSI(Processor Device)
[    0.520667] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.521107] ACPI: Added _OSI(Processor Aggregator Device)
[    0.521664] ACPI: Added _OSI(Linux-Dell-Video)
[    0.522090] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.522664] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.526888] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.536947] ACPI: Interpreter enabled
[    0.537465] ACPI: (supports S0 S3 S4 S5)
[    0.537660] ACPI: Using IOAPIC for interrupt routing
[    0.538183] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.540484] ACPI: Enabled 16 GPEs in block 00 to 0F
[    0.571959] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.572585] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.572736] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.574905] PCI host bridge to bus 0000:00
[    0.575297] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.575661] pci_bus 0000:00: root bus resource [io  0x0d00-0xadff window]
[    0.576266] pci_bus 0000:00: root bus resource [io  0xae0f-0xaeff window]
[    0.576661] pci_bus 0000:00: root bus resource [io  0xaf20-0xafdf window]
[    0.577662] pci_bus 0000:00: root bus resource [io  0xafe4-0xffff window]
[    0.578282] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.578661] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.579664] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.580220] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.582483] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.584608] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.587034] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.588432] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.588661] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.589661] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.590292] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.592010] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.592937] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
[    0.593587] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by PIIX4 SMB
[    0.595518] pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
[    0.596661] pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
[    0.598440] pci 0000:00:02.0: reg 0x14: [mem 0xfebf0000-0xfebf0fff]
[    0.603038] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.604943] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.606009] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.607357] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.611657] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.615890] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.616780] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.617678] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.618547] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.618851] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.623002] iommu: Default domain type: Translated 
[    0.623712] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.624269] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.624672] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.625665] vgaarb: loaded
[    0.626231] SCSI subsystem initialized
[    0.626930] ACPI: bus type USB registered
[    0.627744] usbcore: registered new interface driver usbfs
[    0.628337] usbcore: registered new interface driver hub
[    0.628785] usbcore: registered new device driver usb
[    0.629365] pps_core: LinuxPPS API ver. 1 registered
[    0.629659] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.630674] PTP clock support registered
[    0.631824] Advanced Linux Sound Architecture Driver Initialized.
[    0.633396] NetLabel: Initializing
[    0.633660] NetLabel:  domain hash size = 128
[    0.634064] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.634705] NetLabel:  unlabeled traffic allowed by default
[    0.635359] PCI: Using ACPI for IRQ routing
[    0.635860] hpet: 3 channels of 0 reserved for per-cpu timers
[    0.636667] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.637127] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.640800] clocksource: Switched to clocksource tsc-early
[    0.888845] VFS: Disk quotas dquot_6.6.0
[    0.889303] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.890178] pnp: PnP ACPI init
[    0.893715] pnp: PnP ACPI: found 6 devices
[    0.919486] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.920623] NET: Registered protocol family 2
[    0.921743] tcp_listen_portaddr_hash hash table entries: 2048 (order: 6, 262144 bytes, linear)
[    0.922730] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.923611] TCP bind hash table entries: 32768 (order: 9, 3932160 bytes, linear)
[    0.926324] TCP: Hash tables configured (established 32768 bind 32768)
[    0.927113] UDP hash table entries: 2048 (order: 7, 524288 bytes, linear)
[    0.928005] UDP-Lite hash table entries: 2048 (order: 7, 524288 bytes, linear)
[    0.929141] NET: Registered protocol family 1
[    0.930453] RPC: Registered named UNIX socket transport module.
[    0.931065] RPC: Registered udp transport module.
[    0.931590] RPC: Registered tcp transport module.
[    0.932071] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.933210] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.933820] pci_bus 0000:00: resource 5 [io  0x0d00-0xadff window]
[    0.934394] pci_bus 0000:00: resource 6 [io  0xae0f-0xaeff window]
[    0.934961] pci_bus 0000:00: resource 7 [io  0xaf20-0xafdf window]
[    0.935559] pci_bus 0000:00: resource 8 [io  0xafe4-0xffff window]
[    0.936114] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff window]
[    0.936773] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xfebfffff window]
[    0.937921] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.938487] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.939032] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.939661] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.940438] PCI: CLS 0 bytes, default 64
[    0.941050] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.941676] software IO TLB: mapped [mem 0xbbffe000-0xbfffe000] (64MB)
[    0.946671] check: Scanning for low memory corruption every 60 seconds
[    0.950094] Initialise system trusted keyrings
[    0.951024] workingset: timestamp_bits=56 max_order=20 bucket_order=0
[    0.978755] NFS: Registering the id_resolver key type
[    0.979236] Key type id_resolver registered
[    0.979647] Key type id_legacy registered
[    0.990223] Key type asymmetric registered
[    0.990669] Asymmetric key parser 'x509' registered
[    0.991155] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.991849] io scheduler mq-deadline registered
[    0.992267] io scheduler kyber registered
[    0.994101] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.995081] ===================================================
[    0.995619] Dept: Circular dependency has been detected.
[    0.995816] 5.9.0+ #8 Tainted: G        W        
[    0.996493] ---------------------------------------------------
[    0.996493] summary
[    0.996493] ---------------------------------------------------
[    0.996493] *** AA DEADLOCK ***
[    0.996493] 
[    0.996493] context A
[    0.996493]     [S] __mutex_lock(&dev->mutex:0)
[    0.996493]     [W] __mutex_lock(&dev->mutex:0)
[    0.996493]     [E] __mutex_unlock(&dev->mutex:0)
[    0.996493] 
[    0.996493] [S]: start of the event context
[    0.996493] [W]: the wait blocked
[    0.996493] [E]: the event not reachable
[    0.996493] ---------------------------------------------------
[    0.996493] context A's detail
[    0.996493] ---------------------------------------------------
[    0.996493] context A
[    0.996493]     [S] __mutex_lock(&dev->mutex:0)
[    0.996493]     [W] __mutex_lock(&dev->mutex:0)
[    0.996493]     [E] __mutex_unlock(&dev->mutex:0)
[    0.996493] 
[    0.996493] [S] __mutex_lock(&dev->mutex:0):
[    0.996493] [<ffffffff8168a0f8>] device_driver_attach+0x18/0x50
[    0.996493] stacktrace:
[    0.996493]       __mutex_lock+0x6b5/0x8f0
[    0.996493]       device_driver_attach+0x18/0x50
[    0.996493]       __driver_attach+0x82/0xc0
[    0.996493]       bus_for_each_dev+0x57/0x90
[    0.996493]       bus_add_driver+0x175/0x1f0
[    0.996493]       driver_register+0x56/0xe0
[    0.996493]       do_one_initcall+0x62/0x20f
[    0.996493]       kernel_init_freeable+0x22e/0x26a
[    0.996493]       kernel_init+0x5/0x110
[    0.996493]       ret_from_fork+0x22/0x30
[    0.996493] 
[    0.996493] [W] __mutex_lock(&dev->mutex:0):
[    0.996493] [<ffffffff816841f2>] device_del+0x32/0x3d0
[    0.996493] stacktrace:
[    0.996493]       dept_wait_ecxt_enter+0x130/0x2b0
[    0.996493]       __mutex_lock+0x6b5/0x8f0
[    0.996493]       device_del+0x32/0x3d0
[    0.996493]       device_unregister+0x9/0x20
[    0.996493]       wakeup_source_unregister+0x20/0x30
[    0.996493]       device_wakeup_enable+0x93/0xd0
[    0.996493]       acpi_button_add+0x3a1/0x480
[    0.996493]       acpi_device_probe+0x40/0x100
[    0.996493]       really_probe+0x1b7/0x380
[    0.996493]       driver_probe_device+0x4a/0xa0
[    0.996493]       device_driver_attach+0x4a/0x50
[    0.996493]       __driver_attach+0x82/0xc0
[    0.996493]       bus_for_each_dev+0x57/0x90
[    0.996493]       bus_add_driver+0x175/0x1f0
[    0.996493]       driver_register+0x56/0xe0
[    0.996493]       do_one_initcall+0x62/0x20f
[    0.996493] 
[    0.996493] [E] __mutex_unlock(&dev->mutex:0):
[    0.996493] (N/A)
[    0.996493] ---------------------------------------------------
[    0.996493] information that might be helpful
[    0.996493] ---------------------------------------------------
[    0.996493] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.9.0+ #8
[    0.996493] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    0.996493] Call Trace:
[    0.996493]  dump_stack+0x77/0x9b
[    0.996493]  print_circle+0x431/0x670
[    0.996493]  ? device_driver_attach+0x18/0x50
[    0.996493]  ? print_circle+0x670/0x670
[    0.996493]  ? device_del+0x32/0x3d0
[    0.996493]  cb_check_dl+0x45/0x60
[    0.996493]  bfs+0x6c/0x190
[    0.996493]  ? device_del+0x32/0x3d0
[    0.996493]  add_dep+0x6b/0x80
[    0.996493]  add_wait+0x2fb/0x350
[    0.996493]  ? device_del+0x32/0x3d0
[    0.996493]  dept_wait_ecxt_enter+0x130/0x2b0
[    0.996493]  __mutex_lock+0x6b5/0x8f0
[    0.996493]  ? device_del+0x32/0x3d0
[    0.996493]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[    0.996493]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[    0.996493]  ? device_del+0x32/0x3d0
[    0.996493]  device_del+0x32/0x3d0
[    0.996493]  ? del_timer_sync+0x74/0xa0
[    0.996493]  device_unregister+0x9/0x20
[    0.996493]  wakeup_source_unregister+0x20/0x30
[    0.996493]  device_wakeup_enable+0x93/0xd0
[    0.996493]  acpi_button_add+0x3a1/0x480
[    0.996493]  acpi_device_probe+0x40/0x100
[    0.996493]  really_probe+0x1b7/0x380
[    0.996493]  ? rdinit_setup+0x26/0x26
[    0.996493]  driver_probe_device+0x4a/0xa0
[    0.996493]  device_driver_attach+0x4a/0x50
[    0.996493]  __driver_attach+0x82/0xc0
[    0.996493]  ? device_driver_attach+0x50/0x50
[    0.996493]  bus_for_each_dev+0x57/0x90
[    0.996493]  bus_add_driver+0x175/0x1f0
[    0.996493]  driver_register+0x56/0xe0
[    0.996493]  ? acpi_ac_init+0x8e/0x8e
[    0.996493]  do_one_initcall+0x62/0x20f
[    0.996493]  kernel_init_freeable+0x22e/0x26a
[    0.996493]  ? rest_init+0x120/0x120
[    0.996493]  kernel_init+0x5/0x110
[    0.996493]  ret_from_fork+0x22/0x30
[    1.033630] ACPI: Power Button [PWRF]
[    1.034325] ===================================================
[    1.034425] Dept: Circular dependency has been detected.
[    1.034425] 5.9.0+ #8 Tainted: G        W        
[    1.034425] ---------------------------------------------------
[    1.034425] summary
[    1.034425] ---------------------------------------------------
[    1.034425] *** DEADLOCK ***
[    1.034425] 
[    1.034425] context A
[    1.034425]     [S] __mutex_lock(&dev->mutex:0)
[    1.034425]     [W] __mutex_lock(cpu_add_remove_lock:0)
[    1.034425]     [E] __mutex_unlock(&dev->mutex:0)
[    1.034425] 
[    1.034425] context B
[    1.034425]     [S] __mutex_lock(pmus_lock:0)
[    1.034425]     [W] __mutex_lock(&dev->mutex:0)
[    1.034425]     [E] __mutex_unlock(pmus_lock:0)
[    1.034425] 
[    1.034425] context C
[    1.034425]     [S] __mutex_lock(cpu_add_remove_lock:0)
[    1.034425]     [W] __mutex_lock(pmus_lock:0)
[    1.034425]     [E] __mutex_unlock(cpu_add_remove_lock:0)
[    1.034425] 
[    1.034425] [S]: start of the event context
[    1.034425] [W]: the wait blocked
[    1.034425] [E]: the event not reachable
[    1.034425] ---------------------------------------------------
[    1.034425] context A's detail
[    1.034425] ---------------------------------------------------
[    1.034425] context A
[    1.034425]     [S] __mutex_lock(&dev->mutex:0)
[    1.034425]     [W] __mutex_lock(cpu_add_remove_lock:0)
[    1.034425]     [E] __mutex_unlock(&dev->mutex:0)
[    1.034425] 
[    1.034425] [S] __mutex_lock(&dev->mutex:0):
[    1.034425] [<ffffffff8168a0f8>] device_driver_attach+0x18/0x50
[    1.034425] stacktrace:
[    1.034425]       __mutex_lock+0x6b5/0x8f0
[    1.034425]       device_driver_attach+0x18/0x50
[    1.034425]       __driver_attach+0x82/0xc0
[    1.034425]       bus_for_each_dev+0x57/0x90
[    1.034425]       bus_add_driver+0x175/0x1f0
[    1.034425]       driver_register+0x56/0xe0
[    1.034425]       acpi_processor_driver_init+0x1c/0xad
[    1.034425]       do_one_initcall+0x62/0x20f
[    1.034425]       kernel_init_freeable+0x22e/0x26a
[    1.034425]       kernel_init+0x5/0x110
[    1.034425]       ret_from_fork+0x22/0x30
[    1.034425] 
[    1.034425] [W] __mutex_lock(cpu_add_remove_lock:0):
[    1.034425] [<ffffffff8106635e>] cpu_hotplug_disable+0xe/0x30
[    1.034425] stacktrace:
[    1.034425]       dept_wait_ecxt_enter+0x130/0x2b0
[    1.034425]       __mutex_lock+0x6b5/0x8f0
[    1.034425]       cpu_hotplug_disable+0xe/0x30
[    1.034425]       acpi_processor_start+0x25/0x40
[    1.034425]       really_probe+0x1b7/0x380
[    1.034425]       driver_probe_device+0x4a/0xa0
[    1.034425]       device_driver_attach+0x4a/0x50
[    1.034425]       __driver_attach+0x82/0xc0
[    1.034425]       bus_for_each_dev+0x57/0x90
[    1.034425]       bus_add_driver+0x175/0x1f0
[    1.034425]       driver_register+0x56/0xe0
[    1.034425]       acpi_processor_driver_init+0x1c/0xad
[    1.034425]       do_one_initcall+0x62/0x20f
[    1.034425]       kernel_init_freeable+0x22e/0x26a
[    1.034425]       kernel_init+0x5/0x110
[    1.034425]       ret_from_fork+0x22/0x30
[    1.034425] 
[    1.034425] [E] __mutex_unlock(&dev->mutex:0):
[    1.034425] (N/A)
[    1.034425] ---------------------------------------------------
[    1.034425] context B's detail
[    1.034425] ---------------------------------------------------
[    1.034425] context B
[    1.034425]     [S] __mutex_lock(pmus_lock:0)
[    1.034425]     [W] __mutex_lock(&dev->mutex:0)
[    1.034425]     [E] __mutex_unlock(pmus_lock:0)
[    1.034425] 
[    1.034425] [S] __mutex_lock(pmus_lock:0):
[    1.034425] [<ffffffff82cad537>] perf_event_sysfs_init+0x12/0x86
[    1.034425] stacktrace:
[    1.034425]       __mutex_lock+0x6b5/0x8f0
[    1.034425]       perf_event_sysfs_init+0x12/0x86
[    1.034425]       do_one_initcall+0x62/0x20f
[    1.034425]       kernel_init_freeable+0x22e/0x26a
[    1.034425]       kernel_init+0x5/0x110
[    1.034425]       ret_from_fork+0x22/0x30
[    1.034425] 
[    1.034425] [W] __mutex_lock(&dev->mutex:0):
[    1.034425] [<ffffffff81689974>] __device_attach+0x24/0x120
[    1.034425] stacktrace:
[    1.034425]       __mutex_lock+0x6b5/0x8f0
[    1.034425]       __device_attach+0x24/0x120
[    1.034425]       bus_probe_device+0x97/0xb0
[    1.034425]       device_add+0x49a/0x810
[    1.034425]       pmu_dev_alloc+0x83/0xf0
[    1.034425]       perf_event_sysfs_init+0x50/0x86
[    1.034425]       do_one_initcall+0x62/0x20f
[    1.034425]       kernel_init_freeable+0x22e/0x26a
[    1.034425]       kernel_init+0x5/0x110
[    1.034425]       ret_from_fork+0x22/0x30
[    1.034425] 
[    1.034425] [E] __mutex_unlock(pmus_lock:0):
[    1.034425] (N/A)
[    1.034425] ---------------------------------------------------
[    1.034425] context C's detail
[    1.034425] ---------------------------------------------------
[    1.034425] context C
[    1.034425]     [S] __mutex_lock(cpu_add_remove_lock:0)
[    1.034425]     [W] __mutex_lock(pmus_lock:0)
[    1.034425]     [E] __mutex_unlock(cpu_add_remove_lock:0)
[    1.034425] 
[    1.034425] [S] __mutex_lock(cpu_add_remove_lock:0):
[    1.034425] [<ffffffff81067f97>] cpu_up+0x27/0xa0
[    1.034425] stacktrace:
[    1.034425]       __mutex_lock+0x6b5/0x8f0
[    1.034425]       cpu_up+0x27/0xa0
[    1.034425]       bringup_nonboot_cpus+0x4a/0x60
[    1.034425]       smp_init+0x21/0x6f
[    1.034425]       kernel_init_freeable+0x13f/0x26a
[    1.034425]       kernel_init+0x5/0x110
[    1.034425]       ret_from_fork+0x22/0x30
[    1.034425] 
[    1.034425] [W] __mutex_lock(pmus_lock:0):
[    1.034425] [<ffffffff81176515>] perf_event_init_cpu+0x55/0x100
[    1.034425] stacktrace:
[    1.034425]       __mutex_lock+0x6b5/0x8f0
[    1.034425]       perf_event_init_cpu+0x55/0x100
[    1.034425]       cpuhp_invoke_callback+0xaf/0x610
[    1.034425]       _cpu_up+0xa2/0x130
[    1.034425]       cpu_up+0x61/0xa0
[    1.034425]       bringup_nonboot_cpus+0x4a/0x60
[    1.034425]       smp_init+0x21/0x6f
[    1.034425]       kernel_init_freeable+0x13f/0x26a
[    1.034425]       kernel_init+0x5/0x110
[    1.034425]       ret_from_fork+0x22/0x30
[    1.034425] 
[    1.034425] [E] __mutex_unlock(cpu_add_remove_lock:0):
[    1.034425] [<ffffffff81088ea7>] __kthread_parkme+0x27/0x60
[    1.034425] ---------------------------------------------------
[    1.034425] information that might be helpful
[    1.034425] ---------------------------------------------------
[    1.034425] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.9.0+ #8
[    1.034425] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    1.034425] Call Trace:
[    1.034425]  dump_stack+0x77/0x9b
[    1.034425]  ? __kthread_parkme+0x27/0x60
[    1.034425]  print_circle+0x431/0x670
[    1.034425]  ? cpu_up+0x27/0xa0
[    1.034425]  ? print_circle+0x670/0x670
[    1.034425]  cb_check_dl+0x58/0x60
[    1.034425]  bfs+0xd1/0x190
[    1.034425]  ? cpu_hotplug_disable+0xe/0x30
[    1.034425]  add_dep+0x6b/0x80
[    1.034425]  add_wait+0x2fb/0x350
[    1.034425]  ? cpu_hotplug_disable+0xe/0x30
[    1.034425]  dept_wait_ecxt_enter+0x130/0x2b0
[    1.034425]  __mutex_lock+0x6b5/0x8f0
[    1.034425]  ? kernfs_add_one+0x12e/0x140
[    1.034425]  ? __mutex_unlock_slowpath+0x45/0x290
[    1.034425]  ? cpu_hotplug_disable+0xe/0x30
[    1.034425]  ? kernfs_add_one+0x12e/0x140
[    1.034425]  ? cpu_hotplug_disable+0xe/0x30
[    1.034425]  cpu_hotplug_disable+0xe/0x30
[    1.034425]  acpi_processor_start+0x25/0x40
[    1.034425]  really_probe+0x1b7/0x380
[    1.034425]  ? rdinit_setup+0x26/0x26
[    1.034425]  driver_probe_device+0x4a/0xa0
[    1.034425]  device_driver_attach+0x4a/0x50
[    1.034425]  __driver_attach+0x82/0xc0
[    1.034425]  ? device_driver_attach+0x50/0x50
[    1.034425]  bus_for_each_dev+0x57/0x90
[    1.034425]  bus_add_driver+0x175/0x1f0
[    1.034425]  driver_register+0x56/0xe0
[    1.034425]  ? acpi_video_init+0x7d/0x7d
[    1.034425]  acpi_processor_driver_init+0x1c/0xad
[    1.034425]  do_one_initcall+0x62/0x20f
[    1.034425]  kernel_init_freeable+0x22e/0x26a
[    1.034425]  ? rest_init+0x120/0x120
[    1.034425]  kernel_init+0x5/0x110
[    1.034425]  ret_from_fork+0x22/0x30
[    1.102213] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.103016] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.106696] Non-volatile memory driver v1.3
[    1.107354] Linux agpgart interface v0.103
[    1.133716] loop: module loaded
[    1.140278] scsi host0: ata_piix
[    1.141849] scsi host1: ata_piix
[    1.142560] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    1.143177] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    1.144821] e100: Intel(R) PRO/100 Network Driver
[    1.145263] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.145847] e1000: Intel(R) PRO/1000 Network Driver
[    1.146302] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.149639] PCI Interrupt Link [LNKC] enabled at IRQ 11
[    1.272470] ata1.00: ATA-7: QEMU HARDDISK, 2.0.0, max UDMA/100
[    1.273150] ata1.00: 16777216 sectors, multi 16: LBA48 
[    1.273808] ata2.00: ATAPI: QEMU DVD-ROM, 2.0.0, max UDMA/100
[    1.275445] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    0    PQ: 0 ANSI: 5
[    1.277740] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.277937] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 GB/8.00 GiB)
[    1.279176] sd 0:0:0:0: [sda] Write Protect is off
[    1.280032] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.0. PQ: 0 ANSI: 5
[    1.281733] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.287285]  sda: sda1 sda2 < sda5 >
[    1.290588] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.400427] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    1.401118] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.406553] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    1.456822] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    1.457472] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    1.458256] e1000e: Intel(R) PRO/1000 Network Driver
[    1.458741] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.459375] sky2: driver version 1.30
[    1.460732] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.461363] ehci-pci: EHCI PCI platform driver
[    1.461872] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.462464] ohci-pci: OHCI PCI platform driver
[    1.462968] uhci_hcd: USB Universal Host Controller Interface driver
[    1.463844] usbcore: registered new interface driver usblp
[    1.464433] usbcore: registered new interface driver usb-storage
[    1.465370] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.467044] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.467535] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.469937] rtc_cmos 00:00: RTC can wake from S4
[    1.471005] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.472993] rtc_cmos 00:00: registered as rtc0
[    1.473839] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram, hpet irqs
[    1.475466] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[    1.476279] intel_pstate: CPU model not supported
[    1.476814] hid: raw HID events driver (C) Jiri Kosina
[    1.478926] usbcore: registered new interface driver usbhid
[    1.479450] usbhid: USB HID core driver
[    1.482086] Initializing XFRM netlink socket
[    1.484824] NET: Registered protocol family 10
[    1.486654] Segment Routing with IPv6
[    1.487535] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.489292] NET: Registered protocol family 17
[    1.489856] Key type dns_resolver registered
[    1.492066] IPI shorthand broadcast: enabled
[    1.492516] sched_clock: Marking stable (1420822386, 71074958)->(1569263593, -77366249)
[    1.493921] registered taskstats version 1
[    1.494323] Loading compiled-in X.509 certificates
[    1.495557] PM:   Magic number: 12:947:778
[    1.496041] printk: console [netcon0] enabled
[    1.496457] netconsole: network logging started
[    1.498082] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.499579] kworker/u8:1 (80) used greatest stack depth: 13616 bytes left
[    1.500936] ===================================================
[    1.501536] Dept: Circular dependency has been detected.
[    1.502355] 5.9.0+ #8 Tainted: G        W        
[    1.503244] ---------------------------------------------------
[    1.504366] summary
[    1.504816] ---------------------------------------------------
[    1.505938] *** AA DEADLOCK ***
[    1.505938] 
[    1.506808] context A
[    1.507213]     [S] (unknown)(&larval->completion:0)
[    1.508142]     [W] wait_for_completion_killable(&larval->completion:0)
[    1.509325]     [E] complete_all(&larval->completion:0)
[    1.509833] 
[    1.509975] [S]: start of the event context
[    1.510342] [W]: the wait blocked
[    1.510637] [E]: the event not reachable
[    1.511061] ---------------------------------------------------
[    1.511580] context A's detail
[    1.511929] ---------------------------------------------------
[    1.512446] context A
[    1.512651]     [S] (unknown)(&larval->completion:0)
[    1.513149]     [W] wait_for_completion_killable(&larval->completion:0)
[    1.513781]     [E] complete_all(&larval->completion:0)
[    1.514244] 
[    1.514382] [S] (unknown)(&larval->completion:0):
[    1.514870] (N/A)
[    1.515051] 
[    1.515214] [W] wait_for_completion_killable(&larval->completion:0):
[    1.515836] [<ffffffff813aad5a>] crypto_wait_for_test+0x3a/0x70
[    1.516359] stacktrace:
[    1.516581]       wait_for_completion_killable+0x34/0x150
[    1.517139]       crypto_wait_for_test+0x3a/0x70
[    1.517545]       crypto_register_instance+0xe8/0x110
[    1.518067]       pkcs1pad_create+0x1d9/0x250
[    1.518452]       cryptomgr_probe+0x33/0x80
[    1.518880]       kthread+0x144/0x180
[    1.519204]       ret_from_fork+0x22/0x30
[    1.519557] 
[    1.519735] [E] complete_all(&larval->completion:0):
[    1.520208] [<ffffffff813b0d9c>] cryptomgr_probe+0x5c/0x80
[    1.520702] stacktrace:
[    1.520967]       complete_all+0x28/0x60
[    1.521339]       cryptomgr_probe+0x5c/0x80
[    1.521824]       kthread+0x144/0x180
[    1.522154]       ret_from_fork+0x22/0x30
[    1.522509] ---------------------------------------------------
[    1.523085] information that might be helpful
[    1.523471] ---------------------------------------------------
[    1.524107] CPU: 3 PID: 82 Comm: cryptomgr_probe Tainted: G        W         5.9.0+ #8
[    1.524873] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    1.525876] Call Trace:
[    1.526104]  dump_stack+0x77/0x9b
[    1.526401]  ? cryptomgr_probe+0x5c/0x80
[    1.526859]  print_circle+0x431/0x670
[    1.527190]  ? stack_trace_save+0x36/0x40
[    1.527547]  ? print_circle+0x670/0x670
[    1.528001]  cb_check_dl+0x45/0x60
[    1.528306]  bfs+0x6c/0x190
[    1.528559]  add_dep+0x6b/0x80
[    1.528916]  dept_event+0x4a9/0x580
[    1.529232]  ? cryptomgr_probe+0x5c/0x80
[    1.529603]  ? crypto_alg_put+0x40/0x40
[    1.530007]  complete_all+0x28/0x60
[    1.530328]  cryptomgr_probe+0x5c/0x80
[    1.530662]  kthread+0x144/0x180
[    1.531007]  ? kthread_destroy_worker+0x40/0x40
[    1.531442]  ret_from_fork+0x22/0x30
[    1.532135] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.532949] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.533850] cfg80211: failed to load regulatory.db
[    1.533886] ALSA device list:
[    1.534700]   No soundcards found.
[    1.979978] tsc: Refined TSC clocksource calibration: 3197.737 MHz
[    1.981303] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e17f0aea14, max_idle_ns: 440795355206 ns
[    1.983501] clocksource: Switched to clocksource tsc
[    2.094732] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[    2.097508] md: Waiting for all devices to be available before autodetect
[    2.098771] md: If you don't use raid, use raid=noautodetect
[    2.099833] md: Autodetecting RAID arrays.
[    2.100591] md: autorun ...
[    2.101163] md: ... autorun DONE.
[    2.108775] EXT4-fs (sda1): INFO: recovery required on readonly filesystem
[    2.109605] EXT4-fs (sda1): write access will be enabled during recovery
[    2.143768] random: fast init done
[    2.156518] EXT4-fs (sda1): recovery complete
[    2.161843] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    2.162971] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[    2.166192] devtmpfs: mounted
[    2.168706] Freeing unused kernel image (initmem) memory: 1184K
[    2.169965] Write protecting the kernel read-only data: 22528k
[    2.175246] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    2.178542] Freeing unused kernel image (rodata/data gap) memory: 1584K
[    2.180077] Run /sbin/init as init process
SELinux:  Could not open policy file <= /etc/selinux/targeted/policy/policy.33:  No such file or directory
[    2.327709] random: init: uninitialized urandom read (12 bytes read)
[    2.356127] hostname (87) used greatest stack depth: 13000 bytes left
[    2.393522] startpar-upstar (93) used greatest stack depth: 12904 bytes left
[    2.402851] ===================================================
[    2.403419] Dept: Circular dependency has been detected.
[    2.404088] 5.9.0+ #8 Tainted: G        W        
[    2.404677] ---------------------------------------------------
[    2.405532] summary
[    2.405887] ---------------------------------------------------
[    2.406745] *** AA DEADLOCK ***
[    2.406745] 
[    2.407383] context A
[    2.407717]     [S] __mutex_lock(&tty->legacy_mutex:0)
[    2.408466]     [W] __mutex_lock(&tty->legacy_mutex:0)
[    2.409208]     [E] __mutex_unlock(&tty->legacy_mutex:0)
[    2.409746] 
[    2.409894] [S]: start of the event context
[    2.410270] [W]: the wait blocked
[    2.410570] [E]: the event not reachable
[    2.411032] ---------------------------------------------------
[    2.411562] context A's detail
[    2.411892] ---------------------------------------------------
[    2.412421] context A
[    2.412774]     [S] __mutex_lock(&tty->legacy_mutex:0)
[    2.413274]     [W] __mutex_lock(&tty->legacy_mutex:0)
[    2.413791]     [E] __mutex_unlock(&tty->legacy_mutex:0)
[    2.414320] 
[    2.414487] [S] __mutex_lock(&tty->legacy_mutex:0):
[    2.415030] [<ffffffff814c468d>] tty_release+0x4d/0x500
[    2.415498] stacktrace:
[    2.415791]       __mutex_lock+0x6b5/0x8f0
[    2.416168]       tty_release+0x4d/0x500
[    2.416526]       __fput+0x97/0x240
[    2.416913]       task_work_run+0x60/0x90
[    2.417281]       exit_to_user_mode_prepare+0x146/0x150
[    2.417797]       syscall_exit_to_user_mode+0x2d/0x190
[    2.418262]       entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.418817] 
[    2.418963] [W] __mutex_lock(&tty->legacy_mutex:0):
[    2.419413] [<ffffffff814c4b9c>] __tty_hangup+0x5c/0x2b0
[    2.419941] stacktrace:
[    2.420166]       dept_wait_ecxt_enter+0x130/0x2b0
[    2.420598]       __mutex_lock+0x6b5/0x8f0
[    2.421052]       __tty_hangup+0x5c/0x2b0
[    2.421425]       tty_release+0xf3/0x500
[    2.421889]       __fput+0x97/0x240
[    2.422205]       task_work_run+0x60/0x90
[    2.422565]       exit_to_user_mode_prepare+0x146/0x150
[    2.423066]       syscall_exit_to_user_mode+0x2d/0x190
[    2.423524]       entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.424124] 
[    2.424264] [E] __mutex_unlock(&tty->legacy_mutex:0):
[    2.424774] (N/A)
[    2.424961] ---------------------------------------------------
[    2.425764] information that might be helpful
[    2.426160] ---------------------------------------------------
[    2.426737] CPU: 0 PID: 1 Comm: init Tainted: G        W         5.9.0+ #8
[    2.427355] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    2.428126] Call Trace:
[    2.428354]  dump_stack+0x77/0x9b
[    2.428656]  print_circle+0x431/0x670
[    2.429049]  ? tty_release+0x4d/0x500
[    2.429382]  ? print_circle+0x670/0x670
[    2.429778]  ? __tty_hangup+0x5c/0x2b0
[    2.430135]  cb_check_dl+0x45/0x60
[    2.430491]  bfs+0x6c/0x190
[    2.430815]  ? __tty_hangup+0x5c/0x2b0
[    2.431158]  add_dep+0x6b/0x80
[    2.431472]  add_wait+0x2fb/0x350
[    2.431912]  ? __tty_hangup+0x5c/0x2b0
[    2.432252]  dept_wait_ecxt_enter+0x130/0x2b0
[    2.432645]  __mutex_lock+0x6b5/0x8f0
[    2.433076]  ? __tty_hangup+0x29/0x2b0
[    2.433422]  ? __tty_hangup+0x5c/0x2b0
[    2.433810]  ? find_held_lock+0x2d/0x90
[    2.434161]  ? __tty_hangup+0x54/0x2b0
[    2.434501]  ? to_pool+0x43/0x70
[    2.434847]  ? pop_ecxt+0x108/0x110
[    2.435164]  ? __tty_hangup+0x5c/0x2b0
[    2.435503]  __tty_hangup+0x5c/0x2b0
[    2.435900]  tty_release+0xf3/0x500
[    2.436216]  ? _raw_spin_unlock_irq+0x2d/0x30
[    2.436608]  __fput+0x97/0x240
[    2.436941]  task_work_run+0x60/0x90
[    2.437269]  exit_to_user_mode_prepare+0x146/0x150
[    2.437764]  syscall_exit_to_user_mode+0x2d/0x190
[    2.438202]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.438653] RIP: 0033:0x7fb31f764f60
[    2.439032] Code: 00 64 c7 00 0d 00 00 00 b8 ff ff ff ff eb 90 b8 ff ff ff ff eb 89 0f 1f 40 00 83 3d 1d 81 2d 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe c1 01 00 48 89 04 24
[    2.440820] RSP: 002b:00007ffeaef17ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[    2.441499] RAX: 0000000000000000 RBX: 0000561ce2919ca0 RCX: 00007fb31f764f60
[    2.442199] RDX: 0000561ce2919c70 RSI: 00007ffeaef17b10 RDI: 000000000000000a
[    2.442900] RBP: 0000561ce2919c70 R08: 0000000000000000 R09: 0000561ce2919d00
[    2.443567] R10: 00007fb31fa38c8c R11: 0000000000000246 R12: 0000561ce2919d00
[    2.444274] R13: 0000561ce2919c70 R14: 0000561ce2919ca0 R15: 00007ffeaef17d60
[    2.445912] init: plymouth-upstart-bridge main process (89) terminated with status 1
[    2.446781] init: plymouth-upstart-bridge main process ended, respawning
[    2.467366] init: plymouth-upstart-bridge main process (100) terminated with status 1
[    2.469260] init: plymouth-upstart-bridge main process ended, respawning
[    2.485527] init: ureadahead main process (92) terminated with status 5
[    2.486635] init: plymouth-upstart-bridge main process (104) terminated with status 1
[    2.486750] init: plymouth-upstart-bridge main process ended, respawning
[    2.492446] plymouthd (90) used greatest stack depth: 12744 bytes left
[    2.512003] ===================================================
[    2.512589] Dept: Circular dependency has been detected.
[    2.513102] 5.9.0+ #8 Tainted: G        W        
[    2.513538] ---------------------------------------------------
[    2.514408] summary
[    2.514611] ---------------------------------------------------
[    2.515243] *** AA DEADLOCK ***
[    2.515243] 
[    2.515678] context A
[    2.515898]     [S] __raw_spin_lock(&wq_head->lock:0)
[    2.516382]         <softirq interrupt>
[    2.516745]         [W] __raw_spin_lock_irqsave(&wq_head->lock:0)
[    2.517324]     [E] __raw_spin_unlock(&wq_head->lock:0)
[    2.517806] 
[    2.517950] [S]: start of the event context
[    2.518338] [W]: the wait blocked
[    2.518648] [E]: the event not reachable
[    2.519012] ---------------------------------------------------
[    2.519558] context A's detail
[    2.519844] ---------------------------------------------------
[    2.520388] context A
[    2.520601]     [S] __raw_spin_lock(&wq_head->lock:0)
[    2.521076]         <softirq interrupt>
[    2.521437]         [W] __raw_spin_lock_irqsave(&wq_head->lock:0)
[    2.521993]     [E] __raw_spin_unlock(&wq_head->lock:0)
[    2.522459] 
[    2.522600] softirq has been enabled:
[    2.522946] [<ffffffff81b4fd89>] _raw_spin_unlock_irqrestore+0x39/0x40
[    2.523523] 
[    2.523664] [S] __raw_spin_lock(&wq_head->lock:0):
[    2.524109] [<ffffffff819da779>] unix_dgram_peer_wake_disconnect+0x19/0x80
[    2.524742] stacktrace:
[    2.524975]       dept_wait_ecxt_enter+0x1cc/0x2b0
[    2.525411]       _raw_spin_lock+0x49/0x60
[    2.525789]       unix_dgram_peer_wake_disconnect+0x19/0x80
[    2.526292]       unix_release_sock+0x15c/0x330
[    2.526702]       unix_release+0x14/0x20
[    2.527067]       __sock_release+0x38/0xb0
[    2.527454]       sock_close+0xf/0x20
[    2.527795]       __fput+0x97/0x240
[    2.528117]       task_work_run+0x60/0x90
[    2.528479]       exit_to_user_mode_prepare+0x146/0x150
[    2.528961]       syscall_exit_to_user_mode+0x2d/0x190
[    2.529429]       entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.529931] 
[    2.530072] [W] __raw_spin_lock_irqsave(&wq_head->lock:0):
[    2.530574] [<ffffffff810d7f2a>] rcu_sync_func+0x2a/0xb0
[    2.531064] stacktrace:
[    2.531314]       _raw_spin_lock_irqsave+0x5a/0x70
[    2.531764]       rcu_sync_func+0x2a/0xb0
[    2.532134]       rcu_core+0x265/0x870
[    2.532473]       __do_softirq+0x16f/0x390
[    2.532852]       asm_call_irq_on_stack+0x12/0x20
[    2.533313]       do_softirq_own_stack+0x32/0x40
[    2.533742]       irq_exit_rcu+0xb0/0xc0
[    2.534105]       sysvec_apic_timer_interrupt+0x2c/0x80
[    2.534585]       asm_sysvec_apic_timer_interrupt+0x12/0x20
[    2.535097]       _raw_spin_unlock_irqrestore+0x3b/0x40
[    2.535565]       __set_cpus_allowed_ptr+0x7a/0x190
[    2.536020]       __kthread_create_on_node+0x161/0x1c0
[    2.536478]       kthread_create_on_node+0x32/0x40
[    2.536922]       kthread_create_on_cpu+0x22/0x90
[    2.537352]       __smpboot_create_thread.part.8+0x5e/0x110
[    2.537861]       smpboot_create_threads+0x61/0x90
[    2.538295] 
[    2.538436] [E] __raw_spin_unlock(&wq_head->lock:0):
[    2.538894] (N/A)
[    2.539072] ---------------------------------------------------
[    2.539598] information that might be helpful
[    2.540004] ---------------------------------------------------
[    2.540531] CPU: 3 PID: 98 Comm: status Tainted: G        W         5.9.0+ #8
[    2.541188] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    2.541917] Call Trace:
[    2.542146]  dump_stack+0x77/0x9b
[    2.542448]  print_circle+0x431/0x670
[    2.542787]  ? unix_dgram_peer_wake_disconnect+0x19/0x80
[    2.543268]  ? print_circle+0x670/0x670
[    2.543627]  cb_check_dl+0x45/0x60
[    2.543963]  bfs+0x6c/0x190
[    2.544219]  add_iecxt+0x123/0x1d0
[    2.544529]  ? arch_stack_walk+0x7e/0xb0
[    2.544901]  ? unix_dgram_peer_wake_disconnect+0x19/0x80
[    2.545589]  add_ecxt+0x126/0x1a0
[    2.545907]  ? unix_dgram_peer_wake_disconnect+0x19/0x80
[    2.546386]  dept_wait_ecxt_enter+0x1cc/0x2b0
[    2.546789]  _raw_spin_lock+0x49/0x60
[    2.547140]  ? unix_dgram_peer_wake_disconnect+0x19/0x80
[    2.547617]  unix_dgram_peer_wake_disconnect+0x19/0x80
[    2.548095]  unix_release_sock+0x15c/0x330
[    2.548494]  unix_release+0x14/0x20
[    2.548824]  __sock_release+0x38/0xb0
[    2.549188]  sock_close+0xf/0x20
[    2.549488]  __fput+0x97/0x240
[    2.549776]  task_work_run+0x60/0x90
[    2.550109]  exit_to_user_mode_prepare+0x146/0x150
[    2.550541]  syscall_exit_to_user_mode+0x2d/0x190
[    2.550981]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.551436] RIP: 0033:0x7f397dbc3f60
[    2.551769] Code: 00 64 c7 00 0d 00 00 00 b8 ff ff ff ff eb 90 b8 ff ff ff ff eb 89 0f 1f 40 00 83 3d 1d 81 2d 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe c1 01 00 48 89 04 24
[    2.553462] RSP: 002b:00007ffed2511978 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[    2.554149] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f397dbc3f60
[    2.554801] RDX: 00007f397de96780 RSI: 0000000000000000 RDI: 0000000000000003
[    2.555441] RBP: 0000000000000000 R08: 0000000000000a00 R09: 0000563a8fc69ec0
[    2.556083] R10: 00007ffed2511740 R11: 0000000000000246 R12: 0000563a8dae973b
[    2.556716] R13: 00007ffed2511b40 R14: 0000000000000000 R15: 0000000000000000
[    2.595010] random: mountall: uninitialized urandom read (12 bytes read)
[    2.792977] apt-config (170) used greatest stack depth: 12728 bytes left
 * Starting Mount filesystems on boot[74G[ OK ]
 * Starting Populate /dev filesystem[74G[ OK ]
 * Stopping Populate /dev filesystem[74G[ OK ]
 * Starting Populate and link to /run filesystem[74G[ OK ]
 * Stopping Populate and link to /run filesystem[74G[ OK ]
 * Stopping Track if upstart is running in a container[74G[ OK ]
 * Starting Initialize or finalize resolvconf[74G[ OK ]
 * Starting set console keymap[74G[ OK ]
 * Starting Signal sysvinit that virtual filesystems are mounted[74G[ OK ]
 * Starting Signal sysvinit that virtual filesystems are mounted[74G[ OK ]
 * Starting Bridge udev events into upstart[74G[ OK ]
 * Starting Signal sysvinit that remote filesystems are mounted[74G[ OK ]
 * Starting device node and kernel event manager[74G[ OK ]
 * Stopping set console keymap[74G[ OK ]
 * Starting load modules from /etc/modules[74G[ OK ]
 * Starting cold plug devices[74G[ OK ]
 * Starting log initial device creation[74G[ OK ]
 * Stopping load modules from /etc/modules[74G[ OK ]
 * Starting Uncomplicated firewall[74G[ OK ]
 * Starting configure network device security[74G[ OK ]
 * Starting configure network device[74G[ OK ]
 * Starting configure network device security[74G[ OK ]
 * Starting configure network device security[74G[ OK ]
 * Starting configure network device[74G[ OK ]
 * Starting Mount network filesystems[74G[ OK ]
 * Starting Signal sysvinit that the rootfs is mounted[74G[ OK ]
 * Stopping Mount network filesystems[74G[ OK ]
 * Stopping cold plug devices[74G[ OK ]
 * Stopping log initial device creation[74G[ OK ]
 * Starting load fallback graphics devices[74G[ OK ]
 * Stopping load fallback graphics devices[74G[ OK ]
 * Starting set console font[74G[ OK ]
 * Starting set sysctls from /etc/sysctl.conf[74G[ OK ]
 * Stopping set sysctls from /etc/sysctl.conf[74G[ OK ]
 * Starting Clean /tmp directory[74G[ OK ]
 * Starting Bridge socket events into upstart[74G[ OK ]
 * Stopping Clean /tmp directory[74G[ OK ]
 * Starting Signal sysvinit that local filesystems are mounted[74G[ OK ]
 * Starting restore software rfkill state[74G[ OK ]
 * Starting configure network device security[74G[ OK ]
 * Stopping set console font[74G[ OK ]
 * Stopping restore software rfkill state[74G[ OK ]
 * Starting userspace bootsplash[74G[ OK ]
 * Starting flush early job output to logs[74G[ OK ]
 * Stopping Failsafe Boot Delay[74G[ OK ]
 * Stopping Mount filesystems on boot[74G[ OK ]
 * Starting System V initialisation compatibility[74G[ OK ]
 * Starting Send an event to indicate plymouth is up[74G[ OK ]
 * Starting configure network device[74G[ OK ]
 * Starting D-Bus system message bus[74G[ OK ]
 * Stopping userspace bootsplash[74G[ OK ]
 * Stopping flush early job output to logs[74G[ OK ]
 * Starting modem connection manager[74G[ OK ]
 * Starting configure network device security[74G[ OK ]
ModemManager[564]: <info>  ModemManager (version 1.0.0) starting...

 * Stopping Send an event to indicate plymouth is up[74G[ OK ]
 * Starting SystemD login management service[74G[ OK ]
 * Starting configure virtual network devices[74G[ OK ]
 * Starting bluetooth daemon[74G[ OK ]
 * Starting network connection manager[74G[ OK ]
 * Starting system logging daemon[74G[ OK ]
 * Setting up X socket directories...       [80G [74G[ OK ]
 * Starting mDNS/DNS-SD daemon[74G[ OK ]
 * Starting Reload cups, upon starting avahi-daemon to make sure remote queues are populated[74G[ OK ]
 * Stopping System V initialisation compatibility[74G[ OK ]
 * Starting System V runlevel compatibility[74G[ OK ]
 * Starting Restore Sound Card State[74G[ OK ]
 * Starting anac(h)ronistic cron[74G[ OK ]
 * Starting save kernel messages[74G[ OK ]
 * Starting CPU interrupts balancing daemon[74G[ OK ]
 * Starting ACPI daemon[74G[ OK ]
 * Starting crash report submission daemon[74G[ OK ]
 * Starting OpenSSH server[74G[ OK ]
 * Starting regular background program processing daemon[74G[ OK ]
 * Stopping Restore Sound Card State[74G[ OK ]
 * speech-dispatcher disabled; edit /etc/default/speech-dispatcher
saned disabled; edit /etc/default/saned
 * Stopping save kernel messages[74G[ OK ]
 * Stopping Reload cups, upon starting avahi-daemon to make sure remote queues are populated[74G[ OK ]
 * Restoring resolver state...       [80G [74G[ OK ]
