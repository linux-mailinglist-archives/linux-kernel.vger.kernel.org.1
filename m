Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0972B6A46
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgKQQb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgKQQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:31:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC2C0613CF;
        Tue, 17 Nov 2020 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rF0S5oZ64sMTW6BRYasM34ii4IScQtTva2pW7lJfCuY=; b=UDP2U5E5Ky18BAjorFy1v8jyXj
        Bhl1EK0AXtln7Tx8Daggx1S9vYUJ/LeXxU9GyhufECkx90wuqi7QAegLw2SIh+8GlM9GWMoequqTh
        bjwRMCK0vcpg2Vt5eaVHsf9tmLeDPs+/gnWAV9cUliAvcc8VN8H9CWQU+Gt919Te+C4WQ8fYgrfe9
        4zob4A2O60/1RlRipo9ZYfO9IixiOIqfoafeBVOiNKAh0l9oChMbEy2HGmvVEBAoKfqUN7dl4vokw
        WrsLq9xrSecnBx2KE/QB+KB3Y39sCHPvdqgxqIwZb6ZUdO1r7fMKdC+BmkJxCkn1fuPEqhDA4bQTa
        09O94d0w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf3t4-0001qZ-DW; Tue, 17 Nov 2020 16:31:22 +0000
Date:   Tue, 17 Nov 2020 16:31:22 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     syzbot <syzbot+fd01c5d29a476390728d@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in brd_probe
Message-ID: <20201117163122.GA4563@infradead.org>
References: <00000000000053abd705b44afb9b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000053abd705b44afb9b@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is a false positive due to the cycling through different
bd_mutex instances.  I think my next big series aimed at 5.11 will
fix this as a side effect, so I plan to ignore this for now, but will
test the reproducer with the follow on work applied eventually.

