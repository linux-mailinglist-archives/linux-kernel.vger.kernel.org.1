Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3951F2FFDEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbhAVIKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:10:48 -0500
Received: from audible.transient.net ([24.143.126.66]:37052 "HELO
        audible.transient.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726820AbhAVIJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:09:51 -0500
Received: (qmail 23646 invoked from network); 22 Jan 2021 08:09:08 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 22 Jan 2021 08:09:08 -0000
Received: (nullmailer pid 3300 invoked by uid 1000);
        Fri, 22 Jan 2021 08:09:08 -0000
Date:   Fri, 22 Jan 2021 08:09:08 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org
Subject: bisected regression in v5.11-rc1 snd-usb-audio
Message-ID: <YAqIJHzE3UG51G/U@audible.transient.net>
Mail-Followup-To: tiwai@suse.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UNroi1QpYmtvioNX"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UNroi1QpYmtvioNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've bisected a failure in support for the M2Tech USB HiFace Two
192kHz Digital Audio Interface device (read as: a reclocked USB
S/PDIF) to the following ...

commit 93db51d06b32227319dae2ac289029ccf1b33181
Author: Takashi Iwai <tiwai@suse.de>
Date:   Mon Nov 23 09:53:09 2020 +0100

    ALSA: usb-audio: Check valid altsetting at parsing rates for UAC2/3

This has always been a somewhat finicky device, but my life is a
silent void without it, as it is currently a vital part of getting
audio to my mixer (now, if I could get USB Audio on my Rane MP2015
actually working right I'd very happily take that approach instead[1],
but I digress).  It has been known to require replugging to initialize
properly at times, but until now, it's always worked fine eventually.

I've attached the dmesg from a working 5.10.9 kernel, the alsa-info
output, and the lsusb -vvv output for this device when it's
functioning.  (Note, that alsa-info claims jack isn't running...
that's not actually true though, maybe because I'm using jack 2's
jackdbus subsystem, but jack is infact running, though it's probably
not relevant to the issue at hand[2].) 

When I boot 93db51d06b32 or later I get lot of errors in the dmesg
like:

 usb 1-1.1.2: New USB device found, idVendor=249c, idProduct=930b, bcdDevice= 2.13
 usb 1-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
 usb 1-1.1.2: Product: M2Tech USB Audio 2.0
 usb 1-1.1.2: Manufacturer: M2Tech 
 usb 1-1.1.2: SerialNumber: 0000
 usb 1-1.1.2: cannot get ctl value: req = 0x83, wValue = 0x201, wIndex = 0xa00, type = 4
 usb 1-1.1.2: 10:0: cannot get min/max values for control 2 (id 10)
 usb 1-1.1.2: cannot get ctl value: req = 0x83, wValue = 0x200, wIndex = 0xa00, type = 4
 usb 1-1.1.2: 10:0: cannot get min/max values for control 2 (id 10)
 usbcore: registered new interface driver snd-usb-audio
 usb 1-1.1-port2: disabled by hub (EMI?), re-enabling...
 usb 1-1.1.2: USB disconnect, device number 6
 usb 1-1.1.2: new full-speed USB device number 7 using ehci-pci
 usb 1-1.1.2: device descriptor read/64, error -32
 usb 1-1.1.2: device descriptor read/64, error -32
 usb 1-1.1.2: new full-speed USB device number 8 using ehci-pci
 usb 1-1.1.2: device descriptor read/64, error -32
 usb 1-1.1.2: device descriptor read/64, error -32
 usb 1-1.1-port2: attempt power cycle
 usb 1-1.1.2: new full-speed USB device number 9 using ehci-pci
 usb 1-1.1.2: device not accepting address 9, error -32
 usb 1-1.1.2: new full-speed USB device number 10 using ehci-pci
 usb 1-1.1.2: device not accepting address 10, error -32
 usb 1-1.1-port2: unable to enumerate USB device

and obviously the device doesn't work at all.  Sometimes there's more
"cannot get ctl value:" noise than other times, but the above is a
clean boot after being in a working state (it tends to require
replugging to get back to a being usable again after this, once I've
booted a working kernel, possibly becuase its hanging off a hub in my
monitor, not the most elegant of setups, I know---but none of this
changes even if I plug it directly into my workstation's USB ports, I
tried that).

I'm happy to try any patches, or provide more details, just ask.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/

[1] it's never been quite right, if you ever want to try to figure out
    why, I'd be happy to tackle that separately

[2] just in case, jack_control dp output:
--- get driver parameters (type:isset:default:value)
              device: ALSA device name (str:set:hw:0:hw:CARD=hiFace2,DEV=0)
             capture: Provide capture ports.  Optionally set device (str:notset:none:none)
            playback: Provide playback ports.  Optionally set device (str:set:none:hw:CARD=hiFace2,DEV=0)
                rate: Sample rate (uint:set:48000:96000)
              period: Frames per period (uint:notset:1024:1024)
            nperiods: Number of periods of playback latency (uint:set:2:3)
               hwmon: Hardware monitoring, if available (bool:notset:False:False)
             hwmeter: Hardware metering, if available (bool:notset:False:False)
              duplex: Provide both capture and playback ports (bool:notset:True:True)
            softmode: Soft-mode, no xrun handling (bool:notset:False:False)
             monitor: Provide monitor ports for the output (bool:notset:False:False)
              dither: Dithering mode (char:notset:n:n)
          inchannels: Number of capture channels (defaults to hardware max) (uint:notset:0:0)
         outchannels: Number of playback channels (defaults to hardware max) (uint:notset:0:0)
              shorts: Try 16-bit samples before 32-bit (bool:notset:False:False)
       input-latency: Extra input latency (frames) (uint:notset:0:0)
      output-latency: Extra output latency (frames) (uint:notset:0:0)
         midi-driver: ALSA MIDI driver (str:notset:none:none)


--UNroi1QpYmtvioNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="v5.10.9-working-dmesg.txt"

[    0.000000] Linux version 5.10.9 (jamie@cucamonga) (gcc (Debian 10.2.1-3) 10.2.1 20201224, GNU ld (GNU Binutils for Debian) 2.35.1) #1 SMP PREEMPT Thu Jan 21 10:39:14 UTC 2021
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.10.9 root=/dev/mapper/S-root ro rng-core.default_quality=512
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Enabled xstate features 0x3, context size is 576 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfe01bff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfe01c00-0x00000000bfe53bff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bfe53c00-0x00000000bfe55bff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bfe55c00-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fed003ff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed9ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023bffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: Dell Inc. Precision WorkStation T3400  /0TP412, BIOS A14 04/30/2012
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2992.388 MHz processor
[    0.001305] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001309] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001315] last_pfn = 0x23c000 max_arch_pfn = 0x400000000
[    0.001319] MTRR default type: uncachable
[    0.001320] MTRR fixed ranges enabled:
[    0.001321]   00000-9FFFF write-back
[    0.001322]   A0000-BFFFF uncachable
[    0.001323]   C0000-D3FFF write-protect
[    0.001324]   D4000-EFFFF uncachable
[    0.001325]   F0000-FFFFF write-protect
[    0.001326] MTRR variable ranges enabled:
[    0.001328]   0 base 000000000 mask 000000000 write-back
[    0.001330]   1 base 0BFF00000 mask FFFF00000 uncachable
[    0.001331]   2 base 0C0000000 mask FC0000000 uncachable
[    0.001332]   3 disabled
[    0.001333]   4 disabled
[    0.001334]   5 disabled
[    0.001335]   6 disabled
[    0.002789] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.003050] e820: update [mem 0xbff00000-0xffffffff] usable ==> reserved
[    0.003056] last_pfn = 0xbfe01 max_arch_pfn = 0x400000000
[    0.003072] check: Scanning 1 areas for low memory corruption
[    0.003784] RAMDISK: [mem 0x371dd000-0x378e5fff]
[    0.003791] ACPI: Early table checksum verification disabled
[    0.003796] ACPI: RSDP 0x00000000000FEBF0 000024 (v02 DELL  )
[    0.003800] ACPI: XSDT 0x00000000000FCEAA 000084 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.003807] ACPI: FACP 0x00000000000FCFD2 0000F4 (v03 DELL   B9K      00000015 ASL  00000061)
[    0.003813] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 128/64 (20200925/tbfadt-564)
[    0.003925] ACPI: DSDT 0x00000000FFF5D83F 003794 (v01 DELL   dt_ex    00001000 INTL 20050624)
[    0.003934] ACPI: FACS 0x00000000BFE01C00 000040
[    0.003937] ACPI: FACS 0x00000000BFE01C00 000040
[    0.004003] ACPI: SSDT 0x00000000FFF610F4 0000AC (v01 DELL   st_ex    00001000 INTL 20050624)
[    0.004008] ACPI: APIC 0x00000000000FD0C6 000092 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.004012] ACPI: BOOT 0x00000000000FD158 000028 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.004017] ACPI: ASF! 0x00000000000FD180 000096 (v32 DELL   B9K      00000015 ASL  00000061)
[    0.004021] ACPI: MCFG 0x00000000000FD216 00003E (v01 DELL   B9K      00000015 ASL  00000061)
[    0.004026] ACPI: HPET 0x00000000000FD254 000038 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.004031] ACPI: TCPA 0x00000000000FD4B0 000032 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.004035] ACPI: SLIC 0x00000000000FD28C 000176 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.004039] ACPI: SSDT 0x00000000BFE01C40 0001F9 (v01 DpgPmm Cpu0Ist  00000011 INTL 20050624)
[    0.004044] ACPI: SSDT 0x00000000BFE02049 0001F9 (v01 DpgPmm Cpu1Ist  00000011 INTL 20050624)
[    0.004049] ACPI: SSDT 0x00000000BFE02452 000140 (v01 DpgPmm CpuPm    00000010 INTL 20050624)
[    0.004321] ACPI: Local APIC address 0xfee00000
[    0.004341] Zone ranges:
[    0.004342]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.004345]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.004347]   Normal   [mem 0x0000000100000000-0x000000023bffffff]
[    0.004349] Movable zone start for each node
[    0.004350] Early memory node ranges
[    0.004351]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.004353]   node   0: [mem 0x0000000000100000-0x00000000bfe00fff]
[    0.004354]   node   0: [mem 0x0000000100000000-0x000000023bffffff]
[    0.004564] Zeroed struct page in unavailable ranges: 16994 pages
[    0.004566] Initmem setup node 0 [mem 0x0000000000001000-0x000000023bffffff]
[    0.004568] On node 0 totalpages: 2080158
[    0.004570]   DMA zone: 64 pages used for memmap
[    0.004571]   DMA zone: 21 pages reserved
[    0.004572]   DMA zone: 3997 pages, LIFO batch:0
[    0.004618]   DMA32 zone: 12217 pages used for memmap
[    0.004619]   DMA32 zone: 781825 pages, LIFO batch:63
[    0.021721]   Normal zone: 20224 pages used for memmap
[    0.021723]   Normal zone: 1294336 pages, LIFO batch:63
[    0.051892] ACPI: PM-Timer IO Port: 0x808
[    0.051895] ACPI: Local APIC address 0xfee00000
[    0.051903] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.051915] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.051918] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.051920] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.051922] ACPI: IRQ0 used by override.
[    0.051924] ACPI: IRQ9 used by override.
[    0.051927] Using ACPI (MADT) for SMP configuration information
[    0.051929] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.051936] smpboot: 8 Processors exceeds NR_CPUS limit of 2
[    0.051937] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.051952] [mem 0xc0000000-0xdfffffff] available for PCI devices
[    0.051958] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.063282] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.063866] percpu: Embedded 44 pages/cpu s139288 r8192 d32744 u1048576
[    0.063871] pcpu-alloc: s139288 r8192 d32744 u1048576 alloc=1*2097152
[    0.063873] pcpu-alloc: [0] 0 1 
[    0.063893] Built 1 zonelists, mobility grouping on.  Total pages: 2047632
[    0.063895] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.10.9 root=/dev/mapper/S-root ro rng-core.default_quality=512
[    0.065863] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.066889] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.066923] mem auto-init: stack:byref_all(zero), heap alloc:on, heap free:on
[    0.066925] mem auto-init: clearing system memory may take some time...
[    3.193603] Memory: 8084924K/8320632K available (8194K kernel code, 962K rwdata, 2340K rodata, 860K init, 400K bss, 235452K reserved, 0K cma-reserved)
[    3.193654] random: get_random_u64 called from cache_random_seq_create+0x75/0x143 with crng_init=0
[    3.193724] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    3.193733] random: get_random_u32 called from allocate_slab+0x15f/0x2c5 with crng_init=0
[    3.193741] Kernel/User page tables isolation: enabled
[    3.193807] rcu: Preemptible hierarchical RCU implementation.
[    3.193809] 	Trampoline variant of Tasks RCU enabled.
[    3.193810] 	Tracing variant of Tasks RCU enabled.
[    3.193812] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    3.193822] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    3.194040] random: get_random_bytes called from start_kernel+0x360/0x4fc with crng_init=0
[    3.199068] Console: colour VGA+ 80x25
[    3.203708] printk: console [tty0] enabled
[    3.203764] ACPI: Core revision 20200925
[    3.263784] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    3.263859] APIC: Switch to symmetric I/O mode setup
[    3.264271] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    3.268860] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2b222eb6c51, max_idle_ns: 440795267384 ns
[    3.268928] Calibrating delay loop (skipped), value calculated using timer frequency.. 5984.77 BogoMIPS (lpj=2992388)
[    3.268993] pid_max: default: 32768 minimum: 301
[    3.269075] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    3.269129] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    3.269409] mce: CPU0: Thermal monitoring enabled (TM2)
[    3.269462] process: using mwait in idle threads
[    3.269516] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    3.269567] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    3.269621] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    3.269683] Spectre V2 : Mitigation: Full generic retpoline
[    3.269734] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    3.269788] Speculative Store Bypass: Vulnerable
[    3.269840] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    3.269995] Freeing SMP alternatives memory: 12K
[    3.372445] smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz (family: 0x6, model: 0x17, stepping: 0xa)
[    3.372632] Performance Events: PEBS fmt0+, Core2 events, 4-deep LBR, Intel PMU driver.
[    3.372694] ... version:                2
[    3.372744] ... bit width:              40
[    3.372793] ... generic registers:      2
[    3.372843] ... value mask:             000000ffffffffff
[    3.372894] ... max period:             000000007fffffff
[    3.372924] ... fixed-purpose events:   3
[    3.372924] ... event mask:             0000000700000003
[    3.372924] rcu: Hierarchical SRCU implementation.
[    3.372924] smp: Bringing up secondary CPUs ...
[    3.372924] x86: Booting SMP configuration:
[    3.372926] .... node  #0, CPUs:      #1
[    3.373949] smp: Brought up 1 node, 2 CPUs
[    3.374984] smpboot: Max logical packages: 4
[    3.375034] smpboot: Total of 2 processors activated (11969.55 BogoMIPS)
[    3.376239] devtmpfs: initialized
[    3.376931] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    3.376931] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    3.376931] NET: Registered protocol family 16
[    3.377021] thermal_sys: Registered thermal governor 'step_wise'
[    3.377039] cpuidle: using governor teo
[    3.377143] Simple Boot Flag at 0x7a set to 0x1
[    3.377210] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    3.377276] ACPI: bus type PCI registered
[    3.377944] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    3.378003] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    3.378052] pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe0200000] with a huge-page mapping due to MTRR override.
[    3.378052] PCI: Using configuration type 1 for base access
[    3.750202] ACPI: Added _OSI(Module Device)
[    3.750202] ACPI: Added _OSI(Processor Device)
[    3.750202] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.750202] ACPI: Added _OSI(Processor Aggregator Device)
[    3.750925] ACPI: Added _OSI(Linux-Dell-Video)
[    3.750925] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    3.750925] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    3.795187] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    3.803432] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    3.835892] ACPI: Interpreter enabled
[    3.835930] ACPI: (supports S0 S5)
[    3.835979] ACPI: Using IOAPIC for interrupt routing
[    3.836925] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.838294] ACPI: Enabled 12 GPEs in block 00 to 3F
[    3.994931] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    3.994987] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    4.004288] PCI host bridge to bus 0000:00
[    4.004339] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    4.004391] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    4.004442] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    4.004495] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000effff window]
[    4.004547] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
[    4.007927] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfec00000 window]
[    4.007979] pci_bus 0000:00: root bus resource [mem 0xbff00000-0xdfffffff window]
[    4.008032] pci_bus 0000:00: root bus resource [mem 0xff980800-0xff980bff window]
[    4.008084] pci_bus 0000:00: root bus resource [mem 0xff97c000-0xff97ffff window]
[    4.008136] pci_bus 0000:00: root bus resource [mem 0xfed20000-0xfed9ffff window]
[    4.008189] pci_bus 0000:00: root bus resource [bus 00-ff]
[    4.008252] pci 0000:00:00.0: [8086:29e0] type 00 class 0x060000
[    4.008926] pci 0000:00:01.0: [8086:29e1] type 01 class 0x060400
[    4.008926] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    4.008957] pci 0000:00:06.0: [8086:29e9] type 01 class 0x060400
[    4.008957] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    4.009924] pci 0000:00:1a.0: [8086:2937] type 00 class 0x0c0300
[    4.009924] pci 0000:00:1a.0: reg 0x20: [io  0xff20-0xff3f]
[    4.009956] pci 0000:00:1a.1: [8086:2938] type 00 class 0x0c0300
[    4.009956] pci 0000:00:1a.1: reg 0x20: [io  0xff00-0xff1f]
[    4.010929] pci 0000:00:1a.2: [8086:2939] type 00 class 0x0c0300
[    4.010929] pci 0000:00:1a.2: reg 0x20: [io  0xecc0-0xecdf]
[    4.010956] pci 0000:00:1a.7: [8086:293c] type 00 class 0x0c0320
[    4.010956] pci 0000:00:1a.7: reg 0x10: [mem 0xfdffbc00-0xfdffbfff]
[    4.010956] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    4.011924] pci 0000:00:1b.0: [8086:293e] type 00 class 0x040300
[    4.011924] pci 0000:00:1b.0: reg 0x10: [mem 0xfdffc000-0xfdffffff 64bit]
[    4.011924] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    4.011956] pci 0000:00:1c.0: [8086:2940] type 01 class 0x060400
[    4.011988] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    4.012937] pci 0000:00:1c.5: [8086:294a] type 01 class 0x060400
[    4.012937] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    4.012955] pci 0000:00:1d.0: [8086:2934] type 00 class 0x0c0300
[    4.013024] pci 0000:00:1d.0: reg 0x20: [io  0xff80-0xff9f]
[    4.013924] pci 0000:00:1d.1: [8086:2935] type 00 class 0x0c0300
[    4.013924] pci 0000:00:1d.1: reg 0x20: [io  0xff60-0xff7f]
[    4.013978] pci 0000:00:1d.2: [8086:2936] type 00 class 0x0c0300
[    4.014061] pci 0000:00:1d.2: reg 0x20: [io  0xff40-0xff5f]
[    4.014937] pci 0000:00:1d.7: [8086:293a] type 00 class 0x0c0320
[    4.014937] pci 0000:00:1d.7: reg 0x10: [mem 0xff980800-0xff980bff]
[    4.014937] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    4.015924] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    4.015955] pci 0000:00:1f.0: [8086:2916] type 00 class 0x060100
[    4.015955] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by ICH6 ACPI/GPIO/TCO
[    4.015955] pci 0000:00:1f.0: quirk: [io  0x0880-0x08bf] claimed by ICH6 GPIO
[    4.015955] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0c00 (mask 007f)
[    4.015955] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 00e0 (mask 0007)
[    4.016934] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
[    4.016934] pci 0000:00:1f.2: reg 0x10: [io  0xfe00-0xfe07]
[    4.016934] pci 0000:00:1f.2: reg 0x14: [io  0xfe10-0xfe13]
[    4.016934] pci 0000:00:1f.2: reg 0x18: [io  0xfe20-0xfe27]
[    4.016934] pci 0000:00:1f.2: reg 0x1c: [io  0xfe30-0xfe33]
[    4.016934] pci 0000:00:1f.2: reg 0x20: [io  0xfec0-0xfedf]
[    4.016934] pci 0000:00:1f.2: reg 0x24: [mem 0xff970000-0xff9707ff]
[    4.016934] pci 0000:00:1f.2: PME# supported from D3hot
[    4.017924] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
[    4.017924] pci 0000:00:1f.3: reg 0x10: [mem 0xfdffbb00-0xfdffbbff 64bit]
[    4.017924] pci 0000:00:1f.3: reg 0x20: [io  0xece0-0xecff]
[    4.017955] pci 0000:01:00.0: [10de:042f] type 00 class 0x030000
[    4.017955] pci 0000:01:00.0: reg 0x10: [mem 0xfc000000-0xfcffffff]
[    4.017955] pci 0000:01:00.0: reg 0x14: [mem 0xd0000000-0xdfffffff 64bit pref]
[    4.017955] pci 0000:01:00.0: reg 0x1c: [mem 0xfa000000-0xfbffffff 64bit]
[    4.017955] pci 0000:01:00.0: reg 0x24: [io  0xdc80-0xdcff]
[    4.017955] pci 0000:01:00.0: reg 0x30: [mem 0xfde00000-0xfde1ffff pref]
[    4.018929] pci 0000:00:01.0: PCI bridge to [bus 01]
[    4.018929] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    4.018929] pci 0000:00:01.0:   bridge window [mem 0xfa000000-0xfdefffff]
[    4.018929] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    4.018956] pci 0000:00:06.0: PCI bridge to [bus 02]
[    4.018956] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    4.018956] pci 0000:00:1c.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
[    4.018956] pci 0000:04:00.0: [14e4:167a] type 00 class 0x020000
[    4.018956] pci 0000:04:00.0: reg 0x10: [mem 0xf9ef0000-0xf9efffff 64bit]
[    4.018956] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    4.018956] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    4.019002] pci 0000:00:1c.5:   bridge window [mem 0xf9e00000-0xf9efffff]
[    4.019069] pci_bus 0000:05: extended config space not accessible
[    4.019932] pci 0000:00:1e.0: PCI bridge to [bus 05] (subtractive decode)
[    4.019932] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    4.019932] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    4.019932] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    4.019932] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000effff window] (subtractive decode)
[    4.019932] pci 0000:00:1e.0:   bridge window [mem 0x000f0000-0x000fffff window] (subtractive decode)
[    4.019932] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfec00000 window] (subtractive decode)
[    4.019932] pci 0000:00:1e.0:   bridge window [mem 0xbff00000-0xdfffffff window] (subtractive decode)
[    4.019932] pci 0000:00:1e.0:   bridge window [mem 0xff980800-0xff980bff window] (subtractive decode)
[    4.019932] pci 0000:00:1e.0:   bridge window [mem 0xff97c000-0xff97ffff window] (subtractive decode)
[    4.019932] pci 0000:00:1e.0:   bridge window [mem 0xfed20000-0xfed9ffff window] (subtractive decode)
[    4.019932] pci_bus 0000:00: on NUMA node 0
[    4.050611] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
[    4.051566] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[    4.052516] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 15)
[    4.053494] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[    4.054446] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12 15)
[    4.055424] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[    4.056375] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 15)
[    4.057333] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[    4.057993] iommu: Default domain type: Translated 
[    4.058113] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    4.058113] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    4.058113] pci 0000:01:00.0: vgaarb: bridge control possible
[    4.058113] vgaarb: loaded
[    4.058960] SCSI subsystem initialized
[    4.058987] libata version 3.00 loaded.
[    4.059014] ACPI: bus type USB registered
[    4.059091] usbcore: registered new interface driver usbfs
[    4.059148] usbcore: registered new interface driver hub
[    4.059220] usbcore: registered new device driver usb
[    4.059284] EDAC MC: Ver: 3.0.0
[    4.059550] PCI: Using ACPI for IRQ routing
[    4.063912] PCI: pci_cache_line_size set to 64 bytes
[    4.063935] pci 0000:00:1f.2: can't claim BAR 5 [mem 0xff970000-0xff9707ff]: no compatible bridge window
[    4.064014] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    4.064065] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    4.064117] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    4.064119] e820: reserve RAM buffer [mem 0xbfe01c00-0xbfffffff]
[    4.065044] hpet: 4 channels of 0 reserved for per-cpu timers
[    4.065097] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    4.065150] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    4.066943] clocksource: Switched to clocksource tsc-early
[    4.067060] pnp: PnP ACPI init
[    4.070360] pnp 00:00: disabling [io  0x0800-0x085f] because it overlaps 0000:00:1f.0 BAR 7 [io  0x0800-0x087f]
[    4.070424] pnp 00:00: disabling [io  0x0860-0x08ff] because it overlaps 0000:00:1f.0 BAR 7 [io  0x0800-0x087f]
[    4.070508] system 00:00: [io  0x0c00-0x0c7f] has been reserved
[    4.070568] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    4.070800] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    4.077398] pnp 00:02: [dma 2]
[    4.077889] pnp 00:02: Plug and Play ACPI device, IDs PNP0700 (active)
[    4.083815] pnp 00:03: Plug and Play ACPI device, IDs PNP0f13 (active)
[    4.091416] pnp 00:04: [dma 0 disabled]
[    4.092610] pnp 00:04: Plug and Play ACPI device, IDs PNP0401 (active)
[    4.097967] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    4.102851] pnp 00:06: Plug and Play ACPI device, IDs SMO1200 PNP0c31 (active)
[    4.112202] pnp: PnP ACPI: found 7 devices
[    4.119289] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    4.119382] NET: Registered protocol family 2
[    4.119554] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    4.119637] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    4.119850] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    4.120214] TCP: Hash tables configured (established 65536 bind 65536)
[    4.120279] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    4.120373] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    4.120487] NET: Registered protocol family 1
[    4.120571] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[    4.120625] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    4.120690] pci 0000:00:1c.5: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
[    4.120744] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 100000
[    4.120822] pci 0000:00:1c.0: BAR 9: assigned [mem 0xf0000000-0xf01fffff 64bit pref]
[    4.120879] pci 0000:00:1c.5: BAR 9: assigned [mem 0xf0200000-0xf03fffff 64bit pref]
[    4.120933] pci 0000:00:1c.0: BAR 7: assigned [io  0x1000-0x1fff]
[    4.120985] pci 0000:00:1c.5: BAR 7: assigned [io  0x2000-0x2fff]
[    4.121037] pci 0000:00:1f.2: BAR 5: assigned [mem 0xf0400000-0xf04007ff]
[    4.121093] pci 0000:00:01.0: PCI bridge to [bus 01]
[    4.121144] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    4.121196] pci 0000:00:01.0:   bridge window [mem 0xfa000000-0xfdefffff]
[    4.121248] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    4.121302] pci 0000:00:06.0: PCI bridge to [bus 02]
[    4.121355] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    4.121406] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    4.121459] pci 0000:00:1c.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
[    4.121511] pci 0000:00:1c.0:   bridge window [mem 0xf0000000-0xf01fffff 64bit pref]
[    4.121573] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    4.121624] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    4.121677] pci 0000:00:1c.5:   bridge window [mem 0xf9e00000-0xf9efffff]
[    4.121730] pci 0000:00:1c.5:   bridge window [mem 0xf0200000-0xf03fffff 64bit pref]
[    4.121785] pci 0000:00:1e.0: PCI bridge to [bus 05]
[    4.121842] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    4.121893] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    4.121944] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    4.121996] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000effff window]
[    4.122047] pci_bus 0000:00: resource 8 [mem 0x000f0000-0x000fffff window]
[    4.122099] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfec00000 window]
[    4.122151] pci_bus 0000:00: resource 10 [mem 0xbff00000-0xdfffffff window]
[    4.122203] pci_bus 0000:00: resource 11 [mem 0xff980800-0xff980bff window]
[    4.122254] pci_bus 0000:00: resource 12 [mem 0xff97c000-0xff97ffff window]
[    4.122306] pci_bus 0000:00: resource 13 [mem 0xfed20000-0xfed9ffff window]
[    4.122358] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    4.122409] pci_bus 0000:01: resource 1 [mem 0xfa000000-0xfdefffff]
[    4.122460] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    4.122512] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    4.122566] pci_bus 0000:03: resource 1 [mem 0xf9f00000-0xf9ffffff]
[    4.126093] pci_bus 0000:03: resource 2 [mem 0xf0000000-0xf01fffff 64bit pref]
[    4.126145] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
[    4.126196] pci_bus 0000:04: resource 1 [mem 0xf9e00000-0xf9efffff]
[    4.126247] pci_bus 0000:04: resource 2 [mem 0xf0200000-0xf03fffff 64bit pref]
[    4.126299] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7 window]
[    4.126350] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff window]
[    4.126401] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff window]
[    4.126453] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000effff window]
[    4.126505] pci_bus 0000:05: resource 8 [mem 0x000f0000-0x000fffff window]
[    4.126558] pci_bus 0000:05: resource 9 [mem 0xf0000000-0xfec00000 window]
[    4.126609] pci_bus 0000:05: resource 10 [mem 0xbff00000-0xdfffffff window]
[    4.126661] pci_bus 0000:05: resource 11 [mem 0xff980800-0xff980bff window]
[    4.126713] pci_bus 0000:05: resource 12 [mem 0xff97c000-0xff97ffff window]
[    4.126765] pci_bus 0000:05: resource 13 [mem 0xfed20000-0xfed9ffff window]
[    4.132350] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    4.132406] PCI: CLS 64 bytes, default 64
[    4.132496] Trying to unpack rootfs image as initramfs...
[    4.861518] Freeing initrd memory: 7204K
[    4.861576] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    4.861628] software IO TLB: mapped [mem 0x00000000bbe01000-0x00000000bfe01000] (64MB)
[    4.862120] check: Scanning for low memory corruption every 60 seconds
[    4.862952] Initialise system trusted keyrings
[    4.863005] _warn_unseeded_randomness: 26 callbacks suppressed
[    4.863010] random: get_random_bytes called from key_alloc+0x241/0x332 with crng_init=0
[    4.863122] workingset: timestamp_bits=62 max_order=21 bucket_order=0
[    4.864679] random: get_random_u64 called from cache_random_seq_create+0x75/0x143 with crng_init=0
[    4.864732] random: get_random_u32 called from bucket_table_alloc.isra.0+0xf1/0x119 with crng_init=0
[    4.864778] Key type asymmetric registered
[    4.864951] Asymmetric key parser 'x509' registered
[    4.865011] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    4.865093] io scheduler mq-deadline registered
[    4.865143] io scheduler kyber registered
[    4.865235] io scheduler bfq registered
[    4.867133] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    4.867189] ACPI: Power Button [VBTN]
[    4.867299] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    4.867352] ACPI: Power Button [PWRF]
[    4.867679] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    4.867794] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    4.868410] Non-volatile memory driver v1.3
[    4.877577] tpm_tis 00:06: 1.2 TPM (device-id 0x4A10, rev-id 78)
[    4.967649] nouveau 0000:01:00.0: vgaarb: deactivate vga console
[    4.970929] Console: switching to colour dummy device 80x25
[    4.971204] nouveau 0000:01:00.0: NVIDIA G86 (086f00a2)
[    4.987594] random: fast init done
[    5.008570] random: crng init done
[    5.008573] random: 6 get_random_xx warning(s) missed due to ratelimiting
[    5.074389] nouveau 0000:01:00.0: bios: version 60.86.6c.00.21
[    5.095251] nouveau 0000:01:00.0: bios: M0203T not found
[    5.095255] nouveau 0000:01:00.0: bios: M0203E not matched!
[    5.095259] nouveau 0000:01:00.0: fb: 256 MiB DDR2
[    5.573779] [TTM] Zone  kernel: Available graphics memory: 4046198 KiB
[    5.573782] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    5.573785] [TTM] Initializing pool allocator
[    5.573791] [TTM] Initializing DMA pool allocator
[    5.573805] nouveau 0000:01:00.0: DRM: VRAM: 256 MiB
[    5.573808] nouveau 0000:01:00.0: DRM: GART: 1048576 MiB
[    5.573814] nouveau 0000:01:00.0: DRM: TMDS table version 2.0
[    5.573817] nouveau 0000:01:00.0: DRM: DCB version 4.0
[    5.573821] nouveau 0000:01:00.0: DRM: DCB outp 00: 02011300 00000028
[    5.573824] nouveau 0000:01:00.0: DRM: DCB outp 01: 01011302 00000010
[    5.573828] nouveau 0000:01:00.0: DRM: DCB outp 02: 01000310 00000028
[    5.573831] nouveau 0000:01:00.0: DRM: DCB outp 03: 02000312 00000010
[    5.573835] nouveau 0000:01:00.0: DRM: DCB conn 00: 2030
[    5.573837] nouveau 0000:01:00.0: DRM: DCB conn 01: 1130
[    5.575585] nouveau 0000:01:00.0: DRM: MM: using CRYPT for buffer copies
[    5.617309] nouveau 0000:01:00.0: DRM: allocated 1920x1200 fb: 0x50000, bo 0000000052caefd7
[    5.618981] fbcon: nouveaudrmfb (fb0) is primary device
[    5.745845] Console: switching to colour frame buffer device 240x75
[    5.749002] nouveau 0000:01:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[    5.749173] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
[    5.749230] parport_pc 00:04: reported by Plug and Play ACPI
[    5.749286] parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
[    5.840397] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x0000000000000828-0x000000000000082D (\GLBC) (20200925/utaddress-204)
[    5.840418] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x000000000000082A-0x000000000000082A (\SACT) (20200925/utaddress-204)
[    5.840434] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x0000000000000828-0x0000000000000828 (\SSTS) (20200925/utaddress-204)
[    5.840451] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    5.840487] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    5.840567] ahci 0000:00:1f.2: version 3.0
[    5.841018] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    5.841030] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ccc ems 
[    5.856557] scsi host0: ahci
[    5.856695] scsi host1: ahci
[    5.856811] scsi host2: ahci
[    5.856935] scsi host3: ahci
[    5.857050] scsi host4: ahci
[    5.857205] scsi host5: ahci
[    5.857262] ata1: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400100 irq 29
[    5.857271] ata2: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400180 irq 29
[    5.857279] ata3: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400200 irq 29
[    5.857287] ata4: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400280 irq 29
[    5.857295] ata5: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400300 irq 29
[    5.857303] ata6: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400380 irq 29
[    5.857344] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.857352] ehci-pci: EHCI PCI platform driver
[    5.857736] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    5.857749] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    5.857765] ehci-pci 0000:00:1a.7: debug port 1
[    5.861668] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    5.861686] ehci-pci 0000:00:1a.7: irq 22, io mem 0xfdffbc00
[    5.868933] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    5.868989] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
[    5.869002] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.869013] usb usb1: Product: EHCI Host Controller
[    5.869024] usb usb1: Manufacturer: Linux 5.10.9 ehci_hcd
[    5.869032] usb usb1: SerialNumber: 0000:00:1a.7
[    5.869158] hub 1-0:1.0: USB hub found
[    5.869169] hub 1-0:1.0: 6 ports detected
[    5.869689] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    5.869700] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    5.869715] ehci-pci 0000:00:1d.7: debug port 1
[    5.873600] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    5.873617] ehci-pci 0000:00:1d.7: irq 23, io mem 0xff980800
[    5.879937] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    5.879998] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
[    5.880012] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.880023] usb usb2: Product: EHCI Host Controller
[    5.880031] usb usb2: Manufacturer: Linux 5.10.9 ehci_hcd
[    5.880040] usb usb2: SerialNumber: 0000:00:1d.7
[    5.880495] hub 2-0:1.0: USB hub found
[    5.880854] hub 2-0:1.0: 6 ports detected
[    5.881348] uhci_hcd: USB Universal Host Controller Interface driver
[    5.882042] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    5.882412] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    5.882784] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff20
[    5.883171] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    5.883527] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.884047] usb usb3: Product: UHCI Host Controller
[    5.884574] usb usb3: Manufacturer: Linux 5.10.9 uhci_hcd
[    5.885108] usb usb3: SerialNumber: 0000:00:1a.0
[    5.885722] hub 3-0:1.0: USB hub found
[    5.886180] hub 3-0:1.0: 2 ports detected
[    5.887138] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    5.887496] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    5.887873] uhci_hcd 0000:00:1a.1: irq 17, io base 0x0000ff00
[    5.888368] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    5.888886] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.889451] usb usb4: Product: UHCI Host Controller
[    5.890020] usb usb4: Manufacturer: Linux 5.10.9 uhci_hcd
[    5.890590] usb usb4: SerialNumber: 0000:00:1a.1
[    5.891256] hub 4-0:1.0: USB hub found
[    5.891751] hub 4-0:1.0: 2 ports detected
[    5.892750] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    5.893117] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    5.893497] uhci_hcd 0000:00:1a.2: irq 22, io base 0x0000ecc0
[    5.894058] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    5.894585] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.895154] usb usb5: Product: UHCI Host Controller
[    5.895702] usb usb5: Manufacturer: Linux 5.10.9 uhci_hcd
[    5.896243] usb usb5: SerialNumber: 0000:00:1a.2
[    5.896861] hub 5-0:1.0: USB hub found
[    5.897328] hub 5-0:1.0: 2 ports detected
[    5.898282] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    5.898628] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    5.898987] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000ff80
[    5.899410] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    5.899880] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.900402] usb usb6: Product: UHCI Host Controller
[    5.900917] usb usb6: Manufacturer: Linux 5.10.9 uhci_hcd
[    5.901446] usb usb6: SerialNumber: 0000:00:1d.0
[    5.902060] hub 6-0:1.0: USB hub found
[    5.902520] hub 6-0:1.0: 2 ports detected
[    5.903483] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    5.903834] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    5.904210] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000ff60
[    5.904722] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    5.905254] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.905824] usb usb7: Product: UHCI Host Controller
[    5.906396] usb usb7: Manufacturer: Linux 5.10.9 uhci_hcd
[    5.906968] usb usb7: SerialNumber: 0000:00:1d.1
[    5.907615] hub 7-0:1.0: USB hub found
[    5.908105] hub 7-0:1.0: 2 ports detected
[    5.909094] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    5.909451] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    5.909830] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
[    5.910393] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    5.910930] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.911499] usb usb8: Product: UHCI Host Controller
[    5.912066] usb usb8: Manufacturer: Linux 5.10.9 uhci_hcd
[    5.912625] usb usb8: SerialNumber: 0000:00:1d.2
[    5.913278] hub 8-0:1.0: USB hub found
[    5.913769] hub 8-0:1.0: 2 ports detected
[    5.914464] i8042: PNP: PS/2 Controller [PNP0f13:MOU] at 0x60,0x64 irq 12
[    5.914898] i8042: PNP: PS/2 controller doesn't have KBD irq; using default 1
[    5.918204] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.918607] serio: i8042 AUX port at 0x60,0x64 irq 12
[    5.919041] mousedev: PS/2 mouse device common for all mice
[    5.919441] rtc_cmos 00:01: RTC can wake from S4
[    5.919933] tsc: Refined TSC clocksource calibration: 2992.481 MHz
[    5.919942] rtc_cmos 00:01: registered as rtc0
[    5.920376] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b228661c25, max_idle_ns: 440795245102 ns
[    5.921526] rtc_cmos 00:01: setting system clock to 2021-01-22T07:12:52 UTC (1611299572)
[    5.922144] clocksource: Switched to clocksource tsc
[    5.922171] rtc_cmos 00:01: alarms up to one day, 242 bytes nvram, hpet irqs
[    5.923750] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    6.030979] i2c i2c-3: 4/4 memory slots populated (from DMI)
[    6.031673] i2c i2c-3: Successfully instantiated SPD at 0x50
[    6.032407] i2c i2c-3: Successfully instantiated SPD at 0x51
[    6.033131] i2c i2c-3: Successfully instantiated SPD at 0x52
[    6.033849] i2c i2c-3: Successfully instantiated SPD at 0x53
[    6.034387] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    6.034776] iTCO_wdt: Found a ICH9R TCO device (Version=2, TCOBASE=0x0860)
[    6.035206] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    6.035765] EDAC MC0: Giving out device to module x38_edac controller x38: DEV 0000:00:00.0 (POLLED)
[    6.036163] hid: raw HID events driver (C) Jiri Kosina
[    6.036687] usbcore: registered new interface driver usbhid
[    6.037264] usbhid: USB HID core driver
[    6.037923] Key type dns_resolver registered
[    6.038668] microcode: sig=0x1067a, pf=0x1, revision=0xa0b
[    6.040202] microcode: Microcode Update Driver: v2.2.
[    6.040205] IPI shorthand broadcast: enabled
[    6.040965] sched_clock: Marking stable (5971034302, 69915592)->(6043795974, -2846080)
[    6.041385] registered taskstats version 1
[    6.041899] Loading compiled-in X.509 certificates
[    6.046615] Loaded X.509 cert 'Build time autogenerated kernel key: 857c83a6ce39267c0fa8278441e37276fef91989'
[    6.047449] RAS: Correctable Errors collector initialized.
[    6.169972] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.170428] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.170809] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.171196] ata6: SATA link down (SStatus 4 SControl 300)
[    6.171771] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.172477] ata4.00: ATA-9: WDC WD20NPVX-00EA4T0, 01.01A01, max UDMA/133
[    6.172978] ata4.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    6.173580] ata5.00: ATA-9: WDC WD20NPVX-00EA4T0, 01.01A01, max UDMA/133
[    6.174196] ata5.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    6.174972] ata1.00: ATA-8: WDC WD10EADS-00L5B1, 01.01A01, max UDMA/133
[    6.175427] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    6.176174] ata5.00: configured for UDMA/133
[    6.176675] ata4.00: configured for UDMA/133
[    6.177469] ata1.00: configured for UDMA/133
[    6.177994] scsi 0:0:0:0: Direct-Access     ATA      WDC WD10EADS-00L 1A01 PQ: 0 ANSI: 5
[    6.178702] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    6.179125] sd 0:0:0:0: [sda] Write Protect is off
[    6.179718] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.179739] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.180583] ata3.00: ATAPI: PBDS CD-RW/DVD-ROM DH-48C2S, ND12, max UDMA/100
[    6.190689] ata3.00: configured for UDMA/100
[    6.192047]  sda: sda1 sda2
[    6.192778] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.193939] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    6.322235] usb 1-1: New USB device found, idVendor=0424, idProduct=2502, bcdDevice= 0.01
[    6.322702] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    6.323263] hub 1-1:1.0: USB hub found
[    6.323860] hub 1-1:1.0: 2 ports detected
[    6.393933] usb 8-2: new full-speed USB device number 2 using uhci_hcd
[    6.429940] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.434767] ata2.00: ATA-8: WDC WD10EADS-00L5B1, 01.01A01, max UDMA/133
[    6.435282] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    6.436527] ata2.00: configured for UDMA/133
[    6.437113] scsi 1:0:0:0: Direct-Access     ATA      WDC WD10EADS-00L 1A01 PQ: 0 ANSI: 5
[    6.437752] sd 1:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    6.438178] sd 1:0:0:0: [sdb] Write Protect is off
[    6.438565] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    6.438585] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.439090] scsi 2:0:0:0: CD-ROM            PBDS     CDRWDVD DH-48C2S ND12 PQ: 0 ANSI: 5
[    6.451606]  sdb: sdb1 sdb2
[    6.452384] sd 1:0:0:0: [sdb] Attached SCSI disk
[    6.456855] scsi 3:0:0:0: Direct-Access     ATA      WDC WD20NPVX-00E 1A01 PQ: 0 ANSI: 5
[    6.457468] sd 3:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    6.457487] scsi 4:0:0:0: Direct-Access     ATA      WDC WD20NPVX-00E 1A01 PQ: 0 ANSI: 5
[    6.457888] sd 3:0:0:0: [sdc] 4096-byte physical blocks
[    6.458518] sd 4:0:0:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    6.458906] sd 3:0:0:0: [sdc] Write Protect is off
[    6.459577] sd 4:0:0:0: [sdd] 4096-byte physical blocks
[    6.459613] sd 4:0:0:0: [sdd] Write Protect is off
[    6.460284] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    6.460928] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    6.460945] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.461613] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.582394] usb 8-2: New USB device found, idVendor=0b33, idProduct=08a1, bcdDevice= 3.00
[    6.582879] usb 8-2: New USB device strings: Mfr=1, Product=4, SerialNumber=3
[    6.583286] usb 8-2: Product: Contour Mouse
[    6.583723] usb 8-2: Manufacturer: Contour Design
[    6.584367] usb 8-2: SerialNumber: V3.0
[    6.594752] input: Contour Design Contour Mouse as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.0/0003:0B33:08A1.0001/input/input4
[    6.595265] hid-generic 0003:0B33:08A1.0001: input,hidraw0: USB HID v1.11 Mouse [Contour Design Contour Mouse] on usb-0000:00:1d.2-2/input0
[    6.625934] usb 3-2: new full-speed USB device number 2 using uhci_hcd
[    6.799950] usb 3-2: New USB device found, idVendor=05f3, idProduct=0081, bcdDevice= 3.20
[    6.800420] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.800839] usb 3-2: Product: Kinesis Keyboard Hub
[    6.801449] usb 3-2: Manufacturer: PI Engineering
[    6.804994] hub 3-2:1.0: USB hub found
[    6.806952] hub 3-2:1.0: 4 ports detected
[    6.814186] sd 3:0:0:0: [sdc] Attached SCSI disk
[    6.816166] sd 4:0:0:0: [sdd] Attached SCSI disk
[    6.816947] Freeing unused kernel image (initmem) memory: 860K
[    6.827934] Write protecting the kernel read-only data: 14336k
[    6.829202] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    6.830256] Freeing unused kernel image (rodata/data gap) memory: 1756K
[    6.880125] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.880564] x86/mm: Checking user space page tables
[    6.925376] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.925814] Run /init as init process
[    6.926218]   with arguments:
[    6.926219]     /init
[    6.926220]   with environment:
[    6.926221]     HOME=/
[    6.926222]     TERM=linux
[    6.926223]     BOOT_IMAGE=/boot/vmlinuz-5.10.9
[    7.073987] md/raid1:md0: active with 2 out of 2 mirrors
[    7.074437] md0: detected capacity change from 0 to 1000204746752
[    7.075663]  md0: p1 p2
[    7.101935] usb 3-2.2: new full-speed USB device number 3 using uhci_hcd
[    7.217959] usb 3-2.2: New USB device found, idVendor=05f3, idProduct=0007, bcdDevice= 3.20
[    7.218452] usb 3-2.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    7.226303] input: HID 05f3:0007 as /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2.2/3-2.2:1.0/0003:05F3:0007.0002/input/input6
[    7.278004] hid-generic 0003:05F3:0007.0002: input,hidraw1: USB HID v1.00 Keyboard [HID 05f3:0007] on usb-0000:00:1a.0-2.2/input0
[    7.282646] input: HID 05f3:0007 System Control as /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:05F3:0007.0003/input/input7
[    7.291049] device-mapper: uevent: version 1.0.3
[    7.291561] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
[    7.292018] usb 1-1.1: new high-speed USB device number 4 using ehci-pci
[    7.335001] input: HID 05f3:0007 Consumer Control as /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:05F3:0007.0003/input/input8
[    7.335541] hid-generic 0003:05F3:0007.0003: input,hidraw2: USB HID v1.00 Device [HID 05f3:0007] on usb-0000:00:1a.0-2.2/input1
[    7.382239] usb 1-1.1: New USB device found, idVendor=0424, idProduct=2504, bcdDevice= 0.01
[    7.382786] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    7.383398] hub 1-1.1:1.0: USB hub found
[    7.383981] hub 1-1.1:1.0: 4 ports detected
[    7.460933] usb 1-1.2: new high-speed USB device number 5 using ehci-pci
[    7.573519] input: PS2++ Logitech Mouse as /devices/platform/i8042/serio1/input/input5
[    7.628612] usb 1-1.2: New USB device found, idVendor=0424, idProduct=223a, bcdDevice= 3.60
[    7.629094] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.629532] usb 1-1.2: Product: USB2223
[    7.630294] usb 1-1.2: Manufacturer: SMSC
[    7.631058] usb 1-1.2: SerialNumber: 000223223223
[    7.667934] usb 1-1.1.2: new high-speed USB device number 6 using ehci-pci
[    7.758986] usb 1-1.1.2: New USB device found, idVendor=249c, idProduct=930b, bcdDevice= 2.13
[    7.759493] usb 1-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.759933] usb 1-1.1.2: Product: M2Tech USB Audio 2.0
[    7.760651] usb 1-1.1.2: Manufacturer: M2Tech 
[    7.761406] usb 1-1.1.2: SerialNumber: 0000
[    8.905942] SGI XFS with ACLs, security attributes, realtime, no debug enabled
[    9.152359] XFS (dm-0): Deprecated V4 format (crc=0) will not be supported after September 2030.
[    9.152994] XFS (dm-0): Mounting V4 Filesystem
[    9.342806] XFS (dm-0): Ending clean mount
[   11.593619] Floppy drive(s): fd0 is 1.44M
[   11.608120] FDC 0 is a post-1991 82077
[   11.672736] tg3 0000:04:00.0 eth0: Tigon3 [partno(BCM95754) rev b002] (PCI Express) MAC address 00:24:e8:2e:01:56
[   11.673208] tg3 0000:04:00.0 eth0: attached PHY is 5787 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   11.673651] tg3 0000:04:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   11.674414] tg3 0000:04:00.0 eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[   11.676729] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.4)
[   11.731968] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   11.732438] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   11.732895] scsi 2:0:0:0: Attached scsi generic sg2 type 5
[   11.733599] sd 3:0:0:0: Attached scsi generic sg3 type 0
[   11.734363] sd 4:0:0:0: Attached scsi generic sg4 type 0
[   11.926582] sr 2:0:0:0: [sr0] scsi3-mmc drive: 0x/48x writer cd/rw xa/form2 cdda tray
[   11.926585] cdrom: Uniform CD-ROM driver Revision: 3.20
[   11.952204] sr 2:0:0:0: Attached scsi CD-ROM sr0
[   12.335856] usb-storage 1-1.2:1.0: USB Mass Storage device detected
[   12.336400] scsi host6: usb-storage 1-1.2:1.0
[   12.336908] usbcore: registered new interface driver usb-storage
[   12.860819] snd_hda_codec_analog hdaudioC1D0: autoconfig for AD1984: line_outs=1 (0x12/0x0/0x0/0x0/0x0) type:line
[   12.861321] snd_hda_codec_analog hdaudioC1D0:    speaker_outs=1 (0x13/0x0/0x0/0x0/0x0)
[   12.861752] snd_hda_codec_analog hdaudioC1D0:    hp_outs=1 (0x11/0x0/0x0/0x0/0x0)
[   12.862525] snd_hda_codec_analog hdaudioC1D0:    mono: mono_out=0x0
[   12.863310] snd_hda_codec_analog hdaudioC1D0:    inputs:
[   12.864079] snd_hda_codec_analog hdaudioC1D0:      Mic=0x14
[   12.864870] snd_hda_codec_analog hdaudioC1D0:      Line=0x15
[   12.874611] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[   12.876121] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card1/input10
[   12.876619] input: HDA Intel Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card1/input11
[   12.878656] input: HDA Intel Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input12
[   12.915910] usbcore: registered new interface driver snd-usb-audio
[   13.353261] scsi 6:0:0:0: Direct-Access     SMSC     223 U HS-CF      3.60 PQ: 0 ANSI: 0
[   13.357002] scsi 6:0:0:1: Direct-Access     SMSC     223 U HS-MS      3.60 PQ: 0 ANSI: 0
[   13.360756] scsi 6:0:0:2: Direct-Access     SMSC     223 U HS-SM      3.60 PQ: 0 ANSI: 0
[   13.364127] scsi 6:0:0:3: Direct-Access     SMSC     223 U HS-SD/MMC  3.60 PQ: 0 ANSI: 0
[   13.364894] sd 6:0:0:0: Attached scsi generic sg5 type 0
[   13.365471] sd 6:0:0:1: Attached scsi generic sg6 type 0
[   13.366036] sd 6:0:0:2: Attached scsi generic sg7 type 0
[   13.366582] sd 6:0:0:3: Attached scsi generic sg8 type 0
[   13.442126] sd 6:0:0:1: [sdf] Attached SCSI removable disk
[   13.451997] sd 6:0:0:0: [sde] Attached SCSI removable disk
[   13.458624] sd 6:0:0:3: [sdh] Attached SCSI removable disk
[   13.472746] sd 6:0:0:2: [sdg] Attached SCSI removable disk
[   14.006241] xfs filesystem being remounted at / supports timestamps until 2038 (0x7fffffff)
[   14.757468] tun: Universal TUN/TAP device driver, 1.6
[   15.724498] XFS (dm-1): Mounting V4 Filesystem
[   15.996222] XFS (dm-1): Ending clean mount
[   15.996729] xfs filesystem being mounted at /var supports timestamps until 2038 (0x7fffffff)
[   16.015757] XFS (sdc): Mounting V5 Filesystem
[   16.252537] XFS (sdc): Ending clean mount
[   16.296022] xfs filesystem being mounted at /media/music supports timestamps until 2038 (0x7fffffff)
[   16.396935] Adding 8388172k swap on /dev/mapper/swap.  Priority:-2 extents:1 across:8388172k 
[   17.082065] br0: port 1(eth0) entered blocking state
[   17.082478] br0: port 1(eth0) entered disabled state
[   17.082909] device eth0 entered promiscuous mode
[   17.639728] RPC: Registered named UNIX socket transport module.
[   17.640147] RPC: Registered udp transport module.
[   17.640526] RPC: Registered tcp transport module.
[   17.640919] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   17.688356] FS-Cache: Loaded
[   17.715920] FS-Cache: Netfs 'nfs' registered for caching
[   17.759505] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   20.171354] tg3 0000:04:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   20.172836] tg3 0000:04:00.0 eth0: Flow control is on for TX and on for RX
[   20.174332] br0: port 1(eth0) entered blocking state
[   20.175782] br0: port 1(eth0) entered forwarding state
[   20.895316] NFSD: Using UMH upcall client tracking operations.
[   20.895729] NFSD: starting 90-second grace period (net f0000098)
[   31.545526] NFS: Registering the id_resolver key type
[   31.545536] Key type id_resolver registered
[   31.545537] Key type id_legacy registered

