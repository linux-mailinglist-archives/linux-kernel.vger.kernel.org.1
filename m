Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA6A2C1D57
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 06:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgKXFWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 00:22:39 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:58128 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgKXFWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 00:22:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UGNsM.k_1606195353;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGNsM.k_1606195353)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 13:22:34 +0800
Subject: Re: INFO: task can't die in shrink_inactive_list (2)
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <0000000000000340a105b49441d3@google.com>
 <20201123195452.8ecd01b1fc2ce287dfd6a0d5@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <00b6e510-4763-a4ad-480d-fdf7a8cb86b8@linux.alibaba.com>
Date:   Tue, 24 Nov 2020 13:20:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201123195452.8ecd01b1fc2ce287dfd6a0d5@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Hugh Dickin & Johannes, 



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
> 
> Alex, your series "per memcg lru lock" changed the vmscan code rather a
> lot.  Could you please take a look at that reproducer?
> 

Sure, I will try to reproduce and look into it.

Thanks!
Alex

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