On Tue, Nov 17, 2020 at 02:30:20AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    03430750 Add linux-next specific files for 20201116
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1642f486500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a1c4c3f27041fdb8
> dashboard link: https://syzkaller.appspot.com/bug?extid=fd01c5d29a476390728d
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14646461500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17dc946a500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fd01c5d29a476390728d@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.10.0-rc3-next-20201116-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor541/8491 is trying to acquire lock:
> ffffffff8bd213a8 (brd_devices_mutex){+.+.}-{3:3}, at: brd_probe+0x31/0x250 drivers/block/brd.c:434
> 
> but task is already holding lock:
> ffffffff8bac3508 (major_names_lock){+.+.}-{3:3}, at: request_gendisk_module block/genhd.c:976 [inline]
> ffffffff8bac3508 (major_names_lock){+.+.}-{3:3}, at: get_gendisk+0x3c8/0x6a0 block/genhd.c:1029
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (major_names_lock){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>        __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
>        __register_blkdev+0x2b/0x390 block/genhd.c:449
>        register_mtd_blktrans+0x85/0x3c0 drivers/mtd/mtd_blkdevs.c:534
>        do_one_initcall+0x103/0x650 init/main.c:1222
>        do_initcall_level init/main.c:1295 [inline]
>        do_initcalls init/main.c:1311 [inline]
>        do_basic_setup init/main.c:1331 [inline]
>        kernel_init_freeable+0x600/0x684 init/main.c:1531
>        kernel_init+0xd/0x1b8 init/main.c:1420
>        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> -> #2 (mtd_table_mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>        __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
>        blktrans_open+0x69/0x600 drivers/mtd/mtd_blkdevs.c:212
>        __blkdev_get+0x80f/0x1870 fs/block_dev.c:1494
>        blkdev_get+0xd1/0x240 fs/block_dev.c:1634
>        blkdev_open+0x21d/0x2b0 fs/block_dev.c:1751
>        do_dentry_open+0x4b9/0x11b0 fs/open.c:817
>        do_open fs/namei.c:3252 [inline]
>        path_openat+0x1b9a/0x2730 fs/namei.c:3369
>        do_filp_open+0x17e/0x3c0 fs/namei.c:3396
>        do_sys_openat2+0x16d/0x420 fs/open.c:1168
>        do_sys_open fs/open.c:1184 [inline]
>        __do_sys_open fs/open.c:1192 [inline]
>        __se_sys_open fs/open.c:1188 [inline]
>        __x64_sys_open+0x119/0x1c0 fs/open.c:1188
>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #1 (&bdev->bd_mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>        __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
>        __blkdev_get+0x457/0x1870 fs/block_dev.c:1479
>        blkdev_get+0xd1/0x240 fs/block_dev.c:1634
>        blkdev_get_by_dev+0x3b/0x70 fs/block_dev.c:1715
>        disk_scan_partitions block/genhd.c:677 [inline]
>        register_disk block/genhd.c:727 [inline]
>        __device_add_disk+0xe02/0x1250 block/genhd.c:814
>        add_disk include/linux/genhd.h:295 [inline]
>        brd_init+0x2af/0x475 drivers/block/brd.c:518
>        do_one_initcall+0x103/0x650 init/main.c:1222
>        do_initcall_level init/main.c:1295 [inline]
>        do_initcalls init/main.c:1311 [inline]
>        do_basic_setup init/main.c:1331 [inline]
>        kernel_init_freeable+0x600/0x684 init/main.c:1531
>        kernel_init+0xd/0x1b8 init/main.c:1420
>        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> -> #0 (brd_devices_mutex){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:2866 [inline]
>        check_prevs_add kernel/locking/lockdep.c:2991 [inline]
>        validate_chain kernel/locking/lockdep.c:3606 [inline]
>        __lock_acquire+0x2ca6/0x5c00 kernel/locking/lockdep.c:4830
>        lock_acquire kernel/locking/lockdep.c:5435 [inline]
>        lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5400
>        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>        __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
>        brd_probe+0x31/0x250 drivers/block/brd.c:434
>        request_gendisk_module block/genhd.c:979 [inline]
>        get_gendisk+0x4c3/0x6a0 block/genhd.c:1029
>        bdev_get_gendisk fs/block_dev.c:1094 [inline]
>        __blkdev_get+0x344/0x1870 fs/block_dev.c:1455
>        blkdev_get+0xd1/0x240 fs/block_dev.c:1634
>        blkdev_open+0x21d/0x2b0 fs/block_dev.c:1751
>        do_dentry_open+0x4b9/0x11b0 fs/open.c:817
>        do_open fs/namei.c:3252 [inline]
>        path_openat+0x1b9a/0x2730 fs/namei.c:3369
>        do_filp_open+0x17e/0x3c0 fs/namei.c:3396
>        do_sys_openat2+0x16d/0x420 fs/open.c:1168
>        do_sys_open fs/open.c:1184 [inline]
>        __do_sys_openat fs/open.c:1200 [inline]
>        __se_sys_openat fs/open.c:1195 [inline]
>        __x64_sys_openat+0x13f/0x1f0 fs/open.c:1195
>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   brd_devices_mutex --> mtd_table_mutex --> major_names_lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(major_names_lock);
>                                lock(mtd_table_mutex);
>                                lock(major_names_lock);
>   lock(brd_devices_mutex);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by syz-executor541/8491:
>  #0: ffffffff8bac3508 (major_names_lock){+.+.}-{3:3}, at: request_gendisk_module block/genhd.c:976 [inline]
>  #0: ffffffff8bac3508 (major_names_lock){+.+.}-{3:3}, at: get_gendisk+0x3c8/0x6a0 block/genhd.c:1029
> 
> stack backtrace:
> CPU: 0 PID: 8491 Comm: syz-executor541 Not tainted 5.10.0-rc3-next-20201116-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:120
>  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2115
>  check_prev_add kernel/locking/lockdep.c:2866 [inline]
>  check_prevs_add kernel/locking/lockdep.c:2991 [inline]
>  validate_chain kernel/locking/lockdep.c:3606 [inline]
>  __lock_acquire+0x2ca6/0x5c00 kernel/locking/lockdep.c:4830
>  lock_acquire kernel/locking/lockdep.c:5435 [inline]
>  lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5400
>  __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>  __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
>  brd_probe+0x31/0x250 drivers/block/brd.c:434
>  request_gendisk_module block/genhd.c:979 [inline]
>  get_gendisk+0x4c3/0x6a0 block/genhd.c:1029
>  bdev_get_gendisk fs/block_dev.c:1094 [inline]
>  __blkdev_get+0x344/0x1870 fs/block_dev.c:1455
>  blkdev_get+0xd1/0x240 fs/block_dev.c:1634
>  blkdev_open+0x21d/0x2b0 fs/block_dev.c:1751
>  do_dentry_open+0x4b9/0x11b0 fs/open.c:817
>  do_open fs/namei.c:3252 [inline]
>  path_openat+0x1b9a/0x2730 fs/namei.c:3369
>  do_filp_open+0x17e/0x3c0 fs/namei.c:3396
>  do_sys_openat2+0x16d/0x420 fs/open.c:1168
>  do_sys_open fs/open.c:1184 [inline]
>  __do_sys_openat fs/open.c:1200 [inline]
>  __se_sys_openat fs/open.c:1195 [inline]
>  __x64_sys_openat+0x13f/0x1f0 fs/open.c:1195
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x445ec9
> Code: e8 fc b8 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f6bca748d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00000000006ddc38 RCX: 0000000000445ec9
> RDX: 0000000000000000 RSI: 0000000020002040 RDI: 00000000ffffff9c
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
---end quoted text---