--UNroi1QpYmtvioNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="v5.10.9-working-alsa-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.65
!!################################

!!Script ran on: Fri Jan 22 07:22:57 UTC 2021


!!Linux Distribution
!!------------------

Debian GNU/Linux bullseye/sid \n \l PRETTY_NAME="Debian GNU/Linux bullseye/sid" NAME="Debian GNU/Linux" ID=debian HOME_URL="https://www.debian.org/" SUPPORT_URL="https://www.debian.org/support" BUG_REPORT_URL="https://bugs.debian.org/"


!!DMI Information
!!---------------

Manufacturer:      Dell Inc.
Product Name:      Precision WorkStation T3400  
Product Version:   
Firmware Version:  A14
System SKU:        
Board Vendor:      Dell Inc.
Board Name:        0TP412


!!ACPI Device Status Information
!!---------------

/sys/bus/acpi/devices/PNP0401:00/status 	 15
/sys/bus/acpi/devices/PNP0501:00/status 	 15
/sys/bus/acpi/devices/PNP0700:00/status 	 15
/sys/bus/acpi/devices/PNP0C0F:00/status 	 9
/sys/bus/acpi/devices/PNP0C0F:01/status 	 9
/sys/bus/acpi/devices/PNP0C0F:02/status 	 9
/sys/bus/acpi/devices/PNP0C0F:03/status 	 9
/sys/bus/acpi/devices/PNP0C0F:04/status 	 9
/sys/bus/acpi/devices/PNP0C0F:05/status 	 9
/sys/bus/acpi/devices/PNP0C0F:06/status 	 9
/sys/bus/acpi/devices/PNP0C0F:07/status 	 9
/sys/bus/acpi/devices/PNP0F13:00/status 	 15
/sys/bus/acpi/devices/SMO1200:00/status 	 15
/sys/bus/acpi/devices/device:07/status 	 15
/sys/bus/acpi/devices/device:08/status 	 15
/sys/bus/acpi/devices/device:09/status 	 15
/sys/bus/acpi/devices/device:0a/status 	 15
/sys/bus/acpi/devices/device:0b/status 	 15
/sys/bus/acpi/devices/device:0c/status 	 15


