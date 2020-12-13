Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B38F2D908F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 21:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405671AbgLMUbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 15:31:51 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35538 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgLMUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 15:31:50 -0500
Received: by mail-io1-f69.google.com with SMTP id z10so9645789iol.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 12:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tC6bo6KmGRgs/CZFg5djjofdCulEFI9EWEPKD7juNsg=;
        b=JTkx24Kj/j88whPSIQuTaaofHSazAGXWkZJI7QVT09UlW9HDkS0PYoFo4ItZ/qnRTt
         9UKhWJEq0OLQRxk8ezdHvq8U4C73OlOkbxtcQThvYMDkYm2HPsRqA5yVsnV/4X757zd2
         NgHm8o1uB5ZHBihuReH/WQoBAMZTmzNCrkS0/Av+GQPJS3A+rpxhvZ55Hgc0/XHMdB/t
         1BwsE1Zngn5m/U6CemH+JHBKZeRS5KNW4fM2n8dGilrdv78QyZjwqdh9EiZ/GbfuF/ZM
         lecpQu/LGmxI5Wv0hQMOXJIXbalG/C4Z2I3mJoDBAOjj2glIO/ySQ5Lju6knf88p607a
         M5wA==
X-Gm-Message-State: AOAM533lSWOWS/gnkY1uqvTw9ier62r0JHBKAKdlZpi2KX6dekbbRcab
        fq9qhnFqFAyUvZAP3EI7PIjpIbG6zL9f/5Dy/smmeGXXkXEH
X-Google-Smtp-Source: ABdhPJx+ZMR+wL9QqZCtYvTZL1aVE7MwQ1ZfiMC1kM+NHHyAMOR/CqFo5dmx8rKqZlULuTqFnTZvar3K5fPTNyv+wHbj5w6rgZRp
MIME-Version: 1.0
X-Received: by 2002:a92:9881:: with SMTP id a1mr31084089ill.238.1607891469603;
 Sun, 13 Dec 2020 12:31:09 -0800 (PST)
Date:   Sun, 13 Dec 2020 12:31:09 -0800
In-Reply-To: <0000000000007f73da05b64bfe7c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2186705b65e671f@google.com>
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

HEAD commit:    a256e240 usb: phy: convert comma to semicolon
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=147b6adf500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e267dbb5fea6c8b3
dashboard link: https://syzkaller.appspot.com/bug?extid=e87ebe0f7913f71f2ea5
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15edcf17500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e87ebe0f7913f71f2ea5@syzkaller.appspotmail.com

------------[ cut here ]------------
URB 000000000aabe4b9 submitted while active
WARNING: CPU: 1 PID: 7771 at drivers/usb/core/urb.c:378 usb_submit_urb+0x1228/0x14e0 drivers/usb/core/urb.c:378
Modules linked in:
CPU: 1 PID: 7771 Comm: syz-executor.4 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x1228/0x14e0 drivers/usb/core/urb.c:378
Code: 89 de e8 8b 24 bd fd 84 db 0f 85 da f4 ff ff e8 2e 2c bd fd 4c 89 fe 48 c7 c7 c0 63 41 86 c6 05 33 ea b0 04 01 e8 63 2d f3 01 <0f> 0b e9 b8 f4 ff ff c7 44 24 14 01 00 00 00 e9 6f f5 ff ff 41 bd
RSP: 0018:ffffc90001a57cb8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888122eee500 RSI: ffffffff8128f483 RDI: fffff5200034af89
RBP: 1ffff9200034afa9 R08: 0000000000000001 R09: ffff8881f6b2f5cf
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888109853400
R13: 00000000fffffff0 R14: ffff8881098534e8 R15: ffff888107dbfc00
FS:  00007fee407c7700(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb79c135ef0 CR3: 000000010b8aa000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 yurex_write+0x3f4/0x840 drivers/usb/misc/yurex.c:494
 vfs_write+0x28e/0x9e0 fs/read_write.c:603
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e159
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fee407c6c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045e159
RDX: 0000000000000001 RSI: 0000000020000740 RDI: 0000000000000004
RBP: 000000000119bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007fffcdbf5b7f R14: 00007fee407c79c0 R15: 000000000119bf8c

