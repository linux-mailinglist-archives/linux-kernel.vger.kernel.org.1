Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4372678BB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 09:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgILH7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 03:59:23 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:46157 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgILH7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 03:59:21 -0400
Received: by mail-io1-f80.google.com with SMTP id j8so105996iof.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 00:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=go9OmBFDLb2n53CiVIZT2Q/pl1bejLw6HkAlVDkgsBE=;
        b=L9fO7O5lxHfAJs44WGmRM3qN6/YJ/vqa38Q0WP3g4pahaoBSxnZhevlib5/hfT0aEl
         iVDFsqLBZGoNUCmaVGuU0lufuXY8tTHvCQKjDvJctNkGUbroeIubEjQ4OSFInmy+sqvX
         XD6g4Dk66kV+WxLcpaw+2BMEnC10j1ta7wuoKgExArSV3AmXniQaXEc1J1dMwDipPWWo
         JNOoTfXeLnnnhGjdRY07I6hq67KAslVdZFVMpTNZkrCkMQ+r6gK0wElsPERBlWfybnPH
         ChACmv83WXXf2QdiRNuykXkO1gb8Iyu6JHZIsX/4qw69Hf8cunYZzQ6oZ2nObjKUIUtd
         sJ5g==
X-Gm-Message-State: AOAM531aji8yO+Sfn/PkpHQoY6lSH7u7TttmUfdBtpwau4glW6CEsF/S
        1CEz0Huoda0N1InxZI7UdL18azajcXl6BSp8Z4I1sSu8woa4
X-Google-Smtp-Source: ABdhPJxwV1H3W0bPHW/nlO//YfrCJZcoP3tSXnp34cEVfY3njErOz56u9OumJ1xOcGiIuXLJ3BO3D8OVXrZjFYplsbuMCK9FRZE/
MIME-Version: 1.0
X-Received: by 2002:a5d:8612:: with SMTP id f18mr4583223iol.135.1599897560098;
 Sat, 12 Sep 2020 00:59:20 -0700 (PDT)
Date:   Sat, 12 Sep 2020 00:59:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf2d3605af192d03@google.com>
Subject: KMSAN: uninit-value in netif_receive_generic_xdp
From:   syzbot <syzbot+026212ad75beeadc9907@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, glider@google.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, paulmck@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3b3ea602 x86: add failure injection to get/put/clear_user
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=177d7335900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
dashboard link: https://syzkaller.appspot.com/bug?extid=026212ad75beeadc9907
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+026212ad75beeadc9907@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in netif_receive_generic_xdp+0x15c9/0x2530 net/core/dev.c:4670
CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 netif_receive_generic_xdp+0x15c9/0x2530 net/core/dev.c:4670
 do_xdp_generic net/core/dev.c:4735 [inline]
 __netif_receive_skb_core+0x823/0x6520 net/core/dev.c:5107
 __netif_receive_skb_one_core net/core/dev.c:5279 [inline]
 __netif_receive_skb+0x164/0x670 net/core/dev.c:5395
 process_backlog+0x50d/0xba0 net/core/dev.c:6239
 napi_poll+0x43b/0xfd0 net/core/dev.c:6684
 net_rx_action+0x35c/0xd40 net/core/dev.c:6752
 __do_softirq+0x2ea/0x7f5 kernel/softirq.c:293
 run_ksoftirqd+0x25/0x40 kernel/softirq.c:634
 smpboot_thread_fn+0x5f5/0xa90 kernel/smpboot.c:165
 kthread+0x551/0x590 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 kmsan_memcpy_memmove_metadata+0x272/0x2e0 mm/kmsan/kmsan.c:247
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:267
 __msan_memcpy+0x43/0x50 mm/kmsan/kmsan_instr.c:116
 pskb_expand_head+0x3fd/0x1e30 net/core/skbuff.c:1636
 netif_receive_generic_xdp+0x629/0x2530 net/core/dev.c:4616
 do_xdp_generic net/core/dev.c:4735 [inline]
 __netif_receive_skb_core+0x823/0x6520 net/core/dev.c:5107
 __netif_receive_skb_one_core net/core/dev.c:5279 [inline]
 __netif_receive_skb+0x164/0x670 net/core/dev.c:5395
 process_backlog+0x50d/0xba0 net/core/dev.c:6239
 napi_poll+0x43b/0xfd0 net/core/dev.c:6684
 net_rx_action+0x35c/0xd40 net/core/dev.c:6752
 __do_softirq+0x2ea/0x7f5 kernel/softirq.c:293

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:80
 slab_alloc_node mm/slub.c:2839 [inline]
 __kmalloc_node_track_caller+0xeab/0x12e0 mm/slub.c:4478
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0x35f/0xb30 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1083 [inline]
 alloc_skb_with_frags+0x1f2/0xc10 net/core/skbuff.c:5770
 sock_alloc_send_pskb+0xc83/0xe50 net/core/sock.c:2356
 sock_alloc_send_skb+0xca/0xe0 net/core/sock.c:2373
 j1939_sk_alloc_skb net/can/j1939/socket.c:843 [inline]
 j1939_sk_send_loop net/can/j1939/socket.c:1025 [inline]
 j1939_sk_sendmsg+0xe11/0x2950 net/can/j1939/socket.c:1160
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0xc82/0x1240 net/socket.c:2352
 ___sys_sendmsg net/socket.c:2406 [inline]
 __sys_sendmsg+0x6d1/0x840 net/socket.c:2439
 __compat_sys_sendmsg net/compat.c:466 [inline]
 __do_compat_sys_sendmsg net/compat.c:473 [inline]
 __se_compat_sys_sendmsg+0xa7/0xc0 net/compat.c:470
 __ia32_compat_sys_sendmsg+0x4a/0x70 net/compat.c:470
 do_syscall_32_irqs_on arch/x86/entry/common.c:430 [inline]
 __do_fast_syscall_32+0x2af/0x480 arch/x86/entry/common.c:477
 do_fast_syscall_32+0x6b/0xd0 arch/x86/entry/common.c:505
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:554
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
