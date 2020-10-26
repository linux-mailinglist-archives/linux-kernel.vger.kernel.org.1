Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5319E2993E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1776610AbgJZRdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:33:13 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39920 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407989AbgJZRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:33:13 -0400
Received: by mail-pj1-f65.google.com with SMTP id m3so3430311pjf.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=QsmUOkeY3+ES5z+hZb07Kh6nlwFFRCGw9RftCsYnODQ=;
        b=rwSlxB5yB1XX/5/vNw4ubDKx0X3z3NwLNQ7fx/D70KqC1TUmve5nPoa6ewr2GuqO6q
         BhbFa/ZUd9Xe6hptpjIlwwWcG6cAobOVIq8Hv0Tl7ziTnjlGN6DqxUxfNgw06gkYGuSv
         BkdBZm2Dn/i05IR8+aooDtb72UZJ3ODy124mSYz0M/uEAq15nwhOG0fpImZaqAvRPm/+
         hn5wU1+LLW12T1R6YsmqL4GhAJSOVo0SXzqPvggtOZ/ugrik6e/B/VL1RiDqk0J3ZC+J
         jWttz/eEh/M3pdhmhhmMS8vJQ3wS1RErPc9InYxAU7o0WCNlyTNlNjT7IchXJg4EJPC3
         GVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QsmUOkeY3+ES5z+hZb07Kh6nlwFFRCGw9RftCsYnODQ=;
        b=SJhAsB7TCcUF11espiK8p0YCz/OoHeS1cj1f1EDpcQ/wYhQ4X4vUGniJm3LVnVaBVX
         Zu+K6vDBpxZq2NoLrrCaSlPgxKjdRPWdBpaWUupPUai98D1rHvAk68MZL6gWd9gRbsSh
         Ct5KW+G84ZMgLIkuMjJ8fAXZiZcopeM20cpizXcOw9POIwWedE1WVXSiEmtwwZl2i17R
         PJVHtU7Roo5lVBHzhiUW938aFwSI0n9A7uy2aUaATEzZwwRmKHrUF2IJZN7O++g3m7rF
         /KG6cMMsS4e4oafD0IJ2Ad/T66Rld++uGTlcGDVEDE50ngHCbSGkUGlVs/RyrtZmlBiO
         4G1w==
X-Gm-Message-State: AOAM533ZRo//2gsTBLcmDbjIli9VvybjW5dcMrOlohCfBXmE68QvmQZf
        6F49lV0GpDkBwcmKLvYOkIUHbQ==
X-Google-Smtp-Source: ABdhPJwbbdgGM8oCeSoqR9wfqRtQBOIijTzVsSX02zSp/aQ1OwT8/ayOEG92i1veOcvIGuN9YcFe1g==
X-Received: by 2002:a17:902:934b:b029:d4:e4c7:26f5 with SMTP id g11-20020a170902934bb02900d4e4c726f5mr13089836plp.60.1603733591051;
        Mon, 26 Oct 2020 10:33:11 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id e11sm12380662pfl.58.2020.10.26.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:33:10 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] irq-meson-gpio: make it possible to build as a module
