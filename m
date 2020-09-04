Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E225D0FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 07:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIDFsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 01:48:22 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44394 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDFsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:48:20 -0400
Received: by mail-io1-f72.google.com with SMTP id l8so3688225ioa.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 22:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=adSaErrS+NJDZ1sWGnEkBTMPxTpUC1WocPpkg5ogTnk=;
        b=HjC83Kq0MN9smnySDsTzLznF6Kshd6O3N47r3FrHaZrdVuHwEkUMrBLwos9Zi0pX+M
         SYcuOEUQmBXKMBjqr37BepH97qkAnYBzV3bBGpBTBmvuwO6BCiGvrSTQaxqhCXfBv9TS
         xIFgMoH54eHhbCTafFeYaIxdDqLReRDJcthPEpKqJ6LaG7iulafCoLFoiqjNm60NSNNz
         PF38lNkxrAa2brrOaSwIDUX4LLZV74iFaoiuVts2VRVGsPjoDSGyl5myvE8HdXuliyyR
         7oZ9DYguV2GlCAw+zMuQr6ycpKncmWcD453jcmqF7k+b0X7Wf6vKE6Xo3uYivPBKD/jb
         rWIA==
X-Gm-Message-State: AOAM531ckyAjKK3obsEPvi6LXX8ByM+RbA0I+/5wjOM7FTzFycACzvWH
        9NhJR4hlbHWjLgnCVN2xlRFmLwZwqL1QbgJMUuv9QD7TpOEw
X-Google-Smtp-Source: ABdhPJzyUvGdhVGGYWRgQ83jR0N7k+odBtrWn5pX3Pdq4vlCdraGt8u1ZVFoefVHVT6vT2KSCleT0/SItSm+1Fev8iqBUPsbS5MZ
MIME-Version: 1.0
X-Received: by 2002:a92:ce44:: with SMTP id a4mr5797266ilr.240.1599198499477;
 Thu, 03 Sep 2020 22:48:19 -0700 (PDT)
Date:   Thu, 03 Sep 2020 22:48:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ca0e105ae766a11@google.com>
Subject: KASAN: null-ptr-deref Read in percpu_ref_exit
From:   syzbot <syzbot+4264ecfcf0f27a5e4180@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7a695657 Add linux-next specific files for 20200903
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ac984e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39134fcec6c78e33
dashboard link: https://syzkaller.appspot.com/bug?extid=4264ecfcf0f27a5e4180
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13709f15900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147047e9900000

The issue was bisected to:

commit d0c567d60f3730b97050347ea806e1ee06445c78
Author: Ming Lei <ming.lei@redhat.com>
Date:   Wed Sep 2 12:26:42 2020 +0000

    percpu_ref: reduce memory footprint of percpu_ref in fast path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ed5a95900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=141d5a95900000
console output: https://syzkaller.appspot.com/x/log.txt?x=101d5a95900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4264ecfcf0f27a5e4180@syzkaller.appspotmail.com
Fixes: d0c567d60f37 ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
BUG: KASAN: null-ptr-deref in atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
BUG: KASAN: null-ptr-deref in percpu_ref_exit+0x102/0x1f0 lib/percpu-refcount.c:136
Read of size 8 at addr 0000000000000000 by task syz-executor932/7175

CPU: 0 PID: 7175 Comm: syz-executor932 Not tainted 5.9.0-rc3-next-20200903-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
 atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
 percpu_ref_exit+0x102/0x1f0 lib/percpu-refcount.c:136
 hd_free_part block/partitions/../blk.h:391 [inline]
 part_release+0x9d/0xc0 block/partitions/core.c:262
 device_release+0x9f/0x240 drivers/base/core.c:1802
 kobject_cleanup lib/kobject.c:708 [inline]
 kobject_release lib/kobject.c:739 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x171/0x270 lib/kobject.c:756
 put_device+0x1b/0x30 drivers/base/core.c:3031
 add_partition+0x648/0xb00 block/partitions/core.c:493
 blk_add_partition block/partitions/core.c:685 [inline]
 blk_add_partitions+0x9db/0xe00 block/partitions/core.c:761
 bdev_disk_changed+0x208/0x390 fs/block_dev.c:1417
 loop_reread_partitions+0x29/0x50 drivers/block/loop.c:658
 loop_set_status+0x6da/0x1010 drivers/block/loop.c:1427
 loop_set_status64 drivers/block/loop.c:1547 [inline]
 lo_ioctl+0x900/0x1690 drivers/block/loop.c:1715
 __blkdev_driver_ioctl block/ioctl.c:224 [inline]
 blkdev_ioctl+0x28c/0x700 block/ioctl.c:620
 block_ioctl+0xf9/0x140 fs/block_dev.c:1870
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c27
Code: 48 83 c4 08 48 89 d8 5b 5d c3 66 0f 1f 84 00 00 00 00 00 48 89 e8 48 f7 d8 48 39 c3 0f 92 c0 eb 92 66 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 6d 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb6aa64db48 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000446c27
RDX: 00007fb6aa64dbe0 RSI: 0000000000004c04 RDI: 0000000000000004
RBP: 00000000200158a8 R08: fe03f80fe03f80ff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fb6aa64e6d0
R13: 0000000000000003 R14: 0000000000000003 R15: 000a00d800050102
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
