Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0B2B5B75
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKQJAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:00:19 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:55296 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKQJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:00:19 -0500
Received: by mail-il1-f198.google.com with SMTP id w10so14153755ila.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lJJe4Mkcih/jYQwDgbFyQnQNvGKLMoaZ+6egKWnU7c0=;
        b=cr13Q/vDACnwanaCRZr6hgp2ozHBQQC1e/S4uhoKl4PG8IaAGzGYGZ+/o9GSicL8fR
         VHai+L5w1MZ1RNflLxe0TILfxpDUi4SwnaBB1UysjSzFw3NYQc+Z4EQHBhW2ixinczpb
         gW2SvQuCjGQ6jqdXPgXJcMNBp4es0vgWDX4lzp5Y2hkgxyvGVXYw8oA9XmdcUKLoOVvJ
         0IkQvZBp5NwSMvkR9S8Bh4eWOu69KWGfBLGy/wxTghvSqndVVH/z2O9fF0PwvG1wlLa4
         rVojZUEFuUXbpoMz6N7cK0V5qneA18xpL6p4UxWA07ec12gViqVMWVRwci3iOFYBVpF7
         VmKg==
X-Gm-Message-State: AOAM530BWND2/hMYaCBA1UbTJ9S3mqHLoExBGMQX5XT8/uXq/YITPZPP
        STAhzLCdKgcBwSihQRWYcg17d3cj+kIrA5tPAAF5ZjWQ4vwo
X-Google-Smtp-Source: ABdhPJwNciEJFlHJoFSCvKJSulGaAUplDXRZhw5ZtaY4xYKVyYfnBykThPgmpG6rduFNzy0R5r+ll0OmCTjAqI7ml1kS2Nct31Cu
MIME-Version: 1.0
X-Received: by 2002:a92:5b46:: with SMTP id p67mr10985550ilb.150.1605603618399;
 Tue, 17 Nov 2020 01:00:18 -0800 (PST)
Date:   Tue, 17 Nov 2020 01:00:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000532b5c05b449b97a@google.com>
Subject: KMSAN: kernel-infoleak in vmci_host_unlocked_ioctl
From:   syzbot <syzbot+a79e17c39564bedf0930@syzkaller.appspotmail.com>
To:     arnd@arndb.de, glider@google.com, gregkh@linuxfoundation.org,
        jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    73d62e81 kmsan: random: prevent boot-time reports in _mix_..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10c36af6500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81c697c46ab63515
dashboard link: https://syzkaller.appspot.com/bug?extid=a79e17c39564bedf0930
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11180fe6500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e0e5e6500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a79e17c39564bedf0930@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0x9c/0xb0 mm/kmsan/kmsan_hooks.c:249
CPU: 1 PID: 8267 Comm: syz-executor275 Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 kmsan_internal_check_memory+0x484/0x520 mm/kmsan/kmsan.c:437
 kmsan_copy_to_user+0x9c/0xb0 mm/kmsan/kmsan_hooks.c:249
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0x16e/0x240 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:209 [inline]
 vmci_host_do_ctx_get_cpt_state drivers/misc/vmw_vmci/vmci_host.c:723 [inline]
 vmci_host_unlocked_ioctl+0x3486/0x59a0 drivers/misc/vmw_vmci/vmci_host.c:939
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0x311/0x4d0 fs/ioctl.c:739
 __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:739
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x443f19
Code: e8 fc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffeaed45fc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000443f19
RDX: 0000000020001540 RSI: 00000000000007b1 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000404cc0
R13: 0000000000404d50 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:104
 kmsan_slab_alloc+0x8d/0xe0 mm/kmsan/kmsan_hooks.c:76
 slab_alloc_node mm/slub.c:2906 [inline]
 slab_alloc mm/slub.c:2915 [inline]
 __kmalloc+0x2f0/0x530 mm/slub.c:3983
 kmalloc include/linux/slab.h:557 [inline]
 vmci_ctx_get_chkpt_doorbells drivers/misc/vmw_vmci/vmci_context.c:746 [inline]
 vmci_ctx_get_chkpt_state+0x6a0/0xf30 drivers/misc/vmw_vmci/vmci_context.c:798
 vmci_host_do_ctx_get_cpt_state drivers/misc/vmw_vmci/vmci_host.c:719 [inline]
 vmci_host_unlocked_ioctl+0x2e02/0x59a0 drivers/misc/vmw_vmci/vmci_host.c:939
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0x311/0x4d0 fs/ioctl.c:739
 __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:739
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Bytes 8-15 of 16 are uninitialized
Memory access of size 16 starts at ffff8881248eec00
Data copied to user address 0000000020000540
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