In-Reply-To: <7hy2jshp6w.fsf@baylibre.com>
References: <20201020072532.949137-1-narmstrong@baylibre.com> <87v9eyo75s.wl-maz@kernel.org> <7ha6w9hsfm.fsf@baylibre.com> <b0780e423d5fa527835ba55c64dba473@kernel.org> <7hy2jshp6w.fsf@baylibre.com>
Date:   Mon, 26 Oct 2020 10:33:09 -0700
Message-ID: <7hv9ewhoyy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Marc Zyngier <maz@kernel.org> writes:
>
>> On 2020-10-26 16:18, Kevin Hilman wrote:
>>> Marc Zyngier <maz@kernel.org> writes:
>>> 
>>>> On Tue, 20 Oct 2020 08:25:30 +0100,
>>>> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>> 
>>>>> In order to reduce the kernel Image size on multi-platform 
>>>>> distributions,
>>>>> make it possible to build the Amlogic GPIO IRQ controller as a module
>>>>> by switching it to a platform driver.
>>>>> 
>>>>> The second patch removes MESON_IRQ_GPIO selection from ARCH_MESON to 
>>>>> allow
>>>>> building the driver as module.
>>>>> 
>>>>> Neil Armstrong (2):
>>>>>   irqchip: irq-meson-gpio: make it possible to build as a module
>>>>>   arm64: meson: remove MESON_IRQ_GPIO selection
>>>>> 
>>>>>  arch/arm64/Kconfig.platforms     |  1 -
>>>>>  drivers/irqchip/Kconfig          |  5 +-
>>>>>  drivers/irqchip/irq-meson-gpio.c | 89 
>>>>> ++++++++++++++++++++------------
>>>>>  3 files changed, 59 insertions(+), 36 deletions(-)
>>>> 
>>>> I've tried this series on my vim3l with the this driver compiled as a
>>>> module, and lost the Ethernet interface in the process, as the phy
>>>> wasn't able to resolve its interrupt and things fail later on:
>>>> 
>>>> [   72.238291] meson8b-dwmac ff3f0000.ethernet eth1: no phy at addr -1
>>>> [   72.238917] meson8b-dwmac ff3f0000.ethernet eth1: stmmac_open: 
>>>> Cannot attach to PHY (error: -19)
>>>> 
>>>> This is a generic problem with making DT-based interrupt controllers
>>>> modular when not *all* the drivers can deal with probing deferral.
>>> 
>>> Yes, but this series still keeps the default as built-in.
>>> 
>>> If you build as a module, and you add `fw_devlink=on` to the kernel
>>> command-line, device-links will be created based on DT dependencies
>>> which will ensure the right module load order.
>>
>> It doesn't work here. I get the exact same error (well, with eth0 
>> instead
>> of eth1). In my experience, fw_devlink isn't reliable yet. Config on 
>> request.
>
> Other than CONFIG_MESON_IRQ_GPIO=m, are you using default upstream
> defconfig?
>
> I just double-checked with this series on top of v5.10-rc1, and I have
> eth0 working with interrupts without needing fw_devlink=on.
>
> With the default upstream defconfig all the networking for these devices
> is already configured as modules.

Forgot to include a full boot log:


U-Boot 2020.07-00031-gb35ed474d2b4 (Sep 14 2020 - 11:11:52 -0700) khadas-vim3l

Model: Khadas VIM3L
SoC:   Amlogic Meson SM1 (Unknown) Revision 2b:c (4:2)
DRAM:  2 GiB
MMC:   sd@ffe03000: 0, sd@ffe05000: 1, mmc@ffe07000: 2
Loading Environment from MMC... *** Warning - bad CRC, using default environment

In:    serial@3000
Out:   serial@3000
Err:   serial@3000
Net:   eth0: ethernet@ff3f0000
Verify GPT: success!
switch to partitions #0, OK
mmc2(part 0) is current device

MMC read: dev # 2, block # 1024, count 4096 ... 4096 blocks read: OK
Hit any key to stop autoboot:  2 
# PYBOOT: u-boot: taking control.
 0 
=> 
=> version
version
U-Boot 2020.07-00031-gb35ed474d2b4 (Sep 14 2020 - 11:11:52 -0700) khadas-vim3l

aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0
GNU ld (GNU Binutils for Debian) 2.31.1
=> setenv preboot 
setenv preboot 
=> setenv bootargs console=ttyAML0,115200
setenv bootargs console=ttyAML0,115200
=> if test -n ${initenv}; then run initenv; fi
if test -n ${initenv}; then run initenv; fi
=> if test -n ${preboot}; then run preboot; fi
if test -n ${preboot}; then run preboot; fi
=> setenv autoload no
setenv autoload no
=> setenv autoboot no
setenv autoboot no
=> dhcp
dhcp
ethernet@ff3f0000 Waiting for PHY auto negotiation to complete.... done
Speed: 100, full duplex
BOOTP broadcast 1
DHCP client bound to address 192.168.0.143 (2 ms)
=> setenv serverip 192.168.1.2
setenv serverip 192.168.1.2
=> if test -n ${netargs}; then run netargs; fi
if test -n ${netargs}; then run netargs; fi
=> tftp 0x03000000 192.168.1.2:tmp/meson-sm1-khadas-vim3l-_Mngjr/Image.gz
tftp 0x03000000 192.168.1.2:tmp/meson-sm1-khadas-vim3l-_Mngjr/Image.gz
Speed: 100, full duplex
Using ethernet@ff3f0000 device
TFTP from server 192.168.1.2; our IP address is 192.168.0.143; sending through gateway 192.168.0.254
Filename 'tmp/meson-sm1-khadas-vim3l-_Mngjr/Image.gz'.
Load address: 0x3000000
Loading: *#################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #####################################################T ############
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 ###############################
 736.3 KiB/s
