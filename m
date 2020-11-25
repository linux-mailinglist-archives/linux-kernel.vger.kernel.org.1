Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A852E2C4975
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgKYVB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:01:58 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:59384 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730456AbgKYVB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:01:58 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2020 16:01:54 EST
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0APKo5le031346;
        Wed, 25 Nov 2020 20:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=2IR/yUx0b0hY4pwOCFiHY19GU0mpx7ueC8cQdYZt0Xs=;
 b=PDceBCNGv49oxJ+2Q64VC6MQxlbEr+vSg1gPBtFh4AI2A7A8guQwHqitCVekesmXCkyU
 8DdMeKs7wgTsg2WZMifKuPNc/4K1JBausrnXrNSkQPYWDihJXrGxYH2fumTE/gEeKpfU
 4ozsKve+FyYYfthRy2kK6Zrqe3XScdcgAk2nMf9qUAaSZA5xlajyJ2KEdwxfx09NvQtM
 xvJS9qlLZmdIvNZ9JvVFbfm7oJYfgFCiMBqYKa1Tql0TSoqm++TQsKoKoaH3YtYikvea
 hEXXsJIJr+uJH6SkQJ3BBf/SB+pPIc24YMksF7qMAk5UIq8vmIKcRTLGWDYAQ+aRzn2p nA== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 34y0vu06w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 20:54:39 +0000
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 0APKo4Q7017863;
        Wed, 25 Nov 2020 15:54:38 -0500
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint2.akamai.com with ESMTP id 34xy421d84-1;
        Wed, 25 Nov 2020 15:54:38 -0500
Received: from [0.0.0.0] (stag-ssh-gw01.bos01.corp.akamai.com [172.27.113.23])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 515E423FA4;
        Wed, 25 Nov 2020 20:54:38 +0000 (GMT)
Subject: Re: [PATCH 7/7] dyndbg: enable 'cache' of active pr_debug callsites
To:     Jim Cromie <jim.cromie@gmail.com>, linux-mm@kvack.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
References: <20201125193626.2266995-1-jim.cromie@gmail.com>
 <20201125193626.2266995-8-jim.cromie@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <d57d4f39-b9d3-99f0-6fd0-b3f072895edd@akamai.com>
Date:   Wed, 25 Nov 2020 15:54:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125193626.2266995-8-jim.cromie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_12:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=2 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250128
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_12:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=2 mlxlogscore=999 adultscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250128
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.19)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/20 2:36 PM, Jim Cromie wrote:
> In ddebug_putsite(), dont zs_unmap the callsite if it is enabled for
> printing.  This means that the next time this pr_debug callsite is
> executed, the _getsite() will succeed quickly without remapping the
> zrec.
> 
> Once the callsite is disabled via >control, a following _putsite()
> will see the flag cleared, and zs_unmap it.
> 
> This changes the lifetime of our zs_mappings from brief (only for the
> single printk) to as long as uptime (if a prdebug is enabled til
> poweroff).  This appears to be triggering the ensuing mayhem.
> 
> I am able to get through init, to root console, by disabling all
> dynamic-debugs, including the ones that are enabled at compile.
> 
> $ kruna --kopt \*.dyndbg=-p --kopt debug_locks_proceed=1
> 
> but enabling any pr-debug crashes.
> Plain old boot also panics, as pasted below.
> 


Hi Jim,

Looks like you've made a lot of progress with this series...but if I
understand correctly there are still some unresolved issues (panic).
So I think this series is more 'RFC' at this point?

I was also expecting to see updates to the actual printing functions
to now use dp->site. But perhaps I missed those bits?

Thanks,

-Jason

