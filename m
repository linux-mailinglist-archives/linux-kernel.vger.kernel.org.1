Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1138F1F0AE5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jun 2020 13:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgFGLNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 07:13:22 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51262 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgFGLNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 07:13:15 -0400
Received: by mail-io1-f71.google.com with SMTP id c5so8933069iok.18
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 04:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OOjEQIons+lsRC+MLbUNzqJPBTFz/AkYOD/hoA28tU4=;
        b=TdiCSMTezx8DdrbM+6UvCMBdgm1IfRvs8NL+kEgZjxddW1pzCOC44k3HVQIN8roOkF
         s0SryI2qgQVQEFhlYheKszGWICioOp5QlGESDfh+fpdKsZkNrX1gcrKr7lnEYlqnU+IJ
         BhTU42EvUUnMbJzcY0o8IdF983UVx+DwLBnWmwycStE5JN6tT3Bd3rdmQ8m47hx+VgXM
         8KPkBjHJ24iefmkW9V6xiqDp0XFqaa6I+q6ZIdICzCcZhmuSVM1NuYBtdjH+JsSkodT9
         L5hGI/54gffrSthWtm2uUzJezkduADqmv4Qe9USTBsRDEfWEzMlI3WgkDvXqps/ccm27
         ZnPQ==
X-Gm-Message-State: AOAM531w/69TpHJzb7cS3wWUUxGDrmxf357+MWzHaeMoIvjdUZo2jAsO
        VX5cPY6iIFlJ3WH96jzjFFOePgcG9GliKI4bV8JRz6VX06Xc
X-Google-Smtp-Source: ABdhPJy89XG6T3QO2zwJZoJ4oRiaLdqG84c8lPvbDBFoXL6Uge/3cQeM6CW4V+6+yXNi4HQHQuws+R4y7saQ9mkPVURr0uvn4lqx
MIME-Version: 1.0
X-Received: by 2002:a05:6638:f11:: with SMTP id h17mr17352586jas.79.1591528392927;
 Sun, 07 Jun 2020 04:13:12 -0700 (PDT)
Date:   Sun, 07 Jun 2020 04:13:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082afe105a77c949d@google.com>
Subject: linux-next test error: BUG: using smp_processor_id() in preemptible
 [ADDR] code: kworker/u4:LINE/41
From:   syzbot <syzbot+9ce464e21fc2ab95dbf3@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16a4c051100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=365f706273eaf502
dashboard link: https://syzkaller.appspot.com/bug?extid=9ce464e21fc2ab95dbf3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9ce464e21fc2ab95dbf3@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:2/41
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 5.7.0-next-20200603-syzkaller #0
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
BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:2/41
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 5.7.0-next-20200603-syzkaller #0
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
BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:2/41
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 5.7.0-next-20200603-syzkaller #0
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
BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:2/41
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 1 PID: 41 Comm: kworker/u4:2 Not tainted 5.7.0-next-20200603-syzkaller #0
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
BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:2/41
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 1 PID: 41 Comm: kworker/u4:2 Not tainted 5.7.0-next-20200603-syzkaller #0
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