done
Bytes transferred = 10945439 (a7039f hex)
=> tftp 0x08000000 192.168.1.2:tmp/meson-sm1-khadas-vim3l-_Mngjr/initrd-SAzbRc.cpio.gz
tftp 0x08000000 192.168.1.2:tmp/meson-sm1-khadas-vim3l-_Mngjr/initrd-SAzbRc.cpio.gz
Speed: 100, full duplex
Using ethernet@ff3f0000 device
TFTP from server 192.168.1.2; our IP address is 192.168.0.143; sending through gateway 192.168.0.254
Filename 'tmp/meson-sm1-khadas-vim3l-_Mngjr/initrd-SAzbRc.cpio.gz'.
Load address: 0x8000000
Loading: *#################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 ######################
 1.3 MiB/s
done
Bytes transferred = 15588406 (eddc36 hex)
=> tftp 0x01000000 192.168.1.2:tmp/meson-sm1-khadas-vim3l-_Mngjr/tmpLRsLgg.dtb
tftp 0x01000000 192.168.1.2:tmp/meson-sm1-khadas-vim3l-_Mngjr/tmpLRsLgg.dtb
Speed: 100, full duplex
Using ethernet@ff3f0000 device
TFTP from server 192.168.1.2; our IP address is 192.168.0.143; sending through gateway 192.168.0.254
Filename 'tmp/meson-sm1-khadas-vim3l-_Mngjr/tmpLRsLgg.dtb'.
Load address: 0x1000000
Loading: *####
 937.5 KiB/s
done
Bytes transferred = 48988 (bf5c hex)
=> printenv bootargs
printenv bootargs
bootargs=console=ttyAML0,115200
=> unzip 0x03000000 0x01080000
booti 0x01080000 - 0x01000000

# PYBOOT: u-boot: jumping to kernel image
unzip 0x03000000 0x01080000
Uncompressed size: 31179264 = 0x1DBC200
=> booti 0x01080000 - 0x01000000
## Flattened Device Tree blob at 01000000
   Booting using the fdt blob at 0x1000000
   Loading Device Tree to 0000000075f12000, end 0000000075f20f5b ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd050]
