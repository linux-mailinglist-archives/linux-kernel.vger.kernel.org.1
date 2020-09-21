Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE05D273217
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgIUSmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:42:24 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:37937 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgIUSmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:42:24 -0400
Received: by mail-io1-f77.google.com with SMTP id e21so10700882iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=N56mUcRn5Ly1Kz/Mb+69DHzRjDQQQwe7tYygw2RlZUQ=;
        b=V/BCbnixn+inwHENh1Ni8/yQtlmqC6ht9ibupFyAK8fXKnkyuYfBRkNYTWfgXNu6tA
         K3V6aH3zvb0Kop30FqBrY2bgmLTq5eztZMQf2UKh5OByPVQI6VYgc9L6u5l+zEaIUR+B
         XCV5MpAjWD6JYEPYlya3RfA7nFblog9CiVa9pGROGIamngmvJ9cdKUuFhm6yUC4TvN8T
         E88KGzCPw42BTkBqda0DSZIOQSD7RwW4xOtaP2oxbjXE2bqThKGvCatMb9WB20Z5yNi7
         s+7fJDfSUw13dpy8bbjIqvHXfPJ0Y4oPAGVVK99yYP2sNSk0+ZBHAKVhXSle3HLUsQZy
         CzZQ==
X-Gm-Message-State: AOAM531x1w8PSVcMmQFVDIvYdymr6rsCRIPo3Za+HD2DQ3YEVo/1l4kw
        FdyinFc69jYr2HwIQ4Xyau0BTn74UVqkTT1ZuDbVR9OKlDbi
X-Google-Smtp-Source: ABdhPJw1XJnyUnfXS5QeZtWT2fywvX7nl2tebdBarqAjrEjVz7/tDu3Cps/zdDtyppE8LEGbDh0RCtIlZF88isejGewdtgyIJOtS
MIME-Version: 1.0
X-Received: by 2002:a02:b199:: with SMTP id t25mr1130432jah.124.1600713742724;
 Mon, 21 Sep 2020 11:42:22 -0700 (PDT)
Date:   Mon, 21 Sep 2020 11:42:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005b42305afd736ee@google.com>
Subject: KASAN: invalid-free in ___pte_free_tlb
From:   syzbot <syzbot+298e0d280663dcbc8092@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5925fa68 Merge tag 'perf-tools-fixes-for-v5.9-2020-09-16' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a3bd65900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
dashboard link: https://syzkaller.appspot.com/bug?extid=298e0d280663dcbc8092
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+298e0d280663dcbc8092@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free or invalid-free in pgtable_pte_page_dtor include/linux/mm.h:2202 [inline]
BUG: KASAN: double-free or invalid-free in ___pte_free_tlb+0x29/0x180 arch/x86/mm/pgtable.c:55

CPU: 1 PID: 26083 Comm: syz-executor.1 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 print_address_description+0x66/0x620 mm/kasan/report.c:383
 kasan_report_invalid_free+0x54/0xd0 mm/kasan/report.c:477
 __kasan_slab_free+0x9a/0x110 mm/kasan/common.c:410
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free+0x82/0xf0 mm/slab.c:3693
 pgtable_pte_page_dtor include/linux/mm.h:2202 [inline]
 ___pte_free_tlb+0x29/0x180 arch/x86/mm/pgtable.c:55
 __pte_free_tlb arch/x86/include/asm/pgalloc.h:61 [inline]
 free_pte_range mm/memory.c:221 [inline]
 free_pmd_range mm/memory.c:239 [inline]
 free_pud_range mm/memory.c:273 [inline]
 free_p4d_range mm/memory.c:307 [inline]
 free_pgd_range+0x7d2/0xec0 mm/memory.c:387
 free_pgtables+0x29a/0x2d0 mm/memory.c:419
 exit_mmap+0x285/0x550 mm/mmap.c:3184
 __mmput+0x113/0x370 kernel/fork.c:1076
 exit_mm+0x4cd/0x550 kernel/exit.c:483
 do_exit+0x576/0x1f20 kernel/exit.c:793
 do_group_exit+0x161/0x2d0 kernel/exit.c:903
 get_signal+0x13bb/0x1d50 kernel/signal.c:2757
 arch_do_signal+0x33/0x610 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:159 [inline]
 exit_to_user_mode_prepare+0x8d/0x1e0 kernel/entry/common.c:190
 syscall_exit_to_user_mode+0x82/0x1d0 kernel/entry/common.c:265
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5f9
Code: Bad RIP value.
RSP: 002b:00007f64a4d3acf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000118cf48 RCX: 000000000045d5f9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000118cf48
RBP: 000000000118cf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffd2a4f628f R14: 00007f64a4d3b9c0 R15: 000000000118cf4c

