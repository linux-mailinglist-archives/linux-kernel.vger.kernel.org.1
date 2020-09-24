Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFC4276D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgIXJ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:28:10 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:41282 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgIXJ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:26:26 -0400
Received: by mail-il1-f208.google.com with SMTP id a16so2071194ilh.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qKeKvc8PeLpRE0zQtT98loABzInNVPW0ksGhbdloQ5Y=;
        b=e1nIQ/gkVsuge6ZiJYEJrbw4EIoVvhHiWmVNlTZy3oZqOZVycSItujV8SMpvs/OBEk
         I07xH5p63mHHCVSJSBv1VHmOLEkVCS/Qk4cKQHuecHYbmwJhnei5Gv98x45C/NbVRfVm
         HTob8Ql3gqS4YsGjPjsO4HLYGi+E8DtFnxeLk2JEl93dddnNCB4NMS/9owlty1boui1j
         EEDZ2KetiUKI1bo2JIX2lCWhv/PG4BKvGTkXQqKXRrXvZ63onAKTeRkN5457Yr5vvQ4D
         GUNx/ojcFlgyFiveQLSKKpSAZ2eXYg146KdBRWSEkg30vKG16afZrnBwnKYBYRvzPYwb
         hFRA==
X-Gm-Message-State: AOAM530DmLqlZ6iX9xB1eDpJu3fJi3aEgxKimKP7QrNE12WiN7qAW+4E
        n/OeMSHT1oMU9266T4eY2tHcaei8jnL74/+7+/owQrUgHpN1
X-Google-Smtp-Source: ABdhPJwF1SmQZogqxEupOxdWKdPRSsxP8xsxJcSc2atGzmvlxHkGdGlLRnceVW5qpEac2GEjGuQ5Q6mCxAfPZlwcUqtL4QZum+9x
MIME-Version: 1.0
X-Received: by 2002:a6b:2b45:: with SMTP id r66mr2565080ior.159.1600939585741;
 Thu, 24 Sep 2020 02:26:25 -0700 (PDT)
Date:   Thu, 24 Sep 2020 02:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050a95f05b00bcb79@google.com>
Subject: UBSAN: array-index-out-of-bounds in ieee80211_del_key
From:   syzbot <syzbot+b1bb342d1d097516cbda@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    98477740 Merge branch 'rcu/urgent' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17130875900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f4c828c9e3cef97
dashboard link: https://syzkaller.appspot.com/bug?extid=b1bb342d1d097516cbda
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1550bdab900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d783ab900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1bb342d1d097516cbda@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in net/mac80211/cfg.c:524:9
index 255 is out of range for type 'ieee80211_key *[8]'
CPU: 0 PID: 6850 Comm: syz-executor698 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:356
 ieee80211_del_key+0x428/0x440 net/mac80211/cfg.c:524
 rdev_del_key net/wireless/rdev-ops.h:107 [inline]
 nl80211_del_key+0x493/0x980 net/wireless/nl80211.c:4201
 genl_family_rcv_msg_doit net/netlink/genetlink.c:669 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:714 [inline]
 genl_rcv_msg+0x61d/0x980 net/netlink/genetlink.c:731
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2470
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:742
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
 do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
 __do_fast_syscall_32+0x60/0x90 arch/x86/entry/common.c:137
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff9549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000fff7606c EFLAGS: 00000202 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000240
RDX: 0000000000000000 RSI: 00000000f7ff928c RDI: 0000000000000004
RBP: 00000000094f8018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
