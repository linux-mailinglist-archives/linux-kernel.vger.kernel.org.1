Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91202BBF26
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 14:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgKUNFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 08:05:22 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:47391 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgKUNFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 08:05:21 -0500
Received: by mail-il1-f200.google.com with SMTP id u16so9830191ilq.14
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 05:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Kx24CXOx4h3MoNKtzLcVFy4b4NJQ3zEv6U+MFEpVEMI=;
        b=l/u0DKnEFKCx6YiiGLzdevnsftC1eeFQ3KNAcKQgWaSSalRkEnaWCU+mZygtgd3zfc
         rsfqdYAAz0aGI6XX74NCrI+3BPkNiZlvf3V+qisyudpyHXV4snw7JWJu1t3WmKQA5iRc
         uMHudWm0cJC/QdsqkH7k4ZQYif+RD5G3+ifaJh0sWIh2Yw+TfEUIFHC/YZzldHB+RyYQ
         +e6HcPqzDRZPcmu/V0LSuaMR9wy31FUVu+2aJKlE52z4OVrHz/hfj/Mb/BvUEO3lrjNd
         4xGZ+H3Pzi8fusBJ8pxuXFTL49bYtT1tmxSBbB1qCeejiWcqKIj2VgmTs3Ict1Cf2fQS
         a8eQ==
X-Gm-Message-State: AOAM530LCEldQ8mouWdi1qA7G2d/4SffDrs3kqMQ5NqtfbfDG18QY5ie
        n1uU1HMXPPeo7aEhBUkFi68Gh55iAjYwiqUS8gwnf6o4FX6o
X-Google-Smtp-Source: ABdhPJwrNBZNMz72JeyK7xgPiRK9+q7pfheadHRdv6fTc5ia/37KeI+sFITzY5vAAtdYELYBc1kVzcy0ZtQRQlsaPXIvhji/Y8eX
MIME-Version: 1.0
X-Received: by 2002:a5d:8403:: with SMTP id i3mr20142471ion.6.1605963919820;
 Sat, 21 Nov 2020 05:05:19 -0800 (PST)
Date:   Sat, 21 Nov 2020 05:05:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6914405b49d9c9d@google.com>
Subject: kernel BUG at include/linux/highmem.h:LINE!
From:   syzbot <syzbot+dcb847a3e1e0ecd191ab@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c8ca812 Add linux-next specific files for 20201117
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ea946a500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff4bc71371dc5b13
dashboard link: https://syzkaller.appspot.com/bug?extid=dcb847a3e1e0ecd191ab
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14530c7a500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137c581c500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcb847a3e1e0ecd191ab@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at include/linux/highmem.h:202!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8526 Comm: syz-executor603 Not tainted 5.10.0-rc4-next-20201117-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:zero_user_segments include/linux/highmem.h:202 [inline]
RIP: 0010:zero_user include/linux/highmem.h:223 [inline]
RIP: 0010:truncate_inode_partial_page+0x5aa/0x720 mm/truncate.c:264
Code: bc 01 00 00 00 e8 e6 f8 ff ff e9 e7 fe ff ff e8 2c 12 d8 ff 48 c7 c6 00 44 54 89 48 89 ef e8 dd b5 08 00 0f 0b e8 16 12 d8 ff <0f> 0b e8 0f 12 d8 ff 48 c7 c6 80 44 54 89 48 89 ef e8 c0 b5 08 00
RSP: 0018:ffffc90000f8fa00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000200000 RCX: ffffffff81987fe1
RDX: ffff88801e614f80 RSI: ffffffff819882ca RDI: 0000000000000005
RBP: ffffea0000c70000 R08: 0000000000000000 R09: ffffea0000c70007
R10: 0000000000001000 R11: 0000000000000000 R12: 00000000001ffffa
R13: 00000000001ffffa R14: 0000000000000006 R15: ffffea0000c70008
FS:  0000000000e30880(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043e920 CR3: 00000000228a7000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 shmem_undo_range+0x6fd/0x18f0 mm/shmem.c:921
 shmem_truncate_range mm/shmem.c:999 [inline]
 shmem_setattr+0x67a/0xc70 mm/shmem.c:1058
 notify_change+0xb60/0x10a0 fs/attr.c:336
 do_truncate+0x134/0x1f0 fs/open.c:64
 vfs_truncate+0x49e/0x600 fs/open.c:110
 do_sys_truncate.part.0+0x11e/0x140 fs/open.c:133
 do_sys_truncate fs/open.c:127 [inline]
 __do_sys_truncate fs/open.c:145 [inline]
 __se_sys_truncate fs/open.c:143 [inline]
 __x64_sys_truncate+0x69/0x90 fs/open.c:143
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x444109
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffec4a90088 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444109
RDX: 0000000000444109 RSI: 0000000000000006 RDI: 0000000020000040
RBP: 00000000006ce018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000401d70
R13: 0000000000401e00 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 910e59f95b39ab18 ]---
RIP: 0010:zero_user_segments include/linux/highmem.h:202 [inline]
RIP: 0010:zero_user include/linux/highmem.h:223 [inline]
RIP: 0010:truncate_inode_partial_page+0x5aa/0x720 mm/truncate.c:264
Code: bc 01 00 00 00 e8 e6 f8 ff ff e9 e7 fe ff ff e8 2c 12 d8 ff 48 c7 c6 00 44 54 89 48 89 ef e8 dd b5 08 00 0f 0b e8 16 12 d8 ff <0f> 0b e8 0f 12 d8 ff 48 c7 c6 80 44 54 89 48 89 ef e8 c0 b5 08 00
RSP: 0018:ffffc90000f8fa00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000200000 RCX: ffffffff81987fe1
RDX: ffff88801e614f80 RSI: ffffffff819882ca RDI: 0000000000000005
RBP: ffffea0000c70000 R08: 0000000000000000 R09: ffffea0000c70007
R10: 0000000000001000 R11: 0000000000000000 R12: 00000000001ffffa
R13: 00000000001ffffa R14: 0000000000000006 R15: ffffea0000c70008
FS:  0000000000e30880(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043e920 CR3: 00000000228a7000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
