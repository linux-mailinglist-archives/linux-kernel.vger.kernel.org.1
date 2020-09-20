Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2384271324
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgITJWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 05:22:17 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:53408 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 05:22:16 -0400
Received: by mail-il1-f206.google.com with SMTP id w12so2037518ilc.20
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 02:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IJjZQysLXu1/RF9ewteRS4rH+LUmVeCkOSAwIBABgto=;
        b=BVAvbMynTnySMh7jOvAuTOwUW3NymmAtFHDrG7m/sUlKE5aKvzNFbTJ9OlUhEqNDvD
         xApxt3YObXuUbQxQ5brWVETmUy+lxwoUQEvIyhGD7vZW1tDGqpB/4xpIhIw/bSOiiZuN
         bC1KQiUhMU3ooXHVD4fhqfLIvx4N2zlC7vBQ14ODnypHBxXIpfVq1Nwgh08NijSYVFJx
         Qq8m/rs4XE03xIiwNUTF7X3T5uU2pUf2SapRDbygroNwsAfIJVVOer0LmEkwh6ud8WnV
         rTn5hP+9iNSbdwHcJHsZFXNiA4gVeblr+KnLUSA61hzyU1XIR3jkceo+f02ryEc01c07
         yPFQ==
X-Gm-Message-State: AOAM533+2PeXr98uglrTlgVOivkCmKy6t2TthqjgpC6ay59rHdkGBX3D
        bzusNU4Yiap8YF/GEgp52uyq2p/pyhiXxt5x7ojq5aLmStLr
X-Google-Smtp-Source: ABdhPJzegCGBiRCxz2F/3M3r3CJ9P0i4yQ+5vnz9X+cIpF7YYwXUhsCfH9xUomiztgWcfMIp0sV3NsHTm31QB5oFGN1R31LvVSc+
MIME-Version: 1.0
X-Received: by 2002:a5e:8e0a:: with SMTP id a10mr33673966ion.200.1600593735382;
 Sun, 20 Sep 2020 02:22:15 -0700 (PDT)
Date:   Sun, 20 Sep 2020 02:22:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006fb0905afbb458d@google.com>
Subject: KMSAN: uninit-value in is_idle_task
From:   syzbot <syzbot+a4b29e75da1c2c8bd34f@syzkaller.appspotmail.com>
To:     bp@alien8.de, glider@google.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3b3ea602 x86: add failure injection to get/put/clear_user
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=144b8965900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee5f7a0b2e48ed66
dashboard link: https://syzkaller.appspot.com/bug?extid=a4b29e75da1c2c8bd34f
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4b29e75da1c2c8bd34f@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in is_idle_task+0x65/0x70 include/linux/sched.h:1672
CPU: 0 PID: 5351 Comm: syz-executor.3 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 is_idle_task+0x65/0x70 include/linux/sched.h:1672
 sysvec_apic_timer_interrupt+0x2e/0x130 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:593
RIP: 0010:kmsan_get_metadata+0x136/0x180 mm/kmsan/kmsan_shadow.c:201
Code: 75 5f 48 89 df e8 6a 00 00 00 48 85 c0 74 50 48 8b 48 40 48 85 c9 74 47 48 8b 40 48 48 85 c0 74 3e 81 e3 ff 0f 00 00 45 84 f6 <48> 0f 45 c8 48 b8 00 00 00 00 00 16 00 00 48 01 c8 48 c1 e8 04 48
RSP: 0018:ffff8881cde9f460 EFLAGS: 00000246
RAX: ffffea00090451b0 RBX: 0000000000000608 RCX: ffffea00090311b0
RDX: 00000001cde9f608 RSI: 0000000000000720 RDI: ffff8881cde9f608
RBP: ffff8881cde9f478 R08: ffffea000000000f R09: ffff88812fffa000
R10: 0000000000000004 R11: 00000000ffffffff R12: 000000000000006a
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 kmsan_get_shadow_origin_ptr+0x6c/0xb0 mm/kmsan/kmsan_shadow.c:149
 __msan_metadata_ptr_for_load_4+0x10/0x20 mm/kmsan/kmsan_instr.c:54
 vga_8planes_fillrect drivers/video/fbdev/vga16fb.c:855 [inline]
 vga16fb_fillrect+0xbbc/0x1870 drivers/video/fbdev/vga16fb.c:947
 bit_clear_margins+0x582/0x740 drivers/video/fbdev/core/bitblit.c:232
 fbcon_clear_margins drivers/video/fbdev/core/fbcon.c:1381 [inline]
 fbcon_switch+0x2e79/0x3830 drivers/video/fbdev/core/fbcon.c:2363
 redraw_screen+0x9b2/0x2980 drivers/tty/vt/vt.c:1015
 fbcon_modechanged+0x110d/0x1320 drivers/video/fbdev/core/fbcon.c:3001
 fbcon_update_vcs+0x86/0xa0 drivers/video/fbdev/core/fbcon.c:3048
 fb_set_var+0x1420/0x1850 drivers/video/fbdev/core/fbmem.c:1056
 do_fb_ioctl+0xc00/0x1150 drivers/video/fbdev/core/fbmem.c:1109
 fb_ioctl+0x1e4/0x210 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl fs/ioctl.c:753 [inline]
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl+0x319/0x4d0 fs/ioctl.c:760
 __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:760
 do_syscall_64+0xad/0x160 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5f9
Code: Bad RIP value.
RSP: 002b:00007fdcda761c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000e280 RCX: 000000000045d5f9
RDX: 00000000200000c0 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 000000000118cf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 000000000169fb6f R14: 00007fdcda7629c0 R15: 000000000118cf4c

------------[ cut here ]------------
slab index 32768 out of bounds (558) for stack id 262b8000
WARNING: CPU: 0 PID: 5351 at lib/stackdepot.c:235 stack_depot_fetch+0x2d/0x60 lib/stackdepot.c:234


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
