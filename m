Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0832D0671
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 19:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgLFSDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 13:03:51 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:53956 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgLFSDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 13:03:50 -0500
Received: by mail-io1-f72.google.com with SMTP id l20so9636029ioc.20
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 10:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jn1ur1CJ32eLoJ+8rmqxj+7KZgFDqlZi44QtJ1VxAtg=;
        b=f6dGu15AI9B875wuNUN6m+J1VNrxXw0ez1/9a9dJdwEH4nAn2lWI1XbF6jEE4TmrNN
         wiqjCP3ZGEZHjoSj6ZjLjQz3bt28GhT3ezVT3JFz/84BXz9rSIul58pPXL89X3nJ+3ng
         SOdCoRY2QblYBMcKi3kzKfZcZVdHHDB10ZWsplfCg9QAMBOv+4t4ycMwR2Wy06m4k4lP
         kdaCsSwRoZcHZ8lRNZ26amLy3w879IVPSnTROMmKpjddXPtyN/WAuw3yk1xH8xzxK1sb
         Q17oZxvMH8/to4E/iombf8ysWd/9JcxNXvxxPhHKNA0nDVEl/UjWFeiH0fDCGMvbS9+7
         2cmA==
X-Gm-Message-State: AOAM530THfTl9uz3+8F9c+SGX0J9+vjrbiCs9md3eDt9nnyE0J5g7CfH
        zIefe/8I6SuFRNr3dRy/QNzoS3BBa76vQOl0Kr626t7ULi6E
X-Google-Smtp-Source: ABdhPJwxMi28ThkScVLKq4NWcMdO+MNHmvwNGDiR6wvtkMHJcFUVALEmp2MCgp8C+z2rvOG9ar0sLGDoA1Shr05STCvhnxEhIHcu
MIME-Version: 1.0
X-Received: by 2002:a92:6403:: with SMTP id y3mr16672760ilb.72.1607277789787;
 Sun, 06 Dec 2020 10:03:09 -0800 (PST)
Date:   Sun, 06 Dec 2020 10:03:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b73ccc05b5cf8558@google.com>
Subject: possible deadlock in hugetlb_cow
From:   syzbot <syzbot+5eee4145df3c15e96625@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mike.kravetz@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    509a1542 Merge tag '5.10-rc6-smb3-fixes' of git://git.samb..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1694d673500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
dashboard link: https://syzkaller.appspot.com/bug?extid=5eee4145df3c15e96625
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f16b3b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107c8379500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5eee4145df3c15e96625@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.10.0-rc6-syzkaller #0 Not tainted
--------------------------------------------
syz-executor036/9857 is trying to acquire lock:
ffff888011675698 (&hugetlbfs_i_mmap_rwsem_key){++++}-{3:3}, at: i_mmap_lock_write include/linux/fs.h:493 [inline]
ffff888011675698 (&hugetlbfs_i_mmap_rwsem_key){++++}-{3:3}, at: unmap_ref_private mm/hugetlb.c:4019 [inline]
ffff888011675698 (&hugetlbfs_i_mmap_rwsem_key){++++}-{3:3}, at: hugetlb_cow+0xedf/0x15f0 mm/hugetlb.c:4110

but task is already holding lock:
ffff888011675698 (&hugetlbfs_i_mmap_rwsem_key){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:508 [inline]
ffff888011675698 (&hugetlbfs_i_mmap_rwsem_key){++++}-{3:3}, at: hugetlb_fault+0x26c/0x2330 mm/hugetlb.c:4485

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&hugetlbfs_i_mmap_rwsem_key);
  lock(&hugetlbfs_i_mmap_rwsem_key);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor036/9857:
 #0: ffff88801aed8128 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:56 [inline]
 #0: ffff88801aed8128 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x25c/0xb40 arch/x86/mm/fault.c:1313
 #1: ffff888011675698 (&hugetlbfs_i_mmap_rwsem_key){++++}-{3:3}
, at: i_mmap_lock_read include/linux/fs.h:508 [inline]
, at: hugetlb_fault+0x26c/0x2330 mm/hugetlb.c:4485
 #2: ffff8880147fe2a8 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x368/0x2330 mm/hugetlb.c:4499

stack backtrace:
CPU: 0 PID: 9857 Comm: syz-executor036 Not tainted 5.10.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_deadlock_bug kernel/locking/lockdep.c:2761 [inline]
 check_deadlock kernel/locking/lockdep.c:2804 [inline]
 validate_chain kernel/locking/lockdep.c:3595 [inline]
 __lock_acquire.cold+0x15e/0x3b0 kernel/locking/lockdep.c:4832
 lock_acquire kernel/locking/lockdep.c:5437 [inline]
 lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
 down_write+0x8d/0x150 kernel/locking/rwsem.c:1531
 i_mmap_lock_write include/linux/fs.h:493 [inline]
 unmap_ref_private mm/hugetlb.c:4019 [inline]
 hugetlb_cow+0xedf/0x15f0 mm/hugetlb.c:4110
 hugetlb_fault+0x155c/0x2330 mm/hugetlb.c:4562
 handle_mm_fault+0x11c3/0x55d0 mm/memory.c:4605
 do_user_addr_fault+0x55b/0xb40 arch/x86/mm/fault.c:1372
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1485
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:583
RIP: 0033:0x401d0f
Code: 00 00 31 c0 e8 52 a8 04 00 f0 83 2d 0a e3 2f 00 01 4c 89 e7 e8 42 ff ff ff eb b1 85 c0 75 ea b9 6e 00 00 00 4c 89 ef 4c 89 f6 <f3> 48 a5 ba 04 00 00 00 0f b7 06 be 00 0f 00 20 66 89 07 31 c0 bf
RSP: 002b:00007fc848488db0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000700028 RCX: 000000000000006e
RDX: 00000000000f4240 RSI: 00000000004b4a00 RDI: 0000000020000f00
RBP: 0000000000700020 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000070002c
R13: 0000000020000f00 R14: 00000000004b4a00 R15: 20c49ba5e353f7cf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
