Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A0C2A509C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 21:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgKCUBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgKCUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:01:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ADEC0613D1;
        Tue,  3 Nov 2020 12:01:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id 7so26156648ejm.0;
        Tue, 03 Nov 2020 12:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cLf0RBYlSuOED9U3oH1dZaqD+2/M+cXwZ5yGdUp81BQ=;
        b=fSIEOGRqnpejQKtbbD25+KJm5DrfZIQXZn8gvtOcutaxuUdfy4j/8Vz3Ctwd2Ch/za
         V8uRPCghUx7et34fNswjXWaBBDjfyL5NKDjsTXBOTHYRBk/HmNuayYVWpVy8FN+yArwR
         gQPRUNOmCX9Rqx+Dhh6uJKAZIe2aiRUgfmRg98Ukr0dQ4y6lmo9izCstW5IeoBWHJQhY
         /ERn7NaTXTAK4JADbV5TsqcoMzspDtWVxoqZ+f3+GUHvD4cjZpsCAZZzOHbj8kg4sVT1
         NyPPZuKD3ZRWjy3OM8o/lxQ9mwR8DPfQEm9U2a8ixml6hVcilO+Xltd4fAQTYmKVVa/f
         KeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cLf0RBYlSuOED9U3oH1dZaqD+2/M+cXwZ5yGdUp81BQ=;
        b=PyI5FWurpD2ldiqKEp6LDzTuKbDdF0I+/+WF1pnlPSQyMxZOzDPiLymR/hW3D46goO
         KykR/ByXMU3VT+Hawt7FW9+o6m0KwG3xjRNJtqqasMLmt9ocOoWOh14DucgoqYh5Xr56
         a81LojzYHRmMunhWIVqylwGqV+piSRYiydz7c636oQZ8z6qHj8xl9I3GS1GGUiQ5dT0Y
         C5hSK1BeJECWy/kqXWcpDcdHyCYrf2rQqzAb7dm045cfHH44SmTmWJi29QhSVifinM6e
         Ou4vsz3UryAJ5ZSZ7CPZwU8oD/lEcT8d0NSyuoWFUofNwTrSA+z+jgT3sl7JqmlZTKld
         Vo4Q==
X-Gm-Message-State: AOAM530B7xLQ/OJgTKSaho+3bHpHscVeJtpzVgiYJhr77oGESCmdXYrJ
        RaeinvXb6hPCF861KJFLVeQz2fEYsCwmvwmOrgs=
X-Google-Smtp-Source: ABdhPJw30J72MSdCv6Vg78CN3FStRSEJ9tFAe3xewFZaJat0nm5zxvI26u/SJ+i/uVG5im2NI8qt6vw/TdAQoZ6YkVo=
X-Received: by 2002:a17:907:1102:: with SMTP id qu2mr21755654ejb.300.1604433672271;
 Tue, 03 Nov 2020 12:01:12 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Tue, 3 Nov 2020 15:00:59 -0500
Message-ID: <CAEAjamu6c+3CCUTaygr81m=zw1jPpTUUoaZikDeQJOFH4YUX=Q@mail.gmail.com>
Subject: possible deadlock in tcm_alloc
To:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a potential deadlock while setting up a tcm gadget as follows.

==================================================================
WARNING: possible circular locking dependency detected
5.8.13 #7 Not tainted
------------------------------------------------------
c1_fuzz/722 is trying to acquire lock:
ffffffff87cc2828 (tpg_instances_lock){+.+.}-{3:3}, at:
tcm_alloc+0x1f/0x2b0 drivers/usb/gadget/function/f_tcm.c:2300