!!Kernel Information
!!------------------

Kernel release:    5.10.9
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k5.10.9
Library version:    1.2.4
Utilities version:  1.2.4


!!Loaded ALSA modules
!!-------------------

snd_usb_audio
snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [hiFace2        ]: USB-Audio - M2Tech USB Audio 2.0
                      M2Tech M2Tech USB Audio 2.0 at usb-0000:00:1a.7-1.1.2, high speed
 1 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfdffc000 irq 30


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device [0403]: Intel Corporation 82801I (ICH9 Family) HD Audio Controller [8086:293e] (rev 02)
	Subsystem: Dell 82801I (ICH9 Family) HD Audio Controller [1028:0214]


!!Modprobe options (Sound related)
!!--------------------------------

snd_pcsp: index=-2
snd_usb_audio: index=-2
snd_atiixp_modem: index=-2
snd_intel8x0m: index=-2
snd_via82xx_modem: index=-2
snd_hda_intel: model=dell_desktop
snd_usb_audio: vid=0x08bb,0x08bb,0x249c pid=0x2902,0x2707,0x930b id=bithead,bDAC,hiFace2


!!Loaded sound module options
!!---------------------------

!!Module: snd_usb_audio
	autoclock : Y
	delayed_register : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	device_setup : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	id : bithead,bDAC,hiFace2,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	ignore_ctl_error : N
	index : -2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	pid : 10498,9991,37643,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	quirk_alias : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	skip_validation : N
	use_vmalloc : Y
	vid : 2235,2235,9372,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
	dmic_detect : Y
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	model : dell_desktop,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	pm_blacklist : Y
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : -1
	snoop : -1


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Analog Devices AD1984
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11d41984
Subsystem Id: 0x10280214
Revision Id: 0x100400
No Modem Function Group found
Default PCM:
    rates [0x7ff]: 8000 11025 16000 22050 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