> $ kruna --kopt debug_locks_proceed=1
> 
> [    0.443926] -----------------------------------------------------------------
> [    0.445085] BUG:  14 unexpected failures (out of 350) - debugging proceeding anyway! |
> [    0.446498] -----------------------------------------------------------------
> ...
> [    0.617347] dyndbg: 224 modules, 2014 entries and 8960 bytes in ddebug tables, 80560 bytes in __dyndbg section, 80560 bytes in __dyndbg_callsites section
> [    0.617537] dyndbg: 2014 entries. repeated entries: 1789 module 1667 file 809 func
> ...
> [    1.456548] zswap: loaded using pool zstd/zsmalloc
> [    1.462802] dyndbg: total pages: 24 compaction: 0
> [    1.463965] PM:   Magic number: 12:980:889
> [    1.464860] BUG: sleeping function called from invalid context at mm/slab.h:506
> [    1.466150] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
> [    1.467282] 3 locks held by swapper/0/1:
> [    1.467936]  #0: ffffffff82875460 (cpu_hotplug_lock){++++}-{0:0}, at: cpufreq_register_driver+0xb5/0x2f0
> [    1.469622]  #1: ffff888003cfbd28 (subsys mutex#5){+.+.}-{4:4}, at: subsys_interface_register+0x5f/0x130
> [    1.471448]  #2: ffff8880057f00b0 (&zspage->lock){.+.+}-{3:3}, at: zs_map_object+0x7b/0x2b0
> [    1.472666] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc3-00304-g7a4ad0dc5042 #75
> [    1.474007] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-3.fc33 04/01/2014
> [    1.475314] Call Trace:
> [    1.475682]  dump_stack+0x7d/0x9f
> [    1.476162]  ___might_sleep.cold+0xa6/0xb7
> [    1.476745]  __might_sleep+0x46/0x80
> [    1.477266]  __kmalloc_track_caller+0x1dd/0x2d0
> [    1.477895]  kstrdup_const+0x45/0x70
> [    1.478678]  __kernfs_new_node+0x4b/0x280
> [    1.479280]  ? dynamic_emit_prefix+0x1dd/0x1f0
> [    1.479907]  ? __dynamic_pr_debug+0x8a/0xb0
> [    1.480496]  kernfs_create_dir_ns+0x44/0xc0
> [    1.481188]  sysfs_create_dir_ns+0x6c/0xd0
> [    1.481820]  kobject_add_internal+0x102/0x300
> [    1.482505]  kobject_init_and_add+0x71/0xa0
> [    1.483194]  ? kmem_cache_alloc_trace+0x21d/0x270
> [    1.483993]  ? cpufreq_online+0x62/0x960
> [    1.484628]  cpufreq_online+0xa5/0x960
> [    1.485325]  ? system_root_device_release+0x10/0x10
> [    1.486223]  cpufreq_add_dev+0x79/0x90
> [    1.486868]  subsys_interface_register+0x11e/0x130
> [    1.487787]  cpufreq_register_driver+0x171/0x2f0
> [    1.488679]  acpi_cpufreq_init+0x266/0x294
> [    1.489508]  ? CPU_FREQ_GOV_ONDEMAND_init+0x12/0x12
> [    1.490350]  do_one_initcall+0x5a/0x2c0
> [    1.491037]  ? rcu_read_lock_sched_held+0x41/0x80
> [    1.491820]  kernel_init_freeable+0x23b/0x287
> [    1.492561]  ? rest_init+0x24d/0x24d
> [    1.493180]  kernel_init+0x9/0x103
> [    1.493825]  ret_from_fork+0x22/0x30
> [    1.494557]
> [    1.494804] =============================
> [    1.495503] [ BUG: Invalid wait context ]
> [    1.496134] 5.10.0-rc3-00304-g7a4ad0dc5042 #75 Tainted: G        W
> [    1.497346] -----------------------------
> [    1.497986] swapper/0/1 is trying to lock:
> [    1.498668] ffffffff8299ad90 (iattr_mutex){+.+.}-{4:4}, at: kernfs_xattr_get+0x25/0x60
> [    1.499855] other info that might help us debug this:
> [    1.500655] context-{5:5}
> [    1.501118] 3 locks held by swapper/0/1:
> [    1.501732]  #0: ffffffff82875460 (cpu_hotplug_lock){++++}-{0:0}, at: cpufreq_register_driver+0xb5/0x2f0
> [    1.503384]  #1: ffff888003cfbd28 (subsys mutex#5){+.+.}-{4:4}, at: subsys_interface_register+0x5f/0x130
> [    1.505289]  #2: ffff8880057f00b0 (&zspage->lock){.+.+}-{3:3}, at: zs_map_object+0x7b/0x2b0
> [    1.506743] stack backtrace:
> [    1.507228] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-rc3-00304-g7a4ad0dc5042 #75
> [    1.509060] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-3.fc33 04/01/2014
> [    1.510505] Call Trace:
> [    1.510887]  dump_stack+0x7d/0x9f
> [    1.511456]  __lock_acquire.cold+0xb9/0x2cd
> [    1.512389]  ? usage_match+0x20/0x20
> [    1.512960]  ? __bfs+0xf3/0x220
> [    1.513442]  lock_acquire+0x137/0x3e0
> [    1.514069]  ? kernfs_xattr_get+0x25/0x60
> [    1.514724]  ? ___might_sleep+0x15c/0x190
> [    1.515369]  __mutex_lock+0x8e/0x940
> [    1.515866]  ? kernfs_xattr_get+0x25/0x60
> [    1.516515]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
> [    1.517343]  ? kernfs_xattr_get+0x25/0x60
> [    1.517884]  mutex_lock_nested+0x16/0x20
> [    1.518577]  kernfs_xattr_get+0x25/0x60
> [    1.519151]  selinux_kernfs_init_security+0x5c/0x210
> [    1.519822]  ? sched_clock+0x9/0x10
> [    1.520513]  ? sched_clock_cpu+0x11/0xc0
> [    1.521172]  security_kernfs_init_security+0x2a/0x40
> [    1.522164]  __kernfs_new_node+0x1b7/0x280
> [    1.522842]  ? dynamic_emit_prefix+0x1dd/0x1f0
> [    1.523610]  ? __dynamic_pr_debug+0x8a/0xb0
> [    1.524350]  kernfs_create_dir_ns+0x44/0xc0
> [    1.525033]  sysfs_create_dir_ns+0x6c/0xd0
> [    1.525682]  kobject_add_internal+0x102/0x300
> [    1.526384]  kobject_init_and_add+0x71/0xa0
> [    1.527138]  ? kmem_cache_alloc_trace+0x21d/0x270
> [    1.527869]  ? cpufreq_online+0x62/0x960
> [    1.528566]  cpufreq_online+0xa5/0x960
> [    1.529461]  ? system_root_device_release+0x10/0x10
> [    1.530273]  cpufreq_add_dev+0x79/0x90
> [    1.530886]  subsys_interface_register+0x11e/0x130
> [    1.531591]  cpufreq_register_driver+0x171/0x2f0
> [    1.532251]  acpi_cpufreq_init+0x266/0x294
> [    1.532803]  ? CPU_FREQ_GOV_ONDEMAND_init+0x12/0x12
> [    1.533524]  do_one_initcall+0x5a/0x2c0
> [    1.534196]  ? rcu_read_lock_sched_held+0x41/0x80
> [    1.535008]  kernel_init_freeable+0x23b/0x287
> [    1.535706]  ? rest_init+0x24d/0x24d
> [    1.536314]  kernel_init+0x9/0x103
> [    1.536903]  ret_from_fork+0x22/0x30
> [    1.537555] kobject: 'policy0' (0000000099a22e3a): kobject_cleanup, parent 000000008a313735
> [    1.538996] kobject: 'policy0' (0000000099a22e3a): auto cleanup kobject_del
> [    1.540082] kobject: 'policy0' (0000000099a22e3a): calling ktype release
> [    1.541143] kobject: 'policy0': free name
> [    1.541750] ------------[ cut here ]------------
> [    1.542630] initcall acpi_cpufreq_init+0x0/0x294 returned with preemption imbalance
> [    1.544046] WARNING: CPU: 0 PID: 1 at init/main.c:1230 do_one_initcall+0x220/0x2c0
> [    1.545335] Modules linked in:
> [    1.545846] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-rc3-00304-g7a4ad0dc5042 #75
> [    1.547549] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-3.fc33 04/01/2014
> [    1.549121] RIP: 0010:do_one_initcall+0x220/0x2c0
> [    1.549983] Code: 74 09 80 3d 9a 6a aa 01 00 74 50 65 ff 0d a8 5f 01 7f e9 48 fe ff ff 48 8d 55 a0 4c 89 e6 48 c7 c7 60 fb 55 82 e8 4e e1 d2 00 <0f> 0b e9 c6 fe ff ff e8 b4 de 17 00 85 c0 75 a5 48 c7 c2 38 f9 55
> [    1.553209] RSP: 0000:ffffc90000013ea0 EFLAGS: 00010286
> [    1.554326] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000ffffdfff
> [    1.555682] RDX: 00000000ffffdfff RSI: ffffffff8116c1cd RDI: ffffffff8116c326
> [    1.556869] RBP: ffffc90000013f00 R08: 0000000000000000 R09: 0000000000000000
> [    1.558111] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: ffffffff82d5550a
> [    1.559357] R13: 00000000ffffffed R14: ffffffff82e0a940 R15: ffff888003d313e0
> [    1.560577] FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:0000000000000000
> [    1.562159] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.563285] CR2: 0000000000000000 CR3: 0000000002824001 CR4: 0000000000370ef0
> [    1.564578] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.565924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    1.567224] Call Trace:
> [    1.567665]  ? rcu_read_lock_sched_held+0x41/0x80
> [    1.568565]  kernel_init_freeable+0x23b/0x287
> [    1.569420]  ? rest_init+0x24d/0x24d
> [    1.570103]  kernel_init+0x9/0x103
> [    1.570736]  ret_from_fork+0x22/0x30
> [    1.571750] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-rc3-00304-g7a4ad0dc5042 #75
> [    1.573387] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-3.fc33 04/01/2014
> [    1.575132] Call Trace:
> [    1.575538]  dump_stack+0x7d/0x9f
> [    1.576085]  ? do_one_initcall+0x220/0x2c0
> [    1.576744]  __warn.cold+0x24/0x85
> [    1.577522]  ? do_one_initcall+0x220/0x2c0
> [    1.578287]  report_bug+0xa1/0xc0
> [    1.578812]  handle_bug+0x45/0x90
> [    1.579376]  exc_invalid_op+0x19/0x70
> [    1.579994]  asm_exc_invalid_op+0x12/0x20
> [    1.580649] RIP: 0010:do_one_initcall+0x220/0x2c0
> [    1.581497] Code: 74 09 80 3d 9a 6a aa 01 00 74 50 65 ff 0d a8 5f 01 7f e9 48 fe ff ff 48 8d 55 a0 4c 89 e6 48 c7 c7 60 fb 55 82 e8 4e e1 d2 00 <0f> 0b e9 c6 fe ff ff e8 b4 de 17 00 85 c0 75 a5 48 c7 c2 38 f9 55
> [    1.584556] RSP: 0000:ffffc90000013ea0 EFLAGS: 00010286
> [    1.585491] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000ffffdfff
> [    1.586739] RDX: 00000000ffffdfff RSI: ffffffff8116c1cd RDI: ffffffff8116c326
> [    1.588054] RBP: ffffc90000013f00 R08: 0000000000000000 R09: 0000000000000000
> [    1.589347] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: ffffffff82d5550a
> [    1.590800] R13: 00000000ffffffed R14: ffffffff82e0a940 R15: ffff888003d313e0
> [    1.592131]  ? CPU_FREQ_GOV_ONDEMAND_init+0x12/0x12
> [    1.593085]  ? console_unlock+0x37d/0x5c0
> [    1.593785]  ? console_unlock+0x4d6/0x5c0
> [    1.594484]  ? rcu_read_lock_sched_held+0x41/0x80
> [    1.595303]  kernel_init_freeable+0x23b/0x287
> [    1.596049]  ? rest_init+0x24d/0x24d
> [    1.596650]  kernel_init+0x9/0x103
> [    1.597232]  ret_from_fork+0x22/0x30
> [    1.597872] irq event stamp: 1862449
> [    1.598517] hardirqs last  enabled at (1862449): [<ffffffff81d80a15>] irqentry_exit+0x35/0x80
> [    1.600046] hardirqs last disabled at (1862448): [<ffffffff81d7f350>] sysvec_apic_timer_interrupt+0x10/0xb0
> [    1.601801] softirqs last  enabled at (1862354): [<ffffffff81e00fa2>] asm_call_irq_on_stack+0x12/0x20
> [    1.603419] softirqs last disabled at (1862345): [<ffffffff81e00fa2>] asm_call_irq_on_stack+0x12/0x20
> [    1.605203] ---[ end trace ecd8f90d8b1f2ab8 ]---
> [    1.606532] ata2.01: NODEV after polling detection
> [    1.607776] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [    1.609726] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
> [    1.611649] kobject: 'target1:0:0' (0000000025bf58b2): kobject_add_internal: parent: 'host1', set: 'devices'
> [    1.613564] main:device_pm_add: PM: Adding info for scsi:target1:0:0
> [    1.614679] kobject: 'target1:0:0' (0000000025bf58b2): kobject_uevent_env
> [    1.615975] kobject: 'target1:0:0' (0000000025bf58b2): fill_kobj_path: path = '/devices/pci0000:00/0000:00:01.1/ata2/host1/target1:0:0'
> [    1.618095] kobject: '1:0:0:0' (00000000429180e9): kobject_add_internal: parent: 'target1:0:0', set: 'devices'
> [    1.619807] main:device_pm_add: PM: Adding info for scsi:1:0:0:0
> [    1.621053] kobject: '1:0:0:0' (00000000429180e9): kobject_uevent_env
> [    1.622564] kobject: '1:0:0:0' (00000000429180e9): fill_kobj_path: path = '/devices/pci0000:00/0000:00:01.1/ata2/host1/target1:0:0/1:0:0:0'
> [    1.624691] BUG: scheduling while atomic: kworker/u2:0/7/0x0000000d
> [    1.625799] INFO: lockdep is turned off.
> [    1.626446] Modules linked in:
> [    1.626908] CPU: 0 PID: 7 Comm: kworker/u2:0 Tainted: G        W         5.10.0-rc3-00304-g7a4ad0dc5042 #75
> [    1.628455] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-3.fc33 04/01/2014
> [    1.629774] Workqueue: events_unbound async_run_entry_fn
> [    1.630649] Call Trace:
> [    1.631053]  dump_stack+0x7d/0x9f
> [    1.631617]  __schedule_bug.cold+0x5f/0x70
> [    1.632263]  __schedule+0x823/0x9c0
> [    1.632806]  ? lock_release+0x1e1/0x3f0
> [    1.633382]  ? hctx_unlock+0x1a/0xb0
> [    1.633975]  ? wait_for_completion_io+0x7e/0x110
> [    1.634749]  schedule+0x63/0xe0
> [    1.635311]  schedule_timeout+0x175/0x1e0
> [    1.636004]  ? __blk_mq_delay_run_hw_queue+0x16d/0x180
> [    1.636847]  ? lock_acquired+0x1ef/0x380
> [    1.637630]  ? lock_release+0x1e1/0x3f0
> [    1.638484]  ? wait_for_completion_io+0xa1/0x110
> [    1.639208]  ? _raw_spin_unlock_irq+0x23/0x40
> [    1.639877]  io_schedule_timeout+0x4b/0x80
> [    1.640614]  wait_for_completion_io+0xa9/0x110
> [    1.641355]  blk_execute_rq+0x7f/0xb0
> [    1.641905]  __scsi_execute+0x109/0x260
> [    1.642545]  scsi_test_unit_ready+0x5b/0xe0
> [    1.643275]  sr_probe+0x23b/0x610
> [    1.643782]  really_probe+0x3ad/0x460
> [    1.644400]  driver_probe_device+0xe4/0x150
> [    1.645112]  __device_attach_driver+0x6c/0xd0
> [    1.645837]  ? driver_allows_async_probing+0x50/0x50
> [    1.646679]  bus_for_each_drv+0x82/0xd0
> [    1.647285]  __device_attach+0xde/0x1e0
> [    1.647886]  device_initial_probe+0xe/0x10
> [    1.648525]  bus_probe_device+0x9b/0xb0
> [    1.649077]  device_add+0x3b8/0x840
> [    1.649674]  scsi_sysfs_add_sdev+0x91/0x290
> [    1.650393]  scsi_probe_and_add_lun+0x83f/0xbe0
> [    1.651325]  __scsi_add_device+0x10a/0x120
> [    1.652020]  ata_scsi_scan_host+0x98/0x1d0
> [    1.652598]  ? wait_woken+0xb0/0xb0
> [    1.653146]  async_port_probe+0x56/0x70
> [    1.653679]  async_run_entry_fn+0x37/0x150
> [    1.654395]  process_one_work+0x277/0x590
> [    1.655278]  worker_thread+0x50/0x400
> [    1.655802]  kthread+0x14c/0x170
> [    1.656322]  ? process_one_work+0x590/0x590
> [    1.656890]  ? __kthread_bind_mask+0x70/0x70
> [    1.657659]  ret_from_fork+0x22/0x30
> [    1.658512] kobject: 'memmap' (000000007533e45a): kobject_add_internal: parent: 'firmware', set: '<NULL>'
> [    1.660202] kobject: 'memmap' (000000007533e45a): kobject_uevent_env
> [    1.661228] kobject: 'memmap' (000000007533e45a): kobject_uevent_env: attempted to send uevent without kset!
> [    1.662681] kobject: '0' (00000000ba522565): kobject_add_internal: parent: 'memmap', set: 'memmap'
> [    1.664100] kobject: '1' (00000000387ad507): kobject_add_internal: parent: 'memmap', set: 'memmap'
> [    1.665482] kobject: '2' (00000000c4547872): kobject_add_internal: parent: 'memmap', set: 'memmap'
> [    1.666863] kobject: '3' (00000000d3a84794): kobject_add_internal: parent: 'memmap', set: 'memmap'
> [    1.668227] kobject: '4' (0000000059225206): kobject_add_internal: parent: 'memmap', set: 'memmap'
> [    1.669573] kobject: '5' (000000009bfaeef6): kobject_add_internal: parent: 'memmap', set: 'memmap'
> [    1.671050] kobject: '6' (00000000fdded59a): kobject_add_internal: parent: 'memmap', set: 'memmap'
> [    1.672667] ------------[ cut here ]------------
> [    1.673345] initcall firmware_memmap_init+0x0/0x33 returned with preemption imbalance
> [    1.674447] WARNING: CPU: 0 PID: 1 at init/main.c:1230 do_one_initcall+0x220/0x2c0
> [    1.675557] Modules linked in:
> [    1.676071] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-rc3-00304-g7a4ad0dc5042 #75
> [    1.677657] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-3.fc33 04/01/2014
> [    1.678872] RIP: 0010:do_one_initcall+0x220/0x2c0
> [    1.679730] Code: 74 09 80 3d 9a 6a aa 01 00 74 50 65 ff 0d a8 5f 01 7f e9 48 fe ff ff 48 8d 55 a0 4c 89 e6 48 c7 c7 60 fb 55 82 e8 4e e1 d2 00 <0f> 0b e9 c6 fe ff ff e8 b4 de 17 00 85 c0 75 a5 48 c7 c2 38 f9 55
> [    1.682846] RSP: 0000:ffffc90000013ea0 EFLAGS: 00010286
> [    1.683829] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000ffffdfff
> [    1.684931] RDX: 00000000ffffdfff RSI: ffffffff8116c1cd RDI: ffffffff8116c326
> [    1.686030] RBP: ffffc90000013f00 R08: 0000000000000000 R09: 0000000000000000
> [    1.687084] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: ffffffff82d573c1
> [    1.688257] R13: 0000000000000000 R14: ffffffff82e0a944 R15: ffff888003d313e0
> [    1.689795] FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:0000000000000000
> [    1.691023] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.692094] CR2: 0000000000000000 CR3: 0000000002824001 CR4: 0000000000370ef0
> [    1.693237] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.694366] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    1.695536] Call Trace:
> [    1.695877]  ? rcu_read_lock_sched_held+0x41/0x80
> [    1.696667]  kernel_init_freeable+0x23b/0x287
> [    1.697404]  ? rest_init+0x24d/0x24d
> [    1.697968]  kernel_init+0x9/0x103
> [    1.698487]  ret_from_fork+0x22/0x30
> [    1.699071] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-rc3-00304-g7a4ad0dc5042 #75
> [    1.700595] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-3.fc33 04/01/2014
> [    1.702034] Call Trace:
> [    1.702383]  dump_stack+0x7d/0x9f
> [    1.702967]  ? do_one_initcall+0x220/0x2c0
> [    1.703649]  __warn.cold+0x24/0x85
> [    1.704217]  ? do_one_initcall+0x220/0x2c0
> [    1.705099]  report_bug+0xa1/0xc0
> [    1.705575]  handle_bug+0x45/0x90
> [    1.706066]  exc_invalid_op+0x19/0x70
> [    1.706547]  asm_exc_invalid_op+0x12/0x20
> [    1.707180] RIP: 0010:do_one_initcall+0x220/0x2c0
> [    1.707855] Code: 74 09 80 3d 9a 6a aa 01 00 74 50 65 ff 0d a8 5f 01 7f e9 48 fe ff ff 48 8d 55 a0 4c 89 e6 48 c7 c7 60 fb 55 82 e8 4e e1 d2 00 <0f> 0b e9 c6 fe ff ff e8 b4 de 17 00 85 c0 75 a5 48 c7 c2 38 f9 55
> [    1.710508] RSP: 0000:ffffc90000013ea0 EFLAGS: 00010286
> [    1.711470] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000ffffdfff
> [    1.712933] RDX: 00000000ffffdfff RSI: ffffffff8116c1cd RDI: ffffffff8116c326
> [    1.714146] RBP: ffffc90000013f00 R08: 0000000000000000 R09: 0000000000000000
> [    1.715350] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: ffffffff82d573c1
> [    1.716701] R13: 0000000000000000 R14: ffffffff82e0a944 R15: ffff888003d313e0
> [    1.717854]  ? dmi_id_init+0x386/0x386
> [    1.718486]  ? console_unlock+0x37d/0x5c0
> [    1.719158]  ? console_unlock+0x4d6/0x5c0
> [    1.719772]  ? rcu_read_lock_sched_held+0x41/0x80
> [    1.720641]  kernel_init_freeable+0x23b/0x287
> [    1.721566]  ? rest_init+0x24d/0x24d
> [    1.722230]  kernel_init+0x9/0x103
> [    1.722680]  ret_from_fork+0x22/0x30
> [    1.723276] irq event stamp: 1862449
> [    1.723894] hardirqs last  enabled at (1862449): [<ffffffff81d80a15>] irqentry_exit+0x35/0x80
> [    1.725695] hardirqs last disabled at (1862448): [<ffffffff81d7f350>] sysvec_apic_timer_interrupt+0x10/0xb0
> [    1.727307] softirqs last  enabled at (1862354): [<ffffffff81e00fa2>] asm_call_irq_on_stack+0x12/0x20
> [    1.728795] softirqs last disabled at (1862345): [<ffffffff81e00fa2>] asm_call_irq_on_stack+0x12/0x20
> [    1.730347] ---[ end trace ecd8f90d8b1f2ab9 ]---
> [    1.731171] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    1.732579] kworker/u2:1 (62) used greatest stack depth: 14536 bytes left
> [    1.734275] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> [    1.735368] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    1.736684] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    1.737871] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [    1.739479] ALSA device list:
> [    1.739928] cfg80211: failed to load regulatory.db
> [    1.740784]   No soundcards found.
> [    1.741597] kobject: 'regulatory.0' (00000000ab092cdd): kobject_uevent_env
> [    1.742766] kobject: 'regulatory.0' (00000000ab092cdd): fill_kobj_path: path = '/devices/platform/regulatory.0'
> [    1.750002] kobject: '11:0' (0000000035d88d42): kobject_add_internal: parent: 'bdi', set: 'devices'
> [    1.751742] main:device_pm_add: PM: Adding info for No Bus:11:0
> [    1.752660] kobject: '11:0' (0000000035d88d42): kobject_uevent_env
> [    1.753722] kobject: '11:0' (0000000035d88d42): fill_kobj_path: path = '/devices/virtual/bdi/11:0'
> [    1.755338] kobject: 'block' (00000000da37173c): kobject_add_internal: parent: '1:0:0:0', set: '(null)'
> [    1.757024] kobject: 'sr0' (000000000b128df7): kobject_add_internal: parent: 'block', set: 'devices'
> [    1.758667] main:device_pm_add: PM: Adding info for No Bus:sr0
> [    1.759667] kobject: 'sr0' (000000000b128df7): kobject_uevent_env
> [    1.760836] kobject: 'sr0' (000000000b128df7): kobject_uevent_env: uevent_suppress caused the event to drop!
> [    1.762452] kobject: 'holders' (00000000e28bd786): kobject_add_internal: parent: 'sr0', set: '<NULL>'
> [    1.763972] kobject: 'slaves' (00000000b2ff8eb3): kobject_add_internal: parent: 'sr0', set: '<NULL>'
> [    1.765611] kobject: 'sr0' (000000000b128df7): kobject_uevent_env
> [    1.766705] kobject: 'sr0' (000000000b128df7): fill_kobj_path: path = '/devices/pci0000:00/0000:00:01.1/ata2/host1/target1:0:0/1:0:0:0/block/sr0'
> [    1.769006] kobject: 'queue' (00000000fbf3c544): kobject_add_internal: parent: 'sr0', set: '<NULL>'
> [    1.770551] kobject: 'mq' (0000000001f3c10f): kobject_add_internal: parent: 'sr0', set: '<NULL>'
> [    1.772069] kobject: 'mq' (0000000001f3c10f): kobject_uevent_env
> [    1.773222] kobject: 'mq' (0000000001f3c10f): kobject_uevent_env: filter function caused the event to drop!
> [    1.775037] kobject: '0' (0000000078f2eddd): kobject_add_internal: parent: 'mq', set: '<NULL>'
> [    1.776604] kobject: 'cpu0' (000000007c3dee23): kobject_add_internal: parent: '0', set: '<NULL>'
> [    1.778217] kobject: 'iosched' (000000003e5ac6f7): kobject_add_internal: parent: 'queue', set: '<NULL>'
> [    1.779683] kobject: 'queue' (00000000fbf3c544): kobject_uevent_env
> [    1.780580] kobject: 'queue' (00000000fbf3c544): kobject_uevent_env: filter function caused the event to drop!
> [    1.782265] kobject: 'iosched' (000000003e5ac6f7): kobject_uevent_env
> [    1.783231] kobject: 'iosched' (000000003e5ac6f7): kobject_uevent_env: filter function caused the event to drop!
> [    1.784761] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [    1.785487] kobject: '1:0:0:0' (00000000429180e9): kobject_uevent_env
> [    1.786681] kobject: '1:0:0:0' (00000000429180e9): fill_kobj_path: path = '/devices/pci0000:00/0000:00:01.1/ata2/host1/target1:0:0/1:0:0:0'
> [    1.788806] kobject: 'scsi_device' (00000000fc009276): kobject_add_internal: parent: '1:0:0:0', set: '(null)'
> [    1.790501] kobject: '1:0:0:0' (0000000035d4f17d): kobject_add_internal: parent: 'scsi_device', set: 'devices'
> [    1.792243] main:device_pm_add: PM: Adding info for No Bus:1:0:0:0
> [    1.793265] kobject: '1:0:0:0' (0000000035d4f17d): kobject_uevent_env
> [    1.794301] kobject: '1:0:0:0' (0000000035d4f17d): fill_kobj_path: path = '/devices/pci0000:00/0000:00:01.1/ata2/host1/target1:0:0/1:0:0:0/scsi_device/1:0:0:0'
> [    1.796564] kobject: 'scsi_generic' (00000000d5199ad9): kobject_add_internal: parent: '1:0:0:0', set: '(null)'
> [    1.798157] kobject: 'sg0' (00000000da2b5c82): kobject_add_internal: parent: 'scsi_generic', set: 'devices'
> [    1.799695] main:device_pm_add: PM: Adding info for No Bus:sg0
> [    1.800732] BUG: scheduling while atomic: kworker/u2:0/7/0x00000009
> [    1.801776] INFO: lockdep is turned off.
> [    1.802463] Modules linked in:
> [    1.802948] CPU: 0 PID: 7 Comm: kworker/u2:0 Tainted: G        W         5.10.0-rc3-00304-g7a4ad0dc5042 #75
> [    1.804667] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-3.fc33 04/01/2014
> [    1.806213] Workqueue: events_unbound async_run_entry_fn
> [    1.807254] Call Trace:
> [    1.807659]  dump_stack+0x7d/0x9f
> [    1.808232]  __schedule_bug.cold+0x5f/0x70
> [    1.808793]  __schedule+0x823/0x9c0
> [    1.809602]  ? wait_for_completion+0x7e/0x110
> [    1.810402]  schedule+0x63/0xe0
> [    1.810994]  schedule_timeout+0x175/0x1e0
> [    1.811661]  ? lock_release+0x1e1/0x3f0
> [    1.812329]  ? try_to_wake_up+0x1fe/0x740
> [    1.813004]  ? lock_acquired+0x1ef/0x380
> [    1.813607]  ? lock_release+0x1e1/0x3f0
> [    1.814286]  ? wait_for_completion+0xa1/0x110
> [    1.814998]  ? _raw_spin_unlock_irq+0x23/0x40
> [    1.815669]  ? trace_hardirqs_on+0x2a/0xe0
> [    1.816348]  ? wait_for_completion+0x7e/0x110
> [    1.817080]  wait_for_completion+0xa9/0x110
> [    1.817744]  devtmpfs_submit_req+0x6e/0x80
> [    1.818434]  devtmpfs_create_node+0x9e/0xd0
> [    1.819138]  device_add+0x729/0x840
> [    1.819697]  device_create_groups_vargs+0xcf/0xf0
> [    1.820539]  device_create+0x44/0x60
> [    1.821159]  ? cdev_add+0x51/0x80
> [    1.821671]  sg_add_device+0x292/0x410
> [    1.822323]  device_add+0x449/0x840
> [    1.822976]  scsi_sysfs_add_sdev+0x1be/0x290
> [    1.823605]  scsi_probe_and_add_lun+0x83f/0xbe0
> [    1.824332]  __scsi_add_device+0x10a/0x120
> [    1.825052]  ata_scsi_scan_host+0x98/0x1d0
> [    1.825756]  ? wait_woken+0xb0/0xb0
> [    1.826400]  async_port_probe+0x56/0x70
> [    1.827026]  async_run_entry_fn+0x37/0x150
> [    1.827752]  process_one_work+0x277/0x590
> [    1.828530]  worker_thread+0x50/0x400
> [    1.829177]  kthread+0x14c/0x170
> [    1.829654]  ? process_one_work+0x590/0x590
> [    1.830318]  ? __kthread_bind_mask+0x70/0x70
> [    1.830901]  ret_from_fork+0x22/0x30
> [    1.831718] kobject: 'sr0' (000000000b128df7): kobject_uevent_env
> [    1.832675] kobject: 'sr0' (000000000b128df7): fill_kobj_path: path = '/devices/pci0000:00/0000:00:01.1/ata2/host1/target1:0:0/1:0:0:0/block/sr0'
> [    1.834777] kobject: 'sg0' (00000000da2b5c82): kobject_uevent_env
> [    1.835860] kobject: 'sg0' (00000000da2b5c82): fill_kobj_path: path = '/devices/pci0000:00/0000:00:01.1/ata2/host1/target1:0:0/1:0:0:0/scsi_generic/sg0'
> [    1.838069] sr 1:0:0:0: Attached scsi generic sg0 type 5
> [    1.838805] kobject: 'bsg' (000000005c2815cf): kobject_add_internal: parent: '1:0:0:0', set: '(null)'
> [    1.840435] kobject: '1:0:0:0' (00000000ad96192e): kobject_add_internal: parent: 'bsg', set: 'devices'
> [    1.841929] main:device_pm_add: PM: Adding info for No Bus:1:0:0:0
> [    1.842964] kobject: '1:0:0:0' (00000000ad96192e): kobject_uevent_env
> [    1.844087] kobject: '1:0:0:0' (00000000ad96192e): fill_kobj_path: path = '/devices/pci0000:00/0000:00:01.1/ata2/host1/target1:0:0/1:0:0:0/bsg/1:0:0:0'
> [    1.846261] md: Skipping autodetection of RAID arrays. (raid=autodetect will force)
> [    1.847813] kobject: '9p-fcall-cache' (00000000acb65d7d): kobject_add_internal: parent: 'slab', set: 'slab'
> [    1.849788] kobject: '9p-1' (00000000f8fd831c): kobject_add_internal: parent: 'bdi', set: 'devices'
> [    1.851175] main:device_pm_add: PM: Adding info for No Bus:9p-1
> [    1.852055] kobject: '9p-1' (00000000f8fd831c): kobject_uevent_env
> [    1.852906] kobject: '9p-1' (00000000f8fd831c): fill_kobj_path: path = '/devices/virtual/bdi/9p-1'
> [    1.854695] VFS: Mounted root (9p filesystem) readonly on device 0:19.
> [    1.856048] devtmpfs: mounted
> [    1.857202] Freeing unused kernel image (initmem) memory: 3024K
> [    1.858545] Write protecting the kernel read-only data: 24576k
> [    1.860621] Freeing unused kernel image (text/rodata gap) memory: 2028K
> [    1.862354] Freeing unused kernel image (rodata/data gap) memory: 1008K
> [    1.863493] Run /bin/sh as init process
> [    1.864131] main:run_init_process:   with arguments:
> [    1.864902] main:run_init_process:     /bin/sh
> [    1.865869] main:run_init_process:     -c
> [    1.866527] main:run_init_process:     mount -t tmpfs run /run;mkdir -p /run/virtme/guesttools;/bin/mount -n -t 9p -o ro,version=9p2000.L,trans=virtio,access=any virtme.guesttools /run/virtme/guesttools;exec /run/virtme/guesttools/virtme-init
> [    1.869845] main:run_init_process:   with environment:
> [    1.870634] main:run_init_process:     HOME=/
> [    1.871304] main:run_init_process:     TERM=xterm-256color
> [    1.872359] main:run_init_process:     virtme_link_mods=/home/jimc/projects/lx/linux.git/builds/v2/.virtme_mods/lib/modules/0.0.0
> [    1.874369] main:run_init_process:     virtme_stty_con=rows 24 cols 154 iutf8
> [    1.875652] main:run_init_process:     multidevs=remap
> [    1.876632] BUG: scheduling while atomic: swapper/0/1/0x00000011
> [    1.877856] INFO: lockdep is turned off.
> [    1.878502] Modules linked in:
> [    1.879028] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-rc3-00304-g7a4ad0dc5042 #75
> [    1.880594] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-3.fc33 04/01/2014
> [    1.882022] Call Trace:
> [    1.882410]  dump_stack+0x7d/0x9f
> [    1.883045]  __schedule_bug.cold+0x5f/0x70
> [    1.883766]  __schedule+0x823/0x9c0
> [    1.884524]  schedule+0x63/0xe0
> [    1.885126]  p9_client_rpc+0x13b/0x6e0
> [    1.885723]  ? wait_woken+0xb0/0xb0
> [    1.886332]  p9_client_walk+0x80/0x2e0
> [    1.887059]  ? d_alloc_parallel+0x3c8/0xa40
> [    1.887735]  ? get_page_from_freelist+0x3ce/0x13b0
> [    1.888758]  v9fs_vfs_lookup.part.0+0x65/0x1a0
> [    1.889570]  v9fs_vfs_lookup+0x1a/0x20
> [    1.890345]  __lookup_slow+0x108/0x1e0
> [    1.891012]  ? lock_acquire+0x174/0x3e0
> [    1.891705]  ? lock_acquire+0x174/0x3e0
> [    1.892343]  walk_component+0x13c/0x1b0
> [    1.892994]  ? security_inode_permission+0x30/0x50
> [    1.893752]  link_path_walk.part.0+0x21a/0x350
> [    1.894473]  path_openat+0xb0/0xa40
> [    1.895058]  ? _raw_spin_unlock+0x1e/0x30
> [    1.895717]  ? follow_page_mask+0x491/0x600
> [    1.896625]  do_filp_open+0x87/0x130
> [    1.897171]  ? __might_sleep+0x46/0x80
> [    1.897795]  ? _cond_resched+0x15/0x50
> [    1.898370]  ? __kmalloc+0x1f9/0x2c0
> [    1.898875]  ? lock_acquire+0x174/0x3e0
> [    1.899420]  ? avc_disable+0x20/0x20
> [    1.899930]  do_open_execat+0x66/0x1a0
> [    1.900456]  bprm_execve+0x1fe/0x8f0
> [    1.901019]  ? ___might_sleep+0x42/0x190
> [    1.901692]  kernel_execve+0x132/0x1b0
> [    1.902281]  run_init_process+0xc0/0xc5
> [    1.902972]  ? rest_init+0x24d/0x24d
> [    1.903587]  kernel_init+0x96/0x103
> [    1.904160]  ret_from_fork+0x22/0x30
> [    1.908649] Kernel panic - not syncing: Requested init /bin/sh failed (error -14).
> [    1.910091] CPU: 0 PID: 1 Comm: sh Tainted: G        W         5.10.0-rc3-00304-g7a4ad0dc5042 #75
> [    1.911517] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-3.fc33 04/01/2014
> [    1.912845] Call Trace:
> [    1.913289]  dump_stack+0x7d/0x9f
> [    1.913957]  ? rest_init+0x210/0x24d
> [    1.914535]  panic+0x10a/0x2de
> [    1.915094]  ? kernel_execve+0x145/0x1b0
> [    1.915768]  ? rest_init+0x24d/0x24d
> [    1.916417]  kernel_init+0xaf/0x103
> [    1.917038]  ret_from_fork+0x22/0x30
> [    1.917726] Kernel Offset: disabled
> [    1.918324] ---[ end Kernel panic - not syncing: Requested init /bin/sh failed (error -14). ]---
> QEMU 5.1.0 monitor - type 'help' for more information
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/dynamic_debug.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 534d73e45844..0c69aa52395d 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -165,7 +165,9 @@ static void ddebug_putsite(struct _ddebug *dp)
>  		/* need to keep site until zmap backing exists */
>  		return;
>  
> -	/* always unmap for now. if !pr-debug has locking issues */
> +	if (dp->flags & _DPRINTK_FLAGS_PRINT)
> +		return; /* keep maps of enabled pr_debugs */
> +
>  	zs_unmap_object(dd_callsite_zpool, dp->zhandle);
>  	dp->site = NULL;
>  }
> 
