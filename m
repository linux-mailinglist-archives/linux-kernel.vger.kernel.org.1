Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99582B164F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKMHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:21:43 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:47335 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKMHVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:21:43 -0500
Received: by mail-il1-f197.google.com with SMTP id u16so5879676ilq.14
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gVVMdz3oRX87N13pmpdCesTAp3yBHf4CwILFJimeEYc=;
        b=uZygHqPDNz2VYn4MFY/NjaqnDdPshFpSRRvoZ31H2amtuHxWRzpttniC0eMpUY78eY
         eHk5vd560/xwxwlFis0dtUU1FHhAhprL2xu/ixkUXsc+L+3YNKnlMM2k6QRugKEgsjyE
         qgmkOaFirmjSPySg6NAH0xcGii5pg/3GVWoil1hd56cvXWQ+cJZA5BiW4YA4f6C+TgYJ
         6ENHbFsL9aAfErqWvZ/Sr2BKjYU9OGUslScFeoQzuCHF7sRAATsNZsxdZ8SaEFu2LhaD
         zr64oXF/ppZdhfF7eazoBiFLkhRa4r2x0K7O9BiGv4SA5J+oIvFQw75BgMVuN60h96/7
         34cw==
X-Gm-Message-State: AOAM532ncXeFeHYHZ1NpiXORw+j+W5DWn281Lm7B1itXBXXi+N/Mo/qd
        xRBC93CpMriyygqLFXuJvEIm1ex2HwpkSYaJlrUw87VcSAAd
X-Google-Smtp-Source: ABdhPJxgwUKqCrbFTiHbsTHi0QhBas4uFAyNRLPjuGp1oQ6hauIbTtMZWWFCPYVKk7mwG17R4/NRZ2XGz2JVOlmANsNkDqsQukdg
MIME-Version: 1.0
X-Received: by 2002:a05:6602:235b:: with SMTP id r27mr908738iot.123.1605252086524;
 Thu, 12 Nov 2020 23:21:26 -0800 (PST)
Date:   Thu, 12 Nov 2020 23:21:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000647eff05b3f7e0d4@google.com>
Subject: general protection fault in tomoyo_socket_sendmsg_permission
From:   syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9dbc1c03 Merge tag 'xfs-5.10-fixes-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10453034500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1735b7978b1c3721
dashboard link: https://syzkaller.appspot.com/bug?extid=95ce4b142579611ef0a9
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 23364 Comm: vhci_tx Not tainted 5.10.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:tomoyo_socket_sendmsg_permission+0x80/0x340 security/tomoyo/network.c:762
Code: c7 40 0c f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 a0 00 00 00 31 c0 e8 0b 70 f1 fd 48 8d 7d 18 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 7d 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc90016f77ad0 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 1ffff92002deef5b RCX: ffffffff83b3789e
RDX: ffff8880186c8000 RSI: ffffffff837e9945 RDI: 0000000000000018
RBP: 0000000000000000 R08: 0000000000000030 R09: ffffc90016f77d97
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90016f77ce8 R14: ffffc90016f77ce8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562623b70868 CR3: 000000002af19000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 security_socket_sendmsg+0x50/0xb0 security/security.c:2140
 sock_sendmsg+0x3f/0x120 net/socket.c:668
 vhci_send_cmd_submit+0x897/0xf90 drivers/usb/usbip/vhci_tx.c:139
 vhci_tx_loop+0xfc/0x370 drivers/usb/usbip/vhci_tx.c:241
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in:
---[ end trace 535369ec3e6ef304 ]---
RIP: 0010:tomoyo_socket_sendmsg_permission+0x80/0x340 security/tomoyo/network.c:762
Code: c7 40 0c f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 a0 00 00 00 31 c0 e8 0b 70 f1 fd 48 8d 7d 18 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 7d 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc90016f77ad0 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 1ffff92002deef5b RCX: ffffffff83b3789e
RDX: ffff8880186c8000 RSI: ffffffff837e9945 RDI: 0000000000000018
RBP: 0000000000000000 R08: 0000000000000030 R09: ffffc90016f77d97
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90016f77ce8 R14: ffffc90016f77ce8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0c3a930740 CR3: 000000002af19000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
