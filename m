Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7F2BC662
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 16:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgKVPMh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 22 Nov 2020 10:12:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:13152 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgKVPMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 10:12:36 -0500
IronPort-SDR: MU70uQx2Y0H5XPxYMGFhcHfdRsj/ur0JfRd/Qq7gVIN+MknLTaCRrQ9Cog7Z+HStTZrKFcKcHm
 r3iDvfEVrbGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="150914855"
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="150914855"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 07:12:36 -0800
IronPort-SDR: krXSgJDw/NqbEO0uygdJZDBWRjtfW4d6AZtNHtxVbRQPGpeisjN3f+/NTpB6sQplT2p3vTBX7f
 2tSwBLzQoTIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="535830744"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2020 07:12:36 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 22 Nov 2020 07:12:35 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 22 Nov 2020 23:12:33 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.1713.004;
 Sun, 22 Nov 2020 23:12:33 +0800
From:   "Sang, Oliver" <oliver.sang@intel.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
CC:     lkp <lkp@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Roman Gushchin" <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hui Su <sh_def@163.com>, Wei Yang <richard.weiyang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: RE: [mm/memcg] ade1ab542f: EIP:mem_cgroup_lruvec
Thread-Topic: [mm/memcg] ade1ab542f: EIP:mem_cgroup_lruvec
Thread-Index: AQHWwLlV7794MLMs/EGKoVocIBEaXqnUQjQQ
Date:   Sun, 22 Nov 2020 15:12:33 +0000
Message-ID: <5729e72d19b049dd9b9969b7cf67d31f@intel.com>
References: <20201122103620.GE2390@xsang-OptiPlex-9020>
In-Reply-To: <20201122103620.GE2390@xsang-OptiPlex-9020>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please ignore this report. sorry for any inconvenience.

> -----Original Message-----
> From: kernel test robot <oliver.sang@intel.com>
> Sent: Sunday, November 22, 2020 6:36 PM
> To: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: lkp <lkp@intel.com>; Andrew Morton <akpm@linux-foundation.org>;
> Johannes Weiner <hannes@cmpxchg.org>; Shakeel Butt
> <shakeelb@google.com>; Roman Gushchin <guro@fb.com>; Michal Hocko
> <mhocko@suse.com>; Yafang Shao <laoar.shao@gmail.com>; Alexander Duyck
> <alexander.h.duyck@linux.intel.com>; Hui Su <sh_def@163.com>; Wei Yang
> <richard.weiyang@gmail.com>; LKML <linux-kernel@vger.kernel.org>;
> lkp@lists.01.org
> Subject: [mm/memcg] ade1ab542f: EIP:mem_cgroup_lruvec
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: ade1ab542fdd4833c6bc9d685a4b4f3bfea83e00 ("mm/memcg: add
> missed warning in mem_cgroup_lruvec")
> url: https://github.com/0day-ci/linux/commits/UPDATE-20201120-183809/Alex-
> Shi/mm-memcg-add-missed-warning-in-mem_cgroup_lruvec/20201120-173445
> 
> 
> in testcase: locktorture
> version:
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 
> test-description: This torture test consists of creating a number of kernel threads
> which acquire the lock and hold it for specific amount of time, thus simulating
> different critical region behaviors.
> test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
> 
> 
> +----------------------------------------------------------+-----------+------------+
> |                                                          | v5.10-rc4 | ade1ab542f |
> +----------------------------------------------------------+-----------+------------+
> | boot_successes                                           | 195       | 0          |
> | WARNING:at_include/linux/memcontrol.h:#mem_cgroup_lruvec | 0         | 18
> |
> | EIP:mem_cgroup_lruvec                                    | 0         | 18         |
> +----------------------------------------------------------+-----------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   11.506736] WARNING: CPU: 0 PID: 147 at include/linux/memcontrol.h:476
> mem_cgroup_lruvec+0x1a/0x39
> [   11.506745] Modules linked in:
> [   11.509082] ntfs: driver 2.1.32 [Flags: R/W DEBUG].
> [   11.510771]
> [   11.510784] CPU: 0 PID: 147 Comm: kswapd0 Not tainted 5.10.0-rc4-00001-
> gade1ab542fdd #1
> [   11.513334] fuse: init (API version 7.32)
> [   11.515043] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.12.0-1 04/01/2014
> [   11.517040] JFS: nTxBlock = 8192, nTxLock = 65536
> [   11.517150] EIP: mem_cgroup_lruvec+0x1a/0x39
> [   11.517161] Code: eb 06 8d 44 91 4c 8b 00 85 c0 79 02 31 c0 5d c3 55 89 e5 89
> c1 e8 7e ff ff ff 84 c0 74 08 8d 82 54 0b 00 00 eb 19 85 c9 75 08 <0f> 0b 8b 0d 64
> 84 7b 50 8b 82 50 0a 00 00 8b 84 81 60 07 00 00 39
> [   11.521433] EAX: 00000000 EBX: 5078dfe0 ECX: 00000000 EDX: 5078dfe0
> [   11.522288] ESI: 00000000 EDI: 00000002 EBP: 41b39f30 ESP: 41b39f30
> [   11.523089] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [   11.524480] CR0: 80050033 CR2: 00000000 CR3: 108e1000 CR4: 00000690
> [   11.525772] Call Trace:
> [   11.526285]  ? prepare_kswapd_sleep+0x59/0x87
> [   11.527167]  ? kswapd+0xd7/0x354
> [   11.527897]  ? __wake_up_locked_sync_key+0x17/0x17
> [   11.528888]  ? kthread+0xea/0xef
> [   11.529537]  ? balance_pgdat+0x2df/0x2df
> [   11.530343]  ? __list_del_entry+0x1c/0x1c
> [   11.531234]  ? ret_from_fork+0x1c/0x30
> [   11.532077] irq event stamp: 199
> [   11.532751] hardirqs last  enabled at (207): [<4e2803ab>]
> console_unlock+0x479/0x4bb
> [   11.534133] hardirqs last disabled at (214): [<4e28018c>]
> console_unlock+0x25a/0x4bb
> [   11.535480] softirqs last  enabled at (230): [<4f34eb7f>]
> __do_softirq+0x2ef/0x31f
> [   11.536514] softirqs last disabled at (223): [<4e20a975>]
> call_on_stack+0x40/0x46
> [   11.536566] SGI XFS with security attributes, scrub, quota, debug enabled
> [   11.537477] random: get_random_bytes called from init_oops_id+0x23/0x3b
> with crng_init=0
> [   11.537487] ---[ end trace cf4f454a846def0a ]---
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.10.0-rc4-00001-gade1ab542fdd .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare
> modules_prepare bzImage modules
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 INSTALL_MOD_PATH=<mod-
> install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is
> attached in this email
> 
> 
> 
> Thanks,
> Oliver Sang

