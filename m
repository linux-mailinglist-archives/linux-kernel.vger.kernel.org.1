Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B0C2FB77B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389740AbhASK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:59:30 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:56627 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387728AbhASKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:49:39 -0500
Received: by mail-io1-f69.google.com with SMTP id m2so34363509iow.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BNpQVX1O+cyOBMkR/TOJl1Zoq0gO8cOFzbu0wo8ajm0=;
        b=eOvj8DPcks7Dw1Tjm424ir+ioMwwLT9Ec3JxGafxPxKC8Fk99AWBn2mDvx/Xu6rgzG
         R5oEFa1FK2fDsp1zAb1P6ZryM4+sAOG4fR3Rgu2bdmWfhTSsECIkq7xoC04UnoAfITxw
         0/S4Pko7/U9OSJcH1FDleDpukYImJv7Odzis8kevNQL6YjeYCPyNnIAP+E8EmUy9gi6M
         xjYWU7oiq/Cxur5f7CdMcsjA50F/N81YSk/TEXXqmz9Sun/9VfIThNu9si/hJe5pGBGU
         3oLzHTdTlMBynsyr/Q/5VXYDOTs6j/NaRVNmhKRiTcQdJopVTxLUMTtho1RyHUenv7Uz
         //AA==
X-Gm-Message-State: AOAM533w8QFvaBcei1o5fY5453qQmLAqcUWjPKAGlgVd6bC6RKA6MrjL
        dwYySngLiA+ZZ0bxFY1//+xWb7yeG3hXO6xungcKos6+7Pyj
X-Google-Smtp-Source: ABdhPJwRZGICyAc9YguweoA/wKY6u6SOwFq+oTtQJm/1QiI83UN8virOQhf9L37lRF2ihWnI28mucskkdNWBC+/E1HBw5hcBKcrH
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8d:: with SMTP id w13mr2751807ill.301.1611053297346;
 Tue, 19 Jan 2021 02:48:17 -0800 (PST)
Date:   Tue, 19 Jan 2021 02:48:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080aeb405b93e9309@google.com>
Subject: WARNING in mntput_no_expire
From:   syzbot <syzbot+c19357b59a4b43938b97@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b3a3cbde Add linux-next specific files for 20210115
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e9fb98d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ea08dae6aab586f
dashboard link: https://syzkaller.appspot.com/bug?extid=c19357b59a4b43938b97
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c19357b59a4b43938b97@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8486 at fs/namespace.c:1160 mntput_no_expire+0xb47/0xd40 fs/namespace.c:1160
Modules linked in:
CPU: 0 PID: 8486 Comm: syz-executor.2 Not tainted 5.11.0-rc3-next-20210115-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0xb47/0xd40 fs/namespace.c:1160
Code: ff 48 c7 c2 a0 b5 58 89 be c2 02 00 00 48 c7 c7 60 b5 58 89 c6 05 ef f5 25 0b 01 e8 6b e0 f0 06 e9 3f fd ff ff e8 49 5a a9 ff <0f> 0b e9 fc fc ff ff e8 3d 5a a9 ff e8 98 97 95 ff 31 ff 89 c5 89
RSP: 0018:ffffc900016cfcf8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff920002d9fa5 RCX: 0000000000000000
RDX: ffff88801b0e8000 RSI: ffffffff81c9aec7 RDI: 0000000000000003
RBP: ffff8880136e9000 R08: 0000000000000000 R09: ffffffff8ed3d86f
R10: ffffffff81c9abc1 R11: 0000000000000001 R12: 0000000000000008
R13: ffffc900016cfd48 R14: dffffc0000000000 R15: 00000000ffffffff
FS:  00000000019ec940(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffdd486d7c CR3: 0000000051c48000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 path_umount+0x7c9/0x1240 fs/namespace.c:1739
 ksys_umount fs/namespace.c:1758 [inline]
 __do_sys_umount fs/namespace.c:1763 [inline]
 __se_sys_umount fs/namespace.c:1761 [inline]
 __x64_sys_umount+0x159/0x180 fs/namespace.c:1761
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460c47
Code: 64 89 04 25 d0 02 00 00 58 5f ff d0 48 89 c7 e8 2f be ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 ad 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffdd487488 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000460c47
RDX: 00000000004033a8 RSI: 0000000000000002 RDI: 00007fffdd487530
RBP: 00000000000456eb R08: 0000000000000000 R09: 000000000000000b
R10: 0000000000000005 R11: 0000000000000246 R12: 00007fffdd4885e0
R13: 00000000019eda60 R14: 0000000000000000 R15: 0000000000045444


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
