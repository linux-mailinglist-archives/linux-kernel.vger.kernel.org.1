Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEDE30012A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbhAVLGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:06:11 -0500
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:9611
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726981AbhAVKwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:52:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEDyNWEqartUv9g41cJ6X5NPyMMspmGXPS5TkjVvPgRAAvAAzXUJb4+LZri25zT3PMaIjVoyksDE/JFTbeULwIxJHxJm6CC4hrluP4bS+uGmITs3DKeyR3NU3R12ZDGrT6kE3F91D6cCqE29wA9KuBi6SyMcfA3agonffH2bngYkGuafN16Pgnx/btlUh/5mYY8c61KYzoDHHbRg6bnU+RthkVOX5Wdqilcj6h/x3kK11kfSY9y7KBMyptthlDdk2Gzg6EClxliTFdfQbms2U7M4OQIVBSOZiSyhflG1hCV9I37TFDpHzaMmdebz3u5lkz/lj8yrxb24uCPP8K3D2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU9cgtb8caUGBfJes0z4D+cpNNE+gFugtx+nrPLzrzs=;
 b=W7LN9CSjzyUnTY1T/kGj4CL3heT6ZixXgHQLsF6HLnDFVTYCi9ZLo04QcZ+MPFLFbV6KF8teqx43y3NbVsdXEpOeRmJ4/nl+PQmn6TxVAPusbR4CyQvjEcLY2LcoAEdObajbbiuywxHeNIX4xnMz7CjS6iQA3KsqUI8xHPyDgjggHogZvodUFOJRdKtCaTh00BSlIkzNkLpOv8Yt6IcPfWZSVvNPUwFQvdz/m/pAe7ks+8gfYPjygL2mVzmPSELIE5xH4RfAx6vHCeNLSpE3ykGhO+JWoILCjHwGdm4Z4+RpCAjr2EA1xlqgkRBXIXZYFkiD6uuYUX+/YIlM1BPepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU9cgtb8caUGBfJes0z4D+cpNNE+gFugtx+nrPLzrzs=;
 b=E5bvaeEitpwrEyrbfzFOrRfM2UM13KOtQ4Mm8QsNlyunokUVTA0IKCb3K0G84T0B0f/zEjTDEI+v5GLISlpdjCgC2OBmXyU1Dpv1tj+/2A3a7/hJnSxVNJh/tvUOYwKAqJ5u2OvfCmqIbEZlWPpTsISZ8+/+YXaz+5XjoT3URqg=
Received: from BL1PR13CA0296.namprd13.prod.outlook.com (2603:10b6:208:2bc::31)
 by BL0PR02MB4722.namprd02.prod.outlook.com (2603:10b6:208:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Fri, 22 Jan
 2021 10:51:49 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2bc:cafe::e) by BL1PR13CA0296.outlook.office365.com
 (2603:10b6:208:2bc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend
 Transport; Fri, 22 Jan 2021 10:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 10:51:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 22 Jan 2021 02:51:48 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 22 Jan 2021 02:51:48 -0800
Envelope-to: michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 clabbe.montjoie@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.71.117.86] (port=62592 helo=localhost)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <edgar@xilinx.com>)
        id 1l2u2d-0001x6-2j; Fri, 22 Jan 2021 02:51:48 -0800
Date:   Fri, 22 Jan 2021 11:51:53 +0100
From:   "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        <rajan.vaja@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Fail to boot qemu xlnx-zcu102 due to lot of drivers not probing
Message-ID: <20210122105153.GB10562@toto>
References: <YAqZt69Ahba4uubZ@Red>
 <80a6170f-7723-be6e-3ea5-ffd1a4bf8956@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <80a6170f-7723-be6e-3ea5-ffd1a4bf8956@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0678741-a855-4d79-4fbc-08d8bec3b841