[    0.000000] Linux version 5.10.0-rc1-00002-g4b28e5bd6b6a (KernelCI@paris) (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #232 SMP PREEMPT Mon Oct 26 10:18:47 PDT 2020
[    0.000000] Machine model: Khadas VIM3L
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created CMA memory pool at 0x0000000065c00000, size 256 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x000000007f806fff]
[    0.000000] NUMA: NODE_DATA [mem 0x7f3bd100-0x7f3befff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000]   DMA32    [mem 0x0000000040000000-0x000000007f806fff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000004ffffff]
[    0.000000]   node   0: [mem 0x0000000005300000-0x000000007f806fff]
[    0.000000] Zeroed struct page in unavailable ranges: 505 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007f806fff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 23 pages/cpu s56152 r8192 d29864 u94208
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 1530923
[    0.000000] alternatives: patching kernel code
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 513318
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: console=ttyAML0,115200
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x000000003bfff000-0x000000003ffff000] (64MB)
[    0.000000] Memory: 1670932K/2085916K available (14076K kernel code, 2800K rwdata, 7572K rodata, 5952K init, 515K bss, 152840K reserved, 262144K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: RCU event tracing is enabled.
[    0.000000] rcu: RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000] Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] random: get_random_bytes called from start_kernel+0x314/0x4d4 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000004] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000250] Console: colour dummy device 80x25
[    0.000332] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.000346] pid_max: default: 32768 minimum: 301
[    0.000420] LSM: Security Framework initializing
[    0.000477] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.000492] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.001786] rcu: Hierarchical SRCU implementation.
[    0.005342] EFI services will not be available.
[    0.005582] smp: Bringing up secondary CPUs ...
[    0.006335] Detected VIPT I-cache on CPU1
[    0.006396] CPU1: Booted secondary processor 0x0000000100 [0x411fd050]
[    0.007183] Detected VIPT I-cache on CPU2
[    0.007225] CPU2: Booted secondary processor 0x0000000200 [0x411fd050]
[    0.007992] Detected VIPT I-cache on CPU3
[    0.008031] CPU3: Booted secondary processor 0x0000000300 [0x411fd050]
[    0.008103] smp: Brought up 1 node, 4 CPUs
[    0.008125] SMP: Total of 4 processors activated.
[    0.008132] CPU features: detected: Privileged Access Never
[    0.008137] CPU features: detected: LSE atomic instructions
[    0.008142] CPU features: detected: User Access Override
[    0.008147] CPU features: detected: 32-bit EL0 Support
[    0.008153] CPU features: detected: Common not Private translations
[    0.008158] CPU features: detected: RAS Extension Support
[    0.008163] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.008168] CPU features: detected: CRC32 instructions
[    0.008175] CPU features: detected: 32-bit EL1 Support
[    0.023411] CPU: All CPU(s) started at EL2
[    0.025215] devtmpfs: initialized
[    0.033707] KASLR disabled due to lack of seed
[    0.034072] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.034090] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.039946] pinctrl core: initialized pinctrl subsystem
[    0.041395] DMI not present or invalid.
[    0.041886] NET: Registered protocol family 16
[    0.043203] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.043250] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.043361] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.043438] audit: initializing netlink subsys (disabled)
[    0.043590] audit: type=2000 audit(0.040:1): state=initialized audit_enabled=0 res=1
[    0.044851] thermal_sys: Registered thermal governor 'step_wise'
[    0.044857] thermal_sys: Registered thermal governor 'power_allocator'
[    0.045189] cpuidle: using governor menu
[    0.045345] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.045450] ASID allocator initialised with 65536 entries
[    0.047163] Serial: AMBA PL011 UART driver
[    0.094129] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.094144] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.094151] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.094158] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.095243] cryptd: max_cpu_qlen set to 1000
[    0.097462] ACPI: Interpreter disabled.
[    0.100245] VSYS_3V3: supplied by DC_IN
[    0.101006] iommu: Default domain type: Translated 
[    0.101264] vgaarb: loaded
[    0.101533] SCSI subsystem initialized
[    0.101910] usbcore: registered new interface driver usbfs
[    0.101950] usbcore: registered new interface driver hub
[    0.102009] usbcore: registered new device driver usb
[    0.102845] pps_core: LinuxPPS API ver. 1 registered
[    0.102852] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.102868] PTP clock support registered
[    0.103019] EDAC MC: Ver: 3.0.0
[    0.104725] FPGA manager framework
[    0.104818] Advanced Linux Sound Architecture Driver Initialized.
[    0.105515] clocksource: Switched to clocksource arch_sys_counter
[    0.105695] VFS: Disk quotas dquot_6.6.0
[    0.105748] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.105920] pnp: PnP ACPI: disabled
[    0.111989] NET: Registered protocol family 2
[    0.112333] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    0.112363] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.112459] TCP bind hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.112624] TCP: Hash tables configured (established 16384 bind 16384)
[    0.112718] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.112754] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.112888] NET: Registered protocol family 1
[    0.113295] RPC: Registered named UNIX socket transport module.
[    0.113303] RPC: Registered udp transport module.
[    0.113308] RPC: Registered tcp transport module.
[    0.113313] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.113323] PCI: CLS 0 bytes, default 64
[    0.113494] Unpacking initramfs...
[    0.757051] Freeing initrd memory: 15220K
[    0.757975] kvm [1]: IPA Size Limit: 40 bits
[    0.758106] kvm [1]: vgic interrupt IRQ9
[    0.758239] kvm [1]: VHE mode initialized successfully
[    0.761737] Initialise system trusted keyrings
[    0.761875] workingset: timestamp_bits=44 max_order=19 bucket_order=0
[    0.767592] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.768240] NFS: Registering the id_resolver key type
[    0.768264] Key type id_resolver registered
[    0.768270] Key type id_legacy registered
[    0.768351] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.768499] 9p: Installing v9fs 9p2000 file system support
[    0.804991] Key type asymmetric registered
[    0.805000] Asymmetric key parser 'x509' registered
[    0.805034] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.805042] io scheduler mq-deadline registered
[    0.805048] io scheduler kyber registered
[    0.820372] EINJ: ACPI disabled.
[    0.834593] soc soc0: Amlogic Meson SM1 (S905D3) Revision 2b:c (4:2) Detected
[    0.843406] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.846185] SuperH (H)SCI(F) driver initialized
[    0.846878] ff803000.serial: ttyAML0 at MMIO 0xff803000 (irq = 22, base_baud = 1500000) is a meson_uart
[    1.715908] printk: console [ttyAML0] enabled
[    1.720868] ffd24000.serial: ttyAML6 at MMIO 0xffd24000 (irq = 29, base_baud = 1500000) is a meson_uart
[    1.729659] serial serial0: tty port ttyAML6 registered
[    1.735155] msm_serial: driver initialized
[    1.747269] loop: module loaded
[    1.748427] megasas: 07.714.04.00-rc1
[    1.753838] libphy: Fixed MDIO Bus: probed
[    1.755098] tun: Universal TUN/TAP device driver, 1.6
[    1.758461] thunder_xcv, ver 1.0
[    1.760686] thunder_bgx, ver 1.0
[    1.763896] nicpf, ver 1.0
[    1.767908] hclge is initializing
[    1.769859] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    1.776973] hns3: Copyright (c) 2017 Huawei Corporation.
[    1.782295] e1000: Intel(R) PRO/1000 Network Driver
[    1.787059] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.792790] e1000e: Intel(R) PRO/1000 Network Driver
[    1.797667] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.803570] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.808882] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.814431] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    1.820609] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.826947] sky2: driver version 1.30
[    1.831453] VFIO - User Level meta-driver version: 0.3
[    1.837540] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.841657] ehci-pci: EHCI PCI platform driver
[    1.846091] ehci-platform: EHCI generic platform driver
[    1.851411] ehci-orion: EHCI orion driver
[    1.855331] ehci-exynos: EHCI Exynos driver
[    1.859453] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.865480] ohci-pci: OHCI PCI platform driver
[    1.869894] ohci-platform: OHCI generic platform driver
[    1.875179] ohci-exynos: OHCI Exynos driver
[    1.879820] usbcore: registered new interface driver usb-storage
[    1.888415] i2c /dev entries driver
[    1.889925] VCC_3V3: supplied by VSYS_3V3
[    1.892652] pca953x 0-0020: using no AI
[    1.905395] sdhci: Secure Digital Host Controller Interface driver
[    1.906001] sdhci: Copyright(c) Pierre Ossman
[    1.911018] Synopsys Designware Multimedia Card Interface Driver
[    1.917648] VDDIO_AO1V8: supplied by VSYS_3V3
[    1.917794] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.917891] meson-gx-mmc ffe05000.sd: Got CD GPIO
[    1.918956] EMMC_AO1V8: supplied by VCC_3V3
[    1.919128] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.944551] ledtrig-cpu: registered to indicate activity on CPUs
[    1.947066] meson-sm: secure-monitor enabled
[    1.951732] usbcore: registered new interface driver usbhid
[    1.956145] usbhid: USB HID core driver
[    1.969608] NET: Registered protocol family 17
[    1.969774] 9pnet: Installing 9P2000 support
[    1.972695] Key type dns_resolver registered
[    1.977201] registered taskstats version 1
[    1.980947] Loading compiled-in X.509 certificates
[    2.000216] VCC_1V8: supplied by VCC_3V3
[    2.000292] VCC_5V: supplied by DC_IN
[    2.002727] USB_PWR: supplied by VCC_5V
[    2.012712] dwc3-meson-g12a ffe09000.usb: USB2 ports: 2
[    2.012746] dwc3-meson-g12a ffe09000.usb: USB3 ports: 1
[    2.021504] dwc2 ff400000.usb: supply vusb_d not found, using dummy regulator
[    2.024644] dwc2 ff400000.usb: supply vusb_a not found, using dummy regulator
[    2.031863] dwc2 ff400000.usb: EPs: 7, dedicated fifos, 712 entries in SPRAM
[    2.040745] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    2.044095] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
[    2.051767] xhci-hcd xhci-hcd.0.auto: hcc params 0x0228fe6c hci version 0x110 quirks 0x0000000000010010
[    2.061004] xhci-hcd xhci-hcd.0.auto: irq 38, io mem 0xff500000
[    2.067504] hub 1-0:1.0: USB hub found
[    2.070555] hub 1-0:1.0: 2 ports detected
[    2.074792] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    2.079939] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
[    2.087528] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    2.094033] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.102426] hub 2-0:1.0: USB hub found
[    2.105742] hub 2-0:1.0: 1 port detected
[    2.108013] mmc2: new HS200 MMC card at address 0001
[    2.115194] mmcblk2: mmc2:0001 AJTD4R 14.6 GiB 
[    2.119317] mmcblk2boot0: mmc2:0001 AJTD4R partition 1 4.00 MiB
[    2.123008] ALSA device list:
[    2.125139] mmcblk2boot1: mmc2:0001 AJTD4R partition 2 4.00 MiB
[    2.127825]   No soundcards found.
[    2.133841] mmcblk2rpmb: mmc2:0001 AJTD4R partition 3 4.00 MiB, chardev (234:0)
[    2.139106] Freeing unused kernel memory: 5952K
[    2.147508]  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
[    2.161599] Run /init as init process

