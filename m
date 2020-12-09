Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CED72D3E15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgLIJDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:03:53 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:57137 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgLIJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:03:52 -0500
Received: by mail-io1-f70.google.com with SMTP id e14so724697iow.23
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3mtedUjAwI8f4shC04nIt+59q9kWEP3I6LJ0F4TrT+Q=;
        b=QUcbRn7R/dBLW9wLeZg96cU8QWS4yQb0GqzzARUQ/KNQllCZuDZQgt30Hpktmqk/ji
         HkjsHXZMyyhXU6R0G8SFZQaF76xWNQ57KN1o2EjIYQWjfZXBbg4mUuinxBRrXtHqOhl+
         yBnBezBzHWjMpQkq5pVfvispgPQCJmF4qOiJgwjPVgfI5CZEQYPVGxFmbujFD+o6aFV7
         /2ikhUglqK/qeqomiQ0CqQWtqXMqh85CKbA81CLd3UqJt5t67PED1txlp5ewmqRQvt19
         r8H3L10bV3OuB4OX78iWAOOtAyocllNgEQy1f+6KuZKid0yhQCSylesUsiNozRGHAUcK
         9wxQ==
X-Gm-Message-State: AOAM532rNlNILCfyAqMgU7g//DEHqls3nuLb4WCFdz83ibs7/e0ketCG
        +IDUjdnVus8jcQWZS35vx87L6iutvZn2ESwMMfMvg0v+gXuQ
X-Google-Smtp-Source: ABdhPJyozlh81Rtr8i71n0pWqk07GjzVZFZOleyydxyOWCO98usiz4zgyEs1c3T+mEVIu97bProvZALEoJRaeO3lkqx5hVF/pots
MIME-Version: 1.0
X-Received: by 2002:a5e:990c:: with SMTP id t12mr1547320ioj.33.1607504591397;
 Wed, 09 Dec 2020 01:03:11 -0800 (PST)
Date:   Wed, 09 Dec 2020 01:03:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002525c205b604547a@google.com>
Subject: KASAN: null-ptr-deref Write in bdi_put
From:   syzbot <syzbot+aded2f2ab94d81727898@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15ac8fdb Add linux-next specific files for 20201207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1735927b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3696b8138207d24d
dashboard link: https://syzkaller.appspot.com/bug?extid=aded2f2ab94d81727898
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11993623500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15799413500000

The issue was bisected to:

commit 4d004099a668c41522242aa146a38cc4eb59cb1e
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Oct 2 09:04:21 2020 +0000

    lockdep: Fix lockdep recursion

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1469d00f500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1669d00f500000
console output: https://syzkaller.appspot.com/x/log.txt?x=1269d00f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aded2f2ab94d81727898@syzkaller.appspotmail.com
Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
BUG: KASAN: null-ptr-deref in __refcount_sub_and_test include/linux/refcount.h:272 [inline]
BUG: KASAN: null-ptr-deref in __refcount_dec_and_test include/linux/refcount.h:315 [inline]
BUG: KASAN: null-ptr-deref in refcount_dec_and_test include/linux/refcount.h:333 [inline]
BUG: KASAN: null-ptr-deref in kref_put include/linux/kref.h:64 [inline]
BUG: KASAN: null-ptr-deref in bdi_put+0x22/0xa0 mm/backing-dev.c:901
Write of size 4 at addr 0000000000000040 by task syz-executor719/8459

CPU: 1 PID: 8459 Comm: syz-executor719 Not tainted 5.10.0-rc6-next-20201207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 __kasan_report mm/kasan/report.c:400 [inline]
 kasan_report.cold+0x5f/0xd5 mm/kasan/report.c:413
 check_memory_region_inline mm/kasan/generic.c:180 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:186
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 kref_put include/linux/kref.h:64 [inline]
 bdi_put+0x22/0xa0 mm/backing-dev.c:901
 bdev_evict_inode+0x280/0x4a0 fs/block_dev.c:809
 evict+0x2ed/0x6b0 fs/inode.c:577
 iput_final fs/inode.c:1651 [inline]
 iput.part.0+0x41e/0x840 fs/inode.c:1677
 iput+0x58/0x70 fs/inode.c:1667
 dentry_unlink_inode+0x2b1/0x3d0 fs/dcache.c:374
 __dentry_kill+0x3c0/0x640 fs/dcache.c:579
 dentry_kill fs/dcache.c:705 [inline]
 dput+0x786/0xc10 fs/dcache.c:878
 do_one_tree fs/dcache.c:1625 [inline]
 shrink_dcache_for_umount+0x11f/0x330 fs/dcache.c:1639
 generic_shutdown_super+0x68/0x370 fs/super.c:447
 kill_anon_super+0x36/0x60 fs/super.c:1055
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a3/0x530 fs/namespace.c:1123
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x1f0/0x200 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x444439
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc4e2a8a38 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffea RBX: 00007ffc4e2a8a40 RCX: 0000000000444439
RDX: 0000000020000100 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000400c60
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004020a0
R13: 0000000000402130 R14: 0000000000000000 R15: 0000000000000000
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
