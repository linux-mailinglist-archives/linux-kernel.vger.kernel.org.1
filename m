Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61897203358
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 11:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgFVJaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 05:30:14 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47471 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgFVJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:30:13 -0400
Received: by mail-io1-f72.google.com with SMTP id m11so12105939ioj.14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=y6d+8mqZsCB5fv3nyzzC3YvhcX1zZRURP+KDtTPm8uQ=;
        b=jH35Jih/s5Jmxkws4lVZ5evSPvIsmrTEtSPkHZmO9oGV85g6v7hJyFGw3ehrRLH8DS
         Hhwr4jnpOIAhIEgrXRusazEI+vgAMmotdu3tJksKJTpAwHSepdOWA74FRoP2bmaks/sJ
         471Rmaz1eCuQdXbBlNtYYBeyjQfLpMTXTNSEhxF4X2yZeUkvOhzXIhhXxDvb626iIRWn
         z5qRUBii6ksGxOuq2D48LSMCySPAsFdLzaX0hqB7ta7uo4XxBPiWXGsUEQ4IoMtNvzVh
         5q+b1E1s3pNDw0fhPNBjn34sQJqhn/S/XGaxP0covft7SQKBRiANTfGuY0Evwh0s5oNa
         yAVw==
X-Gm-Message-State: AOAM532ieBrOFwY0C/P8KEyWJ3gxBZg0iuNN2b5qjSRPvrIHB2o3CTU7
        081iP02njSNeSJ3vROggiwjdwb2VY0O68Z2i8ybOeycNV2yP
X-Google-Smtp-Source: ABdhPJzhFnjmYwgimrnVMBiTmAAXlEyHzTVcudgvl1qpTyANamrFaH6gyQq7grxFCFtK3Z4UBKZLlv8OVFvqHFhLujNtgTI8yRtc
MIME-Version: 1.0
X-Received: by 2002:a02:cdc4:: with SMTP id m4mr16943490jap.57.1592818212975;
 Mon, 22 Jun 2020 02:30:12 -0700 (PDT)
Date:   Mon, 22 Jun 2020 02:30:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6b93705a8a8e304@google.com>
Subject: WARNING in warn_bad_map
From:   syzbot <syzbot+42a07faa5923cfaeb9c9@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
        mptcp@lists.01.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11124521100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=42a07faa5923cfaeb9c9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+42a07faa5923cfaeb9c9@syzkaller.appspotmail.com

------------[ cut here ]------------
Bad mapping: ssn=2478501 map_seq=0 map_data_len=32748
WARNING: CPU: 0 PID: 20706 at net/mptcp/subflow.c:581 warn_bad_map.isra.0.part.0+0x7d/0xb0 net/mptcp/subflow.c:581
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 20706 Comm: syz-executor.2 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:105 [inline]
 fixup_bug arch/x86/kernel/traps.c:100 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:197
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:216
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:warn_bad_map.isra.0.part.0+0x7d/0xb0 net/mptcp/subflow.c:581
Code: 48 c1 ea 03 0f b6 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 1c 8b 13 44 89 e6 48 c7 c7 20 5c fe 88 e8 4b 2e 6b f9 <0f> 0b 48 83 c4 08 5b 5d 41 5c c3 48 89 df 89 4c 24 04 e8 7c 3f d9
RSP: 0018:ffffc90006f2f420 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88809e4fe43c RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815d5ba7 RDI: fffff52000de5e76
RBP: ffff88809e4fe444 R08: ffff8880850aa580 R09: 0000000000000001
R10: ffffffff8c347a27 R11: fffffbfff1868f44 R12: 000000000025d1a5
R13: ffff88809e4fe400 R14: ffff88809e4fe444 R15: ffff88809e4fe43c
 warn_bad_map net/mptcp/subflow.c:613 [inline]
 validate_mapping net/mptcp/subflow.c:613 [inline]
 get_mapping_status net/mptcp/subflow.c:728 [inline]
 subflow_check_data_avail net/mptcp/subflow.c:766 [inline]
 mptcp_subflow_data_available+0x145b/0x1aa0 net/mptcp/subflow.c:862
 subflow_data_ready+0x10b/0x170 net/mptcp/subflow.c:903
 tcp_data_ready+0xe8/0x230 net/ipv4/tcp_input.c:4776
 tcp_data_queue+0x1161/0x4760 net/ipv4/tcp_input.c:4842
 tcp_rcv_established+0x905/0x1d90 net/ipv4/tcp_input.c:5735
 tcp_v4_do_rcv+0x605/0x8b0 net/ipv4/tcp_ipv4.c:1629
 sk_backlog_rcv include/net/sock.h:996 [inline]
 __release_sock+0x134/0x3a0 net/core/sock.c:2548
 release_sock+0x54/0x1b0 net/core/sock.c:3064
 mptcp_sendmsg+0x11f9/0x17f0 net/mptcp/protocol.c:872
 inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:814
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 sock_write_iter+0x288/0x3c0 net/socket.c:999
 call_write_iter include/linux/fs.h:1917 [inline]
 do_iter_readv_writev+0x51e/0x790 fs/read_write.c:694
 do_iter_write fs/read_write.c:999 [inline]
 do_iter_write+0x18b/0x600 fs/read_write.c:980
 vfs_writev+0x1b3/0x2f0 fs/read_write.c:1072
 do_writev+0x27f/0x300 fs/read_write.c:1115
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca59
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5887229c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 000000000050e320 RCX: 000000000045ca59
RDX: 0000000000000001 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000d43 R14: 00000000004cb67f R15: 00007f588722a6d4
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
