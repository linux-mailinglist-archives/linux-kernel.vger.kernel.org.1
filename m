Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345861F0AE2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jun 2020 13:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFGLNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 07:13:18 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:46286 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgFGLNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 07:13:15 -0400
Received: by mail-il1-f200.google.com with SMTP id d16so5818648ilc.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 04:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YYswQKILazrP4JetGbUd/7c68gWgB2rDDnGxYj3VwNg=;
        b=l23/xClzilZ+zjNKXRT0JctvKyis3iCDCtRK/X92zWi/ifPL7HoBtShS6+OejpEpJX
         56MJm8a/137JY3RjAk0qg65X5AwltYmQbF8/+owqvgmCCe+hVhSgmosCzqyn9PcytNC1
         hBPWSwFqcC9dLMc25QAbEpIkAJTy4G/dwa1STsex7CWwzubKCwCzDtZn6/QB5JM4hk+p
         9V56/RA827l5k1cfl+PGq8bXmJ4hNRCQ82foamjXtkjsvcTD39DnLaPj4R4iOXdW4IMF
         JjhIdApiZcmmypkkMiw6X2km58+9msIB9Cw5O9EUS9ZIrEpBqda2/TJ1+k5WF1Orgchp
         cgOA==
X-Gm-Message-State: AOAM530Q9hx7gb3tFwV0jXWzGRPA4pxm3fxMzdZI7+olVKAczsp0pQUH
        +M0Xq9aAWUJ7zH0C62kAhQFnkCxg4oHj2Ox/2ydJxSJIvfiS
X-Google-Smtp-Source: ABdhPJySQ8ZAplF7MdltxSKJlLlkH3hlQAtoOHrebOYLk69a2youR7LbvDdePK2EYU/LId4vY4dtcDxDZ7/COo51gtB1irIdJBTJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e81:: with SMTP id m1mr6185835iow.147.1591528392687;
 Sun, 07 Jun 2020 04:13:12 -0700 (PDT)
Date:   Sun, 07 Jun 2020 04:13:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f04d405a77c9485@google.com>
Subject: linux-next test error: BUG: using smp_processor_id() in preemptible
 [ADDR] code: kworker/u4:LINE/4205
From:   syzbot <syzbot+5c2f1b4ae8c49a698784@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    48f99181 Add linux-next specific files for 20200603
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=148e22f2100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=365f706273eaf502
dashboard link: https://syzkaller.appspot.com/bug?extid=5c2f1b4ae8c49a698784
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5c2f1b4ae8c49a698784@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:5/4205
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 0 PID: 4205 Comm: kworker/u4:5 Not tainted 5.7.0-next-20200603-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
 ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 mpage_map_one_extent fs/ext4/inode.c:2377 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2430 [inline]
 ext4_writepages+0x1ab5/0x3400 fs/ext4/inode.c:2782
 do_writepages+0xfa/0x2a0 mm/page-writeback.c:2354
 __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1452
 writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1716
 __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1785
 wb_check_old_data_flush fs/fs-writeback.c:1996 [inline]
 wb_do_writeback fs/fs-writeback.c:2049 [inline]
 wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2078
 process_one_work+0x965/0x1690 kernel/workqueue.c:2269
 worker_thread+0x96/0xe10 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:5/4205
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 0 PID: 4205 Comm: kworker/u4:5 Not tainted 5.7.0-next-20200603-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
 ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1452
 writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1716
 __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1785
 wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1894
 wb_check_old_data_flush fs/fs-writeback.c:1996 [inline]
 wb_do_writeback fs/fs-writeback.c:2049 [inline]
 wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2078
 process_one_work+0x965/0x1690 kernel/workqueue.c:2269
 worker_thread+0x96/0xe10 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:5/4205
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 1 PID: 4205 Comm: kworker/u4:5 Not tainted 5.7.0-next-20200603-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
 ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 mpage_map_one_extent fs/ext4/inode.c:2377 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2430 [inline]
 ext4_writepages+0x1ab5/0x3400 fs/ext4/inode.c:2782
 do_writepages+0xfa/0x2a0 mm/page-writeback.c:2354
 __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1452
 writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1716
 __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1785
 wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1894
 wb_check_old_data_flush fs/fs-writeback.c:1996 [inline]
 wb_do_writeback fs/fs-writeback.c:2049 [inline]
 wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2078
 process_one_work+0x965/0x1690 kernel/workqueue.c:2269
 worker_thread+0x96/0xe10 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:5/4205
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 0 PID: 4205 Comm: kworker/u4:5 Not tainted 5.7.0-next-20200603-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
 ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 mpage_map_one_extent fs/ext4/inode.c:2377 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2430 [inline]
 ext4_writepages+0x1ab5/0x3400 fs/ext4/inode.c:2782
 do_writepages+0xfa/0x2a0 mm/page-writeback.c:2354
 __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1452
 writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1716
 __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1785
 wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1894
 wb_check_old_data_flush fs/fs-writeback.c:1996 [inline]
 wb_do_writeback fs/fs-writeback.c:2049 [inline]
 wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2078
 process_one_work+0x965/0x1690 kernel/workqueue.c:2269
 worker_thread+0x96/0xe10 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:5/4205
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 0 PID: 4205 Comm: kworker/u4:5 Not tainted 5.7.0-next-20200603-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
 ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 mpage_map_one_extent fs/ext4/inode.c:2377 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2430 [inline]
 ext4_writepages+0x1ab5/0x3400 fs/ext4/inode.c:2782
 do_writepages+0xfa/0x2a0 mm/page-writeback.c:2354
 __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1452
 writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1716
 __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1785
 wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1894
 wb_check_old_data_flush fs/fs-writeback.c:1996 [inline]
 wb_do_writeback fs/fs-writeback.c:2049 [inline]
 wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2078
 process_one_work+0x965/0x1690 kernel/workqueue.c:2269
 worker_thread+0x96/0xe10 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
tipc: TX() has been purged, node left!


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