X-MS-TrafficTypeDiagnostic: BL0PR02MB4722:
X-Microsoft-Antispam-PRVS: <BL0PR02MB472282D0ED40FC2677E9941EC2A00@BL0PR02MB4722.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++wLj9GhQLnDnDOTThrUNeMW/pBUOkIJFKXqzhOm8EWTa8LtvGTy84BNiA5o8e2t7jQfFdgX9iLT+qwngHpO9WLoT4NUc7rWZI3SlWhBF/jyD/nuXJaLia5Sf7pW3YiB3VdF6nGclEz6i3qSbJBcQQTt/sICmFR1+9vlaAhiTzusn5dlO8gMzQPiCsizAKJBIEhrHBiCWP9/rhbfUcceGoZHnMCoii4T5MmfEeI4mY2yBAn1hDP+RutRgCDtOjBVZ5ZapUC3q277K7PvUBjoi48bnq/Y3/qKIjCTpKxERtTCVlOz9rDVuiZD6uZdy+1u6ytCUMr5G94a2rwTDd2am7zZtrDSfesueAw7Xfvh3Z4vgdgTaQtMM9YW/oYGlTCkaIUA42TgxIH1sWKx0B9WMNOChofccrsvKS+Qa2FG88oLHOVgqUv7YvNtwLhKgVvAU7gm/cNNk69tQjaG8jnJ65ZKNrCEEzq7P/c8gUfo5bcq/fjEHF5J1Sdr8YfnhLY7JqOykVUSGkBZkEZ0xg9q1wXosfBsiCqHQ0VGG9B4ZFzbeVPxu5c9J4oA24IvyJIU
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(7916004)(396003)(346002)(136003)(376002)(39860400002)(46966006)(336012)(44144004)(478600001)(235185007)(6636002)(8936002)(82740400003)(4326008)(426003)(54906003)(186003)(53546011)(966005)(5660300002)(9786002)(9686003)(1076003)(82310400003)(316002)(70206006)(66616009)(70586007)(83380400001)(356005)(7636003)(30864003)(6862004)(47076005)(8676002)(26005)(33716001)(2906002)(21480400003)(6666004)(36906005)(33656002)(2700100001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 10:51:49.0694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0678741-a855-4d79-4fbc-08d8bec3b841
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4722
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5vNYLRcllDrimb99
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Jan 22, 2021 at 10:52:18AM +0100, Michal Simek wrote:
> Hi,
> 
> On 1/22/21 10:24 AM, Corentin Labbe wrote:
> > Hello
> > 
> > With at least qemu 5.1.0 (and later), the xlnx-zcu102 machine boot lead to a panic due to missing console.
> > qemu-system-aarch64 -kernel Image -nographic -machine xlnx-zcu102 -device ide-hd,drive=lavatest -serial mon:stdio -serial null -append 'earlycon=cdns,mmio,0xFF000000,115200n8 console=ttyPS0 root=/dev/ram0 ip=dhcp' -dtb zynqmp-zcu102-rev1.0.dtb -m 2048 -nic user,model=cadence_gem,mac=52:54:00:12:34:58 -drive format=qcow2,file=disk.img,if=none,id=lavatest -initrd rootfs.cpio.gz
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> > [    0.000000] Linux version 5.5.0-rc1-00004-g9c8a47b484ed (clabbe@arnold) (gcc version 7.5.0 (Linaro GCC 7.5-2019.12)) #17 SMP PREEMPT Fri Jan 22 09:19:31 UTC 2021
> > [    0.000000] Machine model: ZynqMP ZCU102 Rev1.0
> > [    0.000000] earlycon: cdns0 at MMIO 0x00000000ff000000 (options '115200n8')
> > [    0.000000] printk: bootconsole [cdns0] enabled
> > [    0.000000] efi: Getting EFI parameters from FDT:
> > [    0.000000] efi: UEFI not found.
> > [    0.000000] cma: Reserved 32 MiB at 0x000000007e000000
> > [    0.000000] NUMA: No NUMA configuration found
> > [    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x000000007fffffff]
> > [    0.000000] NUMA: NODE_DATA [mem 0x7dbe0100-0x7dbe1fff]
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000000000-0x000000003fffffff]
> > [    0.000000]   DMA32    [mem 0x0000000040000000-0x000000007fffffff]
> > [    0.000000]   Normal   empty
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
> > [    0.000000] psci: probing for conduit method from DT.
> > [    0.000000] psci: PSCIv0.2 detected in firmware.
> > [    0.000000] psci: Using standard PSCI v0.2 function IDs
> > [    0.000000] psci: Trusted OS migration not required
> > [    0.000000] percpu: Embedded 22 pages/cpu s53016 r8192 d28904 u90112
> > [    0.000000] Detected VIPT I-cache on CPU0
> > [    0.000000] CPU features: detected: ARM erratum 845719
> > [    0.000000] CPU features: detected: ARM erratum 843419
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 516096
> > [    0.000000] Policy zone: DMA32
> > [    0.000000] Kernel command line: earlycon=cdns,mmio,0xFF000000,115200n8 console=ttyPS0 root=/dev/ram0 ip=dhcp
> > [    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> > [    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> > [    0.000000] software IO TLB: mapped [mem 0x3bfff000-0x3ffff000] (64MB)
> > [    0.000000] Memory: 1907172K/2097152K available (12092K kernel code, 1896K rwdata, 6640K rodata, 5120K init, 456K bss, 157212K reserved, 32768K cma-reserved)
> > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> > [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> > [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
> > [    0.000000] 	Tasks RCU enabled.
> > [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> > [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> > [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> > [    0.000000] random: get_random_bytes called from start_kernel+0x2b8/0x454 with crng_init=0
> > [    0.000000] arch_timer: cp15 timer(s) running at 62.50MHz (virt).
> > [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
> > [    0.000118] sched_clock: 56 bits at 62MHz, resolution 16ns, wraps every 4398046511096ns
> > [    0.006458] Console: colour dummy device 80x25
> > [    0.008026] Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=250000)
> > [    0.008182] pid_max: default: 32768 minimum: 301
> > [    0.009157] LSM: Security Framework initializing
> > [    0.010014] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
> > [    0.010106] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
> > [    0.060263] ASID allocator initialised with 32768 entries
> > [    0.067849] rcu: Hierarchical SRCU implementation.
> > [    0.079370] EFI services will not be available.
> > [    0.088702] smp: Bringing up secondary CPUs ...
> > [    0.118904] Detected VIPT I-cache on CPU1
> > [    0.119921] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
> > [    0.156284] Detected VIPT I-cache on CPU2
> > [    0.156514] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
> > [    0.189310] Detected VIPT I-cache on CPU3
> > [    0.189472] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
> > [    0.189921] smp: Brought up 1 node, 4 CPUs
> > [    0.190504] SMP: Total of 4 processors activated.
> > [    0.190633] CPU features: detected: 32-bit EL0 Support
> > [    0.190817] CPU features: detected: CRC32 instructions
> > [    0.297754] CPU: All CPU(s) started at EL1
> > [    0.298034] alternatives: patching kernel code
> > [    0.313974] devtmpfs: initialized
> > [    0.331444] KASLR disabled due to lack of seed
> > [    0.334720] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> > [    0.334884] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
> > [    0.338030] pinctrl core: initialized pinctrl subsystem
> > [    0.346728] thermal_sys: Registered thermal governor 'step_wise'
> > [    0.346790] thermal_sys: Registered thermal governor 'power_allocator'
> > [    0.347676] DMI not present or invalid.
> > [    0.351563] NET: Registered protocol family 16
> > [    0.365080] DMA: preallocated 256 KiB pool for atomic allocations
> > [    0.365197] audit: initializing netlink subsys (disabled)
> > [    0.367450] audit: type=2000 audit(0.352:1): state=initialized audit_enabled=0 res=1
> > [    0.373249] cpuidle: using governor menu
> > [    0.374322] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
> > [    0.377901] Serial: AMBA PL011 UART driver
> > [    0.409786] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> > [    0.409852] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
> > [    0.409899] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> > [    0.409943] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
> > [    0.427753] cryptd: max_cpu_qlen set to 1000
> > [    0.451024] ACPI: Interpreter disabled.
> > [    0.455411] iommu: Default domain type: Translated 
> > [    0.460553] vgaarb: loaded
> > [    0.461653] SCSI subsystem initialized
> > [    0.463668] usbcore: registered new interface driver usbfs
> > [    0.464015] usbcore: registered new interface driver hub
> > [    0.464233] usbcore: registered new device driver usb
> > [    0.465642] pps_core: LinuxPPS API ver. 1 registered
> > [    0.465719] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> > [    0.465913] PTP clock support registered
> > [    0.466536] EDAC MC: Ver: 3.0.0
> > [    0.470918] FPGA manager framework
> > [    0.480307] clocksource: Switched to clocksource arch_sys_counter
> > [    0.481151] VFS: Disk quotas dquot_6.6.0
> > [    0.481303] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> > [    0.483302] pnp: PnP ACPI: disabled
> > [    0.499697] NET: Registered protocol family 2
> > [    0.503466] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
> > [    0.503600] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
> > [    0.503883] TCP bind hash table entries: 16384 (order: 6, 262144 bytes, linear)
> > [    0.504340] TCP: Hash tables configured (established 16384 bind 16384)
> > [    0.505760] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
> > [    0.505955] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
> > [    0.509700] NET: Registered protocol family 1
> > [    0.512672] RPC: Registered named UNIX socket transport module.
> > [    0.512748] RPC: Registered udp transport module.
> > [    0.512798] RPC: Registered tcp transport module.
> > [    0.512873] RPC: Registered tcp NFSv4.1 backchannel transport module.
> > [    0.513000] PCI: CLS 0 bytes, default 64
> > [    0.518640] Trying to unpack rootfs image as initramfs...
> > [    1.561069] Freeing initrd memory: 24492K
> > [    1.563539] hw perfevents: no interrupt-affinity property for /pmu, guessing.
> > [    1.566112] hw perfevents: enabled with armv8_pmuv3 PMU driver, 5 counters available
> > [    1.566604] kvm [1]: HYP mode not available
> > [    2.168380] Initialise system trusted keyrings
> > [    2.170604] workingset: timestamp_bits=44 max_order=19 bucket_order=0
> > [    2.182859] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> > [    2.185289] NFS: Registering the id_resolver key type
> > [    2.185516] Key type id_resolver registered
> > [    2.185568] Key type id_legacy registered
> > [    2.185735] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> > [    2.186423] 9p: Installing v9fs 9p2000 file system support
> > [    2.216137] Key type asymmetric registered
> > [    2.216526] Asymmetric key parser 'x509' registered
> > [    2.216938] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
> > [    2.217290] io scheduler mq-deadline registered
> > [    2.217490] io scheduler kyber registered
> > [    2.238034] EINJ: ACPI disabled.
> > [    2.256746] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > [    2.262019] SuperH (H)SCI(F) driver initialized
> > [    2.262788] msm_serial: driver initialized
> > [    2.266149] cacheinfo: Unable to detect cache hierarchy for CPU 0
> > [    2.290568] brd: module loaded
> > [    2.305751] loop: module loaded
> > [    2.314997] libphy: Fixed MDIO Bus: probed
> > [    2.315445] tun: Universal TUN/TAP device driver, 1.6
> > [    2.317611] macb ff0e0000.ethernet: failed to get macb_clk (-517)
> > [    2.318012] thunder_xcv, ver 1.0
> > [    2.318108] thunder_bgx, ver 1.0
> > [    2.318192] nicpf, ver 1.0
> > [    2.319004] hclge is initializing
> > [    2.319116] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
> > [    2.319168] hns3: Copyright (c) 2017 Huawei Corporation.
> > [    2.319475] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> > [    2.319522] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> > [    2.319625] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
> > [    2.319676] igb: Copyright (c) 2007-2014 Intel Corporation.
> > [    2.319784] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
> > [    2.319841] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> > [    2.320480] sky2: driver version 1.30
> > [    2.321671] VFIO - User Level meta-driver version: 0.3
> > [    2.324375] dwc3 fe200000.usb: Failed to get clk 'ref': -2
> > [    2.324580] dwc3 fe200000.usb: this is not a DesignWare USB3 DRD Core
> > [    2.326494] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> > [    2.326582] ehci-pci: EHCI PCI platform driver
> > [    2.326765] ehci-platform: EHCI generic platform driver
> > [    2.326969] ehci-orion: EHCI orion driver
> > [    2.327149] ehci-exynos: EHCI EXYNOS driver
> > [    2.327338] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> > [    2.327450] ohci-pci: OHCI PCI platform driver
> > [    2.327632] ohci-platform: OHCI generic platform driver
> > [    2.327841] ohci-exynos: OHCI EXYNOS driver
> > [    2.333183] i2c /dev entries driver
> > [    2.340433] CPUidle PSCI: Invalid PSCI power state 0x40000000
> > [    2.340503] CPUidle PSCI: CPU 0 failed to PSCI idle
> > [    2.341032] sdhci: Secure Digital Host Controller Interface driver
> > [    2.341081] sdhci: Copyright(c) Pierre Ossman
> > [    2.341664] Synopsys Designware Multimedia Card Interface Driver
> > [    2.342891] sdhci-pltfm: SDHCI platform and OF driver helper
> > [    2.344309] sdhci-arasan ff170000.mmc: clk_ahb clock not found.
> > [    2.347585] ledtrig-cpu: registered to indicate activity on CPUs
> > [    2.350355] usbcore: registered new interface driver usbhid
> > [    2.350408] usbhid: USB HID core driver
> > [    2.355763] NET: Registered protocol family 17
> > [    2.357107] 9pnet: Installing 9P2000 support
> > [    2.357402] Key type dns_resolver registered
> > [    2.358493] registered taskstats version 1
> > [    2.358570] Loading compiled-in X.509 certificates
> > [    2.366581] macb ff0e0000.ethernet: failed to get macb_clk (-517)
> > [    2.368578] sdhci-arasan ff170000.mmc: clk_ahb clock not found.
> > [    2.380780] macb ff0e0000.ethernet: failed to get macb_clk (-517)
> > [    2.382995] sdhci-arasan ff170000.mmc: clk_ahb clock not found.
> > [    2.387684] hctosys: unable to open rtc device (rtc0)
> > [   14.675537] Warning: unable to open an initial console.
> > [   14.696554] Freeing unused kernel memory: 5120K
> > [   14.697256] Run /init as init process
> > [   14.757187] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100
> > [   14.757393] CPU: 0 PID: 1 Comm: init Not tainted 5.5.0-rc1-00004-g9c8a47b484ed #17
> > [   14.757452] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> > [   14.757660] Call trace:
> > [   14.757705]  dump_backtrace+0x0/0x1a0
> > [   14.757790]  show_stack+0x14/0x20
> > [   14.757827]  dump_stack+0xbc/0x104
> > [   14.757855]  panic+0x16c/0x37c
> > [   14.757880]  do_exit+0x97c/0x980
> > [   14.757905]  do_group_exit+0x44/0xa0
> > [   14.757932]  __arm64_sys_exit_group+0x14/0x18
> > [   14.757968]  el0_svc_common.constprop.2+0x64/0x160
> > [   14.758002]  el0_svc_handler+0x20/0x80
> > [   14.758029]  el0_sync_handler+0xe4/0x188
> > [   14.758057]  el0_sync+0x140/0x180
> > [   14.758265] SMP: stopping secondary CPUs
> > [   14.758640] Kernel Offset: disabled
> > [   14.758792] CPU features: 0x00002,24002004
> > [   14.758844] Memory Limit: none
> > [   14.759190] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100 ]---
> > 
> > I have bisect it;
> > git bisect start
> > # good: [937381741d02cc6594477c593b2f3a087b3a0bc1] Linux 5.5.19
> > git bisect good 937381741d02cc6594477c593b2f3a087b3a0bc1
> > # bad: [61aba373f5708f2aebc3f72078e51949a068aa6f] Linux 5.6.19
> > git bisect bad 61aba373f5708f2aebc3f72078e51949a068aa6f
> > # good: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
> > git bisect good d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
> > # good: [ccaaaf6fe5a5e1fffca5cca0f3fc4ec84d7ae752] Merge tag 'mpx-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/daveh/x86-mpx
> > git bisect good ccaaaf6fe5a5e1fffca5cca0f3fc4ec84d7ae752
> > # bad: [6f08e98d62799e53c89dbf2c9a49d77e20ca648c] net: phy: restore mdio regs in the iproc mdio driver
> > git bisect bad 6f08e98d62799e53c89dbf2c9a49d77e20ca648c
> > # good: [5b21115414f5b5220e7ab3ca7f5d2c1396f11854] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
> > git bisect good 5b21115414f5b5220e7ab3ca7f5d2c1396f11854
> > # bad: [d030a0dd01306d45569c6a4449dee603f994744a] Merge tag 'ti-k3-soc-for-v5.6-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux into arm/dt
> > git bisect bad d030a0dd01306d45569c6a4449dee603f994744a
> > # good: [78c47feaff0597ac5567466d937e42d3bde52a29] Merge tag 'imx-dt-5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/dt
> > git bisect good 78c47feaff0597ac5567466d937e42d3bde52a29
> > # good: [2e04d1bd540c849495c6f50d3c8086be824bd4e5] Merge tag 'qcom-arm64-for-5.6' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
> > git bisect good 2e04d1bd540c849495c6f50d3c8086be824bd4e5
> > # good: [55a03ac8374d1f6ad149624419777bfbf077dc42] Merge tag 'at91-5.6-dt-2' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/dt
> > git bisect good 55a03ac8374d1f6ad149624419777bfbf077dc42
> > # bad: [5a25e646902f8bfd97379b0b385d93c93cb5b94e] arm64: zynqmp: Add label property to all ina226 on zcu106
> > git bisect bad 5a25e646902f8bfd97379b0b385d93c93cb5b94e
> > # bad: [4426df7c8dc2eb9a1438418a3cbeeff41ef5c097] arm64: zynqmp: Turn comment to gpio-line-names
> > git bisect bad 4426df7c8dc2eb9a1438418a3cbeeff41ef5c097
> > # bad: [4406486805bffbf245473e6111e2d7984550846e] arm64: dts: xilinx: Remove dtsi for fixed clock
> > git bisect bad 4406486805bffbf245473e6111e2d7984550846e
> > # good: [a6764cbda6c64b76a3f7511c099fc1a0accca5b0] arm64: dts: zynqmp: Use decimal values for drm-clock properties
> > git bisect good a6764cbda6c64b76a3f7511c099fc1a0accca5b0
> > # bad: [9c8a47b484ed8d7b06b4ca0032e93c458c7b931e] arm64: dts: xilinx: Add the clock nodes for zynqmp
> > git bisect bad 9c8a47b484ed8d7b06b4ca0032e93c458c7b931e
> > # good: [df906cf54bd54dbc87efb5129ce38e3ca9e7d329] arm64: zynqmp: Add dr_mode property to usb node
> > git bisect good df906cf54bd54dbc87efb5129ce38e3ca9e7d329
> > # first bad commit: [9c8a47b484ed8d7b06b4ca0032e93c458c7b931e] arm64: dts: xilinx: Add the clock nodes for zynqmp
> > 
> > Regards
> > 
> 
> Do you have uart driver enabled? And do you have uart IP modeled in
> Qemu? I can't see driver be probed.
> Anyway the commit suggest that qemu has any issue with getting
> information about CLK from firmware. Not sure how this is modeled.
> Edgar: Are you testing it?


Yeah.
Since Linux added the power and clock nodes to the dts, direct QEMU Linux boots don't work since you need the firmware modules.
Firmware only runs on the Xilinx QEMU (not upstream).

I've patched the Linux tree dts files to remove these nodes for our testing.
It would be good to have a zcu102 QEMU dts somewhere.

Here's the patched tree with some information in the README.xilinx file.
git log -p will show the needed changes in DTS.
https://github.com/edgarigl/linux/blob/xilinx-pcie-no-fw/README.xilinx

I've also attached the modified dtb file to this email for convenience.

Cheers,
Edgar

--5vNYLRcllDrimb99
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="zynqmp-zcu102-rev1.0.dtb"
Content-Transfer-Encoding: base64

0A3+7QAAXw4AAAA4AABaBAAAACgAAAARAAAAEAAAAAAAAAUKAABZzAAAAAAAAAAAAAAAAAAA
AAAAAAABAAAAAAAAAAMAAAA5AAAAAHhsbngsenlucW1wLXpjdTEwMi1yZXYxLjAAeGxueCx6
eW5xbXAtemN1MTAyAHhsbngsenlucW1wAAAAAAAAAAMAAAAEAAAACwAAAAIAAAADAAAABAAA
ABoAAAACAAAAAwAAABUAAAAmWnlucU1QIFpDVTEwMiBSZXYxLjAAAAAAAAAAAWNwdXMAAAAA
AAAAAwAAAAQAAAALAAAAAQAAAAMAAAAEAAAAGgAAAAAAAAABY3B1QDAAAAAAAAADAAAADwAA
AABhcm0sY29ydGV4LWE1MwAAAAAAAwAAAAQAAAAsY3B1AAAAAAMAAAAFAAAAOHBzY2kAAAAA
AAAAAwAAAAQAAABGAAAAAQAAAAMAAAAEAAAAWgAAAAAAAAADAAAABAAAAF4AAAACAAAAAwAA
AAgAAABuAAAAAwAAAAoAAAACAAAAAWNwdUAxAAAAAAAAAwAAAA8AAAAAYXJtLGNvcnRleC1h
NTMAAAAAAAMAAAAEAAAALGNwdQAAAAADAAAABQAAADhwc2NpAAAAAAAAAAMAAAAEAAAAWgAA
AAEAAAADAAAABAAAAEYAAAABAAAAAwAAAAQAAABeAAAAAgAAAAIAAAABY3B1QDIAAAAAAAAD
AAAADwAAAABhcm0sY29ydGV4LWE1MwAAAAAAAwAAAAQAAAAsY3B1AAAAAAMAAAAFAAAAOHBz
Y2kAAAAAAAAAAwAAAAQAAABaAAAAAgAAAAMAAAAEAAAARgAAAAEAAAADAAAABAAAAF4AAAAC
AAAAAgAAAAFjcHVAMwAAAAAAAAMAAAAPAAAAAGFybSxjb3J0ZXgtYTUzAAAAAAADAAAABAAA
ACxjcHUAAAAAAwAAAAUAAAA4cHNjaQAAAAAAAAADAAAABAAAAFoAAAADAAAAAwAAAAQAAABG
AAAAAQAAAAMAAAAEAAAAXgAAAAIAAAACAAAAAWlkbGUtc3RhdGVzAAAAAAMAAAAFAAAAdXBz
Y2kAAAAAAAAAAWNwdS1zbGVlcC0wAAAAAAMAAAAPAAAAAGFybSxpZGxlLXN0YXRlAAAAAAAD
AAAABAAAAIJAAAAAAAAAAwAAAAAAAACZAAAAAwAAAAQAAACqAAABLAAAAAMAAAAEAAAAuwAA
AlgAAAADAAAABAAAAMsAACcQAAAAAwAAAAQAAADcAAAAAgAAAAIAAAACAAAAAgAAAAFjcHUt
b3BwLXRhYmxlAAAAAAAAAwAAABQAAAAAb3BlcmF0aW5nLXBvaW50cy12MgAAAAADAAAAAAAA
AOQAAAADAAAABAAAANwAAAABAAAAAW9wcDAwAAAAAAAAAwAAAAgAAADvAAAAAEeGi/QAAAAD
AAAABAAAAPYAD0JAAAAAAwAAAAQAAAEEAAehIAAAAAIAAAABb3BwMDEAAAAAAAADAAAACAAA
AO8AAAAAI8NF+gAAAAMAAAAEAAAA9gAPQkAAAAADAAAABAAAAQQAB6EgAAAAAgAAAAFvcHAw
MgAAAAAAAAMAAAAIAAAA7wAAAAAX14P8AAAAAwAAAAQAAAD2AA9CQAAAAAMAAAAEAAABBAAH
oSAAAAACAAAAAW9wcDAzAAAAAAAAAwAAAAgAAADvAAAAABHhov0AAAADAAAABAAAAPYAD0JA
AAAAAwAAAAQAAAEEAAehIAAAAAIAAAACAAAAAWRjYwAAAAADAAAACAAAAABhcm0sZGNjAAAA
AAMAAAAFAAABFW9rYXkAAAAAAAAAAgAAAAFwbXUAAAAAAwAAABAAAAAAYXJtLGFybXY4LXBt
dXYzAAAAAAMAAAAEAAABHAAAAAQAAAADAAAAMAAAAS0AAAAAAAAAjwAAAAQAAAAAAAAAkAAA
AAQAAAAAAAAAkQAAAAQAAAAAAAAAkgAAAAQAAAACAAAAAXBzY2kAAAAAAAAAAwAAAA0AAAAA
YXJtLHBzY2ktMC4yAAAAAAAAAAMAAAAEAAAAP3NtYwAAAAACAAAAAWZpcm13YXJlAAAAAAAA
AAF6eW5xbXAtZmlybXdhcmUAAAAAAwAAABUAAAAAeGxueCx6eW5xbXAtZmlybXdhcmUAAAAA
AAAAAwAAAAkAAAEVZGlzYWJsZWQAAAAAAAAAAwAAAAQAAAE4AAAAAQAAAAMAAAAEAAAAP3Nt
YwAAAAABenlucW1wLXBvd2VyAAAAAAAAAAMAAAASAAAAAHhsbngsenlucW1wLXBvd2VyAAAA
AAAAAwAAAAQAAAEcAAAABAAAAAMAAAAMAAABLQAAAAAAAAAjAAAABAAAAAIAAAABY2xvY2st
Y29udHJvbGxlcgAAAAAAAAADAAAABAAAAUwAAAABAAAAAwAAABAAAAAAeGxueCx6eW5xbXAt
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
EAAAAAADAAAAEQAAAVlwY2xrAGhjbGsAdHhfY2xrAAAAAAAAAAMAAAAEAAAACwAAAAEAAAAD
AAAABAAAABoAAAAAAAAAAwAAAAgAAAHGAAAADQAACHcAAAADAAAADAAAAG4AAAAMAAAADAAA
AAwAAAADAAAABAAAAc0AAAAOAAAAAwAAAAkAAAHYcmdtaWktaWQAAAAAAAAAAWV0aGVybmV0
LXBoeUBjAAAAAAADAAAABAAAAFoAAAAMAAAAAwAAAAQAAAHhAAAACAAAAAMAAAAEAAAB9gAA
AAoAAAADAAAABAAAAgsAAAABAAAAAwAAAAAAAAIZAAAAAwAAAAQAAADcAAAADgAAAAIAAAAC
AAAAAWdwaW9AZmYwYTAwMDAAAAAAAAADAAAAFQAAAAB4bG54LHp5bnFtcC1ncGlvLTEuMAAA
AAAAAAADAAAABQAAARVva2F5AAAAAAAAAAMAAAAEAAACNwAAAAIAAAADAAAAAAAAAkMAAAAD
AAAABAAAARwAAAAEAAAAAwAAAAwAAAEtAAAAAAAAABAAAAAEAAAAAwAAAAAAAAGGAAAAAwAA
AAQAAAF1AAAAAgAAAAMAAAAQAAAAWgAAAAD/CgAAAAAAAAAAEAAAAAADAAAACAAAAG4AAAAD
AAAAHwAAAAMAAAAEAAAA3AAAABMAAAACAAAAAWkyY0BmZjAyMDAwMAAAAAAAAAADAAAADwAA
AABjZG5zLGkyYy1yMXAxNAAAAAAAAwAAAAUAAAEVb2theQAAAAAAAAADAAAABAAAARwAAAAE
AAAAAwAAAAwAAAEtAAAAAAAAABEAAAAEAAAAAwAAABAAAABaAAAAAP8CAAAAAAAAAAAQAAAA
AAMAAAAEAAAACwAAAAEAAAADAAAABAAAABoAAAAAAAAAAwAAAAgAAABuAAAAAwAAAD0AAAAD
AAAABAAAAlMABhqAAAAAAWdwaW9AMjAAAAAAAwAAAAsAAAAAdGksdGNhNjQxNgAAAAAAAwAA
AAQAAABaAAAAIAAAAAMAAAAAAAACQwAAAAMAAAAEAAACNwAAAAIAAAADAAAAegAAAmNQU19H
VFJfTEFOX1NFTDAAUFNfR1RSX0xBTl9TRUwxAFBTX0dUUl9MQU5fU0VMMgBQU19HVFJfTEFO
X1NFTDMAUENJX0NMS19ESVJfU0VMAElJQ19NVVhfUkVTRVRfQgBHRU0zX0VYUF9SRVNFVF9C
AAAAAAAAAAAAAAAAAAAAAWd0ci1zZWwwLWhvZwAAAAAAAAADAAAAAAAAAnMAAAADAAAACAAA
AnwAAAAAAAAAAAAAAAMAAAAAAAACggAAAAMAAAAFAAACjXNlbDAAAAAAAAAAAgAAAAFndHIt
c2VsMS1ob2cAAAAAAAAAAwAAAAAAAAJzAAAAAwAAAAgAAAJ8AAAAAQAAAAAAAAADAAAAAAAA
ApcAAAADAAAABQAAAo1zZWwxAAAAAAAAAAIAAAABZ3RyLXNlbDItaG9nAAAAAAAAAAMAAAAA
AAACcwAAAAMAAAAIAAACfAAAAAIAAAAAAAAAAwAAAAAAAAKXAAAAAwAAAAUAAAKNc2VsMgAA
AAAAAAACAAAAAWd0ci1zZWwzLWhvZwAAAAAAAAADAAAAAAAAAnMAAAADAAAACAAAAnwAAAAD
AAAAAAAAAAMAAAAAAAAClwAAAAMAAAAFAAACjXNlbDMAAAAAAAAAAgAAAAIAAAABZ3Bpb0Ay
MQAAAAADAAAACwAAAAB0aSx0Y2E2NDE2AAAAAAADAAAABAAAAFoAAAAhAAAAAwAAAAAAAAJD
AAAAAwAAAAQAAAI3AAAAAgAAAAMAAADtAAACY1ZDQ1BTUExMX0VOAE1HVFJBVkNDX0VOAE1H
VFJBVlRUX0VOAFZDQ1BTRERSUExMX0VOAE1JTzI2X1BNVV9JTlBVVF9MUwBQTF9QTUJVU19B
TEVSVABQU19QTUJVU19BTEVSVABNQVhJTV9QTUJVU19BTEVSVABQTF9ERFI0X1ZURVJNX0VO
AFBMX0REUjRfVlBQXzJWNV9FTgBQU19ESU1NX1ZERFFfVE9fUFNWQ0NPX09OAFBTX0RJTU1f
U1VTUEVORF9FTgBQU19ERFI0X1ZURVJNX0VOAFBTX0REUjRfVlBQXzJWNV9FTgAAAAAAAAAA
AAIAAAABaTJjLW11eEA3NQAAAAAAAwAAAAwAAAAAbnhwLHBjYTk1NDQAAAAAAwAAAAQAAAAL
AAAAAQAAAAMAAAAEAAAAGgAAAAAAAAADAAAABAAAAFoAAAB1AAAAAWkyY0AwAAAAAAAAAwAA
AAQAAAALAAAAAQAAAAMAAAAEAAAAGgAAAAAAAAADAAAABAAAAFoAAAAAAAAAAWluYTIyNkA0
MAAAAAAAAAMAAAAKAAAAAHRpLGluYTIyNgAAAAAAAAMAAAAEAAACowAAAAEAAAADAAAACwAA
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
AAFpbmEyMjYtdTc1AAAAAAADAAAACgAAAABpaW8taHdtb24AAAAAAAADAAAAIAAABP4AAAAl
AAAAAAAAACUAAAABAAAAJQAAAAIAAAAlAAAAAwAAAAIAAAACAAAACWNvbXBhdGlibGUAI2Fk
ZHJlc3MtY2VsbHMAI3NpemUtY2VsbHMAbW9kZWwAZGV2aWNlX3R5cGUAZW5hYmxlLW1ldGhv
ZABvcGVyYXRpbmctcG9pbnRzLXYyAHJlZwBjcHUtaWRsZS1zdGF0ZXMAY2xvY2tzAGVudHJ5
LW1ldGhvZABhcm0scHNjaS1zdXNwZW5kLXBhcmFtAGxvY2FsLXRpbWVyLXN0b3AAZW50cnkt
bGF0ZW5jeS11cwBleGl0LWxhdGVuY3ktdXMAbWluLXJlc2lkZW5jeS11cwBwaGFuZGxlAG9w
cC1zaGFyZWQAb3BwLWh6AG9wcC1taWNyb3ZvbHQAY2xvY2stbGF0ZW5jeS1ucwBzdGF0dXMA
aW50ZXJydXB0LXBhcmVudABpbnRlcnJ1cHRzACNwb3dlci1kb21haW4tY2VsbHMAI2Nsb2Nr
LWNlbGxzAGNsb2NrLW5hbWVzAGZwZ2EtbWdyAHJhbmdlcwAjaW50ZXJydXB0LWNlbGxzAGlu
dGVycnVwdC1jb250cm9sbGVyAHR4LWZpZm8tZGVwdGgAcngtZmlmby1kZXB0aAB4bG54LGJ1
cy13aWR0aABpb21tdXMAcGh5LWhhbmRsZQBwaHktbW9kZQB0aSxyeC1pbnRlcm5hbC1kZWxh
eQB0aSx0eC1pbnRlcm5hbC1kZWxheQB0aSxmaWZvLWRlcHRoAHRpLGRwODM4NjctcnhjdHJs
LXN0cmFwLXF1aXJrACNncGlvLWNlbGxzAGdwaW8tY29udHJvbGxlcgBjbG9jay1mcmVxdWVu
Y3kAZ3Bpby1saW5lLW5hbWVzAGdwaW8taG9nAGdwaW9zAG91dHB1dC1sb3cAbGluZS1uYW1l
AG91dHB1dC1oaWdoACNpby1jaGFubmVsLWNlbGxzAGxhYmVsAHNodW50LXJlc2lzdG9yAHRl
bXBlcmF0dXJlLXN0YWJpbGl0eQBmYWN0b3J5LWZvdXQAY2xvY2stb3V0cHV0LW5hbWVzAG1z
aS1jb250cm9sbGVyAGludGVycnVwdC1uYW1lcwBtc2ktcGFyZW50AHJlZy1uYW1lcwBidXMt
cmFuZ2UAaW50ZXJydXB0LW1hcC1tYXNrAGludGVycnVwdC1tYXAAaW9tbXUtbWFwACNwaHkt
Y2VsbHMAY2FsaWJyYXRpb24AY2V2YSxwMC1jb21pbml0LXBhcmFtcwBjZXZhLHAwLWNvbXdh
a2UtcGFyYW1zAGNldmEscDAtYnVyc3QtcGFyYW1zAGNldmEscDAtcmV0cnktcGFyYW1zAGNl
dmEscDEtY29taW5pdC1wYXJhbXMAY2V2YSxwMS1jb213YWtlLXBhcmFtcwBjZXZhLHAxLWJ1
cnN0LXBhcmFtcwBjZXZhLHAxLXJldHJ5LXBhcmFtcwBuby0xLTgtdgAjZ2xvYmFsLWludGVy
cnVwdHMAI2lvbW11LWNlbGxzAHRpbWVyLXdpZHRoAGRyX21vZGUAdGltZW91dC1zZWMAZXRo
ZXJuZXQwAGkyYzAAaTJjMQBtbWMwAHJ0YzAAc2VyaWFsMABzZXJpYWwxAHNlcmlhbDIAYm9v
dGFyZ3MAc3Rkb3V0LXBhdGgAYXV0b3JlcGVhdABsaW51eCxjb2RlAHdha2V1cC1zb3VyY2UA
bGludXgsZGVmYXVsdC10cmlnZ2VyAGlvLWNoYW5uZWxzAA==

--5vNYLRcllDrimb99--