Allocated by task 6856:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461
 slab_post_alloc_hook+0x3e/0x290 mm/slab.h:518
 slab_alloc mm/slab.c:3312 [inline]
 kmem_cache_alloc+0x1c1/0x2d0 mm/slab.c:3482
 ptlock_alloc+0x1c/0x70 mm/memory.c:5065
 ptlock_init include/linux/mm.h:2166 [inline]
 pgtable_pte_page_ctor include/linux/mm.h:2193 [inline]
 __pte_alloc_one include/asm-generic/pgalloc.h:66 [inline]
 pte_alloc_one+0x6a/0x180 arch/x86/mm/pgtable.c:33
 __pte_alloc+0x1d/0x2a0 mm/memory.c:429
 copy_pte_range mm/memory.c:829 [inline]
 copy_pmd_range mm/memory.c:905 [inline]
 copy_pud_range mm/memory.c:939 [inline]
 copy_p4d_range mm/memory.c:961 [inline]
 copy_page_range+0x2458/0x2950 mm/memory.c:1023
 dup_mmap+0x982/0xd60 kernel/fork.c:592
 dup_mm+0x98/0x320 kernel/fork.c:1354
 copy_mm kernel/fork.c:1410 [inline]
 copy_process+0x1fdc/0x5200 kernel/fork.c:2069
 _do_fork+0x1ab/0x6d0 kernel/fork.c:2428
 __do_sys_clone kernel/fork.c:2545 [inline]
 __se_sys_clone kernel/fork.c:2529 [inline]
 __x64_sys_clone+0x1e9/0x230 kernel/fork.c:2529
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 26083:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:56
 kasan_set_free_info+0x17/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xdd/0x110 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free+0x82/0xf0 mm/slab.c:3693
 pgtable_pte_page_dtor include/linux/mm.h:2202 [inline]
 ___pte_free_tlb+0x29/0x180 arch/x86/mm/pgtable.c:55
 __pte_free_tlb arch/x86/include/asm/pgalloc.h:61 [inline]
 free_pte_range mm/memory.c:221 [inline]
 free_pmd_range mm/memory.c:239 [inline]
 free_pud_range mm/memory.c:273 [inline]
 free_p4d_range mm/memory.c:307 [inline]
 free_pgd_range+0x7d2/0xec0 mm/memory.c:387
 free_pgtables+0x29a/0x2d0 mm/memory.c:419
 exit_mmap+0x285/0x550 mm/mmap.c:3184
 __mmput+0x113/0x370 kernel/fork.c:1076
 exit_mm+0x4cd/0x550 kernel/exit.c:483
 do_exit+0x576/0x1f20 kernel/exit.c:793
 do_group_exit+0x161/0x2d0 kernel/exit.c:903
 get_signal+0x13bb/0x1d50 kernel/signal.c:2757
 arch_do_signal+0x33/0x610 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:159 [inline]
 exit_to_user_mode_prepare+0x8d/0x1e0 kernel/entry/common.c:190
 syscall_exit_to_user_mode+0x82/0x1d0 kernel/entry/common.c:265
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888000117000
 which belongs to the cache page->ptl of size 64
The buggy address is located 0 bytes inside of
 64-byte region [ffff888000117000, ffff888000117040)
The buggy address belongs to the page:
page:00000000d8cb99e1 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x117
flags: 0x7ffe0000000200(slab)
raw: 007ffe0000000200 ffffea00029c9808 ffffea0002784948 ffff8880aa44fc00
raw: 0000000000000000 ffff888000117000 000000010000002a 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888000116f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888000116f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888000117000: fa fb fb fb fb fb fb fb fc fc fc fc 00 00 00 00
                   ^
 ffff888000117080: 00 00 00 00 fc fc fc fc fb fb fb fb fb fb fb fb
 ffff888000117100: fc fc fc fc 00 00 00 00 00 00 00 00 fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
