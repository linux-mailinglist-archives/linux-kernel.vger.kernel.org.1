Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9552A13C7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 07:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgJaGOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 02:14:21 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40973 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJaGOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 02:14:21 -0400
Received: by mail-io1-f69.google.com with SMTP id j21so5730574iog.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 23:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rkjvzxYfDZDr/kKEmWkJIKU9mlk3DIFp+Fpj4HynMVo=;
        b=pMtRHWTAcYMRmqt7LJDBqoI2So84VzTgVPqA9NwPGFc3i2vIKcmXvS4LIbikpIJIl5
         D0ubUBoBFYRIKXgQFvxH4pOBATWkUNLOb/yuhgSnwp14pLEiKMD0ShXgRH1As1ZAJkee
         qkuRWaFmVpQ+PnbxBAOYWcazrVIT9r8LzzXN9aoEMuj1FISK/asGSsHwJdIbCfRUFd3x
         Ns/ui+lLq9tOasr6xtpBuQ7XTcVWFNdx+TL6U0/aTvw/8xQ84/Sl6dQZKnzrUgn1gMCj
         sYFtV3eDVr5/OXQ14xyUYKIiZhzVRINH+2ScbI6YEmrG4rSVkP5hH7YlTpfP5gN++1nR
         E5zw==
X-Gm-Message-State: AOAM533iUfqom3YkS8Tv7xo7YrQey2WC34SHZkhJCaLQEsaaBaoLrzEC
        FMMDGsTo1YDhsnMfqCXJfwAMamf3FmdLPCF9q1FKRTmAHYj7
X-Google-Smtp-Source: ABdhPJypkpupBDU6TcMP0bm+7oqikDemEodNPdzkLUhm1RqlxE05epf6h++O7rxWP6lZ6flKG1R9tYApU+1STtR2IhdkaiV2KBZ9
MIME-Version: 1.0
X-Received: by 2002:a02:242b:: with SMTP id f43mr4785183jaa.111.1604124859291;
 Fri, 30 Oct 2020 23:14:19 -0700 (PDT)
Date:   Fri, 30 Oct 2020 23:14:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069dbc805b2f16c3e@google.com>
Subject: WARNING in vkms_vblank_simulate (2)
From:   syzbot <syzbot+4fc21a003c8332eb0bdd@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        melissa.srw@gmail.com, rodrigosiqueiramelo@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f267ec6 Add linux-next specific files for 20201029
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=170739d2500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f00c6dd47ae4c2c
dashboard link: https://syzkaller.appspot.com/bug?extid=4fc21a003c8332eb0bdd
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e83ef2500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159f01f2500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4fc21a003c8332eb0bdd@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 34 at drivers/gpu/drm/vkms/vkms_crtc.c:21 vkms_vblank_simulate+0x31e/0x3b0 drivers/gpu/drm/vkms/vkms_crtc.c:21
Modules linked in:
CPU: 0 PID: 34 Comm: kauditd Not tainted 5.10.0-rc1-next-20201029-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vkms_vblank_simulate+0x31e/0x3b0 drivers/gpu/drm/vkms/vkms_crtc.c:21
Code: 85 9e 00 00 00 48 8b 95 b8 01 00 00 4c 89 e1 bf 02 00 00 00 48 c7 c6 20 e6 b3 89 e8 0c 91 ef ff e9 e5 fe ff ff e8 72 e0 34 fd <0f> 0b e9 88 fd ff ff e8 e6 7b 76 fd e9 11 fe ff ff 4c 89 ef e8 d9
RSP: 0018:ffffc90000007dc0 EFLAGS: 00010046
RAX: 0000000000010001 RBX: ffff888143c91e48 RCX: ffffffff843b47c3
RDX: ffff888010fa0000 RSI: ffffffff843b4a3e RDI: 0000000000000007
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888143c90d40
R13: 0000000000fe4c00 R14: ffffffff843b4720 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff2c859fb4 CR3: 0000000013fee000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x693/0xea0 kernel/time/hrtimer.c:1583
 hrtimer_interrupt+0x334/0x940 kernel/time/hrtimer.c:1645
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1097
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_sysvec_on_irqstack arch/x86/include/asm/irq_stack.h:37 [inline]
 run_sysvec_on_irqstack_cond arch/x86/include/asm/irq_stack.h:89 [inline]
 sysvec_apic_timer_interrupt+0xbd/0x100 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:631
RIP: 0010:console_unlock+0x7b6/0xbb0 kernel/printk/printk.c:2509
Code: 60 8f 24 8b e8 6b 8d fd ff e8 f6 3b 00 00 31 ff 4c 89 ee e8 2c 76 17 00 4d 85 ed 0f 85 3a 02 00 00 e8 ae 7d 17 00 ff 34 24 9d <8b> 5c 24 34 31 ff 89 de e8 ed 75 17 00 85 db 0f 84 eb f9 ff ff e8
RSP: 0018:ffffc90000dcfaf0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8155b067
RDX: ffff888010fa0000 RSI: ffffffff8158ad02 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8ebb4667
R10: fffffbfff1d768cc R11: 0000000000000000 R12: ffffffff84a24b90
R13: 0000000000000200 R14: dffffc0000000000 R15: ffffc90000dcfb50
 vprintk_emit+0x1a1/0x4c0 kernel/printk/printk.c:2028
 vprintk_func+0x8d/0x1e0 kernel/printk/printk_safe.c:393
 printk+0xba/0xed kernel/printk/printk.c:2076
 kauditd_printk_skb kernel/audit.c:538 [inline]
 kauditd_hold_skb.cold+0x41/0x50 kernel/audit.c:571
 kauditd_send_queue+0x19d/0x210 kernel/audit.c:734
 kauditd_thread+0x7f0/0xb80 kernel/audit.c:860
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
