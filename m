Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2278127213B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIUKeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:34:17 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:41443 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgIUKeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:34:17 -0400
Received: by mail-il1-f207.google.com with SMTP id a16so10562095ilh.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Rqv7ma3g5vT9RFE1FzGJX+9Mme19slmfv9DQVzggPg4=;
        b=ujiPkApucssnO8Ui+TcG+F6Ca6Tbn//40hKfmLuniW05fJBT7lpIIGd/rR4hn2XsD4
         bNlcXh99TyxJKsgc+l0vVMjF4BXhTZ+1I0zFUPsA7U2y9MLPiITsdhRFlgkHOW4qwvPC
         ZH+AtPuF3TaQqFf3uBQtFz+mEha+P1EPQjfrDjaII/sIcwD2C3IXXVpDEkAsDrs18mRi
         mfoqXK8QdfN2pF5SF8YCi7XMjFo45i/Pe5C4C94va1EeK/NbGNrINzh7aBH0VxWKNfot
         nf+x2P+B9VnTpNGBBuCMMzTYfssk2LK/6lSYuw72Q6ydyS+MGmMNMWOUFJ+2ozUTIt5t
         aaKg==
X-Gm-Message-State: AOAM530I1kr9wmcz7QbBEyqwhhUA9BO2QVFHnNsA5xXF1s0X/g9rvNEw
        wVFuwRbNRQk6Az2SYoh7BxvO1EmsKGRlWJc6uTGv8hWGzIxd
X-Google-Smtp-Source: ABdhPJw5UU5SrthT2z/YNmwIf6HruYWobTiMeWHn4NplvYNN1t4WPtQGFEW6nqm05KGGz48JtKN2j2Qjn2pSPVxL34A0PfIg9LDo
MIME-Version: 1.0
X-Received: by 2002:a92:2c5:: with SMTP id 188mr30053816ilc.262.1600684455900;
 Mon, 21 Sep 2020 03:34:15 -0700 (PDT)
Date:   Mon, 21 Sep 2020 03:34:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000643b2605afd064d7@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in map_vdso
From:   syzbot <syzbot+9d25c706da4558b9f11a@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162d70d3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
dashboard link: https://syzkaller.appspot.com/bug?extid=9d25c706da4558b9f11a
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d25c706da4558b9f11a@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5029 Comm: systemd-rfkill Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:map_vdso+0x1ea/0x270 arch/x86/entry/vdso/vma.c:308
Code: 24 31 c9 e8 88 7c a7 00 eb 7a 4c 8b 74 24 28 43 80 3c 3e 00 48 8b 5c 24 08 74 08 4c 89 ef e8 4d 00 00 00 00 20 05 00 00 49 03 <6d> 00 48 89 e8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 ef e8 ae 64
RSP: 0018:ffffc90016bafb98 EFLAGS: 00010282
RAX: 00000000ab3c6738 RBX: ffff888056ebc538 RCX: ffff888093622440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888056ebc480 R08: ffffffff81912471 R09: fffffbfff131e57c
R10: fffffbfff131e57c R11: 0000000000000000 R12: 00007fffda9dc000
R13: ffff888093622868 R14: 1ffff110126c450d R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000008fac6000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 load_elf_binary+0x2e90/0x48a0 fs/binfmt_elf.c:1221
 search_binary_handler fs/exec.c:1819 [inline]
 exec_binprm fs/exec.c:1860 [inline]
 bprm_execve+0x919/0x1500 fs/exec.c:1931
 do_execveat_common+0x487/0x5f0 fs/exec.c:2026
 do_execve fs/exec.c:2094 [inline]
 __do_sys_execve fs/exec.c:2170 [inline]
 __se_sys_execve fs/exec.c:2165 [inline]
 __x64_sys_execve+0x8e/0xa0 fs/exec.c:2165
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f8127340647
Code: Bad RIP value.
RSP: 002b:00007ffc7b57dbf8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a0c9286d40 RCX: 00007f8127340647
RDX: 000055a0c9307440 RSI: 000055a0c91cd210 RDI: 000055a0c924e9a0
RBP: 00007ffc7b57dd60 R08: 000000000000fe00 R09: 0000000000000030
R10: 000055a0c9239740 R11: 0000000000000246 R12: 000055a0c91e1228
R13: 0000000000000000 R14: 000055a0c91cd210 R15: 00007ffc7b57de40
Modules linked in:
CR2: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
