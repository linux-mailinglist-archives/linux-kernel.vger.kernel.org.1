Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA4270E2E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgISNmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 09:42:23 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:50108 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgISNmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 09:42:23 -0400
Received: by mail-il1-f205.google.com with SMTP id n1so7031135ilm.16
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 06:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yOyCHWQQoRyAKAF0HzMowQuhfbsREVKqwAPSYsKGzpE=;
        b=IvecIgHDufdUHm7ueyzWthALhyBxr+fNdtBzf5GCyb/QKBLMKHwKs2ZA0FKNWG+uau
         Nl+MTJypM7g4Hpy/OEcE+cx4RHegiFHhIeUwFpyRnkdeEOk+2Q4OJXEk4Yc9joe3Yvll
         6h1es4Sf6pHV7dlX4ga71cG/zjql8xicKHuR5vqsEZkZqlmTqtl1d7ckq5IhMEACrIr6
         SY3snT9fSuF6vBTTiao2IqnWfaRtOaLgN/8Z8lQeLv8IYywUUKrHmThAnLQCGMp+8Wp1
         K8eZ4ZGFFXQCgy4Ili6fU90dMsZpDjtiX2yfqnCuvSugcC0L+F9W1nvPXylbrbRFJn7b
         cXRg==
X-Gm-Message-State: AOAM530z0KTkBVb5t7hSEa8kGdFIntKzTFVYCh/LClg6xisXAoABGB0w
        Psi2Ir3cQkDGfVcj5soH6b6G6p0jl1ry0Xbvh8mqMj++kaGM
X-Google-Smtp-Source: ABdhPJyKhAzte/NJFAV4UyJH4tIvOu1lTta/kM8V6FBfUNin7qm5rdNi60NF9h749bV0F7G5/pq8wFytUdukGd+fsK05WvhkIgqL
MIME-Version: 1.0
X-Received: by 2002:a6b:680f:: with SMTP id d15mr30985825ioc.198.1600522942316;
 Sat, 19 Sep 2020 06:42:22 -0700 (PDT)
Date:   Sat, 19 Sep 2020 06:42:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e87b905afaac99d@google.com>
Subject: INFO: trying to register non-static key in vma_link
From:   syzbot <syzbot+2b5fc781c93512ef418c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fc4f28bb Merge tag 'for-5.9-rc5-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cb5153900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61f6bd349c981f3
dashboard link: https://syzkaller.appspot.com/bug?extid=2b5fc781c93512ef418c
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b5fc781c93512ef418c@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 9051 Comm: syz-executor.5 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:894 [inline]
 register_lock_class+0x157d/0x1630 kernel/locking/lockdep.c:1206
 __lock_acquire+0xf9/0x5570 kernel/locking/lockdep.c:4305
 lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
 down_write+0x8d/0x150 kernel/locking/rwsem.c:1531
 i_mmap_lock_write include/linux/fs.h:498 [inline]
 vma_link+0x9e/0x830 mm/mmap.c:651
 mmap_region+0xcd8/0x1780 mm/mmap.c:1815
 do_mmap+0xcf9/0x11d0 mm/mmap.c:1545
 aio_setup_ring fs/aio.c:528 [inline]
 ioctx_alloc+0x881/0x1d70 fs/aio.c:760
 __do_sys_io_setup fs/aio.c:1329 [inline]
 __se_sys_io_setup fs/aio.c:1312 [inline]
 __x64_sys_io_setup+0xc4/0x3d0 fs/aio.c:1312
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5f9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa4d2ef3c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000ce
RAX: ffffffffffffffda RBX: 0000000000008240 RCX: 000000000045d5f9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000002
RBP: 000000000118cf78 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 000000000169fb6f R14: 00007fa4d2ef49c0 R15: 000000000118cf4c
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x1, magic = 0x0, owner = 0xffff88808cb38100, curr 0xffff88808cb38100, list not empty
WARNING: CPU: 0 PID: 9051 at kernel/locking/rwsem.c:1450 __up_write kernel/locking/rwsem.c:1450 [inline]
WARNING: CPU: 0 PID: 9051 at kernel/locking/rwsem.c:1450 up_write+0x381/0x560 kernel/locking/rwsem.c:1584


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
