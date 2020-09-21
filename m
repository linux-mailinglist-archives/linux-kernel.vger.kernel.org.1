Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9FD271F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIUJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:51:23 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:41523 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIUJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:51:23 -0400
Received: by mail-io1-f78.google.com with SMTP id j4so9410891iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wz0aqlCjsfTpRqr+pf6KpVJ+HwrHBjlnSzyfXblYD2w=;
        b=DgatpcFPBW4Bp6xgBwIJGZyQl/m7QeEI66mGtT+7OvQVVKMce8V367niHR/RO8JsXX
         4lgHH7y7bgkZsOJ3fDH2NTL1YZ9OA5TBZ3QrolJx8BmHyijTkXG/ikpqGuNS47237jEx
         vtyEgVcWAhe3HT+VQK9D3k80/E5WUoXh8ZEC6j6Ld+mnX8fPn2ojy5joZOUwxRFH30QD
         xwKfAONupJNandIE7EmnwHiMMlNddQgBTR0CoNZkoRSGctTJp620kWLNZ7iR1PnsU3Le
         yqu+HgM1Hnp5sDDDfa4V9KboFnlWUUUFa8wHoUmc2txE6mGYgkygX7jofZa7h4zcZUts
         3igA==
X-Gm-Message-State: AOAM531jROxMBGzT+2i0c/gkH+4A0iup80f9eHWL7avN/LT/uc0A6/z8
        EJcjq5ClbKGMkk2Mxi9kGFDD0fvTSo0YqKirTQkZlBQ10XZ7
X-Google-Smtp-Source: ABdhPJyoQ8k7Rz6htld3nIvEhG92ifUzZKHlLAPOKIRwfcDy27Rt36TfoAWEpHtICmO4VIqruGK/xQPweY0u2dtxqOvmciCvkm4S
MIME-Version: 1.0
X-Received: by 2002:a92:d2c5:: with SMTP id w5mr20560414ilg.80.1600681882117;
 Mon, 21 Sep 2020 02:51:22 -0700 (PDT)
Date:   Mon, 21 Sep 2020 02:51:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb6bf305afcfca61@google.com>
Subject: WARNING: suspicious RCU usage in bond_ipsec_add_sa (2)
From:   syzbot <syzbot+11dcfe6879155fbb6a4e@syzkaller.appspotmail.com>
To:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f13d783a MAINTAINERS: Update ibmveth maintainer
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12dda4e3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ac0d21536db480b
dashboard link: https://syzkaller.appspot.com/bug?extid=11dcfe6879155fbb6a4e
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17588ec5900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13db3281900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11dcfe6879155fbb6a4e@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
=============================
WARNING: suspicious RCU usage
5.9.0-rc3-syzkaller #0 Not tainted
-----------------------------
drivers/net/bonding/bond_main.c:395 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor943/6877:
 #0: ffff888092adba68 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{3:3}, at: xfrm_netlink_rcv+0x5c/0x90 net/xfrm/xfrm_user.c:2691

stack backtrace:
CPU: 0 PID: 6877 Comm: syz-executor943 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 bond_ipsec_add_sa+0x1dc/0x240 drivers/net/bonding/bond_main.c:395
 xfrm_dev_state_add+0x2da/0x7b0 net/xfrm/xfrm_device.c:268
 xfrm_state_construct net/xfrm/xfrm_user.c:655 [inline]
 xfrm_add_sa+0x2166/0x34f0 net/xfrm/xfrm_user.c:684
 xfrm_user_rcv_msg+0x41e/0x720 net/xfrm/xfrm_user.c:2684
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2470
 xfrm_netlink_rcv+0x6b/0x90 net/xfrm/xfrm_user.c:2692
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4439c9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb 0d fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe685e5dd8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004439c9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007ffe685e5df0 R08: 00000000bb1414ac R09: 00000000bb1414ac
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe685e5e20
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
bond0: (slave bond_slave_0): Slave does not support ipsec offload


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
