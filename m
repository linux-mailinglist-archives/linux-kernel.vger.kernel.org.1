Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9EC26887B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgINJeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:34:12 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:38910 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgINJdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:33:19 -0400
Received: by mail-io1-f78.google.com with SMTP id e21so10669624iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DJUq5XrhAYhtHbOepiU7xqamyttrBJSi0jWTB9ZyYVk=;
        b=J2SdzqKGOgi+2cb2TqmqvT+f8ru7xh+S1piPrgeNUCEAtHnubHbIsaRyUK0iZDewRy
         fHZ8Bzuvx4RcKa5XuLPK1pEVUsX3oVqH6IZP5pBngvfI595ZQFoLaRqntJbLWMgT1nLn
         ghWwb81CPvTsgxPkCwUBiMcyZkcSnkggjFM9zfblLMF68yzYpn4bX/7fiWdqlX5bP+zU
         VNVMXrBurf+Jxk0LQ6mDsmKjVaMCpLpRo/4Wi7Lw9VOAI1kdLbQcEVg6flUaArlm3x3+
         5cES5njRD3vUcalQ6nPSljA/py4LrcCP+oAcTudZZsx8PiGCYvq07G1yDeKLO4F5uvhI
         HALg==
X-Gm-Message-State: AOAM531gpQMKmNvlhPXOYe52MauUIs2h8N2HtQ/0jCfwvgNnfBwNvSn6
        e55wbpk8PjuzxsinOZdfh1jH7izg3EU4zMqRASFVBiZWZS5C
X-Google-Smtp-Source: ABdhPJwwUWrNj4Z0DiTe6zo1NImw1NKYEq3vDz2Ie/ucA57ZOyvizj2/pwThU5abRcLsSj8CdwBbq6z4aej7SSAB9VrmASMnYDx2
MIME-Version: 1.0
X-Received: by 2002:a6b:7c07:: with SMTP id m7mr10719738iok.32.1600075998706;
 Mon, 14 Sep 2020 02:33:18 -0700 (PDT)
Date:   Mon, 14 Sep 2020 02:33:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000843f5305af42b9fa@google.com>
Subject: general protection fault in tipc_mon_reinit_self
From:   syzbot <syzbot+11c08b913d16224fde6f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jmaloy@redhat.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7fe10096 Merge branch 'linus' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14886e9e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
dashboard link: https://syzkaller.appspot.com/bug?extid=11c08b913d16224fde6f
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11c08b913d16224fde6f@syzkaller.appspotmail.com

tipc: 32-bit node address hash set to a3a24078
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8164 Comm: kworker/0:4 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events tipc_net_finalize_work
RIP: 0010:tipc_mon_reinit_self+0x389/0x610 net/tipc/monitor.c:686
Code: a8 f9 49 8d 7c 24 10 48 89 f8 48 c1 e8 03 0f b6 04 18 84 c0 74 08 3c 03 0f 8e 40 02 00 00 4c 89 e8 45 8b 64 24 10 48 c1 e8 03 <0f> b6 04 18 84 c0 74 08 3c 03 0f 8e 62 02 00 00 45 89 65 00 4c 89
RSP: 0018:ffffc9001623fc68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff89bd6a40 RDI: ffff888054228010
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880a280cd60
R10: fffffbfff1564d71 R11: 0000000000000000 R12: 00000000a3a24078
R13: 0000000000000000 R14: ffff888049b91010 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558623d05ee8 CR3: 0000000090a76000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tipc_net_finalize net/tipc/net.c:140 [inline]
 tipc_net_finalize+0x1df/0x310 net/tipc/net.c:131
 tipc_net_finalize_work+0x55/0x80 net/tipc/net.c:150
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace 070d9aa71f52a0c0 ]---
RIP: 0010:tipc_mon_reinit_self+0x389/0x610 net/tipc/monitor.c:686
Code: a8 f9 49 8d 7c 24 10 48 89 f8 48 c1 e8 03 0f b6 04 18 84 c0 74 08 3c 03 0f 8e 40 02 00 00 4c 89 e8 45 8b 64 24 10 48 c1 e8 03 <0f> b6 04 18 84 c0 74 08 3c 03 0f 8e 62 02 00 00 45 89 65 00 4c 89
RSP: 0018:ffffc9001623fc68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff89bd6a40 RDI: ffff888054228010
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880a280cd60
R10: fffffbfff1564d71 R11: 0000000000000000 R12: 00000000a3a24078
R13: 0000000000000000 R14: ffff888049b91010 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558623d05ee8 CR3: 0000000090a76000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
