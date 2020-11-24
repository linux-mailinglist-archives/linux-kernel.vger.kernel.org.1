Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6202C2530
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbgKXMC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:02:27 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59133 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729173AbgKXMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:02:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UGQCS94_1606219332;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGQCS94_1606219332)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 20:02:12 +0800
Subject: Re: INFO: task can't die in shrink_inactive_list (2)
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterz@infradead.org
References: <0000000000000340a105b49441d3@google.com>
 <20201123195452.8ecd01b1fc2ce287dfd6a0d5@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <97ca8171-c3eb-6462-fcb6-fee53287868a@linux.alibaba.com>
Date:   Tue, 24 Nov 2020 20:00:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201123195452.8ecd01b1fc2ce287dfd6a0d5@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/24 ÉÏÎç11:54, Andrew Morton Ð´µÀ:
> On Fri, 20 Nov 2020 17:55:22 -0800 syzbot <syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com> wrote:
> 
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    03430750 Add linux-next specific files for 20201116
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13f80e5e500000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a1c4c3f27041fdb8
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e5a33e700b1dd0da20a2
>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f7bc5a500000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10934cf2500000

CC Peter Zijlstra.

I found next-20200821 had a very very similar ops as this.
https://groups.google.com/g/syzkaller-upstream-moderation/c/S0pyqK1dZv8/m/dxMoEhGdAQAJ
So does this means the bug exist for long time from 5.9-rc1?

The reproducer works randomly on a cpu=2, mem=1600M x86 vm. It could cause hung again
on both kernel, but both with different kernel stack.

Maybe is system just too busy? I will try more older kernel with the reproducer.

Thanks
Alex

BTW, I remove the drm and wireless config in my testing.

