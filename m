Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC09270A32
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgISCvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:51:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbgISCvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:51:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7A5A1C4FFCAAF84C8CDA;
        Sat, 19 Sep 2020 10:51:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:51:28 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] nbd: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 19 Sep 2020 10:52:00 +0800
Message-ID: <20200919025200.17399-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: based on linux-next(20200917), and can be applied to
    mainline cleanly now.

 drivers/block/nbd.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 15eed210f..ab1242a34 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1543,17 +1543,7 @@ static int nbd_dbg_tasks_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int nbd_dbg_tasks_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nbd_dbg_tasks_show, inode->i_private);
-}
-
-static const struct file_operations nbd_dbg_tasks_ops = {
-	.open = nbd_dbg_tasks_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nbd_dbg_tasks);
 
 static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 {
@@ -1578,17 +1568,7 @@ static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int nbd_dbg_flags_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nbd_dbg_flags_show, inode->i_private);
-}
-
-static const struct file_operations nbd_dbg_flags_ops = {
-	.open = nbd_dbg_flags_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nbd_dbg_flags);
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd)
 {
@@ -1606,11 +1586,11 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 	}
 	config->dbg_dir = dir;
 
-	debugfs_create_file("tasks", 0444, dir, nbd, &nbd_dbg_tasks_ops);
+	debugfs_create_file("tasks", 0444, dir, nbd, &nbd_dbg_tasks_fops);
 	debugfs_create_u64("size_bytes", 0444, dir, &config->bytesize);
 	debugfs_create_u32("timeout", 0444, dir, &nbd->tag_set.timeout);
 	debugfs_create_u64("blocksize", 0444, dir, &config->blksize);
-	debugfs_create_file("flags", 0444, dir, nbd, &nbd_dbg_flags_ops);
+	debugfs_create_file("flags", 0444, dir, nbd, &nbd_dbg_flags_fops);
 
 	return 0;
 }
-- 
2.23.0

