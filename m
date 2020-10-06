Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4028505C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJFQ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:59:25 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:41174 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgJFQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:59:25 -0400
Received: by mail-il1-f208.google.com with SMTP id f10so10496105ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 09:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=304jVXmNKE7DcJ31leVLHnoICeijCtIU0UtX/Gik0Bg=;
        b=RONOcCUlRLv9/FCA9I7Yh2GObbpBf22ew/ixTAqtBnsaOLlpkpJ4RR4k4lxnD+iGfS
         qGGYspjCNFIUQyTRLWnJ3ld0FjLIZHjOTr0NVJOd0bENJw050aN0qEEubwx5hV2KvQK5
         jxypN/aqhz5bxpHWAdcnM7HgbFQ0Imxbba8dLjhRMEu6DKvyIyMHV7TaLCkMWtCabBTm
         2zg8aLkHeV+8r/5nXtXr6thbdVNFiQFO/lEnPR9pCFFq0sAfOp2DKskShDAJjGir658S
         jXr8UnnQ8Ogvr7cLbMGT5Nv5dO76F5uxQmNoFvX2teofq5Q+e2pt5ABhvXjoSJhtp3yr
         6DTw==
X-Gm-Message-State: AOAM533WvJDKLrAyhGM6WA6y5ezQs1ouh5ileITOLushO3GUXSjknLeu
        Bb2USUhKMmSqxzI5wwwGRkqOGgs3PV17cdRX2eKFI2bl6TTI
X-Google-Smtp-Source: ABdhPJz9c04Q00sE+RxOF4zQdZoW4g/OtUVOWOzCJ67icok+aJgy8wPbc8ITof7OzqP/r6sQtF41Hk5DvYD8XEIkvtdGbB95kFuF
MIME-Version: 1.0
X-Received: by 2002:a02:a384:: with SMTP id y4mr2228794jak.63.1602003563813;
 Tue, 06 Oct 2020 09:59:23 -0700 (PDT)
Date:   Tue, 06 Oct 2020 09:59:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059a14005b10385d8@google.com>
Subject: KCSAN: data-race in shmem_add_to_page_cache / shmem_getpage_gfp
From:   syzbot <syzbot+e32fbb814c880bd90628@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7575fdda Merge tag 'platform-drivers-x86-v5.9-2' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11df17ff900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a615d4b735de050
dashboard link: https://syzkaller.appspot.com/bug?extid=e32fbb814c880bd90628
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e32fbb814c880bd90628@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in shmem_add_to_page_cache / shmem_getpage_gfp

write to 0xffff888109580388 of 8 bytes by task 920 on cpu 0:
 shmem_add_to_page_cache+0x5d7/0x900 mm/shmem.c:718
 shmem_getpage_gfp+0x821/0x19c0 mm/shmem.c:1920
 shmem_fault+0x16c/0x430 mm/shmem.c:2107
 __do_fault mm/memory.c:3639 [inline]
 do_read_fault+0x41f/0x760 mm/memory.c:4032
 do_fault mm/memory.c:4160 [inline]
 handle_pte_fault mm/memory.c:4400 [inline]
 __handle_mm_fault mm/memory.c:4535 [inline]
 handle_mm_fault+0x14e9/0x1af0 mm/memory.c:4633
 faultin_page mm/gup.c:878 [inline]
 __get_user_pages+0xa3d/0x1010 mm/gup.c:1090
 populate_vma_page_range mm/gup.c:1423 [inline]
 __mm_populate+0x24d/0x340 mm/gup.c:1471
 mm_populate include/linux/mm.h:2566 [inline]
 vm_mmap_pgoff+0x133/0x170 mm/util.c:511
 ksys_mmap_pgoff+0xe1/0x380 mm/mmap.c:1596
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff888109580388 of 8 bytes by task 916 on cpu 1:
 shmem_recalc_inode mm/shmem.c:367 [inline]
 shmem_getpage_gfp+0xb7c/0x19c0 mm/shmem.c:1930
 shmem_fault+0x16c/0x430 mm/shmem.c:2107
 __do_fault mm/memory.c:3639 [inline]
 do_read_fault+0x41f/0x760 mm/memory.c:4032
 do_fault mm/memory.c:4160 [inline]
 handle_pte_fault mm/memory.c:4400 [inline]
 __handle_mm_fault mm/memory.c:4535 [inline]
 handle_mm_fault+0x14e9/0x1af0 mm/memory.c:4633
 faultin_page mm/gup.c:878 [inline]
 __get_user_pages+0xa3d/0x1010 mm/gup.c:1090
 __get_user_pages_locked mm/gup.c:1276 [inline]
 get_user_pages_unlocked+0x148/0x570 mm/gup.c:1996
 __gup_longterm_unlocked mm/gup.c:2646 [inline]
 internal_get_user_pages_fast+0xfc2/0x1240 mm/gup.c:2707
 get_user_pages_fast+0x46/0x60 mm/gup.c:2803
 iov_iter_get_pages+0x1a3/0x850 lib/iov_iter.c:1324
 af_alg_make_sg+0x45/0x250 crypto/af_alg.c:394
 hash_sendmsg+0x162/0x650 crypto/algif_hash.c:94
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg net/socket.c:671 [inline]
 __sys_sendto+0x2ae/0x380 net/socket.c:1992
 __do_sys_sendto net/socket.c:2004 [inline]
 __se_sys_sendto net/socket.c:2000 [inline]
 __x64_sys_sendto+0x74/0x90 net/socket.c:2000
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 916 Comm: syz-executor.0 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