[ 1861.939128][ T1586] INFO: task systemd-udevd:8999 blocked for more than 143 seconds.
[ 1861.939969][ T1586]       Not tainted 5.9.0-rc1-next-20200821 #5
[ 1861.940553][ T1586] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1861.941369][ T1586] task:systemd-udevd   state:D stack:21192 pid: 8999 ppid:  4717 flags:0x00004080
[ 1861.942245][ T1586] Call Trace:
[ 1861.942581][ T1586]  __schedule+0xaab/0x1f20
[ 1861.943014][ T1586]  ? __sched_text_start+0x8/0x8
[ 1861.943482][ T1586]  schedule+0xc4/0x2b0
[ 1861.943872][ T1586]  schedule_preempt_disabled+0xf/0x20
[ 1861.944390][ T1586]  __mutex_lock+0x8a0/0x13e0
[ 1861.944831][ T1586]  ? __blkdev_get+0x4bc/0x1a00
[ 1861.945286][ T1586]  ? mutex_lock_io_nested+0x12c0/0x12c0
[ 1861.945818][ T1586]  ? up_read+0x1a5/0x740
[ 1861.946224][ T1586]  ? down_read+0x10a/0x420
[ 1861.946653][ T1586]  ? kobj_lookup+0x37a/0x480
[ 1861.947095][ T1586]  ? __blkdev_get+0x4bc/0x1a00
[ 1861.947545][ T1586]  __blkdev_get+0x4bc/0x1a00
[ 1861.947997][ T1586]  ? lock_release+0x730/0x730
[ 1861.948464][ T1586]  ? __blkdev_put+0x720/0x720
[ 1861.962189][T15367] systemd-journald[15367]: Sent WATCHDOG=1 notification.
[ 1861.991663][ T1586]  blkdev_get+0x20/0x80
[ 1861.992088][ T1586]  blkdev_open+0x20a/0x290
[ 1861.992514][ T1586]  do_dentry_open+0x69a/0x1240
[ 1861.992975][ T1586]  ? bd_acquire+0x2c0/0x2c0
[ 1861.993414][ T1586]  path_openat+0xdd2/0x26f0
[ 1861.993846][ T1586]  ? path_lookupat.isra.41+0x520/0x520
[ 1861.994368][ T1586]  ? lockdep_hardirqs_on_prepare+0x4d0/0x4d0
[ 1861.994937][ T1586]  ? lockdep_hardirqs_on_prepare+0x4d0/0x4d0
[ 1861.995502][ T1586]  ? ___sys_sendmsg+0x11c/0x180
[ 1861.995954][ T1586]  ? find_held_lock+0x33/0x1c0
[ 1861.996405][ T1586]  ? __might_fault+0x11f/0x1d0
[ 1861.996850][ T1586]  do_filp_open+0x192/0x260
[ 1861.997268][ T1586]  ? may_open_dev+0xf0/0xf0
[ 1861.997699][ T1586]  ? rwlock_bug.part.1+0x90/0x90
[ 1861.998161][ T1586]  ? do_raw_spin_unlock+0x4f/0x260
[ 1861.998650][ T1586]  ? __alloc_fd+0x282/0x600
[ 1862.002012][ T1586]  ? lock_downgrade+0x6f0/0x6f0
[ 1862.007607][ T1586]  do_sys_openat2+0x573/0x850
[ 1862.008112][ T1586]  ? file_open_root+0x3f0/0x3f0
[ 1862.008570][ T1586]  ? trace_hardirqs_on+0x5f/0x220
[ 1862.028918][ T1586]  do_sys_open+0xca/0x140
[ 1862.028932][ T1586]  ? filp_open+0x70/0x70
[ 1862.028945][ T1586]  do_syscall_64+0x2d/0x70
[ 1862.028954][ T1586]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1862.028966][ T1586] RIP: 0033:0x7fc04686eea0
[ 1862.028969][ T1586] Code: Bad RIP value.
[ 1862.028974][ T1586] RSP: 002b:00007ffd2c78ae68 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
[ 1862.028983][ T1586] RAX: ffffffffffffffda RBX: 000055785498f3c0 RCX: 00007fc04686eea0
[ 1862.028988][ T1586] RDX: 000055785498fcd0 RSI: 00000000000a0800 RDI: 000055785498fcd0
[ 1862.028992][ T1586] RBP: 0000000000000000 R08: 00007ffd2c7ad090 R09: 0000000000051dc0
[ 1862.028997][ T1586] R10: 0000000000051dc0 R11: 0000000000000246 R12: 0000557854990340
[ 1862.029002][ T1586] R13: 0000557854984010 R14: 0000557854990200 R15: 000000000000000c
[ 1862.029024][ T1586] INFO: task repro:17514 can't die for more than 143 seconds.
[ 1862.036603][ T1586] task:repro           state:R  running task     stack:25520 pid:17514 ppid:  8947 flags:0x00004086
[ 1862.037596][ T1586] Call Trace:
[ 1862.037909][ T1586]  __schedule+0xaab/0x1f20
[ 1862.038322][ T1586]  ? __sched_text_start+0x8/0x8
[ 1862.038776][ T1586]  ? preempt_schedule_irq+0x30/0x90
[ 1862.070004][ T1586]  ? bdev_evict_inode+0x420/0x420
[ 1862.070497][ T1586]  ? _raw_spin_unlock_irqrestore+0x47/0x60
[ 1862.071036][ T1586]  ? blkdev_write_begin+0x40/0x40
[ 1862.071504][ T1586]  ? read_pages+0x1ee/0x1170
[ 1862.071933][ T1586]  ? _raw_spin_unlock_irqrestore+0x34/0x60
[ 1862.072484][ T1586]  ? debug_check_no_obj_freed+0x205/0x45a
[ 1862.073013][ T1586]  ? rcu_read_lock_sched_held+0x9c/0xd0
[ 1862.073532][ T1586]  ? read_cache_pages+0x6e0/0x6e0
[ 1862.074002][ T1586]  ? page_cache_readahead_unbounded+0x57b/0x800
[ 1862.074591][ T1586]  ? read_pages+0x1170/0x1170
[ 1862.075028][ T1586]  ? down_read_non_owner+0x470/0x470
[ 1862.075522][ T1586]  ? __do_page_cache_readahead+0xc2/0xf0
[ 1862.076044][ T1586]  ? filemap_fault+0x16df/0x24d0
[ 1862.076507][ T1586]  ? lockdep_init_map_waits+0x267/0x7c0
[ 1862.077021][ T1586]  ? __do_fault+0x10d/0x530
[ 1862.077442][ T1586]  ? handle_mm_fault+0x36af/0x4800
[ 1862.077920][ T1586]  ? copy_page_range+0x2ea0/0x2ea0
[ 1862.078400][ T1586]  ? vmacache_update+0xce/0x140
[ 1862.078851][ T1586]  ? do_user_addr_fault+0x564/0xb40
[ 1862.088905][ T1586]  ? exc_page_fault+0xa1/0x170
[ 1862.089363][ T1586]  ? asm_exc_page_fault+0x8/0x30
[ 1862.089828][ T1586]  ? asm_exc_page_fault+0x1e/0x30
[ 1862.090314][ T1586] INFO: task repro:17545 can't die for more than 143 seconds.
[ 1862.090990][ T1586] task:repro           state:R  running task     stack:25312 pid:17545 ppid:  8946 flags:0x00004086
[ 1862.091978][ T1586] Call Trace:
[ 1862.092282][ T1586]  __schedule+0xaab/0x1f20
[ 1862.092696][ T1586]  ? __sched_text_start+0x8/0x8
[ 1862.093141][ T1586]  ? trace_hardirqs_on+0x5f/0x220
[ 1862.093613][ T1586]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[ 1862.094182][ T1586]  ? preempt_schedule_thunk+0x16/0x18
[ 1862.094681][ T1586]  preempt_schedule_common+0x1a/0xc0
[ 1862.095167][ T1586]  preempt_schedule_thunk+0x16/0x18
[ 1862.095653][ T1586]  kernel_init_free_pages+0xf0/0x110
[ 1862.096145][ T1586]  prep_new_page+0x12e/0x1f0
[ 1862.096578][ T1586]  get_page_from_freelist+0x1202/0x56c0
[ 1862.097097][ T1586]  ? lockdep_hardirqs_on_prepare+0x4d0/0x4d0
[ 1862.097659][ T1586]  ? __isolate_free_page+0x600/0x600
[ 1862.098147][ T1586]  __alloc_pages_nodemask+0x2d7/0x7d0
[ 1862.098645][ T1586]  ? __alloc_pages_slowpath.constprop.108+0x2380/0x2380
[ 1862.121238][ T1586]  ? add_to_page_cache_lru+0x1a3/0x700
[ 1862.121773][ T1586]  ? add_to_page_cache_locked+0x40/0x40
[ 1862.122285][ T1586]  alloc_pages_current+0x108/0x200
[ 1862.122766][ T1586]  __page_cache_alloc+0xfc/0x300
[ 1862.123229][ T1586]  page_cache_readahead_unbounded+0x47f/0x800
[ 1862.123795][ T1586]  ? rcu_read_lock_sched_held+0xd0/0xd0
[ 1862.124307][ T1586]  ? read_pages+0x1170/0x1170
[ 1862.124740][ T1586]  ? find_held_lock+0x33/0x1c0
[ 1862.125182][ T1586]  ? inode_congested+0x256/0x4e0
[ 1862.125647][ T1586]  ? page_cache_async_readahead+0x3e5/0x7c0
[ 1862.126199][ T1586]  __do_page_cache_readahead+0xc2/0xf0
[ 1862.126708][ T1586]  ondemand_readahead+0x579/0xd20
[ 1862.127175][ T1586]  page_cache_async_readahead+0x43b/0x7c0
[ 1862.127703][ T1586]  filemap_fault+0xde9/0x24d0
[ 1862.128143][ T1586]  __do_fault+0x10d/0x530
[ 1862.128550][ T1586]  handle_mm_fault+0x36af/0x4800
[ 1862.148903][ T1586]  ? copy_page_range+0x2ea0/0x2ea0
[ 1862.149413][ T1586]  ? vmacache_update+0xce/0x140
[ 1862.149866][ T1586]  do_user_addr_fault+0x564/0xb40
[ 1862.150336][ T1586]  exc_page_fault+0xa1/0x170
[ 1862.150767][ T1586]  ? asm_exc_page_fault+0x8/0x30
[ 1862.151222][ T1586]  asm_exc_page_fault+0x1e/0x30
[ 1862.151671][ T1586] RIP: 0033:0x428dd7
[ 1862.152033][ T1586] Code: Bad RIP value.
[ 1862.152416][ T1586] RSP: 002b:00007f8995966d78 EFLAGS: 00010202
[ 1862.152980][ T1586] RAX: 0000000020000080 RBX: 0000000000000000 RCX: 000000007665642f
[ 1862.153711][ T1586] RDX: 000000000000000c RSI: 00000000004b2370 RDI: 0000000020000080
[ 1862.154444][ T1586] RBP: 00007f8995966da0 R08: 00007f8995967700 R09: 00007f8995967700
[ 1862.155173][ T1586] R10: 00007f89959679d0 R11: 0000000000000202 R12: 0000000000000000
[ 1862.155901][ T1586] R13: 0000000000021000 R14: 0000000000000000 R15: 00007f8995967700
[ 1862.156630][ T1586] INFO: task repro:17769 can't die for more than 143 seconds.
[ 1862.157309][ T1586] task:repro           state:D stack:28536 pid:17769 ppid:  8950 flags:0x00000084
[ 1862.158153][ T1586] Call Trace:
[ 1862.158467][ T1586]  __schedule+0xaab/0x1f20
[ 1862.178902][ T1586]  ? __sched_text_start+0x8/0x8
[ 1862.179370][ T1586]  schedule+0xc4/0x2b0
[ 1862.179750][ T1586]  schedule_preempt_disabled+0xf/0x20
[ 1862.180247][ T1586]  __mutex_lock+0x8a0/0x13e0
[ 1862.180681][ T1586]  ? __blkdev_get+0x4bc/0x1a00
[ 1862.181121][ T1586]  ? mutex_lock_io_nested+0x12c0/0x12c0
[ 1862.181643][ T1586]  ? up_read+0x1a5/0x740
[ 1862.182035][ T1586]  ? down_read+0x10a/0x420
[ 1862.182449][ T1586]  ? kobj_lookup+0x37a/0x480
[ 1862.182879][ T1586]  ? __blkdev_get+0x4bc/0x1a00
[ 1862.183317][ T1586]  __blkdev_get+0x4bc/0x1a00
[ 1862.183747][ T1586]  ? lock_release+0x730/0x730
[ 1862.184182][ T1586]  ? __blkdev_put+0x720/0x720
[ 1862.184623][ T1586]  blkdev_get+0x20/0x80
[ 1862.185006][ T1586]  blkdev_open+0x20a/0x290
[ 1862.185420][ T1586]  do_dentry_open+0x69a/0x1240
[ 1862.185856][ T1586]  ? bd_acquire+0x2c0/0x2c0
[ 1862.186278][ T1586]  path_openat+0xdd2/0x26f0
[ 1862.186710][ T1586]  ? path_lookupat.isra.41+0x520/0x520
[ 1862.187209][ T1586]  ? lockdep_hardirqs_on_prepare+0x4d0/0x4d0
[ 1862.187769][ T1586]  ? lockdep_hardirqs_on_prepare+0x4d0/0x4d0
[ 1862.188317][ T1586]  ? find_held_lock+0x33/0x1c0
[ 1862.188755][ T1586]  ? __might_fault+0x11f/0x1d0
[ 1862.208898][ T1586]  do_filp_open+0x192/0x260
[ 1862.209341][ T1586]  ? may_open_dev+0xf0/0xf0
[ 1862.209774][ T1586]  ? rwlock_bug.part.1+0x90/0x90
[ 1862.210230][ T1586]  ? do_raw_spin_unlock+0x4f/0x260
[ 1862.210712][ T1586]  ? __alloc_fd+0x282/0x600
[ 1862.211134][ T1586]  ? lock_downgrade+0x6f0/0x6f0
[ 1862.211585][ T1586]  do_sys_openat2+0x573/0x850
[ 1862.212022][ T1586]  ? file_open_root+0x3f0/0x3f0
[ 1862.212478][ T1586]  ? trace_hardirqs_on+0x5f/0x220
[ 1862.212942][ T1586]  do_sys_open+0xca/0x140
[ 1862.213346][ T1586]  ? filp_open+0x70/0x70
[ 1862.213752][ T1586]  do_syscall_64+0x2d/0x70
[ 1862.214162][ T1586]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1862.214713][ T1586] RIP: 0033:0x437419
[ 1862.215071][ T1586] Code: Bad RIP value.
[ 1862.215450][ T1586] RSP: 002b:00007f8995966d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 1862.216222][ T1586] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000437419
[ 1862.216961][ T1586] RDX: 0004000000004002 RSI: 0000000020000080 RDI: ffffffffffffff9c
[ 1862.217687][ T1586] RBP: 00007f8995966da0 R08: 00007f8995967700 R09: 0000000000000000
[ 1862.218419][ T1586] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[ 1862.248893][ T1586] R13: 0000000000021000 R14: 0000000000000000 R15: 00007f8995967700

