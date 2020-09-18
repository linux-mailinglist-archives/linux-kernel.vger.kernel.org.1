Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D4A2707AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIRVBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:01:21 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:42668 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRVBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:01:21 -0400
Received: by mail-io1-f77.google.com with SMTP id w3so5654041iou.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 14:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oCfiGkVYIcxw3idzkPicrwPwIAKvGq4KaTSwFBtjQWU=;
        b=BM6KJxxyof+EWKYGWsUTuF3/hPrT5zfNq8QvCTBr3yq36rFlQ6wq276fm+JJqojgQY
         0CtkScM0NLqeHylyqpkAmjLWasfwYTuV3wpdQfmSiE8kf0km2yLBmrzQjX8RSgAhHx8J
         uHh1WtQwJ8dn0nqxL0OVSVkm1Xv4iixyqYEXvXmftE7bFaRFUmlyyHflq8iaX99lmM8p
         LthN7QvCc5KmH+W4/itG4DksszSekcJadGsmEJLBSvAylaNb3n7eqWqYvSEy/Cm5QZo8
         oTO7dksrsy80H7QCJhtaiJnyhEXk97HgLwWRbyYoDSmIpvJZUwSs65dBDWbXVH86PG22
         MeMA==
X-Gm-Message-State: AOAM531u/lWeVq0u2fQd1oOtEa4TjHFlpOuM1UmmvT+GwNT8GuuB3JZo
        +EIJXu9EckWlvlBBDm5e8fG6R38JuIiykdJDGLIgVSv8sYUb
X-Google-Smtp-Source: ABdhPJyU/RpAOYWZ+94evTfjS1EcCwtmcUxAWWBxwgIfHt8YgUaCIAo5N4I1aCctsfksxUqXtMsLp9GyK3bI2+D+++PDsKGu6vKS
MIME-Version: 1.0
X-Received: by 2002:a92:9408:: with SMTP id c8mr28212311ili.61.1600462880384;
 Fri, 18 Sep 2020 14:01:20 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:01:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000762dee05af9ccd01@google.com>
Subject: WARNING in ex_handler_uaccess
From:   syzbot <syzbot+ea3a78a71705faf41d77@syzkaller.appspotmail.com>
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

HEAD commit:    10b82d51 Merge branch 'for-5.9-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fb6b07900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=773ee8ece5f19a24
dashboard link: https://syzkaller.appspot.com/bug?extid=ea3a78a71705faf41d77
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea3a78a71705faf41d77@syzkaller.appspotmail.com

WARNING: CPU: 2 PID: 6875 at arch/x86/mm/extable.c:77 ex_handler_uaccess+0xba/0xe0 arch/x86/mm/extable.c:77
Kernel panic - not syncing: panic_on_warn set ...
CPU: 2 PID: 6875 Comm: io_uring-sq Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:ex_handler_uaccess+0xba/0xe0 arch/x86/mm/extable.c:77
Code: 1d 5c 30 fa 09 31 ff 89 de e8 e2 ae 40 00 84 db 75 80 e8 b9 b2 40 00 48 c7 c7 e0 1a 69 88 c6 05 3c 30 fa 09 01 e8 a8 ee 10 00 <0f> 0b e9 61 ff ff ff 48 89 df e8 87 7a 81 00 eb 87 e8 10 7b 81 00
RSP: 0018:ffffc9000e03f6c8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801b420400 RSI: ffffffff815f5a85 RDI: fffff52001c07ecb
RBP: ffffc9000e03f7b8 R08: 0000000000000001 R09: ffffffff8ce2daef
R10: 000000000000143b R11: 0000000000000000 R12: ffffffff89b3f410
R13: 000000000000000d R14: 0000000000000000 R15: 0000000000000000
 fixup_exception+0x9a/0xca arch/x86/mm/extable.c:166
 __exc_general_protection arch/x86/kernel/traps.c:557 [inline]
 exc_general_protection+0xeb/0x2e0 arch/x86/kernel/traps.c:524
 asm_exc_general_protection+0x1e/0x30 arch/x86/include/asm/idtentry.h:532
RIP: 0010:check_zeroed_user+0xd7/0x260 lib/usercopy.c:65
Code: ab 00 00 00 e8 6a 61 d4 fd 48 89 ee 48 89 df e8 5f 5d d4 fd 48 39 eb 0f 87 92 00 00 00 e8 51 61 d4 fd 0f 01 cb 0f ae e8 31 ed <49> 8b 1e 31 ff 89 ee e8 9d 5d d4 fd 85 ed 75 6d e8 34 61 d4 fd 31
RSP: 0018:ffffc9000e03f860 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 2000024020012545 RCX: ffffffff83a1de61
RDX: ffff88801b420400 RSI: ffffffff83a1de6f RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8b34a68f
R10: 2000024020012545 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000001232d R14: 2000024020000218 R15: 0000000000000000
 copy_struct_from_user include/linux/uaccess.h:310 [inline]
 io_openat2_prep fs/io_uring.c:3560 [inline]
 io_openat2_prep+0x142/0x1a0 fs/io_uring.c:3547
 io_issue_sqe+0x1932/0x61e0 fs/io_uring.c:5850
 __io_queue_sqe+0x280/0x1160 fs/io_uring.c:6150
 io_queue_sqe+0x692/0xfa0 fs/io_uring.c:6229
 io_submit_sqe fs/io_uring.c:6299 [inline]
 io_submit_sqes+0x1761/0x2400 fs/io_uring.c:6496
 io_sq_thread+0x3ac/0xe00 fs/io_uring.c:6633
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
