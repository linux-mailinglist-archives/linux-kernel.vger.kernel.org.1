Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D391A2C268F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbgKXMue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387452AbgKXMud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:50:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96399C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:50:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 10so2320563wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:mime-version;
        bh=BMZeQI0OohALho3eO19F0j+gqhy5MHPcMjXpauI+d+I=;
        b=SESuRTRFsVbh0poOCh6zxmLCyYfbaBL+4jVYVTmlS6OsWpEzgDQuYX2Iq6btlhPPRQ
         X++HsFcA0rKwkI346aFIjoQ8tpjAuEAsmOdLlx5vXEr9OunjywQf2Xsw6fywUIuVuuWa
         syRHRAQvEp0k1iQU1hJWHEFsOis6C9GiXAEr3Dfp4GNGyYsC85Yp1i7Z4DnCIypSjoKe
         VHje63wNuNrjfdtO19SPbml5TZjZg6HS6C8tuvNZ7TeekkFkUHD3peb5szwxwCCb44kJ
         04mFbqVGinl0nf5k5pll5x2AheuMIN8SQz7AflaVKSXy7kG1b+Yh7enUsHd8lnsU1Yjk
         LW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:mime-version;
        bh=BMZeQI0OohALho3eO19F0j+gqhy5MHPcMjXpauI+d+I=;
        b=GfBa7HgVpwpdxjLWtz+DZpVxjpNydh7s5hV6JJUjg/CuCtgAqpwnj6dfR+CXDmjg9G
         yj+jzb3H1E4I0bVYEQUYJGNW3Po+drskyGW6Vd8s6QYJruzfAlbWemWY5i0bMuUKHYXa
         ZcFRtBQKyJjZysXTEwffdJ57NpwW5k4cg7sSbxVPBfoDhm20WKgdeJnUGpPxdZ1MVeLe
         +ROJBPzWItzls8NTBjxxLhFO+Qt7RENkFs+uAtuXtmRBOJnpqX+te8V0HKlv9uK8P8Cg
         AGaECs7iRb9LPQ03VnIaozMIvgA++A//ZhtTZJf7ndZVCEyQ6HvP0tIjVJiZXTSM8rHg
         e/Kw==
X-Gm-Message-State: AOAM533/FUZYvvNzE0VnOJ8R+y2eK6z/07rCGa4T2p6z+C2OsLo7YIQU
        Bl8CgHlOU+6KGHJh0QTBfSo=
X-Google-Smtp-Source: ABdhPJydWhgfZ+S7i/maUk7eqKbh0xczL80KSM9voDcX2S5uWREWd/ze16jMyZkMCMX3OkVvbpfhpQ==
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr4372213wml.138.1606222231245;
        Tue, 24 Nov 2020 04:50:31 -0800 (PST)
Received: from [192.168.1.12] (a89-155-154-90.cpe.netcabo.pt. [89.155.154.90])
        by smtp.gmail.com with ESMTPSA id u81sm5751534wmb.27.2020.11.24.04.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 04:50:30 -0800 (PST)
Date:   Tue, 24 Nov 2020 12:50:23 +0000
From:   Manuel Reis <mluis.reis@gmail.com>
Subject: ARM.STM32 - Mainline stable kernel 5.9.10 hangs indefinitely on a
 STM32MP157A-DK1 board.
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-kernel@vger.kernel.org,
        Michael Opdenacker <michael.opdenacker@bootlin.com>
Message-Id: <ZZWAKQ.K8IZKPD4L3Z9@gmail.com>
X-Mailer: geary/3.38.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-olZfZSDlhivxz0/Q0p0/"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-olZfZSDlhivxz0/Q0p0/
Content-Type: text/plain; charset=us-ascii; format=flowed

To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:	linux-kernel@vger.kernel.org
CC:	Michael Opdenacker <michael.opdenacker@bootlin.com>

Hi there,

Mainline stable kernel 5.9.10 hangs indefinitely on a STM32MP157A-DK1 
Discovery Kit board.

Built plain vanilla 5.9.10 stable kernel for multi_v7_defconfig (set 
compression to XZ) using arm-linux-gnueabi-gcc (Ubuntu 10.2.0-8ubuntu1) 
10.2.0.

Downloaded it to the board memory via tftp running U-Boot v2020.07. 
After boot, kernel initiates and prints several messages until it hangs 
on:

[ 2.692879] stpmic1 1-0033: PMIC Chip Version: 0x10
[ 2.704158] vddcore: supplied by regulator-dummy
[ 2.710304] vdd_ddr: supplied by regulator-dummy
[ 2.716414] vdd: supplied by regulator-dummy
[ 2.722355] v3v3: supplied by regulator-dummy
[ 2.728033] v1v8_audio: supplied by v3v3
[ 2.734287] v3v3_hdmi: supplied by regulator-dummy
[ 2.741035] vtt_ddr: supplied by vdd_ddr
[ 2.743833] vdd_usb: supplied by regulator-dummy
[ 2.751332] vdda: supplied by regulator-dummy
[ 2.757371] v1v2_hdmi: supplied by v3v3

No other information or indication is given, even though I added kernel 
debugging features such as the ones in "Kernel hacking ->Debug Oops, 
Lockups and Hangs".

Any help would be appreciated. Let me know if I can provide any further 
information.

Cheers,
Manuel


--=-olZfZSDlhivxz0/Q0p0/
Content-Type: text/plain
Content-Disposition: attachment; filename=kernelLog

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.9.10 (mreis@laptop) (arm-linux-gnueabi-gcc (Ubuntu 10.2.0-8ubuntu1) 10.2.0, GNU ld (GNU Binutils for Ubuntu) 2.35.1) #1 SMP Tue Nov 24 12:10:02 WET 2020
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: STMicroelectronics STM32MP157A-DK1 Discovery Board
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at 0x10000000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node mcuram2@10000000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x10040000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node vdev0vring0@10040000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x10041000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node vdev0vring1@10041000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x10042000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node vdev0buffer@10042000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x30000000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node mcuram@30000000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x38000000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node retram@38000000, compatible id shared-dma-pool
[    0.000000] cma: Reserved 64 MiB at 0xdc000000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000c0000000-0x00000000dfffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000c0000000-0x00000000d3ffffff]
[    0.000000]   node   0: [mem 0x00000000d8000000-0x00000000dfffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000c0000000-0x00000000dfffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 20 pages/cpu s49548 r8192 d24180 u81920
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 113664
[    0.000000] Kernel command line: console=ttySTM0,115200 earlyprintk
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 364956K/458752K available (13312K kernel code, 1802K rwdata, 5472K rodata, 2048K init, 406K bss, 28260K reserved, 65536K cma-reserved, 0K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=2.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] random: get_random_bytes called from start_kernel+0x388/0x53c with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000009] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000025] Switching to timer-based delay loop, resolution 41ns
[    0.011495] Console: colour dummy device 80x30
[    0.011561] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.011579] pid_max: default: 32768 minimum: 301
[    0.011802] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.011821] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.012784] CPU: Testing write buffer coherency: ok
[    0.013148] CPU0: update cpu_capacity 1024
[    0.013167] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.013927] Setting up static identity map for 0xc0300000 - 0xc03000ac
[    0.017165] rcu: Hierarchical SRCU implementation.
[    0.024291] EFI services will not be available.
[    0.024806] smp: Bringing up secondary CPUs ...
[    0.025520] CPU1: update cpu_capacity 1024
[    0.025531] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.025710] smp: Brought up 1 node, 2 CPUs
[    0.025735] SMP: Total of 2 processors activated (96.00 BogoMIPS).
[    0.025744] CPU: All CPU(s) started in SVC mode.
[    0.026449] devtmpfs: initialized
[    0.044385] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
[    0.044740] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.044774] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.047892] pinctrl core: initialized pinctrl subsystem
[    0.051105] DMI not present or invalid.
[    0.051695] NET: Registered protocol family 16
[    0.054502] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.058717] thermal_sys: Registered thermal governor 'step_wise'
[    0.059064] cpuidle: using governor menu
[    0.059288] No ATAGs?
[    0.059418] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.059430] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.064585] Serial: AMBA PL011 UART driver
[    0.105514] /soc/interrupt-controller@5000d000: bank0
[    0.105541] /soc/interrupt-controller@5000d000: bank1
[    0.105557] /soc/interrupt-controller@5000d000: bank2
[    0.109918] stm32mp157-pinctrl soc:pin-controller@50002000: GPIOA bank added
[    0.110329] stm32mp157-pinctrl soc:pin-controller@50002000: GPIOB bank added
[    0.110675] stm32mp157-pinctrl soc:pin-controller@50002000: GPIOC bank added
[    0.110997] stm32mp157-pinctrl soc:pin-controller@50002000: GPIOD bank added
[    0.111337] stm32mp157-pinctrl soc:pin-controller@50002000: GPIOE bank added
[    0.111646] stm32mp157-pinctrl soc:pin-controller@50002000: GPIOF bank added
[    0.111968] stm32mp157-pinctrl soc:pin-controller@50002000: GPIOG bank added
[    0.112377] stm32mp157-pinctrl soc:pin-controller@50002000: GPIOH bank added
[    0.112726] stm32mp157-pinctrl soc:pin-controller@50002000: GPIOI bank added
[    0.112878] stm32mp157-pinctrl soc:pin-controller@50002000: Pinctrl STM32 initialized
[    0.114154] stm32mp157-pinctrl soc:pin-controller-z@54004000: GPIOZ bank added
[    0.114180] stm32mp157-pinctrl soc:pin-controller-z@54004000: Pinctrl STM32 initialized
[    0.137591] AT91: Could not find identification node
[    0.139938] iommu: Default domain type: Translated 
[    0.140333] vgaarb: loaded
[    0.141404] SCSI subsystem initialized
[    0.142138] usbcore: registered new interface driver usbfs
[    0.142211] usbcore: registered new interface driver hub
[    0.142300] usbcore: registered new device driver usb
[    0.143783] pps_core: LinuxPPS API ver. 1 registered
[    0.143801] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.143830] PTP clock support registered
[    0.147205] clocksource: Switched to clocksource arch_sys_counter
[    1.481312] NET: Registered protocol family 2
[    1.482203] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
[    1.482247] TCP established hash table entries: 4096 (order: 2, 16384 bytes, linear)
[    1.482311] TCP bind hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    1.482405] TCP: Hash tables configured (established 4096 bind 4096)
[    1.482543] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[    1.482588] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
[    1.482805] NET: Registered protocol family 1
[    1.483584] RPC: Registered named UNIX socket transport module.
[    1.483605] RPC: Registered udp transport module.
[    1.483614] RPC: Registered tcp transport module.
[    1.483622] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.483638] PCI: CLS 0 bytes, default 64
[    1.485709] Initialise system trusted keyrings
[    1.486051] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    1.494618] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.495725] NFS: Registering the id_resolver key type
[    1.495772] Key type id_resolver registered
[    1.495782] Key type id_legacy registered
[    1.495927] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.495979] ntfs: driver 2.1.32 [Flags: R/O].
[    1.496581] Key type asymmetric registered
[    1.496598] Asymmetric key parser 'x509' registered
[    1.496658] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    1.496671] io scheduler mq-deadline registered
[    1.496681] io scheduler kyber registered
[    1.594338] Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
[    1.599094] SuperH (H)SCI(F) driver initialized
[    1.600056] msm_serial: driver initialized
[    1.600255] STMicroelectronics ASC driver initialized
[    1.602268] STM32 USART driver initialized
[    1.602896] 40010000.serial: ttySTM0 at MMIO 0x40010000 (irq = 21, base_baud = 4000000) is a stm32-usart
[    2.469899] printk: console [ttySTM0] enabled
[    2.474856] stm32-usart 40010000.serial: rx dma alloc failed
[    2.479932] stm32-usart 40010000.serial: interrupt mode used for rx (no dma)
[    2.486943] stm32-usart 40010000.serial: tx dma alloc failed
[    2.492642] stm32-usart 40010000.serial: interrupt mode used for tx (no dma)
[    2.524704] random: fast init done
[    2.529887] random: crng init done
[    2.592525] brd: module loaded
[    2.605028] loop: module loaded
[    2.618466] libphy: Fixed MDIO Bus: probed
[    2.622875] CAN device driver interface
[    2.626262] bgmac_bcma: Broadcom 47xx GBit MAC driver loaded
[    2.632114] e1000e: Intel(R) PRO/1000 Network Driver
[    2.635871] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.641967] igb: Intel(R) Gigabit Ethernet Network Driver
[    2.647248] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.656402] stm32-dwmac 5800a000.ethernet: IRQ eth_wake_irq not found
[    2.661435] stm32-dwmac 5800a000.ethernet: IRQ eth_lpi not found
[    2.667600] stm32-dwmac 5800a000.ethernet: PTP uses main clock
[    2.673244] stm32-dwmac 5800a000.ethernet: no reset control found
[    2.680029] stm32-dwmac 5800a000.ethernet: User ID: 0x40, Synopsys ID: 0x42
[    2.686314] stm32-dwmac 5800a000.ethernet: 	DWMAC4/5
[    2.691366] stm32-dwmac 5800a000.ethernet: DMA HW capability register supported
[    2.698640] stm32-dwmac 5800a000.ethernet: RX Checksum Offload Engine supported
[    2.705906] stm32-dwmac 5800a000.ethernet: TX Checksum insertion supported
[    2.712816] stm32-dwmac 5800a000.ethernet: Wake-Up On Lan supported
[    2.719199] stm32-dwmac 5800a000.ethernet: TSO supported
[    2.724374] stm32-dwmac 5800a000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    2.732246] stm32-dwmac 5800a000.ethernet: Enabled Flow TC (entries=2)
[    2.738766] stm32-dwmac 5800a000.ethernet: TSO feature enabled
[    2.744586] stm32-dwmac 5800a000.ethernet: Using 32 bits DMA width
[    2.752132] libphy: stmmac: probed
[    2.759820] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[    2.765846] usbcore: registered new interface driver pegasus
[    2.771573] usbcore: registered new interface driver asix
[    2.776890] usbcore: registered new interface driver ax88179_178a
[    2.783022] usbcore: registered new interface driver cdc_ether
[    2.788847] usbcore: registered new interface driver smsc75xx
[    2.794568] usbcore: registered new interface driver smsc95xx
[    2.800326] usbcore: registered new interface driver net1080
[    2.805964] usbcore: registered new interface driver cdc_subset
[    2.811916] usbcore: registered new interface driver zaurus
[    2.817522] usbcore: registered new interface driver cdc_ncm
[    2.826164] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.831315] ehci-pci: EHCI PCI platform driver
[    2.835749] ehci-platform: EHCI generic platform driver
[    2.841474] ehci-orion: EHCI orion driver
[    2.845125] SPEAr-ehci: EHCI SPEAr driver
[    2.849160] ehci-st: EHCI STMicroelectronics driver
[    2.853961] ehci-exynos: EHCI Exynos driver
[    2.858169] ehci-atmel: EHCI Atmel driver
[    2.862125] tegra-ehci: Tegra EHCI driver
[    2.866147] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.872245] ohci-pci: OHCI PCI platform driver
[    2.876700] ohci-platform: OHCI generic platform driver
[    2.882095] SPEAr-ohci: OHCI SPEAr driver
[    2.886027] ohci-st: OHCI STMicroelectronics driver
[    2.890960] ohci-atmel: OHCI Atmel driver
[    2.895562] usbcore: registered new interface driver usb-storage
[    2.906079] stm32_rtc 5c004000.rtc: IRQ index 1 not found
[    2.910080] stm32_rtc 5c004000.rtc: alarm can't wake up the system: -6
[    2.917524] stm32_rtc 5c004000.rtc: registered as rtc0
[    2.921743] stm32_rtc 5c004000.rtc: setting system clock to 2000-01-01T00:30:14 UTC (946686614)
[    2.930747] stm32_rtc 5c004000.rtc: Date/Time must be initialized
[    2.936509] stm32_rtc 5c004000.rtc: registered rev:1.2
[    2.943192] i2c /dev entries driver
[    2.967080] stm32f7-i2c 40012000.i2c: can't request DMA tx channel
[    2.971833] stm32f7-i2c 40012000.i2c: can't use DMA
[    2.979849] stm32f7-i2c 40012000.i2c: STM32F7 I2C-0 bus adapter
[    3.007340] stm32f7-i2c 5c002000.i2c: can't request DMA tx channel
[    3.012072] stm32f7-i2c 5c002000.i2c: can't use DMA
[    3.019489] stpmic1 1-0033: PMIC Chip Version: 0x10
[    3.030755] vddcore: supplied by regulator-dummy
[    3.036874] vdd_ddr: supplied by regulator-dummy
[    3.043110] vdd: supplied by regulator-dummy
[    3.049006] v3v3: supplied by regulator-dummy
[    3.054723] v1v8_audio: supplied by v3v3
[    3.060968] v3v3_hdmi: supplied by regulator-dummy
[    3.067706] vtt_ddr: supplied by vdd_ddr
[    3.070483] vdd_usb: supplied by regulator-dummy
[    3.077990] vdda: supplied by regulator-dummy
[    3.084068] v1v2_hdmi: supplied by v3v3



--=-olZfZSDlhivxz0/Q0p0/--

