Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4453C2C8032
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgK3IlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:41:00 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:49426 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgK3Ik7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:40:59 -0500
Received: by mail-il1-f199.google.com with SMTP id m14so9470718ila.16
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4aCBCuvmyD57GKLMmxAqAMQu3L+dx0wNKZRZtgKEHG0=;
        b=aqiX+7WcX/h+FTfyX1ik8rohxP10VdXhzpOxCy9KdzO64G9LXPzDEezY3JUMA6z3Ru
         IIogWqADdTiPDRJR7OPScF6RJCg8V9yV8rQshVfWVxmT7dbK9oT9KhjLWt2HPTqx5xcT
         5fjlf0/roC7LCjwVJpS3I7Uzca7uVJMcpdSBWIvMYTcExMDejp17PWh6ATnZ3SxlLJg2
         XssGoWilO34LuzRAAGRXiMNMivOpfniMO+/YQT84row2XVAcgW6PBFWhZjGxUjWDq8p2
         JNAAdzofIq+AvsUEQ7T5bLHSyKhlHOy9lz9oItkR4Z9rYojcMJLHVH67HnPZH0OCXYKp
         9+ow==
X-Gm-Message-State: AOAM530Bck4aNSMTTxnyuh2vx9WAY4YLz2PI1+bTOfp/36yT/7QJpDtw
        6nO5gSqbAChCw1/hcjlQ97LUU8GP3OIWqjCzdzxqldrRo3ck
X-Google-Smtp-Source: ABdhPJz2hvGeiwBoqqzHcTnIDq3oSwqTZVxEqjVYEEaRGWcvHKOtl4mFGJcLSLq9XV8fyBPgaAlWqdH7UiiTiJbfObqftu37W8pT
MIME-Version: 1.0
X-Received: by 2002:a02:6343:: with SMTP id j64mr16614346jac.2.1606725618147;
 Mon, 30 Nov 2020 00:40:18 -0800 (PST)
Date:   Mon, 30 Nov 2020 00:40:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8a70905b54ef5ca@google.com>
Subject: KASAN: use-after-free Write in kernfs_path_from_node_locked
From:   syzbot <syzbot+19e6dd9943972fa1c58a@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6174f052 Add linux-next specific files for 20201127
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12252073500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79c69cf2521bef9c
dashboard link: https://syzkaller.appspot.com/bug?extid=19e6dd9943972fa1c58a
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c3351d500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c28809500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+19e6dd9943972fa1c58a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in strlcpy include/linux/string.h:355 [inline]
BUG: KASAN: use-after-free in kernfs_path_from_node_locked+0x9b3/0xc80 fs/kernfs/dir.c:138
Write of size 1 at addr ffff8880235cd800 by task systemd-rfkill/8530

CPU: 1 PID: 8530 Comm: systemd-rfkill Not tainted 5.10.0-rc5-next-20201127-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 check_memory_region_inline mm/kasan/generic.c:180 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:186
 memcpy+0x39/0x60 mm/kasan/shadow.c:66
 strlcpy include/linux/string.h:355 [inline]
 kernfs_path_from_node_locked+0x9b3/0xc80 fs/kernfs/dir.c:138
 kernfs_path_from_node+0x3a/0x60 fs/kernfs/dir.c:217
 kernfs_path include/linux/kernfs.h:542 [inline]
 cgroup_path include/linux/cgroup.h:661 [inline]
 get_mm_memcg_path+0xb2/0xf0 mm/mmap_lock.c:130
 __mmap_lock_do_trace_start_locking+0x25/0x2d0 mm/mmap_lock.c:172
 __mmap_lock_trace_start_locking include/linux/mmap_lock.h:29 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:135 [inline]
 do_user_addr_fault+0x638/0xc50 arch/x86/mm/fault.c:1339
 handle_page_fault arch/x86/mm/fault.c:1455 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1511
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:580
RIP: 0033:0x7f42776d4798
Code: Unable to access opcode bytes at RIP 0x7f42776d476e.
RSP: 002b:00007fff34baaf68 EFLAGS: 00010202
RAX: 00007f42776d4798 RBX: 00007f4278d7d9e0 RCX: 0000000000000000
RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 00007f4277918088
RBP: 00007fff34bab070 R08: 0000000000000000 R09: 00007f4278723808
R10: 00007f4277912000 R11: 0000000000000012 R12: 00007f4277910a50
R13: 00007fff34baafb0 R14: 00007f4278d86040 R15: 0000000000000000

Allocated by task 9024:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_set_track mm/kasan/common.c:47 [inline]
 set_alloc_info mm/kasan/common.c:405 [inline]
 ____kasan_kmalloc mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc.constprop.0+0xa0/0xd0 mm/kasan/common.c:408
 kmalloc include/linux/slab.h:552 [inline]
 trace_mmap_lock_reg+0x196/0x550 mm/mmap_lock.c:58
 tracepoint_add_func+0x304/0x990 kernel/tracepoint.c:257
 tracepoint_probe_register_prio kernel/tracepoint.c:342 [inline]
 tracepoint_probe_register+0x9c/0xe0 kernel/tracepoint.c:362
 trace_event_reg+0x28f/0x350 kernel/trace/trace_events.c:305
 perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
 perf_trace_event_init+0x549/0xa20 kernel/trace/trace_event_perf.c:204
 perf_trace_init+0x176/0x240 kernel/trace/trace_event_perf.c:228
 perf_tp_event_init+0xa2/0x120 kernel/events/core.c:9590
 perf_try_init_event+0x12a/0x560 kernel/events/core.c:11058
 perf_init_event kernel/events/core.c:11110 [inline]
 perf_event_alloc.part.0+0xe3b/0x38e0 kernel/events/core.c:11388
 perf_event_alloc kernel/events/core.c:11767 [inline]
 __do_sys_perf_event_open+0x72c/0x2cb0 kernel/events/core.c:11883
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 9024:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:47
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:358
 ____kasan_slab_free.part.0+0xe1/0x110 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:187 [inline]
 slab_free_hook mm/slub.c:1548 [inline]
 slab_free_freelist_hook+0x82/0x1d0 mm/slub.c:1586
 slab_free mm/slub.c:3157 [inline]
 kfree+0xe5/0x5c0 mm/slub.c:4156
 trace_mmap_lock_unreg+0xba/0x160 mm/mmap_lock.c:94
 tracepoint_remove_func kernel/tracepoint.c:306 [inline]
 tracepoint_probe_unregister+0x5b6/0x890 kernel/tracepoint.c:382
 trace_event_reg+0x181/0x350 kernel/trace/trace_events.c:309
 perf_trace_event_unreg.isra.0+0xac/0x250 kernel/trace/trace_event_perf.c:162
 perf_trace_destroy+0xb5/0xf0 kernel/trace/trace_event_perf.c:243
 _free_event+0x2ee/0x1300 kernel/events/core.c:4840
 put_event kernel/events/core.c:4934 [inline]
 perf_event_release_kernel+0xa24/0xe00 kernel/events/core.c:5049
 perf_release+0x33/0x40 kernel/events/core.c:5059
 __fput+0x283/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x1f0/0x200 kernel/entry/common.c:199
 syscall_exit_to_user_mode+0x36/0x260 kernel/entry/common.c:277
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880235cd800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 1024-byte region [ffff8880235cd800, ffff8880235cdc00)
The buggy address belongs to the page:
page:0000000010e16530 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x235cc
head:0000000010e16530 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010041140
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880235cd700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880235cd780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880235cd800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880235cd880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880235cd900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