or

[ 2005.496484][ T1626] INFO: task repro:10028 blocked for more than 143 seconds.
[ 2005.497214][ T1626]       Not tainted 5.10.0-rc3-next-20201116 #2
[ 2005.497841][ T1626] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2005.498710][ T1626] task:repro           state:D stack:28080 pid:10028 ppid:  9078 flags:0x00004082
[ 2005.499641][ T1626] Call Trace:
[ 2005.499977][ T1626]  __schedule+0xaaa/0x1f70
[ 2005.500436][ T1626]  ? __sched_text_start+0x8/0x8
[ 2005.500930][ T1626]  schedule+0xc3/0x270
[ 2005.501347][ T1626]  schedule_preempt_disabled+0xf/0x20
[ 2005.501884][ T1626]  __mutex_lock+0x856/0x1420
[ 2005.502358][ T1626]  ? blkdev_put+0x31/0x530
[ 2005.513908][ T1626]  ? mutex_lock_io_nested+0x12c0/0x12c0
[ 2005.514486][ T1626]  ? lock_release+0x690/0x690
[ 2005.514962][ T1626]  ? do_raw_spin_lock+0x121/0x2d0
[ 2005.515468][ T1626]  ? rwlock_bug.part.1+0x90/0x90
[ 2005.515965][ T1626]  ? locks_check_ctx_file_list+0x1d/0x110
[ 2005.516551][ T1626]  ? __fsnotify_parent+0x4fc/0xab0
[ 2005.517076][ T1626]  ? _raw_spin_unlock+0x24/0x40
[ 2005.517572][ T1626]  ? locks_remove_file+0x319/0x570
[ 2005.518086][ T1626]  ? blkdev_put+0x530/0x530
[ 2005.518538][ T1626]  ? blkdev_put+0x31/0x530
[ 2005.518981][ T1626]  blkdev_put+0x31/0x530
[ 2005.519418][ T1626]  ? blkdev_put+0x530/0x530
[ 2005.519872][ T1626]  blkdev_close+0x8c/0xb0
[ 2005.520315][ T1626]  __fput+0x270/0x8e0
[ 2005.520719][ T1626]  task_work_run+0xe0/0x1a0
[ 2005.521178][ T1626]  do_exit+0xb80/0x2eb0
[ 2005.521612][ T1626]  ? rcu_read_lock_sched_held+0x9c/0xd0
[ 2005.522173][ T1626]  ? rcu_read_lock_bh_held+0xb0/0xb0
[ 2005.547613][ T1626]  ? mm_update_next_owner+0x7d0/0x7d0
[ 2005.548173][ T1626]  ? get_signal+0x325/0x2350
[ 2005.548643][ T1626]  ? lock_downgrade+0x6a0/0x6a0
[ 2005.549135][ T1626]  do_group_exit+0x125/0x340
[ 2005.549606][ T1626]  get_signal+0x3f8/0x2350
[ 2005.550050][ T1626]  ? rcu_read_lock_sched_held+0x9c/0xd0
[ 2005.550602][ T1626]  ? rcu_read_lock_bh_held+0xb0/0xb0
[ 2005.551127][ T1626]  ? find_held_lock+0x33/0x1c0
[ 2005.551610][ T1626]  arch_do_signal_or_restart+0x1ea/0x1d40
[ 2005.552181][ T1626]  ? rcu_read_lock_sched_held+0x9c/0xd0
[ 2005.562694][ T1626]  ? copy_siginfo_to_user32+0xa0/0xa0
[ 2005.563262][ T1626]  ? __x64_sys_futex+0x3f3/0x5b0
[ 2005.563758][ T1626]  ? __x64_sys_futex+0x3fc/0x5b0
[ 2005.564262][ T1626]  ? kfree+0x528/0x5b0
[ 2005.564683][ T1626]  ? dput.part.30+0x16/0xbc0
[ 2005.565152][ T1626]  ? unroll_tree_refs+0x2ae/0x410
[ 2005.565672][ T1626]  exit_to_user_mode_prepare+0x108/0x200
[ 2005.566247][ T1626]  syscall_exit_to_user_mode+0x38/0x260
[ 2005.566801][ T1626]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2005.567402][ T1626] RIP: 0033:0x437419
[ 2005.567796][ T1626] Code: Unable to access opcode bytes at RIP 0x4373ef.
[ 2005.568487][ T1626] RSP: 002b:00007f0f27ecfd88 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
[ 2005.569325][ T1626] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000437419
[ 2005.570109][ T1626] RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00000000006e385c
[ 2005.570900][ T1626] RBP: 00007f0f27ecfda0 R08: 0000000000000000 R09: 0000000000000000
[ 2005.571697][ T1626] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[ 2005.572503][ T1626] R13: 0000000000021000 R14: 0000000000000000 R15: 00007f0f27ed0700

