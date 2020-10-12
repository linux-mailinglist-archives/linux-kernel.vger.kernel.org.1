Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6B28B60C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbgJLNUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:20:20 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40715 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388883AbgJLNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:20:17 -0400
Received: by mail-io1-f69.google.com with SMTP id v7so8510216ioe.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=i7R36m5Nwz/soo8xSZ9gC0CAm4nSXg4mO1zlUpI+BvI=;
        b=fKnpxYYEoQS38h2GYGSgTbRxmtBxUL8JB7B+kG7sXx9X6RSvJCcJIOAVO7iH6pP1B6
         y7f/4E9XDsiGDPg96RI2Oa9H8obFbuVkZTgTCqDdNLRs11uss/y45mWaOLWRffN95qFt
         /6OHc7q93WmGe7Mf6QzL4tYjVcLIAPW+ZRmVdywf+QV27Qz0umFV1RtSq5+NsiTDeoCc
         yCrKpsTj3YR1L3qHEE1ylt+mCmXy6Qx6NEkeWC2aBP5+lm4jBfWFLku7en/AOwlNtFm2
         llYM0mitV/dFjsfBbCndU5uA93N4ajwluScqCWyQazHp7RcINP9t9Kk06b/5Pd2Z9TFO
         jcEw==
X-Gm-Message-State: AOAM533jdBwXgPs1IEvxdtxrfLsxSKlwgbre/t2sie55eX+AdJzk8cnr
        EhzAZWCR+VieJPUhBA+A6Lbw9sI/oFZ8ep/wfAW8EYBVFtqc
X-Google-Smtp-Source: ABdhPJynfFh91VQ5K1AOW66HZqn33pphVgk6vgP9su7x29MaAvfOxBvz8K8g+a78DhuegtsGMxDyW1agQMNth+UgTnoZvP7Ia91Q
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2ac8:: with SMTP id m8mr14192203iov.46.1602508815967;
 Mon, 12 Oct 2020 06:20:15 -0700 (PDT)
Date:   Mon, 12 Oct 2020 06:20:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9fad405b179289b@google.com>
Subject: WARNING in udf_truncate_extents
From:   syzbot <syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, chaitanya.kulkarni@wdc.com,
        jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    da690031 Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172e2ef0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
dashboard link: https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ce0a8b900000

The issue was bisected to:

commit 2004bfdef945fe55196db6b9cdf321fbc75bb0de
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Tue Mar 10 04:26:21 2020 +0000

    null_blk: Fix the null_add_dev() error path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10110920500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12110920500000
console output: https://syzkaller.appspot.com/x/log.txt?x=14110920500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com
Fixes: 2004bfdef945 ("null_blk: Fix the null_add_dev() error path")

UDF-fs: Scanning with blocksize 512 failed
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2020/09/19 18:44 (1000)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 17858 at fs/udf/truncate.c:226 udf_truncate_extents+0xf74/0x1120 fs/udf/truncate.c:226
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 17858 Comm: syz-executor.5 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 panic+0x2c0/0x800 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:udf_truncate_extents+0xf74/0x1120 fs/udf/truncate.c:226
Code: 24 14 18 00 00 00 43 80 3c 2f 00 0f 85 63 fe ff ff e9 6b fe ff ff e8 2b 9a cd fe bb fb ff ff ff e9 27 ff ff ff e8 1c 9a cd fe <0f> 0b e9 1b ff ff ff 89 d9 80 e1 07 38 c1 0f 8c 59 f1 ff ff 48 89
RSP: 0018:ffffc90005ea7a08 EFLAGS: 00010293
RAX: ffffffff82a763d4 RBX: 0000000000000000 RCX: ffff888077582040
RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000000
RBP: 0000000000000400 R08: ffffffff82a757a8 R09: ffffffff82a54d54
R10: 0000000000000002 R11: ffff888077582040 R12: 0000000005ea7aff
R13: 00000000000c2000 R14: 0000000000000308 R15: 1ffff1100e577c10
 udf_write_failed fs/udf/inode.c:176 [inline]
 udf_write_begin+0x1e2/0x210 fs/udf/inode.c:211
 generic_perform_write+0x23b/0x4e0 mm/filemap.c:3505
 __generic_file_write_iter+0x22b/0x4e0 mm/filemap.c:3634
 udf_file_write_iter+0x339/0x4e0 fs/udf/file.c:169
 do_iter_readv_writev+0x4f9/0x6c0 include/linux/fs.h:1876
 do_iter_write+0x164/0x610 fs/read_write.c:1026
 vfs_writev fs/read_write.c:1099 [inline]
 do_pwritev+0x234/0x430 fs/read_write.c:1196
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45de59
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4cc0709c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
RAX: ffffffffffffffda RBX: 0000000000026400 RCX: 000000000045de59
RDX: 0000000000000001 RSI: 00000000200014c0 RDI: 0000000000000003
RBP: 000000000118bf70 R08: 0000000000000020 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007fffd7780fdf R14: 00007f4cc070a9c0 R15: 000000000118bf2c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
