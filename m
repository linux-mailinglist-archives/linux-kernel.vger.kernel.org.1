Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403F72E8040
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 14:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLaNtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 08:49:55 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:48078 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLaNty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 08:49:54 -0500
Received: by mail-il1-f198.google.com with SMTP id s23so17740046ilk.14
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 05:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vjD2ZZ/mgnmw6gakxB09UdCgBka/BZgf/7YOmtkm12g=;
        b=Xx7abYlSr7v+0IJv5ewdYQ4I3dtsXT47BUylOrl2WzBAOxj3ZuOnimD9NRO8Cp77E/
         SW8b99R0Sk3bHG03kxj6mtqX3XLWBUWmvck2mH/AuD3GO2LK633e8dJugyePNSG3XHkO
         Acn7vZj3DCI/IAd622dzE5Ubr6WDvreCNOdlq510ZsTwYmVnfmpxOzhjENwmCtF9tXFM
         R+3/eobzlwcf1NGrrxrAOmSZxxb8LniCuUZwmoE2lr1pwHcWzuNhkOXdTsMRvDKg3feK
         PRJ9LzGIInuLjvgtDgTmlj1bcT2i02vlefF226NVkSowGXHbk53MWUV2mJhMsh6msQWT
         AcSQ==
X-Gm-Message-State: AOAM531G/jJESNTqsuRoWiQjjbceRPTlq8qrWz7idMu7AJIi9xWZsCHp
        ph3gK5hJPgn4de5AeJYSf/ISLmE/nXWIfBItTm5yAel/fNZe
X-Google-Smtp-Source: ABdhPJxvJ53DhpF1Y2RjddB22uO5RPk6jOc7ON18+HJretROV1xWBuGuKGgiwnPDWPIu65pjY6PC1JPS+T6pMGrBRAX0Sh/B4rG0
MIME-Version: 1.0
X-Received: by 2002:a92:d44f:: with SMTP id r15mr56672028ilm.237.1609422553587;
 Thu, 31 Dec 2020 05:49:13 -0800 (PST)
Date:   Thu, 31 Dec 2020 05:49:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099a35005b7c2e348@google.com>
Subject: WARNING in page_counter_cancel (2)
From:   syzbot <syzbot+77ce5863039267003700@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f838f8d2 mfd: ab8500-debugfs: Remove extraneous seq_putc
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163c2447500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a43a64bad3fdb39
dashboard link: https://syzkaller.appspot.com/bug?extid=77ce5863039267003700
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77ce5863039267003700@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 22 at mm/page_counter.c:57 page_counter_cancel mm/page_counter.c:57 [inline]
WARNING: CPU: 2 PID: 22 at mm/page_counter.c:57 page_counter_cancel+0x56/0x70 mm/page_counter.c:50
Modules linked in:
CPU: 2 PID: 22 Comm: ksoftirqd/2 Not tainted 5.10.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:page_counter_cancel mm/page_counter.c:57 [inline]
RIP: 0010:page_counter_cancel+0x56/0x70 mm/page_counter.c:50
Code: 89 ef 48 89 c3 48 89 c6 e8 37 fd ff ff 31 ff 48 89 de e8 1d cc b8 ff 48 85 db 78 09 5b 5d 41 5c e9 7f c5 b8 ff e8 7a c5 b8 ff <0f> 0b 5b 5d 41 5c e9 6f c5 b8 ff 0f 1f 44 00 00 66 2e 0f 1f 84 00
RSP: 0018:ffffc90000517328 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffffffffffffda RCX: 0000000000000100
RDX: ffff888010c146c0 RSI: ffffffff81b9b926 RDI: 0000000000000003
RBP: ffff8880146bc120 R08: 0000000000000000 R09: ffff8880109d017f
R10: ffffffff81b9b913 R11: 0000000000000000 R12: 0000000000000118
R13: 0000000000000200 R14: ffff8880146bc000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020008000 CR3: 000000006b808000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 page_counter_uncharge+0x2e/0x60 mm/page_counter.c:156
 drain_stock+0xc9/0x2c0 mm/memcontrol.c:2314
 refill_stock+0x132/0x270 mm/memcontrol.c:2363
 __sk_mem_reduce_allocated+0x24d/0x550 net/core/sock.c:2711
 sk_mem_uncharge include/net/sock.h:1537 [inline]
 dfrag_uncharge net/mptcp/protocol.c:978 [inline]
 dfrag_clear+0x45e/0x540 net/mptcp/protocol.c:987
 __mptcp_clean_una+0x146/0xc60 net/mptcp/protocol.c:1011
 __mptcp_data_acked+0x88/0x290 net/mptcp/protocol.c:2909
 mptcp_incoming_options+0x917/0x1d20 net/mptcp/options.c:952
 tcp_data_queue+0x1665/0x4b10 net/ipv4/tcp_input.c:4943
 tcp_rcv_established+0x841/0x1eb0 net/ipv4/tcp_input.c:5886
 tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1676
 tcp_v4_rcv+0x2d10/0x3750 net/ipv4/tcp_ipv4.c:2058
 ip_protocol_deliver_rcu+0x5c/0x8a0 net/ipv4/ip_input.c:204
 ip_local_deliver_finish+0x20a/0x370 net/ipv4/ip_input.c:231
 NF_HOOK include/linux/netfilter.h:301 [inline]
 NF_HOOK include/linux/netfilter.h:295 [inline]
 ip_local_deliver+0x1b3/0x200 net/ipv4/ip_input.c:252
 dst_input include/net/dst.h:447 [inline]
 ip_rcv_finish+0x1da/0x2f0 net/ipv4/ip_input.c:428
 NF_HOOK include/linux/netfilter.h:301 [inline]
 NF_HOOK include/linux/netfilter.h:295 [inline]
 ip_rcv+0xaa/0xd0 net/ipv4/ip_input.c:539
 __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5323
 __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5437
 process_backlog+0x232/0x6c0 net/core/dev.c:6327
 napi_poll net/core/dev.c:6805 [inline]
 net_rx_action+0x461/0xe10 net/core/dev.c:6888
 __do_softirq+0x2a5/0x9f7 kernel/softirq.c:343
 run_ksoftirqd kernel/softirq.c:650 [inline]
 run_ksoftirqd+0x2d/0x50 kernel/softirq.c:642
 smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