State of AFG node 0x01:
  Power states:  D0 D3
  Power: setting=D0, actual=D0
GPIO: io=3, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=1, unsol=0
  IO[1]: enable=1, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 3 samples
  Connection: 3
     0x01* 0x08 0x09
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD1984 Alt Analog", type="Audio", device=2
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x22 0x22]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Line Out Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD1984 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x22 0x22]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x05 [Audio Input] wcaps 0x10050b: Stereo Amp-In
  Amp-In caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-In vals:  [0xa7 0xa7]
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x17
Node 0x06 [Audio Input] wcaps 0x10050b: Stereo Amp-In
  Amp-In caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-In vals:  [0xa7 0xa7]
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x18
Node 0x07 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x22 0x21
Node 0x08 [Audio Input] wcaps 0x100501: Stereo
  Device: name="AD1984 Analog", type="Audio", device=0
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c
Node 0x09 [Audio Input] wcaps 0x100501: Stereo
  Device: name="AD1984 Alt Analog", type="Audio", device=2
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0d
Node 0x0a [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x04 0x21
Node 0x0b [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x0f 0x21
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0x2f 0x2f]
  Connection: 5
     0x14* 0x15 0x16 0x20 0x25
Node 0x0d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 5
     0x14* 0x15 0x16 0x20 0x25
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03 0x04*
Node 0x0f [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x10 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Control: name="Beep Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="Beep Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x8f]
Node 0x11 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001f: OUT HP Detect Trigger ImpSense
  Pin Default 0x02214040: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x07
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Line Out Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001f: OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x2: EAPD
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0a
Node 0x13 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1a]
  Pincap 0x00010010: OUT EAPD
  EAPD 0x0:
  Pin Default 0x991301f0: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x1f
