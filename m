Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FD3275439
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgIWJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:18:22 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:32967 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIWJSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:18:22 -0400
Received: by mail-il1-f205.google.com with SMTP id e73so15513245ill.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 02:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sWT4N2AkvXMYpr6TVMXLRO9RkoC839KMfK+hPqwmouo=;
        b=mNQKmXAKyGKrmlkRpX3AvJJ0KOwWD7cL0N51s+PXuEuuq0hSpIySUpEhRDZ1xAMhxM
         lxMn4lBljtws2hGa4bk8EUMx6sRxYuKdIee4iJKRWDaV0CTQNVKXCoYCdJWPypgthbvB
         0mGMDTt2N2Ta7Gnml0BIV095xA9WCe1J+QJ9mhfTz+8hGaXbVqBX5HDA2DRTtem+KQ5h
         YTzUSpDi4lVFbKs2qAEsSpfE1NHfjkSB57VbYG0htYYwSKCoKRlt6MB7UwJzLHC3+3rQ
         Y5T0eTzbVE/wSRp0lUhZn9AisIuBe622DPychvY4s2KEfglohTdiBWlZCxI+ZrV37NSl
         Ew9A==
X-Gm-Message-State: AOAM531CvKBdYUnmHw1eGcnZs3RY9WjwmS0HWmrngOt2vKlhaqRazesG
        SYwrzvCnSgg/c5OPMmnGybR5TivJ8otbYRAtj50qPXULNhy6
X-Google-Smtp-Source: ABdhPJxanpgaG5spNSLXqN2KvyWJho17litUGHrn5dmQszvKi9ZZ6ER5umXe7QQXYesLMqXhkZLR0Np0qcgFxvGV/8Ofxe5JcT7i
MIME-Version: 1.0
X-Received: by 2002:a5d:9615:: with SMTP id w21mr6675966iol.59.1600852701114;
 Wed, 23 Sep 2020 02:18:21 -0700 (PDT)
Date:   Wed, 23 Sep 2020 02:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096760d05aff79022@google.com>
Subject: invalid opcode in map_vdso
From:   syzbot <syzbot+9cf5373b0e15476f39a2@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1553eff1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
dashboard link: https://syzkaller.appspot.com/bug?extid=9cf5373b0e15476f39a2
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9cf5373b0e15476f39a2@syzkaller.appspotmail.com

invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 16405 Comm: modprobe Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:map_vdso+0x1e3/0x270 arch/x86/entry/vdso/vma.c:308
Code: 16 48 89 ef 48 8b 34 24 31 c9 e8 88 7c a7 00 eb 7a 4c 8b 74 24 28 43 80 3c 3e 00 48 8b 5c 24 08 74 08 4c 89 ef e8 4d 77 70 70 <07> 20 05 00 00 49 03 6d 00 48 89 e8 48 c1 e8 03 42 80 3c 38 00 74
RSP: 0018:ffffc90006167b98 EFLAGS: 00010246
RAX: ffff8880a7db8420 RBX: ffff88809d5fd7f8 RCX: ffff8880a811a040
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88809d5fd740 R08: ffffffff81912471 R09: fffffbfff131e57c
R10: fffffbfff131e57c R11: 0000000000000000 R12: 00007ffea1107000
R13: ffff8880a811a468 R14: 1ffff1101502348d R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f33d09f8fc0 CR3: 0000000097210000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 load_elf_binary+0x2e90/0x48a0 fs/binfmt_elf.c:1221
 search_binary_handler fs/exec.c:1819 [inline]
 exec_binprm fs/exec.c:1860 [inline]
 bprm_execve+0x919/0x1500 fs/exec.c:1931
 kernel_execve+0x871/0x970 fs/exec.c:2080
 call_usermodehelper_exec_async+0x204/0x330 kernel/umh.c:101
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace 8d12c4aa58699b40 ]---
RIP: 0010:map_vdso+0x1e3/0x270 arch/x86/entry/vdso/vma.c:308
Code: 16 48 89 ef 48 8b 34 24 31 c9 e8 88 7c a7 00 eb 7a 4c 8b 74 24 28 43 80 3c 3e 00 48 8b 5c 24 08 74 08 4c 89 ef e8 4d 77 70 70 <07> 20 05 00 00 49 03 6d 00 48 89 e8 48 c1 e8 03 42 80 3c 38 00 74
RSP: 0018:ffffc90006167b98 EFLAGS: 00010246
RAX: ffff8880a7db8420 RBX: ffff88809d5fd7f8 RCX: ffff8880a811a040
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88809d5fd740 R08: ffffffff81912471 R09: fffffbfff131e57c
R10: fffffbfff131e57c R11: 0000000000000000 R12: 00007ffea1107000
R13: ffff8880a811a468 R14: 1ffff1101502348d R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f33d09f8fc0 CR3: 0000000097210000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
