Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C22DF576
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 14:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgLTNOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 08:14:54 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:52915 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgLTNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 08:14:53 -0500
Received: by mail-il1-f200.google.com with SMTP id h4so6983675ilq.19
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 05:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fGj2OjlxlDy1Zgg+Kr3WB9Wk2gajexubY628list+ps=;
        b=oI4tuDQbQOrQ2rHxW9GR2CwgouUkqkpMZaqZR+CFwqrYukPjRBr3qBOMuIrt7mo+Q8
         e3jq0UnD0s7tA8ar7DgVre79K6lkwqxIRodJh559eTOluCEUDFK5xw6XbShi/XEabyS3
         IkFXfmbunNbu4w2L1TvJBloRhrR75OigpQZwr8uX/N5up1LDDvziYDwjuKnBRM/8ye63
         4SlapWqtSHMeDxrgMmBL+Bi767r71yG7CsKMEl6xCiduAklJb1J9D/YSi6h6TP4O72zx
         MUYMAKlA9N+FhvLmYnQ8tN7MZMcI9eY7jejEZoXRUmvNpNcnZTllV+P8AQVmJukOs9wx
         E8Uw==
X-Gm-Message-State: AOAM530KXyurSrZ207nVMaRDIa3fV1lDneeHyv9p7eXRZ9s6+6ClNqWD
        UDhUriqJkJLiLaquJnulu47LoI29atrHNSgHt9baWWMdY5ML
X-Google-Smtp-Source: ABdhPJyyo+upCdVM4BxURMm9/zk2XCoEKlzd9IgU1yZJvSuAcA/pHb0/HfPRc6mU1UZXEqMGoed5dTAn8/UBgmCk+eNxEnzLp05g
MIME-Version: 1.0
X-Received: by 2002:a5e:9b06:: with SMTP id j6mr10946043iok.171.1608470052365;
 Sun, 20 Dec 2020 05:14:12 -0800 (PST)
Date:   Sun, 20 Dec 2020 05:14:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a6adb05b6e51e3e@google.com>
Subject: KASAN: global-out-of-bounds Read in smc_nl_get_sys_info
From:   syzbot <syzbot+f4708c391121cfc58396@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kgraul@linux.ibm.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3db1a3fa Merge tag 'staging-5.11-rc1' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=121dc937500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2764fc28a92339f9
dashboard link: https://syzkaller.appspot.com/bug?extid=f4708c391121cfc58396
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16522287500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1144680f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4708c391121cfc58396@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in string_nocheck lib/vsprintf.c:611 [inline]
BUG: KASAN: global-out-of-bounds in string+0x39c/0x3d0 lib/vsprintf.c:693
Read of size 1 at addr ffffffff8faea960 by task syz-executor646/8509

CPU: 0 PID: 8509 Comm: syz-executor646 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5/0x4c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 string_nocheck lib/vsprintf.c:611 [inline]
 string+0x39c/0x3d0 lib/vsprintf.c:693
 vsnprintf+0x71b/0x14f0 lib/vsprintf.c:2618
 snprintf+0xbb/0xf0 lib/vsprintf.c:2751
 smc_nl_get_sys_info+0x493/0x880 net/smc/smc_core.c:249
 genl_lock_dumpit+0x60/0x90 net/netlink/genetlink.c:623
 netlink_dump+0x4b9/0xb70 net/netlink/af_netlink.c:2268
 __netlink_dump_start+0x642/0x900 net/netlink/af_netlink.c:2373
 genl_family_rcv_msg_dumpit+0x2af/0x310 net/netlink/genetlink.c:686
 genl_family_rcv_msg net/netlink/genetlink.c:780 [inline]
 genl_rcv_msg+0x434/0x580 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2336
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2390
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2423
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440299
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff4b943e58 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440299
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401aa0
R13: 0000000000401b30 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the variable:
 smc_hostname+0x20/0x40

Memory state around the buggy address:
 ffffffff8faea800: 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
 ffffffff8faea880: 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
>ffffffff8faea900: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 f9 f9 f9 f9
                                                       ^
 ffffffff8faea980: 04 f9 f9 f9 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
 ffffffff8faeaa00: 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