Node 0x14 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a19020: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
Node 0x15 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Control: name="Line Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01813030: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=04, enabled=1
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x413301f0: [N/A] CD at Ext Rear
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0b
Node 0x17 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x41a601f0: [N/A] Mic at Ext Rear
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x18 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x41a601f0: [N/A] Mic at Ext Rear
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x19 [Power Widget] wcaps 0x500500: Mono
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x20 0x21
Node 0x1a [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x41f301f0: [N/A] Other at Ext Rear
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1b [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Pincap 0x00000010: OUT
  Pin Default 0x414511f0: [N/A] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x1c [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x41a190f0: [N/A] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x24
Node 0x1d [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 25
     0x07* 0x19 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x1a 0x1c 0x11 0x12 0x13 0x14 0x15 0x16 0x1e 0x1f 0x20 0x21 0x22 0x23 0x24 0x25 0x26
Node 0x1e [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x0e 0x21
Node 0x1f [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x1e
Node 0x20 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 5
     0x14 0x15 0x16 0x1a 0x25
Node 0x21 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 1
     0x20
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x24 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x23 0x21
Node 0x25 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x1c
Node 0x26 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 3
     0x14* 0x15 0x1c
--endcollapse--


!!USB Mixer information
!!---------------------
--startcollapse--

USB Mixer: usb_id=0x249c930b, ctrlif=0, ctlerr=0
Card: M2Tech M2Tech USB Audio 2.0 at usb-0000:00:1a.7-1.1.2, high speed
  Unit: 10
    Control: name="M2Tech Audio 2.0 Output Playback Volume", index=1
    Info: id=10, control=2, cmask=0x0, channels=1, type="S16"
    Volume: min=-32512, max=0, dBmin=-12700, dBmax=0
  Unit: 10
    Control: name="M2Tech Audio 2.0 Output Playback Volume", index=0
    Info: id=10, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-32512, max=0, dBmin=-12700, dBmax=0
  Unit: 10
    Control: name="M2Tech Audio 2.0 Output Playback Switch", index=1
    Info: id=10, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 10
    Control: name="M2Tech Audio 2.0 Output Playback Switch", index=0
    Info: id=10, control=1, cmask=0x3, channels=2, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 41
    Control: name="M2Tech Internal Clock Validity", index=0
    Info: id=41, control=2, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  9 Jan 22 07:12 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  7 Jan 22 07:12 /dev/snd/controlC1
crw-rw---- 1 root audio 116,  6 Jan 22 07:12 /dev/snd/hwC1D0
crw-rw---- 1 root audio 116,  8 Jan 22 07:13 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116,  3 Jan 22 07:12 /dev/snd/pcmC1D0c
crw-rw---- 1 root audio 116,  2 Jan 22 07:12 /dev/snd/pcmC1D0p
crw-rw---- 1 root audio 116,  5 Jan 22 07:12 /dev/snd/pcmC1D2c
crw-rw---- 1 root audio 116,  4 Jan 22 07:12 /dev/snd/pcmC1D2p
crw-rw---- 1 root audio 116,  1 Jan 22 07:12 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Jan 22 07:12 /dev/snd/timer

/dev/snd/by-id:
total 0
drwxr-xr-x 2 root root  60 Jan 22 07:12 .
drwxr-xr-x 4 root root 280 Jan 22 07:12 ..
lrwxrwxrwx 1 root root  12 Jan 22 07:12 usb-M2Tech_M2Tech_USB_Audio_2.0_0000-00 -> ../controlC0

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 Jan 22 07:12 .
drwxr-xr-x 4 root root 280 Jan 22 07:12 ..
lrwxrwxrwx 1 root root  12 Jan 22 07:12 pci-0000:00:1a.7-usb-0:1.1.2:1.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 Jan 22 07:12 pci-0000:00:1b.0 -> ../controlC1


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: hiFace2 [M2Tech USB Audio 2.0], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 1: Intel [HDA Intel], device 0: AD1984 Analog [AD1984 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Intel [HDA Intel], device 2: AD1984 Alt Analog [AD1984 Alt Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 1: Intel [HDA Intel], device 0: AD1984 Analog [AD1984 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Intel [HDA Intel], device 2: AD1984 Alt Analog [AD1984 Alt Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card hiFace2

Card hw:0 'hiFace2'/'M2Tech M2Tech USB Audio 2.0 at usb-0000:00:1a.7-1.1.2, high speed'
  Mixer name	: 'USB Mixer'
  Components	: 'USB249c:930b'
  Controls      : 7
  Simple ctrls  : 2
Simple mixer control 'M2Tech Audio 2.0 Output',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [0.00dB] [on]
  Front Right: Playback 127 [100%] [0.00dB] [on]
Simple mixer control 'M2Tech Audio 2.0 Output',1
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 127 [100%] [0.00dB] [on]

!!-------Mixer controls for card Intel

Card hw:1 'Intel'/'HDA Intel at 0xfdffc000 irq 30'
  Mixer name	: 'Analog Devices AD1984'
  Components	: 'HDA:11d41984,10280214,00100400'
  Controls      : 35
  Simple ctrls  : 17
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 39
  Mono: Playback 34 [87%] [-7.50dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 39 [100%] [0.00dB] [on]
  Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Line Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Line Out',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 39 [100%] [0.00dB] [on]
  Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 15 [100%] [0.00dB] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 47 [87%] [12.00dB] [on]
  Front Right: Capture 47 [87%] [12.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 0 [0%] [-58.50dB] [off]
  Front Right: Capture 0 [0%] [-58.50dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Speaker Only' 'Line Out+Speaker'
  Item0: 'Line Out+Speaker'
Simple mixer control 'Independent HP',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Disabled'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Line' 'Stereo Mix'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Line' 'Stereo Mix'
  Item0: 'Mic'
Simple mixer control 'Loopback Mixing',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Disabled'


!!Alsactl output
!!--------------

--startcollapse--
state.hiFace2 {
	control.1 {
		iface PCM
		name 'Playback Channel Map'
		value.0 3
		value.1 4
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.2 {
		iface MIXER
		name 'M2Tech Audio 2.0 Output Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'M2Tech Audio 2.0 Output Playback Switch'
		index 1
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'M2Tech Audio 2.0 Output Playback Volume'
		value.0 127
		value.1 127
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -12700
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.5 {
		iface MIXER
		name 'M2Tech Audio 2.0 Output Playback Volume'
		index 1
		value 127
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 127'
			dbmin -12700
			dbmax 0
			dbvalue.0 0
		}
	}
	control.6 {
		iface CARD
		name 'M2Tech Internal Clock Validity'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.7 {
		iface CARD
		name 'Keep Interface'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
}
state.Intel {
	control.1 {
		iface MIXER
		name 'Line Out Playback Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.2 {
		iface MIXER
		name 'Line Out Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.5 {
		iface MIXER
		name 'Speaker Playback Volume'
		value 31
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
			dbmin -4650
			dbmax 0
			dbvalue.0 0
		}
	}
	control.6 {
		iface MIXER
		name 'Speaker Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.7 {
		iface MIXER
		name 'Independent HP'
		value Disabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.8 {
		iface MIXER
		name 'Loopback Mixing'
		value Disabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.9 {
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.10 {
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.11 {
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.12 {
		iface MIXER
		name 'Line Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.13 {
		iface MIXER
		name 'Auto-Mute Mode'
		value 'Line Out+Speaker'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 'Speaker Only'
			item.2 'Line Out+Speaker'
		}
	}
	control.14 {
		iface MIXER
		name 'Input Source'
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 Line
			item.2 'Stereo Mix'
		}
	}
	control.15 {
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 Line
			item.2 'Stereo Mix'
		}
	}
	control.16 {
		iface MIXER
		name 'Capture Volume'
		value.0 47
		value.1 47
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 54'
			dbmin -5850
			dbmax 2250
			dbvalue.0 1200
			dbvalue.1 1200
		}
	}
	control.17 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.18 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 54'
			dbmin -5850
			dbmax 2250
			dbvalue.0 -5850
			dbvalue.1 -5850
		}
	}
	control.19 {
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.20 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.21 {
		iface MIXER
		name 'Line Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.22 {
		iface MIXER
		name 'Master Playback Volume'
		value 34
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 -750
		}
	}
	control.23 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.24 {
		iface CARD
		name 'Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.25 {
		iface CARD
		name 'Line Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.26 {
		iface CARD
		name 'Line Out Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.27 {
		iface CARD
		name 'Front Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.28 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'Beep Playback Volume'
		value 15
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
			dbmin -4500
			dbmax 0
			dbvalue.0 0
		}
	}
	control.30 {
		iface MIXER
		name 'Beep Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.31 {
		iface PCM
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.32 {
		iface PCM
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.33 {
		iface PCM
		device 2
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.34 {
		iface PCM
		device 2
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.35 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

adiantum
aes_generic
auth_rpcgss
autofs4
bridge
cdrom
chacha_generic
chacha_x86_64
cpufreq_conservative
cpufreq_ondemand
cpufreq_powersave
cpufreq_userspace
dcdbas
dm_crypt
dm_mod
evdev
fan
floppy
fscache
grace
irqbypass
kvm
kvm_intel
libaes
libchacha
libpoly1305
llc
lockd
md_mod
nfs
nfs_ssc
nfsd
nfsv4
nhpoly1305
nhpoly1305_sse2
psmouse
raid1
sg
snd
snd_hda_codec
snd_hda_codec_analog
snd_hda_codec_generic
snd_hda_core
snd_hda_intel
snd_hwdep
snd_intel_dspcfg
snd_pcm
snd_rawmidi
snd_seq_device
snd_timer
snd_usb_audio
snd_usbmidi_lib
soundcore
sr_mod
stp
sunrpc
tap
tg3
tun
usb_storage
vhost
vhost_iotlb
vhost_net
xfs


!!Sysfs Files
!!-----------

/sys/class/sound/hwC1D0/init_pin_configs:
0x11 0x02214040
0x12 0x01014010
0x13 0x991301f0
0x14 0x02a19020
0x15 0x01813030
0x16 0x413301f0
0x17 0x41a601f0
0x18 0x41a601f0
0x1a 0x41f301f0
0x1b 0x414511f0
0x1c 0x41a190f0

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D0/hints:


!!ALSA/HDA dmesg
!!--------------

[    3.750925] ACPI: Added _OSI(Linux-Dell-Video)
[    3.750925] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    3.750925] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
--
[   12.336908] usbcore: registered new interface driver usb-storage
[   12.860819] snd_hda_codec_analog hdaudioC1D0: autoconfig for AD1984: line_outs=1 (0x12/0x0/0x0/0x0/0x0) type:line
[   12.861321] snd_hda_codec_analog hdaudioC1D0:    speaker_outs=1 (0x13/0x0/0x0/0x0/0x0)
[   12.861752] snd_hda_codec_analog hdaudioC1D0:    hp_outs=1 (0x11/0x0/0x0/0x0/0x0)
[   12.862525] snd_hda_codec_analog hdaudioC1D0:    mono: mono_out=0x0
[   12.863310] snd_hda_codec_analog hdaudioC1D0:    inputs:
[   12.864079] snd_hda_codec_analog hdaudioC1D0:      Mic=0x14
[   12.864870] snd_hda_codec_analog hdaudioC1D0:      Line=0x15
[   12.874611] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[   12.876121] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card1/input10
[   12.876619] input: HDA Intel Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card1/input11
[   12.878656] input: HDA Intel Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input12
[   12.915910] usbcore: registered new interface driver snd-usb-audio
[   13.353261] scsi 6:0:0:0: Direct-Access     SMSC     223 U HS-CF      3.60 PQ: 0 ANSI: 0


!!Packages installed
!!--------------------

ii  alsa-utils                                 1.2.4-1                             amd64        Utilities for configuring and using ALSA


--UNroi1QpYmtvioNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="v5.10.9-working-lsusb-vvv.txt"

Bus 001 Device 006: ID 249c:930b M2Tech s.r.l. M2Tech USB Audio 2.0
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x249c M2Tech s.r.l.
  idProduct          0x930b 
  bcdDevice            2.13
  iManufacturer           1 M2Tech 
  iProduct                2 M2Tech USB Audio 2.0
  iSerial                 3 0000
  bNumConfigurations      2
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00b9
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       0 
      bFunctionProtocol      32 
      iFunction               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol     32 
      iInterface              2 M2Tech USB Audio 2.0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        bCategory               8
        wTotalLength       0x0048
        bmControls           0x00
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               41
        bmAttributes            3 Internal programmable clock 
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource            9 M2Tech Internal Clock
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     11 (CLOCK_SELECTOR)
        bClockID               40
        bNrInPins               1
        baCSourceID(0)         41
        bmControls           0x03
          Clock Selector Control (read/write)
        iClockSelector          8 M2Tech Clock Selector
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels             2
        bmChannelConfig    0x00000000
        iChannelNames          15 Analogue 1
        bmControls         0x0000
        iTerminal               6 M2Tech Audio 2.0 Output
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               2
        bmaControls(0)     0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(1)     0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(2)     0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            20
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID              10
        bCSourceID             40
        bmControls         0x0000
        iTerminal               0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0006  1x 6 bytes
        bInterval               8
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              4 M2Tech USB 2.0 Audio Out
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              4 M2Tech USB 2.0 Audio Out
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x00
        bFormatType             1
        bmFormats          0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig    0x00000000
        iChannelNames          15 Analogue 1
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            4
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               1
        AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay         0x0008
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      1 
      iInterface             12 M2Tech DFU
      Device Firmware Upgrade Interface Descriptor:
        bLength                             9
        bDescriptorType                    33
        bmAttributes                        7
          Will Not Detach
          Manifestation Tolerant
          Upload Supported
          Download Supported
        wDetachTimeout                    250 milliseconds
        wTransferSize                      64 bytes
        bcdDFUVersion                   1.10
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00b9
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       0 
      bFunctionProtocol      32 
      iFunction               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol     32 
      iInterface              2 M2Tech USB Audio 2.0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        bCategory               8
        wTotalLength       0x0048
        bmControls           0x00
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               41
        bmAttributes            3 Internal programmable clock 
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource            9 M2Tech Internal Clock
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     11 (CLOCK_SELECTOR)
        bClockID               40
        bNrInPins               1
        baCSourceID(0)         41
        bmControls           0x03
          Clock Selector Control (read/write)
        iClockSelector          8 M2Tech Clock Selector
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels             2
        bmChannelConfig    0x00000000
        iChannelNames          15 Analogue 1
        bmControls         0x0000
        iTerminal               6 M2Tech Audio 2.0 Output
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               2
        bmaControls(0)     0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(1)     0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(2)     0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            20
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID              10
        bCSourceID             40
        bmControls         0x0000
        iTerminal               0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0006  1x 6 bytes
        bInterval               8
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              4 M2Tech USB 2.0 Audio Out
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              4 M2Tech USB 2.0 Audio Out
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x00
        bFormatType             1
        bmFormats          0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig    0x00000000
        iChannelNames          15 Analogue 1
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            4
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               1
        AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay         0x0008
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      1 
      iInterface             12 M2Tech DFU
      Device Firmware Upgrade Interface Descriptor:
        bLength                             9
        bDescriptorType                    33
        bmAttributes                        7
          Will Not Detach
          Manifestation Tolerant
          Upload Supported
          Download Supported
        wDetachTimeout                    250 milliseconds
        wTransferSize                      64 bytes
        bcdDFUVersion                   1.10
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  bNumConfigurations      1
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0000
  (Bus Powered)

--UNroi1QpYmtvioNX--
