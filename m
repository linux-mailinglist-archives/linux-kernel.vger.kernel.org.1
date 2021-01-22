Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7859D2FFF95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbhAVJzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:55:19 -0500
Received: from mail-co1nam11on2067.outbound.protection.outlook.com ([40.107.220.67]:24769
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727645AbhAVJxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:53:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvSbZ9v2PSL9qZpOT4ghrwx8DPfYolNsL12t29yA5RMNMIYm1ijLxNv0EDGb199gDIHrcu2S+9PWqVyQRsn1GipFDmnLQzZ3PZrLKi7VUZvxq9oIjJlsXQkH9nQkmOWn7EEKHfuCE5RE6wsAxem2C2oKmY8R/dJ3QQRdFgVoFHSpTUFh7wnCvmkUZ6jVPE2w11EWKyLsPQQQEp9GJSIzWfubRYjEEy/GBBuhj4uIoTqEuhh5kvo19M7NNvi797PmSCtY88OK3gwer7uYa9mnugkwPowS4g9o7Zs6/rfBRmk+oLuBZwynTHAB5QJYDRhfsYa1ADYGipvl6Xg63JE9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2loZbTrVPddyAmEKLUK1CFJ7o88LwLYhvq1jaOtlR0=;
 b=ZULl/7NDKlbAuMivYT24C6UkYQwcWqmLjJ8ACRispd4rink4y8LVLc2AFTTdPR/b0R1L7oJzL05MwK647V/vdyEmdjvEqsVIisivLlfwrdkg0Kyl41/IB6AfpFKT0p8Sk7vnUV5IhskrP2YUb170lip9BtChTnRQFuD1FrucMx82SSv4YgAFVKnkXMllwrrWyrcGEE8U5RiOl9lBfTnoUfGCcHJzgAkKz/5z2yVXOKUdEzP0eKQl4kyazxyBDiei+0dBP32lZkg0j3u/k2qtcan125uXMoJXobAzeLjzPFLzizPSKzEX5IFy2Txjqlgym53pndb9l/Ecc0k+oSV8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2loZbTrVPddyAmEKLUK1CFJ7o88LwLYhvq1jaOtlR0=;
 b=ElR5fSD57NMR77RNR1xqxHXhiGVaXrG4Iq7d0Kk9JWCODeCBoaxc0erVFU/YqaRYLPoBNGfuPxIJqjCNaMjFAZNhhQ/XHT2bK16oqvAvjtsZh6vNvCy1ckowU1CBppQYxfLUzSVHMY1skQNd/siewtP3weT73qcuZmE5oVsDJI8=
Received: from CY4PR22CA0077.namprd22.prod.outlook.com (2603:10b6:903:ad::15)
 by BYAPR02MB4695.namprd02.prod.outlook.com (2603:10b6:a03:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Fri, 22 Jan
 2021 09:52:22 +0000
Received: from CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ad:cafe::1f) by CY4PR22CA0077.outlook.office365.com
 (2603:10b6:903:ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend
 Transport; Fri, 22 Jan 2021 09:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT034.mail.protection.outlook.com (10.152.75.190) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 09:52:22 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 22 Jan 2021 01:52:21 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 22 Jan 2021 01:52:21 -0800
Envelope-to: edgar.iglesias@xilinx.com,
 rajan.vaja@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 clabbe.montjoie@gmail.com
Received: from [172.30.17.109] (port=54576)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l2t76-0003np-Kb; Fri, 22 Jan 2021 01:52:21 -0800
Subject: Re: Fail to boot qemu xlnx-zcu102 due to lot of drivers not probing
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        <michal.simek@xilinx.com>, <rajan.vaja@xilinx.com>,
        "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <YAqZt69Ahba4uubZ@Red>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <80a6170f-7723-be6e-3ea5-ffd1a4bf8956@xilinx.com>
Date:   Fri, 22 Jan 2021 10:52:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAqZt69Ahba4uubZ@Red>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc9affb5-0d41-45de-2471-08d8bebb6a84
X-MS-TrafficTypeDiagnostic: BYAPR02MB4695:
X-Microsoft-Antispam-PRVS: <BYAPR02MB469538A6AA71D5B325445CCDC6A00@BYAPR02MB4695.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:57;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIetPkyAD7iSE7RSAqfpqDhvynqG3phck53jdgJ3EtPdzugios7PAcqVc0IlnVZSz7t1jL2zEiCkmdA59dmN/nJej4eSpQGg482niyQLt6Q2PGeXQbhi8U62pWlVMtAFWF8Bu6H1GTWUL83VP5cBUh40rz7ba7T1Jh6uLWDL92455vi2tbuReRrMwxi9hgWcj7Ggkpd5YVl88meTWBCvYsCtvckbHV5ASWfSl+HpVUBNZ2cutSnz+R5iVrPh3QwPRJUWdFkN4RA2oIoyU7FOYivm1Wbng/RL/nXUOkkjWx0RExGP9QcBKX+AiavEyesn+a/U7EMuleCnxLJD4nEVzjWxY5OAgcTUSWyGZuynCDHJ0scrTMunxUFX6495d8lMfw4cmeJ60wSwlN2pi1ZrV3eW31qw6E3UGC6frrV9yKNsJp+AUeAnb7UhNoQEVRLvR+6ZE8vcwp6esYMJd1Dogjq5rwC/iXoU+6K/qTsyAgZFa2wdowRiizsusdD7rh683zCQ3K1CoH0iGhIkQqN7u/kkgtfEAn9EJevOAvzryZkjg2MNfWfAVbUc/lVfEtcER7MkxOqNF5pYe59Gs7++7h0Ue7WvujMWj973D2NG58c=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(44832011)(70586007)(426003)(336012)(356005)(70206006)(8676002)(966005)(30864003)(478600001)(8936002)(7636003)(54906003)(6666004)(2616005)(83380400001)(316002)(110136005)(36906005)(5660300002)(47076005)(2906002)(82740400003)(186003)(36756003)(82310400003)(6636002)(31686004)(4326008)(26005)(53546011)(31696002)(9786002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 09:52:22.7502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9affb5-0d41-45de-2471-08d8bebb6a84
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4695
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/22/21 10:24 AM, Corentin Labbe wrote:
> Hello
> 
> With at least qemu 5.1.0 (and later), the xlnx-zcu102 machine boot lead to a panic due to missing console.
> qemu-system-aarch64 -kernel Image -nographic -machine xlnx-zcu102 -device ide-hd,drive=lavatest -serial mon:stdio -serial null -append 'earlycon=cdns,mmio,0xFF000000,115200n8 console=ttyPS0 root=/dev/ram0 ip=dhcp' -dtb zynqmp-zcu102-rev1.0.dtb -m 2048 -nic user,model=cadence_gem,mac=52:54:00:12:34:58 -drive format=qcow2,file=disk.img,if=none,id=lavatest -initrd rootfs.cpio.gz
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version 5.5.0-rc1-00004-g9c8a47b484ed (clabbe@arnold) (gcc version 7.5.0 (Linaro GCC 7.5-2019.12)) #17 SMP PREEMPT Fri Jan 22 09:19:31 UTC 2021
> [    0.000000] Machine model: ZynqMP ZCU102 Rev1.0
> [    0.000000] earlycon: cdns0 at MMIO 0x00000000ff000000 (options '115200n8')
> [    0.000000] printk: bootconsole [cdns0] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 32 MiB at 0x000000007e000000
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x7dbe0100-0x7dbe1fff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000003fffffff]
> [    0.000000]   DMA32    [mem 0x0000000040000000-0x000000007fffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv0.2 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
> [    0.000000] percpu: Embedded 22 pages/cpu s53016 r8192 d28904 u90112
> [    0.000000] Detected VIPT I-cache on CPU0
> [    0.000000] CPU features: detected: ARM erratum 845719
> [    0.000000] CPU features: detected: ARM erratum 843419
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 516096
> [    0.000000] Policy zone: DMA32
> [    0.000000] Kernel command line: earlycon=cdns,mmio,0xFF000000,115200n8 console=ttyPS0 root=/dev/ram0 ip=dhcp
> [    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] software IO TLB: mapped [mem 0x3bfff000-0x3ffff000] (64MB)
> [    0.000000] Memory: 1907172K/2097152K available (12092K kernel code, 1896K rwdata, 6640K rodata, 5120K init, 456K bss, 157212K reserved, 32768K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
> [    0.000000] 	Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] random: get_random_bytes called from start_kernel+0x2b8/0x454 with crng_init=0
> [    0.000000] arch_timer: cp15 timer(s) running at 62.50MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
> [    0.000118] sched_clock: 56 bits at 62MHz, resolution 16ns, wraps every 4398046511096ns
> [    0.006458] Console: colour dummy device 80x25
> [    0.008026] Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=250000)
> [    0.008182] pid_max: default: 32768 minimum: 301
> [    0.009157] LSM: Security Framework initializing
> [    0.010014] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
> [    0.010106] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
> [    0.060263] ASID allocator initialised with 32768 entries
> [    0.067849] rcu: Hierarchical SRCU implementation.
> [    0.079370] EFI services will not be available.
> [    0.088702] smp: Bringing up secondary CPUs ...
> [    0.118904] Detected VIPT I-cache on CPU1
> [    0.119921] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
> [    0.156284] Detected VIPT I-cache on CPU2
> [    0.156514] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
> [    0.189310] Detected VIPT I-cache on CPU3
> [    0.189472] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
> [    0.189921] smp: Brought up 1 node, 4 CPUs
> [    0.190504] SMP: Total of 4 processors activated.
> [    0.190633] CPU features: detected: 32-bit EL0 Support
> [    0.190817] CPU features: detected: CRC32 instructions
> [    0.297754] CPU: All CPU(s) started at EL1
> [    0.298034] alternatives: patching kernel code
> [    0.313974] devtmpfs: initialized
> [    0.331444] KASLR disabled due to lack of seed
> [    0.334720] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.334884] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
> [    0.338030] pinctrl core: initialized pinctrl subsystem
> [    0.346728] thermal_sys: Registered thermal governor 'step_wise'
> [    0.346790] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.347676] DMI not present or invalid.
> [    0.351563] NET: Registered protocol family 16
> [    0.365080] DMA: preallocated 256 KiB pool for atomic allocations
> [    0.365197] audit: initializing netlink subsys (disabled)
> [    0.367450] audit: type=2000 audit(0.352:1): state=initialized audit_enabled=0 res=1
> [    0.373249] cpuidle: using governor menu
> [    0.374322] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
> [    0.377901] Serial: AMBA PL011 UART driver
> [    0.409786] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.409852] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
> [    0.409899] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.409943] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
> [    0.427753] cryptd: max_cpu_qlen set to 1000
> [    0.451024] ACPI: Interpreter disabled.
> [    0.455411] iommu: Default domain type: Translated 
> [    0.460553] vgaarb: loaded
> [    0.461653] SCSI subsystem initialized
> [    0.463668] usbcore: registered new interface driver usbfs
> [    0.464015] usbcore: registered new interface driver hub
> [    0.464233] usbcore: registered new device driver usb
> [    0.465642] pps_core: LinuxPPS API ver. 1 registered
> [    0.465719] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.465913] PTP clock support registered
> [    0.466536] EDAC MC: Ver: 3.0.0
> [    0.470918] FPGA manager framework
> [    0.480307] clocksource: Switched to clocksource arch_sys_counter
> [    0.481151] VFS: Disk quotas dquot_6.6.0
> [    0.481303] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.483302] pnp: PnP ACPI: disabled
> [    0.499697] NET: Registered protocol family 2
> [    0.503466] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
> [    0.503600] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.503883] TCP bind hash table entries: 16384 (order: 6, 262144 bytes, linear)
> [    0.504340] TCP: Hash tables configured (established 16384 bind 16384)
> [    0.505760] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
> [    0.505955] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
> [    0.509700] NET: Registered protocol family 1
> [    0.512672] RPC: Registered named UNIX socket transport module.
> [    0.512748] RPC: Registered udp transport module.
> [    0.512798] RPC: Registered tcp transport module.
> [    0.512873] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.513000] PCI: CLS 0 bytes, default 64
> [    0.518640] Trying to unpack rootfs image as initramfs...
> [    1.561069] Freeing initrd memory: 24492K
> [    1.563539] hw perfevents: no interrupt-affinity property for /pmu, guessing.
> [    1.566112] hw perfevents: enabled with armv8_pmuv3 PMU driver, 5 counters available
> [    1.566604] kvm [1]: HYP mode not available
> [    2.168380] Initialise system trusted keyrings
> [    2.170604] workingset: timestamp_bits=44 max_order=19 bucket_order=0
> [    2.182859] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    2.185289] NFS: Registering the id_resolver key type
> [    2.185516] Key type id_resolver registered
> [    2.185568] Key type id_legacy registered
> [    2.185735] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> [    2.186423] 9p: Installing v9fs 9p2000 file system support
> [    2.216137] Key type asymmetric registered
> [    2.216526] Asymmetric key parser 'x509' registered
> [    2.216938] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
> [    2.217290] io scheduler mq-deadline registered
> [    2.217490] io scheduler kyber registered
> [    2.238034] EINJ: ACPI disabled.
> [    2.256746] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    2.262019] SuperH (H)SCI(F) driver initialized
> [    2.262788] msm_serial: driver initialized
> [    2.266149] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [    2.290568] brd: module loaded
> [    2.305751] loop: module loaded
> [    2.314997] libphy: Fixed MDIO Bus: probed
> [    2.315445] tun: Universal TUN/TAP device driver, 1.6
> [    2.317611] macb ff0e0000.ethernet: failed to get macb_clk (-517)
> [    2.318012] thunder_xcv, ver 1.0
> [    2.318108] thunder_bgx, ver 1.0
> [    2.318192] nicpf, ver 1.0
> [    2.319004] hclge is initializing
> [    2.319116] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
> [    2.319168] hns3: Copyright (c) 2017 Huawei Corporation.
> [    2.319475] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    2.319522] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    2.319625] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
> [    2.319676] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    2.319784] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
> [    2.319841] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> [    2.320480] sky2: driver version 1.30
> [    2.321671] VFIO - User Level meta-driver version: 0.3
> [    2.324375] dwc3 fe200000.usb: Failed to get clk 'ref': -2
> [    2.324580] dwc3 fe200000.usb: this is not a DesignWare USB3 DRD Core
> [    2.326494] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    2.326582] ehci-pci: EHCI PCI platform driver
> [    2.326765] ehci-platform: EHCI generic platform driver
> [    2.326969] ehci-orion: EHCI orion driver
> [    2.327149] ehci-exynos: EHCI EXYNOS driver
> [    2.327338] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    2.327450] ohci-pci: OHCI PCI platform driver
> [    2.327632] ohci-platform: OHCI generic platform driver
> [    2.327841] ohci-exynos: OHCI EXYNOS driver
> [    2.333183] i2c /dev entries driver
> [    2.340433] CPUidle PSCI: Invalid PSCI power state 0x40000000
> [    2.340503] CPUidle PSCI: CPU 0 failed to PSCI idle
> [    2.341032] sdhci: Secure Digital Host Controller Interface driver
> [    2.341081] sdhci: Copyright(c) Pierre Ossman
> [    2.341664] Synopsys Designware Multimedia Card Interface Driver
> [    2.342891] sdhci-pltfm: SDHCI platform and OF driver helper
> [    2.344309] sdhci-arasan ff170000.mmc: clk_ahb clock not found.
> [    2.347585] ledtrig-cpu: registered to indicate activity on CPUs
> [    2.350355] usbcore: registered new interface driver usbhid
> [    2.350408] usbhid: USB HID core driver
> [    2.355763] NET: Registered protocol family 17
> [    2.357107] 9pnet: Installing 9P2000 support
> [    2.357402] Key type dns_resolver registered
> [    2.358493] registered taskstats version 1
> [    2.358570] Loading compiled-in X.509 certificates
> [    2.366581] macb ff0e0000.ethernet: failed to get macb_clk (-517)
> [    2.368578] sdhci-arasan ff170000.mmc: clk_ahb clock not found.
> [    2.380780] macb ff0e0000.ethernet: failed to get macb_clk (-517)
> [    2.382995] sdhci-arasan ff170000.mmc: clk_ahb clock not found.
> [    2.387684] hctosys: unable to open rtc device (rtc0)
> [   14.675537] Warning: unable to open an initial console.
> [   14.696554] Freeing unused kernel memory: 5120K
> [   14.697256] Run /init as init process
> [   14.757187] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100
> [   14.757393] CPU: 0 PID: 1 Comm: init Not tainted 5.5.0-rc1-00004-g9c8a47b484ed #17
> [   14.757452] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [   14.757660] Call trace:
> [   14.757705]  dump_backtrace+0x0/0x1a0
> [   14.757790]  show_stack+0x14/0x20
> [   14.757827]  dump_stack+0xbc/0x104
> [   14.757855]  panic+0x16c/0x37c
> [   14.757880]  do_exit+0x97c/0x980
> [   14.757905]  do_group_exit+0x44/0xa0
> [   14.757932]  __arm64_sys_exit_group+0x14/0x18
> [   14.757968]  el0_svc_common.constprop.2+0x64/0x160
> [   14.758002]  el0_svc_handler+0x20/0x80
> [   14.758029]  el0_sync_handler+0xe4/0x188
> [   14.758057]  el0_sync+0x140/0x180
> [   14.758265] SMP: stopping secondary CPUs
> [   14.758640] Kernel Offset: disabled
> [   14.758792] CPU features: 0x00002,24002004
> [   14.758844] Memory Limit: none
> [   14.759190] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100 ]---
> 
> I have bisect it;
> git bisect start
> # good: [937381741d02cc6594477c593b2f3a087b3a0bc1] Linux 5.5.19
> git bisect good 937381741d02cc6594477c593b2f3a087b3a0bc1
> # bad: [61aba373f5708f2aebc3f72078e51949a068aa6f] Linux 5.6.19
> git bisect bad 61aba373f5708f2aebc3f72078e51949a068aa6f
> # good: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
> git bisect good d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
> # good: [ccaaaf6fe5a5e1fffca5cca0f3fc4ec84d7ae752] Merge tag 'mpx-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/daveh/x86-mpx
> git bisect good ccaaaf6fe5a5e1fffca5cca0f3fc4ec84d7ae752
> # bad: [6f08e98d62799e53c89dbf2c9a49d77e20ca648c] net: phy: restore mdio regs in the iproc mdio driver
> git bisect bad 6f08e98d62799e53c89dbf2c9a49d77e20ca648c
> # good: [5b21115414f5b5220e7ab3ca7f5d2c1396f11854] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
> git bisect good 5b21115414f5b5220e7ab3ca7f5d2c1396f11854
> # bad: [d030a0dd01306d45569c6a4449dee603f994744a] Merge tag 'ti-k3-soc-for-v5.6-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux into arm/dt
> git bisect bad d030a0dd01306d45569c6a4449dee603f994744a
> # good: [78c47feaff0597ac5567466d937e42d3bde52a29] Merge tag 'imx-dt-5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/dt
> git bisect good 78c47feaff0597ac5567466d937e42d3bde52a29
> # good: [2e04d1bd540c849495c6f50d3c8086be824bd4e5] Merge tag 'qcom-arm64-for-5.6' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
> git bisect good 2e04d1bd540c849495c6f50d3c8086be824bd4e5
> # good: [55a03ac8374d1f6ad149624419777bfbf077dc42] Merge tag 'at91-5.6-dt-2' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/dt
> git bisect good 55a03ac8374d1f6ad149624419777bfbf077dc42
> # bad: [5a25e646902f8bfd97379b0b385d93c93cb5b94e] arm64: zynqmp: Add label property to all ina226 on zcu106
> git bisect bad 5a25e646902f8bfd97379b0b385d93c93cb5b94e
> # bad: [4426df7c8dc2eb9a1438418a3cbeeff41ef5c097] arm64: zynqmp: Turn comment to gpio-line-names
> git bisect bad 4426df7c8dc2eb9a1438418a3cbeeff41ef5c097
> # bad: [4406486805bffbf245473e6111e2d7984550846e] arm64: dts: xilinx: Remove dtsi for fixed clock
> git bisect bad 4406486805bffbf245473e6111e2d7984550846e
> # good: [a6764cbda6c64b76a3f7511c099fc1a0accca5b0] arm64: dts: zynqmp: Use decimal values for drm-clock properties
> git bisect good a6764cbda6c64b76a3f7511c099fc1a0accca5b0
> # bad: [9c8a47b484ed8d7b06b4ca0032e93c458c7b931e] arm64: dts: xilinx: Add the clock nodes for zynqmp
> git bisect bad 9c8a47b484ed8d7b06b4ca0032e93c458c7b931e
> # good: [df906cf54bd54dbc87efb5129ce38e3ca9e7d329] arm64: zynqmp: Add dr_mode property to usb node
> git bisect good df906cf54bd54dbc87efb5129ce38e3ca9e7d329
> # first bad commit: [9c8a47b484ed8d7b06b4ca0032e93c458c7b931e] arm64: dts: xilinx: Add the clock nodes for zynqmp
> 
> Regards
> 

Do you have uart driver enabled? And do you have uart IP modeled in
Qemu? I can't see driver be probed.
Anyway the commit suggest that qemu has any issue with getting
information about CLK from firmware. Not sure how this is modeled.
Edgar: Are you testing it?

Thanks,
Michal

