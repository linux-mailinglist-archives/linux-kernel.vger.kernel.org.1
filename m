Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082EA240463
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHJJ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 05:58:17 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35350 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgHJJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:58:15 -0400
Received: by mail-io1-f72.google.com with SMTP id s5so6627305iow.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 02:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EZdx3h6CcuB/A3YH4E2rNOxNnzoeylwQGXBumWPwur8=;
        b=XhuNkDFKkXwY5SVxlX6M6tMQ+Rn3aTK+6gDteEQWscOyZgZeG2i5P46TWiTDshzRM+
         O4VmfG5ndBKf6GWawkls9da4EOuxPyKqiinUF5NRZ5AlPALxsvQNGjXxHQU/PA4+aaqe
         qD7HK29iCvCCftwSGxJQ8zM58SQ+Y6JWVww3mx+B2HyMcPqR3mH7nLq9oXTd2zOW2g64
         6pl0g5GUIXWUU64smyc+bED7BSqiTs2I3BYlTAURskkU9ChFBW7KoIcXwQ9WtBT0xJTz
         Xux2peBRwjzL12NTFt0FtPcVh8PM2xociykyghkus1SpOHxrWTn6GN1FmG2gX3p3oMHP
         Oz4g==
X-Gm-Message-State: AOAM533czLEyFM5bHkxksBT5kN/WwiSyoayDpHKGoHbWFT5nylWqn3rD
        Mo8V75rBRzZNBaef/LoUiklpkhApZlAwF1oR+jg2oJ4EexzZ
X-Google-Smtp-Source: ABdhPJzvhXm66kwpK/KNsTcMSQVLGwfYR+Z73cIGZewuTCT2Nd2dRaEHuVytEfcM6cVxylhzXqC2glmT7ms79rqVFYp0uzVFUCAW
MIME-Version: 1.0
X-Received: by 2002:a92:d292:: with SMTP id p18mr16124770ilp.281.1597053494375;
 Mon, 10 Aug 2020 02:58:14 -0700 (PDT)
Date:   Mon, 10 Aug 2020 02:58:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038399005ac82fef7@google.com>
Subject: KCSAN: data-race in __io_cqring_fill_event / io_uring_poll
From:   syzbot <syzbot+3020eb77f81ef0772fbe@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    86cfccb6 Merge tag 'dlm-5.9' of git://git.kernel.org/pub/s..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171cf11a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3757fa75ecfde8e0
dashboard link: https://syzkaller.appspot.com/bug?extid=3020eb77f81ef0772fbe
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3020eb77f81ef0772fbe@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __io_cqring_fill_event / io_uring_poll

write to 0xffff8880a04325c0 of 4 bytes by task 12088 on cpu 1:
 io_get_cqring fs/io_uring.c:1282 [inline]
 __io_cqring_fill_event+0x116/0x430 fs/io_uring.c:1386
 io_cqring_add_event fs/io_uring.c:1420 [inline]
 __io_req_complete+0xdb/0x1b0 fs/io_uring.c:1458
 io_complete_rw_common fs/io_uring.c:2208 [inline]
 __io_complete_rw+0x2c9/0x2e0 fs/io_uring.c:2289
 kiocb_done fs/io_uring.c:2533 [inline]
 io_write fs/io_uring.c:3199 [inline]
 io_issue_sqe+0x4fb1/0x7140 fs/io_uring.c:5530
 io_wq_submit_work+0x23e/0x340 fs/io_uring.c:5775
 io_worker_handle_work+0xa69/0xcf0 fs/io-wq.c:527
 io_wqe_worker+0x1f2/0x860 fs/io-wq.c:569
 kthread+0x20d/0x230 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

read to 0xffff8880a04325c0 of 4 bytes by task 12086 on cpu 0:
 io_cqring_events fs/io_uring.c:1937 [inline]
 io_uring_poll+0x105/0x140 fs/io_uring.c:7751
 vfs_poll include/linux/poll.h:90 [inline]
 __io_arm_poll_handler+0x176/0x3f0 fs/io_uring.c:4735
 io_arm_poll_handler+0x293/0x5c0 fs/io_uring.c:4792
 __io_queue_sqe+0x413/0x760 fs/io_uring.c:5988
 io_queue_sqe+0x81/0x2b0 fs/io_uring.c:6060
 io_submit_sqe+0x333/0x560 fs/io_uring.c:6130
 io_submit_sqes+0x8c6/0xfc0 fs/io_uring.c:6327
 __do_sys_io_uring_enter fs/io_uring.c:8036 [inline]
 __se_sys_io_uring_enter+0x1c2/0x720 fs/io_uring.c:7995
 __x64_sys_io_uring_enter+0x74/0x80 fs/io_uring.c:7995
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 12086 Comm: syz-executor.5 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
