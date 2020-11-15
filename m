Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D74F2B38AE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 20:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgKOTaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 14:30:22 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:49621 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgKOTaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 14:30:20 -0500
Received: by mail-il1-f200.google.com with SMTP id s74so9319279ili.16
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 11:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ksV7G1LvEOFsXln138z/UT0+mU4z4jF6i3q/RbguKBE=;
        b=LNQZRlXRd3k58vegOGWn4Ldrh9uIrEhyp3t6G0E49BzliIDJv+UeTs+Se0NQrkT6Zp
         wbvsIrRscBeqgE/V4Fod53fNSXp0V+JtNDMcN4Sd0kmgrjwC4pwxax5q0E6yhyQpW1Uh
         jaQfmIOQU63/GOuHqLavWldk4PfGt7rz2FH0nlE2HCuIcxuddseAQkmzn8ozFCxnd9tC
         nYkRdjLrZTwgMsyUMQjJvLN1qkRFZFHH3MTCDv0MFn3fPO+cekMRCTZ25SImxrKXAyVm
         qeKO1cscJc0f51vSr72KwoOdNeMw4uJnBjaC8SSdQyOIzXf0LZ+8eZM2XEdUCzamaz5Z
         aLTQ==
X-Gm-Message-State: AOAM533w3i41pI5YBeAZbgSsYVYXldOGf5c/bBPelNkpQPGSLE5qLK1P
        5yHhOjx+KqBHpxYsKlHZdpe8l1LzHycrmb1LadRwjZTnAGAO
X-Google-Smtp-Source: ABdhPJyTFNiW2UMuHFLCQHdHACXWFDf603sbZLflQzA5TfYrxntczCO8luJ0Ua5W+B49yf7sdRIasORLokwCEOVWHt+thHMlsb6r
MIME-Version: 1.0
X-Received: by 2002:a5d:898c:: with SMTP id m12mr5743569iol.196.1605468619350;
 Sun, 15 Nov 2020 11:30:19 -0800 (PST)
Date:   Sun, 15 Nov 2020 11:30:19 -0800
In-Reply-To: <0000000000003b856d05b2bdb5f7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1286c05b42a4a3e@google.com>
Subject: Re: general protection fault in wext_handle_ioctl
From:   syzbot <syzbot+8b2a88a09653d4084179@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e28c0d7c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cd1cc2500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37bf5609aacce0b6
dashboard link: https://syzkaller.appspot.com/bug?extid=8b2a88a09653d4084179
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13706da1500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10229fdc500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b2a88a09653d4084179@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8462 Comm: syz-executor301 Not tainted 5.10.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:call_commit_handler net/wireless/wext-core.c:900 [inline]
RIP: 0010:ioctl_standard_call net/wireless/wext-core.c:1029 [inline]
RIP: 0010:wireless_process_ioctl net/wireless/wext-core.c:954 [inline]
RIP: 0010:wext_ioctl_dispatch net/wireless/wext-core.c:987 [inline]
RIP: 0010:wext_handle_ioctl+0x974/0xb20 net/wireless/wext-core.c:1048
Code: e8 61 1d a3 f8 eb 6c 48 8b 44 24 18 42 80 3c 20 00 48 8b 5c 24 20 74 08 48 89 df e8 26 16 e5 f8 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 0d 16 e5 f8 48 8b 1b 48 89 d8 48
RSP: 0018:ffffc9000143fe00 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff88d1ed88
RDX: ffff8880290e8000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88801b738000 R08: ffffffff88d1edaf R09: ffffed10036e7009
R10: ffffed10036e7009 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000008b04
FS:  0000000001eb8880(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd3b2be000 CR3: 0000000024723000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 sock_ioctl+0xdc/0x690 net/socket.c:1119
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x441529
Code: e8 ec 05 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b 0d fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffeab8016d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffeab801700 RCX: 0000000000441529
RDX: 00000000200000c0 RSI: 0000000000008b04 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000002000000000 R09: 0000002000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000000000 R14: 000000000000000c R15: 0000000000000004
Modules linked in:
---[ end trace d1b799cc496836f9 ]---
RIP: 0010:call_commit_handler net/wireless/wext-core.c:900 [inline]
RIP: 0010:ioctl_standard_call net/wireless/wext-core.c:1029 [inline]
RIP: 0010:wireless_process_ioctl net/wireless/wext-core.c:954 [inline]
RIP: 0010:wext_ioctl_dispatch net/wireless/wext-core.c:987 [inline]
RIP: 0010:wext_handle_ioctl+0x974/0xb20 net/wireless/wext-core.c:1048
Code: e8 61 1d a3 f8 eb 6c 48 8b 44 24 18 42 80 3c 20 00 48 8b 5c 24 20 74 08 48 89 df e8 26 16 e5 f8 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 0d 16 e5 f8 48 8b 1b 48 89 d8 48
RSP: 0018:ffffc9000143fe00 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff88d1ed88
RDX: ffff8880290e8000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88801b738000 R08: ffffffff88d1edaf R09: ffffed10036e7009
R10: ffffed10036e7009 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000008b04
FS:  0000000001eb8880(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd3b2be000 CR3: 0000000024723000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