# PYBOOT: kernel: finished booting, starting userspace.
[    2.216689] udevd[147]: starting version 3.2.9
[    2.217441] random: udevd: uninitialized urandom read (16 bytes read)
[    2.222071] random: udevd: uninitialized urandom read (16 bytes read)
[    2.228339] random: udevd: uninitialized urandom read (16 bytes read)
[    2.239835] udevd[148]: starting eudev-3.2.9
[    2.409604] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    2.413745] input: adc-keys as /devices/platform/adc-keys/input/input0
[    2.581472] meson-drm ff900000.vpu: Queued 2 outputs on vpu
[    2.598429] panfrost ffe40000.gpu: clock rate = 24000000
[    2.598539] panfrost ffe40000.gpu: dev_pm_opp_set_regulators: no regulator (mali) found: -19
[    2.606298] hub 1-1:1.0: USB hub found
[    2.610299] hub 1-1:1.0: 4 ports detected
[    2.625166] meson-gpio-intc ffd0f080.interrupt-controller: 100 to 8 gpio interrupt mux initialized
[    2.630500] panfrost ffe40000.gpu: [drm:panfrost_devfreq_init [panfrost]] Failed to register cooling device
[    2.666788] meson-vrtc ff8000a8.rtc: registered as rtc0
[    2.666861] meson-vrtc ff8000a8.rtc: setting system clock to 1970-01-01T00:00:02 UTC (2)
[    2.675628] panfrost ffe40000.gpu: mali-g31 id 0x7093 major 0x0 minor 0x0 status 0x0
[    2.683070] panfrost ffe40000.gpu: features: 00000000,3fde77ff, issues: 00000000,00000400
[    2.690275] panfrost ffe40000.gpu: Features: L2:0x07100206 Shader:0x00000000 Tiler:0x00000209 Mem:0x1 MMU:0x00002821 AS:0xff JS:0x7
[    2.701558] Registered IR keymap rc-khadas
[    2.703102] panfrost ffe40000.gpu: shader_present=0x1 l2_present=0x1
[    2.711210] VDDCPU: supplied by regulator-dummy
[    2.719518] meson8b-dwmac ff3f0000.ethernet: IRQ eth_wake_irq not found
[    2.723383] meson8b-dwmac ff3f0000.ethernet: IRQ eth_lpi not found
[    2.729680] meson8b-dwmac ff3f0000.ethernet: PTP uses main clock
[    2.736803] meson8b-dwmac ff3f0000.ethernet: no reset control found
[    2.745604] rc_core: Loaded IR protocol module ir-nec-decoder, but protocol nec still not available
[    2.745634] meson8b-dwmac ff3f0000.ethernet: User ID: 0x11, Synopsys ID: 0x37
[    2.749990] [drm] Initialized panfrost 1.1.0 20180908 for ffe40000.gpu on minor 0
[    2.750670] rc rc0: meson-ir as /devices/platform/soc/ff800000.bus/ff808000.ir/rc/rc0
[    2.757652] meson8b-dwmac ff3f0000.ethernet: DWMAC1000
[    2.757665] meson8b-dwmac ff3f0000.ethernet: DMA HW capability register supported
[    2.761805] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    2.766764] input: meson-ir as /devices/platform/soc/ff800000.bus/ff808000.ir/rc/rc0/input1
[    2.772832] meson8b-dwmac ff3f0000.ethernet: RX Checksum Offload Engine supported
[    2.772837] meson8b-dwmac ff3f0000.ethernet: COE Type 2
[    2.772839] meson8b-dwmac ff3f0000.ethernet: TX Checksum insertion supported
[    2.772841] meson8b-dwmac ff3f0000.ethernet: Wake-Up On Lan supported
[    2.772919] meson8b-dwmac ff3f0000.ethernet: Normal descriptors
[    2.778444] meson-ir ff808000.ir: receiver initialized
[    2.785580] meson8b-dwmac ff3f0000.ethernet: Ring mode enabled
[    2.812678] meson-drm ff900000.vpu: CVBS Output connector not available
[    2.818802] meson8b-dwmac ff3f0000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    2.855700] meson-dw-hdmi ff600000.hdmi-tx: Detected HDMI TX controller v2.01a with HDCP (meson_dw_hdmi_phy)
[    2.856686] libphy: stmmac: probed
[    2.869708] meson-dw-hdmi ff600000.hdmi-tx: registered DesignWare HDMI I2C bus driver
[    2.874474] libphy: mdio_mux: probed
[    2.880010] mmc0: queuing unknown CIS tuple 0x80 (2 bytes)
[    2.888353] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.893796] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.895356] meson-drm ff900000.vpu: bound ff600000.hdmi-tx (ops meson_dw_hdmi_ops [meson_dw_hdmi])
[    2.900810] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
[    2.906819] random: fast init done
[    2.907668] [drm] Initialized meson 1.0.0 20161109 for ff900000.vpu on minor 1
[    2.924169] libphy: mdio_mux: probed
[    2.927005] mmc0: queuing unknown CIS tuple 0x81 (9 bytes)
[    2.929560] usb 1-1.1: new full-speed USB device number 3 using xhci-hcd
[    2.979412] Bluetooth: Core ver 2.22
[    2.979529] NET: Registered protocol family 31
[    2.983502] Bluetooth: HCI device and connection manager initialized
[    2.988240] Bluetooth: HCI socket layer initialized
[    2.993054] Bluetooth: L2CAP socket layer initialized
[    2.998047] Bluetooth: SCO socket layer initialized
[    3.008102] Bluetooth: HCI UART driver ver 2.3
[    3.008132] Bluetooth: HCI UART protocol H4 registered
[    3.012496] Bluetooth: HCI UART protocol LL registered
[    3.018922] hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
[    3.025093] hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
[    3.032499] Bluetooth: HCI UART protocol Broadcom registered
[    3.037844] Bluetooth: HCI UART protocol QCA registered
[    3.056314] mmc0: new high speed SDIO card at address 0001
[    3.066154] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.084925] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.085036] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    3.085040] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[    3.095498] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4359-sdio for chip BCM4359/9
[    3.095673] brcmfmac mmc0:0001:1: Direct firmware load for brcm/brcmfmac4359-sdio.bin failed with error -2
[    3.095678] brcmfmac mmc0:0001:1: Falling back to sysfs fallback for: brcm/brcmfmac4359-sdio.bin
[    3.152665] input: Logitech USB Receiver as /devices/platform/soc/ffe09000.usb/ff500000.usb/xhci-hcd.0.auto/usb1/1-1/1-1.1/1-1.1:1.0/0003:046D:C534.0001/input/input2
[    3.210334] hid-generic 0003:046D:C534.0001: input: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-xhci-hcd.0.auto-1.1/input0
[    3.210422] Console: switching to colour frame buffer device 480x135
[    3.217382] input: Logitech USB Receiver Mouse as /devices/platform/soc/ffe09000.usb/ff500000.usb/xhci-hcd.0.auto/usb1/1-1/1-1.1/1-1.1:1.1/0003:046D:C534.0002/input/input3
[    3.218050] input: Logitech USB Receiver Consumer Control as /devices/platform/soc/ffe09000.usb/ff500000.usb/xhci-hcd.0.auto/usb1/1-1/1-1.1/1-1.1:1.1/0003:046D:C534.0002/input/input4
[    3.278033] input: Logitech USB Receiver System Control as /devices/platform/soc/ffe09000.usb/ff500000.usb/xhci-hcd.0.auto/usb1/1-1/1-1.1/1-1.1:1.1/0003:046D:C534.0002/input/input5
[    3.279153] hid-generic 0003:046D:C534.0002: input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-xhci-hcd.0.auto-1.1/input1
[    3.394143] Bluetooth: hci0: BCM: chip id 121
[    3.404246] meson-drm ff900000.vpu: [drm] fb0: mesondrmfb frame buffer device
[    3.416359] Bluetooth: hci0: BCM: features 0x0e
[    3.499719] Bluetooth: hci0: BCM4359C0
[    3.500759] Bluetooth: hci0: BCM4359C0 (003.001.006) build 0000
[    3.520060] axg-sound-card sound: ASoC: no DMI vendor name!
[    3.534874] urandom_read: 3 callbacks suppressed
[    3.534881] random: dd: uninitialized urandom read (512 bytes read)
[    3.577752] random: dropbear: uninitialized urandom read (32 bytes read)
[    3.596038] NET: Registered protocol family 10
[    3.596774] Segment Routing with IPv6
/bin/sh: can't access tty; job control turned off
/ # 
# PYBOOT: userspace: at root shell
cat /proc/cmdline
cat /proc/cmdline
console=ttyAML0,115200
/ # uname -r
uname -r
5.10.0-rc1-00002-g4b28e5bd6b6a
/ # cat /proc/cpuinfo
cat /proc/cpuinfo
processor: 0
BogoMIPS: 48.00
Features: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer: 0x41
CPU architecture: 8
CPU variant: 0x1
CPU part: 0xd05
CPU revision: 0

