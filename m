Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18492D52DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgLJEev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:34:51 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:50890 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbgLJEev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:34:51 -0500
Received: by mail-io1-f71.google.com with SMTP id l5so2992574ioj.17
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 20:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GtmL+rEWRF5LPcilsxz647xmeLLV8HdtqpGhFWPzIoQ=;
        b=XA165+i+dN5HsSburs7QeK4cWMeZc2r25iSoPVG8sTsiOM57EVGE+PBXHHA5b0w0LA
         j0TMIg4Xe+iyZ4jZSilJ/nXVz9XpBBZvflvgVY115FTgYlC/vlzUBM/k2vaDbn6sTofe
         rPDie6TqCZpaQfgIJUE8fTc4+APnPU4koY41NA9VdxMeRhGbFVzzruNRuAUWGVCzkrkS
         LG/FauTd6TqXdfl+FXmNeY52CkKQR8DpyJ3MkwkOL/uvdv7LtdD0ht8jEFvRSUJ5ilWp
         mQBT40hfjWOVMRU0oUVVLWJt9ofNX1cDQW8S2wPdDeNc3uZRto8X+CovaNj2+qwaczYs
         gMJg==
X-Gm-Message-State: AOAM530cWFZbbZsXI4W6g8lMPVfVw8GedjcZm/bXYKwJvwPuU9p8Xz/Y
        UxJ+RAsHDRg/oAJNGrY6bNx/Du1ACm60DR63nySoBz9YpLft
X-Google-Smtp-Source: ABdhPJwbwYY73hqlr6h0G0JJoWVn7I8N0eTTIaQF+qdPJ3IGOt6GKdWxQjzOo53bRAWDush3uGw30NUPiKm7o4zw+ccTkJnLo1n9
MIME-Version: 1.0
X-Received: by 2002:a6b:7906:: with SMTP id i6mr6995828iop.97.1607574850138;
 Wed, 09 Dec 2020 20:34:10 -0800 (PST)
Date:   Wed, 09 Dec 2020 20:34:10 -0800
In-Reply-To: <000000000000b0bbc905b05ab8d5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e47ccf05b614af28@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in __lookup_slow
From:   syzbot <syzbot+3db80bbf66b88d68af9d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a68a0262 mm/madvise: remove racy mm ownership check
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b36097500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e597c2b53c984cd8
dashboard link: https://syzkaller.appspot.com/bug?extid=3db80bbf66b88d68af9d
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1737b8a7500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1697246b500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3db80bbf66b88d68af9d@syzkaller.appspotmail.com

REISERFS (device loop0): journal params: device loop0, size 8192, journal first block 18, max trans len 256, max batch 225, max commit age 30, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using rupasov hash to sort names
REISERFS (device loop0): using 3.5.x disk format
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 1d5b1067 P4D 1d5b1067 PUD 13a4d067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8464 Comm: syz-executor889 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc900015ffa10 EFLAGS: 00010246
RAX: 1ffffffff13857c8 RBX: dffffc0000000000 RCX: ffff8880152c8000
RDX: 0000000000000000 RSI: ffff88802e27dbe8 RDI: ffff888034c90190
RBP: ffffffff89c2be40 R08: ffffffff81c397ee R09: fffffbfff1eabc57
R10: fffffbfff1eabc57 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888034c90190 R14: 1ffff11005c4fb7d R15: ffff88802e27dbe8
FS:  00000000023f0880(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000012d42000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __lookup_slow+0x240/0x370 fs/namei.c:1544
 lookup_one_len+0x10e/0x200 fs/namei.c:2563
 reiserfs_lookup_privroot+0x85/0x1e0 fs/reiserfs/xattr.c:979
 reiserfs_fill_super+0x2a57/0x3140 fs/reiserfs/super.c:2176
 mount_bdev+0x24f/0x360 fs/super.c:1419
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1549
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x17b4/0x2a20 fs/namespace.c:3205
 do_mount fs/namespace.c:3218 [inline]
 __do_sys_mount fs/namespace.c:3426 [inline]
 __se_sys_mount+0x28c/0x320 fs/namespace.c:3403
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44707a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffc217e9828 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc217e9880 RCX: 000000000044707a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc217e9840
RBP: 00007ffc217e9840 R08: 00007ffc217e9880 R09: 00007ffc00000015
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000006
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
Modules linked in:
CR2: 0000000000000000
---[ end trace f20ed6d33f177882 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc900015ffa10 EFLAGS: 00010246
RAX: 1ffffffff13857c8 RBX: dffffc0000000000 RCX: ffff8880152c8000
RDX: 0000000000000000 RSI: ffff88802e27dbe8 RDI: ffff888034c90190
RBP: ffffffff89c2be40 R08: ffffffff81c397ee R09: fffffbfff1eabc57
R10: fffffbfff1eabc57 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888034c90190 R14: 1ffff11005c4fb7d R15: ffff88802e27dbe8
FS:  00000000023f0880(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000012d42000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

