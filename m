Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CB62D9247
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 05:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438602AbgLNEaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 23:30:52 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:47696 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgLNEav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 23:30:51 -0500
Received: by mail-il1-f200.google.com with SMTP id s23so12556656ilk.14
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 20:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EyD6Xv8yPnw7Cjs0n0W7ffYeZrQMhBdBo2hV0DWduyU=;
        b=ria6y16ev+yO1IlZkjDhq5b/99w+6LFBNvZoJ6Bgfd+gXptwGC0KORZo0UZHNluPCQ
         a9drSCQL/mo3eqp/GRIx86si/eFHRDJjflihDnSwwEDFujOmzo1gS//V+JVY5f3zbUqe
         GYd+sqeyKTxInNidAsJNf4ujL7Qd92ZXXyCI5PT/9WhXJ1leVQAbW1SGoAqOTsrN3k8b
         VYeMC3gvqmCW2dvYJu19A64XyhcTJ9TEWpt3hxEqMODhHHPgv8UY/xEaclTWZ7IMlRJ7
         5u9QGPdgCAbZHJMreKmbd0N78M3LzXh2UzR4EM40jSRO1kPXS9ftkV1sOI8jsglMeD4Q
         dFSg==
X-Gm-Message-State: AOAM530JQV2tAOMunuRlq/b545qKXJeR+9rT4wJmWe6NJc1gYp74OTFA
        qqnw2KZvLvDFfiJe14RpLtqpj5+IkK8DjMBdhD7D9fbvKzhX
X-Google-Smtp-Source: ABdhPJyesbPFPvzVPrqNA5vKUwZ8MPUpJMdiIIXET/pC2sHiNwQEajk+jEUTpNqY8ayX6qWyxzaJkFQSYwjBWXLPxybcPTpnNAvl
MIME-Version: 1.0
X-Received: by 2002:a6b:b8d6:: with SMTP id i205mr29780200iof.135.1607920210664;
 Sun, 13 Dec 2020 20:30:10 -0800 (PST)
Date:   Sun, 13 Dec 2020 20:30:10 -0800
In-Reply-To: <0000000000007f73da05b64bfe7c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbe5aa05b6651891@google.com>
Subject: Re: WARNING in yurex_write/usb_submit_urb
From:   syzbot <syzbot+e87ebe0f7913f71f2ea5@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        vulab@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6bff9bb8 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10937c5b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3416bb960d5c705d
dashboard link: https://syzkaller.appspot.com/bug?extid=e87ebe0f7913f71f2ea5
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1583cf17500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11825413500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e87ebe0f7913f71f2ea5@syzkaller.appspotmail.com

------------[ cut here ]------------
URB 0000000091a49304 submitted while active
WARNING: CPU: 0 PID: 8533 at drivers/usb/core/urb.c:378 usb_submit_urb+0x1228/0x14e0 drivers/usb/core/urb.c:378
Modules linked in:
CPU: 0 PID: 8533 Comm: syz-executor014 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x1228/0x14e0 drivers/usb/core/urb.c:378
Code: 89 de e8 eb c8 3b fc 84 db 0f 85 da f4 ff ff e8 ce d0 3b fc 4c 89 fe 48 c7 c7 40 58 e1 89 c6 05 62 6d a4 07 01 e8 74 4f 78 03 <0f> 0b e9 b8 f4 ff ff c7 44 24 14 01 00 00 00 e9 6f f5 ff ff 41 bd
RSP: 0018:ffffc9000187fcb8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888015e73480 RSI: ffffffff8158c835 RDI: fffff5200030ff89
RBP: 1ffff9200030ffa9 R08: 0000000000000001 R09: ffff8880b9e30627
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888017a40c00
R13: 00000000fffffff0 R14: ffff888017a40ce8 R15: ffff888011521a00
FS:  00000000025f8880(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe0726b3000 CR3: 000000001c29c000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 yurex_write+0x3f4/0x840 drivers/usb/misc/yurex.c:493
 vfs_write+0x28e/0xa30 fs/read_write.c:603
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x445809
Code: e8 8c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 6b cc fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe3d547598 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000445809
RDX: 0000000000000001 RSI: 0000000020000740 RDI: 0000000000000004
RBP: 000000000000edca R08: 000000000000000f R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402900
R13: 0000000000402990 R14: 0000000000000000 R15: 0000000000000000

