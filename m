Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191B4301AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 10:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbhAXJbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 04:31:12 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:38151 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbhAXJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 04:31:02 -0500
Received: by mail-io1-f70.google.com with SMTP id k7so15027989ioj.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 01:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=y0rMgdAK3f0M1Gx662xEmfXBbgux3dr6bEK3pA6/yMY=;
        b=S7Wo/yXOGTDReeOU69jnWxHEvGt/zjagqjSoQjEr+9u0qdaM9dx4caEnEsLx2UQD0p
         fgpZ4OW8Ez+WlYQK8gbQQVIotW0iCvr7zp/PWfdzfs60h0tnXgKz9/sHMLnSpyrixJTc
         Fsmso0BYCesGgjdMC9Q4UQsLMLDpJfgZkIcddFlEw8rTfiedRYVGVE+k4xoC6imUbv2L
         XxMVS5eylX5doMq50XaGS7bbT8HxgssVhzPgnhFM9XFHXX9/0No9NbpVVXFjCVkjTHy5
         BbBx/1ZwbK6OPJ+hxv2i4R0THmvTS4CA/p23phqEm1H6oYxOWmA/pR9qugcHnk/HjGWW
         8ghQ==
X-Gm-Message-State: AOAM532xoH/AuSZCXr1RkJfWl9vpc8ujYA+2HpjDsZN8aDxCojqkyZNH
        1gjyzPhXba5hXiZ1XRO/QGTDoJFuEUGJi8FqmMKOSPYL4ejb
X-Google-Smtp-Source: ABdhPJy7R/AOQ/1Y5hhK0KLYXWjBwAjI7Zk8IQ4eVqCecojrmS6hUGPhQrrH3IKP6yufh0o/vL/bHcVD3XEIyWV24eEJmML1/+6n
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:: with SMTP id g6mr1015443ild.274.1611480621360;
 Sun, 24 Jan 2021 01:30:21 -0800 (PST)
Date:   Sun, 24 Jan 2021 01:30:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffac1205b9a2112f@google.com>
Subject: UBSAN: shift-out-of-bounds in load_balance
From:   syzbot <syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bc085f8f Add linux-next specific files for 20210121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b71a2cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1224bbf217b0bec8
dashboard link: https://syzkaller.appspot.com/bug?extid=d7581744d5fd27c9fbe1
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in kernel/sched/fair.c:7741:14
shift exponent 86 is too large for 64-bit type 'long unsigned int'
CPU: 1 PID: 13261 Comm: kworker/u4:13 Not tainted 5.11.0-rc4-next-20210121-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: krdsd rds_tcp_accept_worker
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 detach_tasks kernel/sched/fair.c:7741 [inline]
 load_balance.cold+0x1d/0x2e kernel/sched/fair.c:9670
 rebalance_domains+0x5cc/0xdb0 kernel/sched/fair.c:10058
 __do_softirq+0x2bc/0xa29 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
 do_softirq kernel/softirq.c:246 [inline]
 do_softirq+0xb5/0xe0 kernel/softirq.c:233
 __local_bh_enable_ip+0xf4/0x110 kernel/softirq.c:196
 local_bh_enable include/linux/bottom_half.h:32 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:745 [inline]
 ip_finish_output2+0x88b/0x21b0 net/ipv4/ip_output.c:231
 __ip_finish_output net/ipv4/ip_output.c:308 [inline]
 __ip_finish_output+0x396/0x640 net/ipv4/ip_output.c:290
 ip_finish_output+0x35/0x200 net/ipv4/ip_output.c:318
 NF_HOOK_COND include/linux/netfilter.h:290 [inline]
 ip_output+0x196/0x310 net/ipv4/ip_output.c:432
 dst_output include/net/dst.h:441 [inline]
 ip_local_out net/ipv4/ip_output.c:126 [inline]
 __ip_queue_xmit+0x8e9/0x1a00 net/ipv4/ip_output.c:532
 __tcp_transmit_skb+0x188c/0x38f0 net/ipv4/tcp_output.c:1405
 tcp_transmit_skb net/ipv4/tcp_output.c:1423 [inline]
 tcp_write_xmit+0xde7/0x6140 net/ipv4/tcp_output.c:2689
 __tcp_push_pending_frames+0xaa/0x390 net/ipv4/tcp_output.c:2869
 tcp_send_fin+0x117/0xbb0 net/ipv4/tcp_output.c:3426
 tcp_shutdown net/ipv4/tcp.c:2636 [inline]
 tcp_shutdown+0x127/0x170 net/ipv4/tcp.c:2621
 inet_shutdown+0x1a8/0x430 net/ipv4/af_inet.c:890
 rds_tcp_accept_one+0x5e0/0xc10 net/rds/tcp_listen.c:214
 rds_tcp_accept_worker+0x50/0x80 net/rds/tcp.c:515
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
