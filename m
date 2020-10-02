Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08DF281712
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbgJBPsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:48:25 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:37401 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbgJBPsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:48:20 -0400
Received: by mail-io1-f78.google.com with SMTP id 80so1324964iou.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 08:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mzOlMXI9XMJZP/7qb0kKcMUeHzZ5lxDcjKrpEN9c5HQ=;
        b=cMWGSLXvIHX/2OuyGE5Mh3PwlwDeQ4RKAJPDfqMS6W6G6OdYCHwP3fs1mh0VcDy54+
         KmLZFox5os84bjLFsOWq56Uy+yMpRLzxd8MGi/ZIE33qzxplWWlXqOatuu8G8QQKrhm1
         vxZlUxTaiCIk8wtKb6NF4rVvM26NmawTYKv4EyIbu3h2zYptanZSNay8qUks56ZqEMyW
         /ta3vUl5dab58bThdNiFO7R0Y/2LuPxUkkiw/C+9lq6GSQw0o+kGrM+uY9YnSOo8HeBx
         S/oiDa0MNPf4hOTvBx/nz+0uYGgEVZRkg/vyR0kAY+age8ny2k77hVRfzvOENy0osheY
         8wPg==
X-Gm-Message-State: AOAM530Y1RVxz1m4nk7J/TgaIm6DipaliakZKRmuRqrt2wpUW6cm0lnh
        ZoK2jZYYrx7wOE8qN2hhW0jU7IRKSFNLXmrulQXlf6JJ7tCc
X-Google-Smtp-Source: ABdhPJzOzXL5+AqELbX95OmpDPKJssW2plxfZw/euf5AvcIpnSkTdRUzBagrmUGILRJ0Kq9abXgSu2IzVzEezpTZ1ZP7lfo82hRz
MIME-Version: 1.0
X-Received: by 2002:a02:b70c:: with SMTP id g12mr2807025jam.62.1601653700165;
 Fri, 02 Oct 2020 08:48:20 -0700 (PDT)
Date:   Fri, 02 Oct 2020 08:48:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da06e405b0b20f1e@google.com>
Subject: WARNING in get_signal
From:   syzbot <syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, christian@brauner.io, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        oleg@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fcadab74 Merge tag 'drm-fixes-2020-10-01-1' of git://anong..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116865bd900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=3485e3773f7da290eecc
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1211120b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16474c67900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6899 at kernel/signal.c:2431 do_jobctl_trap kernel/signal.c:2431 [inline]
WARNING: CPU: 1 PID: 6899 at kernel/signal.c:2431 get_signal+0x1b5c/0x1f00 kernel/signal.c:2621
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6899 Comm: syz-executor116 Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:do_jobctl_trap kernel/signal.c:2431 [inline]
RIP: 0010:get_signal+0x1b5c/0x1f00 kernel/signal.c:2621
Code: 00 48 c7 c2 40 da 8a 88 be d1 09 00 00 48 c7 c7 a0 da 8a 88 c6 05 09 8c 09 0a 01 e8 43 97 11 00 e9 42 f5 ff ff e8 14 78 2b 00 <0f> 0b 41 bc 00 80 00 00 e9 49 f9 ff ff 4c 89 ef e8 bf 4d 6c 00 e9
RSP: 0018:ffffc90005537ce8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000100000000 RCX: ffffffff814abfc3
RDX: ffff88809315c580 RSI: ffffffff814ac67c RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff88809315ca0f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000008000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:161 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:192
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:267
 ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:287
RIP: 0033:0x446809
Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbb8cdd1db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: 0000000000000000 RBX: 00000000006dbc28 RCX: 0000000000446809
RDX: 9999999999999999 RSI: 0000000000000000 RDI: 000000000007a900
RBP: 00000000006dbc20 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffeca1e9fef R14: 00007fbb8cdd29c0 R15: 20c49ba5e353f7cf
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