> 
> Alex, your series "per memcg lru lock" changed the vmscan code rather a
> lot.  Could you please take a look at that reproducer?
> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com
>>
>> INFO: task syz-executor880:8534 can't die for more than 143 seconds.
>> task:syz-executor880 state:R  running task     stack:25304 pid: 8534 ppid:  8504 flags:0x00004006
>> Call Trace:
>>  context_switch kernel/sched/core.c:4269 [inline]
>>  __schedule+0x890/0x2030 kernel/sched/core.c:5019
>>  preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:5179
>>  preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:40
>>  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
>>  _raw_spin_unlock_irq+0x3c/0x40 kernel/locking/spinlock.c:199
>>  spin_unlock_irq include/linux/spinlock.h:404 [inline]
>>  shrink_inactive_list+0x4b1/0xce0 mm/vmscan.c:1974
>>  shrink_list mm/vmscan.c:2167 [inline]
>>  shrink_lruvec+0x61b/0x11b0 mm/vmscan.c:2462
>>  shrink_node_memcgs mm/vmscan.c:2650 [inline]
>>  shrink_node+0x839/0x1d60 mm/vmscan.c:2767
>>  shrink_zones mm/vmscan.c:2970 [inline]
>>  do_try_to_free_pages+0x38b/0x1440 mm/vmscan.c:3025
>>  try_to_free_pages+0x29f/0x720 mm/vmscan.c:3264
>>  __perform_reclaim mm/page_alloc.c:4360 [inline]
>>  __alloc_pages_direct_reclaim mm/page_alloc.c:4381 [inline]
>>  __alloc_pages_slowpath.constprop.0+0x917/0x2510 mm/page_alloc.c:4785
>>  __alloc_pages_nodemask+0x5f0/0x730 mm/page_alloc.c:4995
>>  alloc_pages_current+0x191/0x2a0 mm/mempolicy.c:2271
>>  alloc_pages include/linux/gfp.h:547 [inline]
>>  __page_cache_alloc mm/filemap.c:977 [inline]
>>  __page_cache_alloc+0x2ce/0x360 mm/filemap.c:962
>>  page_cache_ra_unbounded+0x3a1/0x920 mm/readahead.c:216
>>  do_page_cache_ra+0xf9/0x140 mm/readahead.c:267
>>  do_sync_mmap_readahead mm/filemap.c:2721 [inline]
>>  filemap_fault+0x19d0/0x2940 mm/filemap.c:2809
>>  __do_fault+0x10d/0x4d0 mm/memory.c:3623
>>  do_shared_fault mm/memory.c:4071 [inline]
>>  do_fault mm/memory.c:4149 [inline]
>>  handle_pte_fault mm/memory.c:4385 [inline]
>>  __handle_mm_fault mm/memory.c:4520 [inline]
>>  handle_mm_fault+0x3033/0x55d0 mm/memory.c:4618
>>  do_user_addr_fault+0x55b/0xba0 arch/x86/mm/fault.c:1377
>>  handle_page_fault arch/x86/mm/fault.c:1434 [inline]
>>  exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1490
>>  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:580
>> RIP: 0033:0x400e71
>> Code: Unable to access opcode bytes at RIP 0x400e47.
>> RSP: 002b:00007f8a5353fdc0 EFLAGS: 00010246
>> RAX: 6c756e2f7665642f RBX: 00000000006dbc38 RCX: 0000000000402824
>> RDX: 928195da81441750 RSI: 0000000000000000 RDI: 00000000006dbc30
>> RBP: 00000000006dbc30 R08: 0000000000000000 R09: 00007f8a53540700
>> R10: 00007f8a535409d0 R11: 0000000000000202 R12: 00000000006dbc3c
>> R13: 00007ffe80747a5f R14: 00007f8a535409c0 R15: 0000000000000001
>>
>> Showing all locks held in the system:
>> 1 lock held by khungtaskd/1659:
>>  #0: ffffffff8b339ce0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6252
>> 1 lock held by kswapd0/2195:
>> 1 lock held by kswapd1/2196:
>> 1 lock held by in:imklog/8191:
>>  #0: ffff8880125b1270 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:932
>> 1 lock held by cron/8189:
>> 2 locks held by syz-executor880/8502:
>> 2 locks held by syz-executor880/8505:
>> 2 locks held by syz-executor880/8507:
>> 2 locks held by syz-executor880/11706:
>> 2 locks held by syz-executor880/11709:
>> 3 locks held by syz-executor880/12008:
>> 2 locks held by syz-executor880/12015:
>>
>> =============================================
>>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
