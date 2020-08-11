Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB01D241BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 15:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgHKNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 09:43:47 -0400
Received: from m15114.mail.126.com ([220.181.15.114]:38809 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgHKNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=6n9ucVjwm5xquc5GPM
        dzBC85j1s4vXBylBHGsRZs4Ms=; b=Jgg5an1wvpkpZs1ZrZkhMeUIB8/6tYVEJw
        jpzf3+Kq+omnrzTjIDicoaMlTNT+YsN6s763Z67WnHDeb++HPzpzDEzloFSVbfeC
        jZCfHKIbqfoFkhNa5hcmMC57X6PlfRD3BtuIRfl7BMtlYYT17b8CoHO56d2qoyke
        xDJ66a1L8=
Received: from 192.168.137.133 (unknown [112.10.84.202])
        by smtp7 (Coremail) with SMTP id DsmowAA3CBBqoDJfSwACIQ--.8153S3;
        Tue, 11 Aug 2020 21:43:09 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: don't read block device if it's invalid
Date:   Tue, 11 Aug 2020 09:43:06 -0400
Message-Id: <1597153386-87954-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowAA3CBBqoDJfSwACIQ--.8153S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw1xXF18Gw4fCFWrAw48Xrb_yoW7Xw4rpr
        y5XryUGr18Cr47Jr47tF13JrW8t3yDtay7JrWxKry3Ar1UGrW5tFyxAFyUAF1qgr18trZr
        JF4qqr40gryUWFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrR6wUUUUU=
X-Originating-IP: [112.10.84.202]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi3A19pFpD-XbzCAAAsh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found several processes in 'D' state after nvme device hot-removed,
The call trace as below, we can see process 848 got lock 'bdev->bd_mutex'
in blkdev_reread_part(), but scheduled out due to wait for IO done. But
the IO won't be completed as the device is hot-removed. Then it caused
the lock 'bdev->bd_mutex' can't be unlocked. As a result, it caused
other processes, which need to get the same lock 'bdev->bd_mutex',
blocked on this lock.

When nvme device hot-removed, kernel will start a thread to handle the
task of nvme device removing, as the call trace of process 1111504 shows
below. I listed the call trace of nvme_kill_queues() in detail as below,
we can see 'NVME_NS_DEAD' is set, then when executing
nvme_revalidate_disk(), it found 'NVME_NS_DEAD' is set and
'set_capacity(disk, 0)' will be called to set disk capacity to 0.
    nvme_kill_queues()
        if (test_and_set_bit(NVME_NS_DEAD, &ns->flags)) return;
            revalidate_disk(disk)
                disk->fops->revalidate_disk(disk) <=for nvme device, revalidate_disk=nvme_revalidate_disk()
                     mutex_lock(&bdev->bd_mutex)

This patch is to reduce the probability of such problem. Before getting
the lock of 'bdev->bd_mutex' in blkdev_reread_part(), add the code to
check if the capacity of the disk is 0, just return. Then we can avoid
the happen of the issue:
nvme device is hot-removed, and its capacity is alreday set to 0; then
if there is process like 848 want to read the device, it will return
directly in blkdev_reread_part(), then it will not get the lock
"bdev->bd_mutex", which can't be unlocked by the process itself as IO
can't be completed.

cat /proc/848/stack
[<ffffffffb14b9d56>] io_schedule+0x16/0x40
[<ffffffffb15b009e>] do_read_cache_page+0x3ee/0x5e0
[<ffffffffb15b02a5>] read_cache_page+0x15/0x20
[<ffffffffb17810ad>] read_dev_sector+0x2d/0xa0
[<ffffffffb17856e4>] read_lba+0x104/0x1c0
[<ffffffffb1785d1a>] find_valid_gpt+0xfa/0x720
[<ffffffffb17863c9>] efi_partition+0x89/0x430
[<ffffffffb1783280>] check_partition+0x100/0x1f0
[<ffffffffb17819e4>] rescan_partitions+0xb4/0x360
[<ffffffffb177d544>] __blkdev_reread_part+0x64/0x70
[<ffffffffb177d573>] blkdev_reread_part+0x23/0x40  <<==mutex_lock(&bdev->bd_mutex);
[<ffffffffb177e00b>] blkdev_ioctl+0x44b/0x8e0
[<ffffffffb1692dc1>] block_ioctl+0x41/0x50
[<ffffffffb1668d37>] do_vfs_ioctl+0xa7/0x5e0
[<ffffffffb16692e9>] SyS_ioctl+0x79/0x90
[<ffffffffb1bd6001>] entry_SYSCALL_64_fastpath+0x1f/0xb9
[<ffffffffffffffff>] 0xffffffffffffffff

cat /proc/1111504/stack
[<ffffffffb1692fb9>] revalidate_disk+0x49/0x80  <<==mutex_lock(&bdev->bd_mutex);
[<ffffffffc0112ff2>] nvme_kill_queues+0x52/0x80 [nvme_core]
[<ffffffffc0116304>] nvme_remove_namespaces+0x44/0x50 [nvme_core]
[<ffffffffc0050805>] nvme_remove+0x85/0x130 [nvme]
[<ffffffffb17e9a69>] pci_device_remove+0x39/0xc0
[<ffffffffb18f9f91>] device_release_driver_internal+0x141/0x210
[<ffffffffb18fa072>] device_release_driver+0x12/0x20
[<ffffffffb17e1b3c>] pci_stop_bus_device+0x8c/0xa0
[<ffffffffb17e1cd2>] pci_stop_and_remove_bus_device+0x12/0x20
[<ffffffffb17fdeaa>] pciehp_unconfigure_device+0x7a/0x1e0
[<ffffffffb17fd9b2>] pciehp_disable_slot+0x52/0xd0
[<ffffffffb17fdaba>] pciehp_power_thread+0x8a/0xb0
[<ffffffffb14a556e>] process_one_work+0x14e/0x370
[<ffffffffb14a601d>] worker_thread+0x4d/0x3f0
[<ffffffffb14abd09>] kthread+0x109/0x140
[<ffffffffb1bd627a>] ret_from_fork+0x2a/0x40
[<ffffffffffffffff>] 0xffffffffffffffff

cat /proc/1197767/stack
[<ffffffffb169444e>] __blkdev_get+0x6e/0x450  <<==mutex_lock_nested(&bdev->bd_mutex, for_part);
[<ffffffffb16949d4>] blkdev_get+0x1a4/0x300
[<ffffffffb1694f1a>] blkdev_open+0x7a/0xa0
[<ffffffffb164f93f>] do_dentry_open+0x20f/0x330
[<ffffffffb1650e10>] vfs_open+0x50/0x70
[<ffffffffb16621f8>] path_openat+0x548/0x13b0
[<ffffffffb1664d71>] do_filp_open+0x91/0x100
[<ffffffffb16511e4>] do_sys_open+0x124/0x210
[<ffffffffb16512ee>] SyS_open+0x1e/0x20
[<ffffffffb140396c>] do_syscall_64+0x6c/0x1b0
[<ffffffffb1bd60c0>] entry_SYSCALL64_slow_path+0x25/0x25
[<ffffffffffffffff>] 0xffffffffffffffff

ps -eo pid,comm,state | grep '  D'
    848 systemd-udevd   D
1111504 kworker/10:1    D
1197767 isdct           D
1198830 isdct           D
1580322 xxd             D
1616804 kworker/10:0    D
1626264 isdct           D
1734726 kworker/10:2    D
2197993 isdct           D
2662117 xxd             D
3083718 xxd             D
3189834 xxd             D

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 block/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index bdb3bbb..159bceb 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -94,6 +94,9 @@ static int blkdev_reread_part(struct block_device *bdev)
 {
 	int ret;
 
+	if (unlikely(!get_capacity(bdev->bd_disk)))
+		return -EIO;
+
 	if (!disk_part_scan_enabled(bdev->bd_disk) || bdev != bdev->bd_contains)
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
-- 
1.8.3.1