but task is already holding lock:
ffff88806396b310 (&gi->lock){+.+.}-{3:3}, at:
config_usb_cfg_link+0x70/0x3a0 drivers/usb/gadget/configfs.c:413

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&gi->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x14f/0x1380 kernel/locking/mutex.c:1103
       mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
       config_usb_cfg_link+0x70/0x3a0 drivers/usb/gadget/configfs.c:413
       configfs_symlink+0x4f5/0xf10 fs/configfs/symlink.c:202
       vfs_symlink fs/namei.c:3953 [inline]
       vfs_symlink+0x304/0x540 fs/namei.c:3939
       do_symlinkat+0x104/0x1a0 fs/namei.c:3980
       __do_sys_symlinkat fs/namei.c:3994 [inline]
       __se_sys_symlinkat fs/namei.c:3991 [inline]
       __x64_sys_symlinkat+0x6e/0xb0 fs/namei.c:3991
       do_syscall_64+0x54/0xa0 arch/x86/entry/common.c:392
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (&sb->s_type->i_mutex_key#17){++++}-{3:3}:
       down_write+0x8f/0x140 kernel/locking/rwsem.c:1531
       inode_lock include/linux/fs.h:810 [inline]
       configfs_depend_item_unlocked+0xba/0x470 fs/configfs/dir.c:1240
       usbg_make_tpg+0x43a/0x5e0 drivers/usb/gadget/function/f_tcm.c:1373
       target_fabric_make_tpg+0xa7/0x9d0
drivers/target/target_core_fabric_configfs.c:837
       configfs_mkdir+0x3f8/0xb40 fs/configfs/dir.c:1344
       vfs_mkdir+0x38f/0x640 fs/namei.c:3641
       do_mkdirat+0x113/0x1e0 fs/namei.c:3664
       __do_sys_mkdir fs/namei.c:3680 [inline]
       __se_sys_mkdir fs/namei.c:3678 [inline]
       __x64_sys_mkdir+0x57/0x80 fs/namei.c:3678
       do_syscall_64+0x54/0xa0 arch/x86/entry/common.c:392
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&opts->dep_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x14f/0x1380 kernel/locking/mutex.c:1103
       mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
       usbg_make_tpg+0x145/0x5e0 drivers/usb/gadget/function/f_tcm.c:1365
       target_fabric_make_tpg+0xa7/0x9d0
drivers/target/target_core_fabric_configfs.c:837
       configfs_mkdir+0x3f8/0xb40 fs/configfs/dir.c:1344
       vfs_mkdir+0x38f/0x640 fs/namei.c:3641
       do_mkdirat+0x113/0x1e0 fs/namei.c:3664
       __do_sys_mkdir fs/namei.c:3680 [inline]
       __se_sys_mkdir fs/namei.c:3678 [inline]
       __x64_sys_mkdir+0x57/0x80 fs/namei.c:3678
       do_syscall_64+0x54/0xa0 arch/x86/entry/common.c:392
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (tpg_instances_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain kernel/locking/lockdep.c:3218 [inline]
       __lock_acquire+0x2fe7/0x5120 kernel/locking/lockdep.c:4395
       lock_acquire+0x18d/0xb00 kernel/locking/lockdep.c:4982
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x14f/0x1380 kernel/locking/mutex.c:1103
       mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
       tcm_alloc+0x1f/0x2b0 drivers/usb/gadget/function/f_tcm.c:2300
       usb_get_function+0x58/0xc0 drivers/usb/gadget/functions.c:61
       config_usb_cfg_link+0x1ed/0x3a0 drivers/usb/gadget/configfs.c:435
       configfs_symlink+0x4f5/0xf10 fs/configfs/symlink.c:202
       vfs_symlink fs/namei.c:3953 [inline]
       vfs_symlink+0x304/0x540 fs/namei.c:3939
       do_symlinkat+0x104/0x1a0 fs/namei.c:3980
       __do_sys_symlinkat fs/namei.c:3994 [inline]
       __se_sys_symlinkat fs/namei.c:3991 [inline]
       __x64_sys_symlinkat+0x6e/0xb0 fs/namei.c:3991
       do_syscall_64+0x54/0xa0 arch/x86/entry/common.c:392
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  tpg_instances_lock --> &sb->s_type->i_mutex_key#17 --> &gi->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&gi->lock);
                               lock(&sb->s_type->i_mutex_key#17);
                               lock(&gi->lock);
  lock(tpg_instances_lock);

 *** DEADLOCK ***

3 locks held by c1_fuzz/722:
 #0: ffff8880662ac438 (sb_writers#15){.+.+}-{0:0}, at: sb_start_write
include/linux/fs.h:1675 [inline]
 #0: ffff8880662ac438 (sb_writers#15){.+.+}-{0:0}, at:
mnt_want_write+0x3c/0xa0 fs/namespace.c:354
 #1: ffff8880568afaf0 (&sb->s_type->i_mutex_key#17){++++}-{3:3}, at:
inode_lock include/linux/fs.h:810 [inline]
 #1: ffff8880568afaf0 (&sb->s_type->i_mutex_key#17){++++}-{3:3}, at:
configfs_symlink+0x388/0xf10 fs/configfs/symlink.c:193
 #2: ffff88806396b310 (&gi->lock){+.+.}-{3:3}, at:
config_usb_cfg_link+0x70/0x3a0 drivers/usb/gadget/configfs.c:413

stack backtrace:
CPU: 2 PID: 722 Comm: c1_fuzz Not tainted 5.8.13 #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xa7/0xea lib/dump_stack.c:118
 print_circular_bug.cold.46+0x15a/0x169 kernel/locking/lockdep.c:1703
 check_noncircular+0x327/0x3e0 kernel/locking/lockdep.c:1827
 check_prev_add kernel/locking/lockdep.c:2496 [inline]
 check_prevs_add kernel/locking/lockdep.c:2601 [inline]
 validate_chain kernel/locking/lockdep.c:3218 [inline]
 __lock_acquire+0x2fe7/0x5120 kernel/locking/lockdep.c:4395
 lock_acquire+0x18d/0xb00 kernel/locking/lockdep.c:4982
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x14f/0x1380 kernel/locking/mutex.c:1103
 mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
 tcm_alloc+0x1f/0x2b0 drivers/usb/gadget/function/f_tcm.c:2300
 usb_get_function+0x58/0xc0 drivers/usb/gadget/functions.c:61
 config_usb_cfg_link+0x1ed/0x3a0 drivers/usb/gadget/configfs.c:435
 configfs_symlink+0x4f5/0xf10 fs/configfs/symlink.c:202
 vfs_symlink fs/namei.c:3953 [inline]
 vfs_symlink+0x304/0x540 fs/namei.c:3939
 do_symlinkat+0x104/0x1a0 fs/namei.c:3980
 __do_sys_symlinkat fs/namei.c:3994 [inline]
 __se_sys_symlinkat fs/namei.c:3991 [inline]
 __x64_sys_symlinkat+0x6e/0xb0 fs/namei.c:3991
 do_syscall_64+0x54/0xa0 arch/x86/entry/common.c:392
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x439d2a
Code: ff 4c 8b 7c 24 30 64 c7 03 22 00 00 00 41 bc 22 00 00 00 e9 1a
fd ff ff 45 31 ed e9 4d fe ff ff 48 63 f6 b8 0a 01 00 00 0f 05 <48> 3d
00 f0 ff ff 77 02 f3 c3 48 c7 c2 c0 ff ff ff f7 d8 64 89 02
RSP: 002b:00007ffc01673278 EFLAGS: 00000206 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00000000004002b0 RCX: 0000000000439d2a
RDX: 00007ffc016732e0 RSI: 0000000000000004 RDI: 00007ffc016732a0
RBP: 00007ffc01673320 R08: 0000000000000000 R09: 00007ffc01674ee1
R10: 0000000000000005 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000403200 R14: 0000000000403290 R15: 0000000000000000
==================================================================

Regards,
Kyungtae Kim