processor: 1
BogoMIPS: 48.00
Features: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer: 0x41
CPU architecture: 8
CPU variant: 0x1
CPU part: 0xd05
CPU revision: 0

processor: 2
BogoMIPS: 48.00
Features: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer: 0x41
CPU architecture: 8
CPU variant: 0x1
CPU part: 0xd05
CPU revision: 0

processor: 3
BogoMIPS: 48.00
Features: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer: 0x41
CPU architecture: 8
CPU variant: 0x1
CPU part: 0xd05
CPU revision: 0

/ # lsmod
lsmod
Module                  Size  Used by    Not tainted
ipv6                  438272 18 [permanent]
snd_soc_hdmi_codec     16384  1 
dw_hdmi_i2s_audio      16384  0 
dw_hdmi_cec            16384  0 
brcmfmac              245760  1 
brcmutil               20480  1 brcmfmac
cfg80211              364544  2 brcmfmac
hci_uart               77824  0 
btqca                  16384  1 hci_uart
btbcm                  24576  1 hci_uart
bluetooth             397312  4 hci_uart,btqca,btbcm
ecdh_generic           16384  1 bluetooth
snd_soc_meson_axg_frddr    36864  3 
ecc                    32768  1 ecdh_generic
rfkill                 36864  2 cfg80211,bluetooth
meson_gxl              16384  0 
snd_soc_meson_g12a_tohdmitx    20480  1 
realtek                20480  0 
snd_soc_meson_codec_glue    16384  1 snd_soc_meson_g12a_tohdmitx
meson_rng              16384  0 
axg_audio              77824 13 
dwmac_generic          16384  0 
reset_meson_audio_arb    16384  3 
snd_soc_meson_axg_fifo    16384  1 snd_soc_meson_axg_frddr
snd_soc_meson_axg_tdmout    24576  1 
rng_core               24576  1 meson_rng
meson_dw_hdmi          20480  0 
dw_hdmi                45056  2 dw_hdmi_i2s_audio,meson_dw_hdmi
sclk_div               16384  1 axg_audio
clk_phase              16384  1 axg_audio
mdio_mux_meson_g12a    16384  0 
cec                    57344  2 dw_hdmi_cec,dw_hdmi
dwmac_meson8b          16384  0 
stmmac_platform        20480  2 dwmac_generic,dwmac_meson8b
pwm_meson              16384  2 
stmmac                184320  3 dwmac_generic,dwmac_meson8b,stmmac_platform
rc_khadas              16384  0 
meson_ir               16384  0 
rc_core                40960  3 rc_khadas,meson_ir
rtc_meson_vrtc         16384  1 
irq_meson_gpio         20480  0 
pcs_xpcs               20480  1 stmmac
panfrost               61440  0 
meson_drm              61440  1 meson_dw_hdmi
gpu_sched              32768  1 panfrost
meson_canvas           16384  1 meson_drm
drm_kms_helper        241664  5 meson_dw_hdmi,dw_hdmi,meson_drm
snd_soc_meson_axg_sound_card    16384  0 
snd_soc_meson_card_utils    16384  1 snd_soc_meson_axg_sound_card
crct10dif_ce           20480  1 
display_connector      16384  0 
snd_soc_meson_axg_tdm_interface    16384  2 snd_soc_meson_axg_sound_card
drm                   565248  8 meson_dw_hdmi,dw_hdmi,panfrost,meson_drm,gpu_sched,drm_kms_helper,display_connector
snd_soc_meson_axg_tdm_formatter    16384  2 snd_soc_meson_axg_tdmout,snd_soc_meson_axg_tdm_interface
nvmem_meson_efuse      16384  0 
adc_keys               16384  0 
/ # ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
    link/ether 3a:62:88:b7:d1:2c brd ff:ff:ff:ff:ff:ff
/ # udhcpc
udhcpc: started, v1.31.1
[    8.576234] meson8b-dwmac ff3f0000.ethernet eth0: PHY [0.0:00] driver [RTL8211F Gigabit Ethernet] (irq=39)
[    8.589563] meson8b-dwmac ff3f0000.ethernet eth0: No Safety Features support found
[    8.591492] meson8b-dwmac ff3f0000.ethernet eth0: PTP not supported by HW
[    8.598574] meson8b-dwmac ff3f0000.ethernet eth0: configuring for phy/rgmii link mode
udhcpc: sending discover
[   11.200356] meson8b-dwmac ff3f0000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
[   11.203516] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
udhcpc: sending discover
udhcpc: sending select for 192.168.0.143
udhcpc: lease of 192.168.0.143 obtained, lease time 86400
deleting routers
adding dns 192.168.0.254
adding dns 192.168.0.254
