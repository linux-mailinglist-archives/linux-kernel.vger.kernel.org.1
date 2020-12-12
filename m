Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166772D8A63
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 23:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgLLWeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 17:34:19 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:46720 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLLWdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 17:33:53 -0500
Received: by mail-io1-f70.google.com with SMTP id a2so9055849iod.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 14:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SYf0xQRzD1Ns7cPczvB/YjihbR0NslJl1NyH/OZYC7o=;
        b=rOk/uQRg4Vlle4QDLDi6rbYM6Dss8e8b+YhaXPEQsr+8ksrq3OyKaEiHUKSI5Ay7t+
         Thh5FwyQftIrXjlOU/CLR25AmCVSspVIAymCH3aMoPVURyvUCTCxhtAeb6+I60+v1Uj/
         fvAvpztLzdFEcjf44E3S8lm9j2X9488XkXLY89XXiUD7ca2i/dz9YioYHsSqTqEgCTGJ
         ApH5sIJ3lzQAooHrT93is/pJ6OHh51dw4Qq6fHLy5iKxuIs+csZzNLn+3JKXXMEEJezJ
         ui4oi9vEJrk0s3CScmSsJNsPiERcuMnMchYSjtgf/VAtsEWQmWlyQI+k5wS5RzOjQ3fl
         qrsw==
X-Gm-Message-State: AOAM532YMrtxZIMAbywyQ7JZQ/heSwVKdbhtM9mXNZg+0uAaoPG1DCD3
        Uj/AeSj08wtW8AabkZtHWU5o607ul7fn9vjCHzdFzDfIugJw
X-Google-Smtp-Source: ABdhPJypGS6w+qq7vjr+d95hKPZAV/6N56WC7pX3l9H6uHa4KwtuACWKvAiLMgK4rWtbeKJsxjSHlp/Mz5k9LyficM1h20bHRk0Q
MIME-Version: 1.0
X-Received: by 2002:a02:a985:: with SMTP id q5mr23934549jam.56.1607812392118;
 Sat, 12 Dec 2020 14:33:12 -0800 (PST)
Date:   Sat, 12 Dec 2020 14:33:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f73da05b64bfe7c@google.com>
Subject: WARNING in yurex_write/usb_submit_urb
From:   syzbot <syzbot+e87ebe0f7913f71f2ea5@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, vulab@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a256e240 usb: phy: convert comma to semicolon
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14c2cef3500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e267dbb5fea6c8b3
dashboard link: https://syzkaller.appspot.com/bug?extid=e87ebe0f7913f71f2ea5
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e87ebe0f7913f71f2ea5@syzkaller.appspotmail.com

------------[ cut here ]------------
URB 00000000dfe6f349 submitted while active
WARNING: CPU: 1 PID: 25254 at drivers/usb/core/urb.c:378 usb_submit_urb+0x1228/0x14e0 drivers/usb/core/urb.c:378
Modules linked in:
CPU: 1 PID: 25254 Comm: syz-executor.0 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x1228/0x14e0 drivers/usb/core/urb.c:378
Code: 89 de e8 8b 24 bd fd 84 db 0f 85 da f4 ff ff e8 2e 2c bd fd 4c 89 fe 48 c7 c7 c0 63 41 86 c6 05 33 ea b0 04 01 e8 63 2d f3 01 <0f> 0b e9 b8 f4 ff ff c7 44 24 14 01 00 00 00 e9 6f f5 ff ff 41 bd
RSP: 0018:ffffc900129e7cb8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff8128f483 RDI: fffff5200253cf89
RBP: 1ffff9200253cfa9 R08: 0000000000000001 R09: ffff8881f6b1ff5b
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888101ccbc00
R13: 00000000fffffff0 R14: ffff888101ccbce8 R15: ffff8881050ce400
FS:  00007f9fd94dd700(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000740 CR3: 00000001135b7000 CR4: 00000000001506e0
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
RSP: 002b:00007f9fd94dcc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045e159
RDX: 0000000000000001 RSI: 0000000020000740 RDI: 0000000000000003
RBP: 000000000119bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007ffc06103bcf R14: 00007f9fd94dd9c0 R15: 000000000119bf8c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
