Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96140221F28
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 10:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGPI6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 04:58:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7761 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbgGPI6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:58:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 077AA2FC830B9AA4065F;
        Thu, 16 Jul 2020 16:58:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:58:26 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mtd: mtdcore: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:02:20 +0800
Message-ID: <20200716090220.12983-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Liu <liuyongqiang13@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
 drivers/mtd/mtdcore.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index e10ff132b..a88fe9fc0 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -335,7 +335,7 @@ static const struct device_type mtd_devtype = {
 	.release	= mtd_release,
 };
 
-static int mtd_partid_show(struct seq_file *s, void *p)
+static int mtd_partid_debug_show(struct seq_file *s, void *p)
 {
 	struct mtd_info *mtd = s->private;
 
@@ -344,19 +344,9 @@ static int mtd_partid_show(struct seq_file *s, void *p)
 	return 0;
 }
 
-static int mtd_partid_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mtd_partid_show, inode->i_private);
-}
-
-static const struct file_operations mtd_partid_debug_fops = {
-	.open           = mtd_partid_debugfs_open,
-	.read_iter           = seq_read_iter,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mtd_partid_debug);
 
-static int mtd_partname_show(struct seq_file *s, void *p)
+static int mtd_partname_debug_show(struct seq_file *s, void *p)
 {
 	struct mtd_info *mtd = s->private;
 
@@ -365,17 +355,7 @@ static int mtd_partname_show(struct seq_file *s, void *p)
 	return 0;
 }
 
-static int mtd_partname_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mtd_partname_show, inode->i_private);
-}
-
-static const struct file_operations mtd_partname_debug_fops = {
-	.open           = mtd_partname_debugfs_open,
-	.read_iter           = seq_read_iter,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mtd_partname_debug);
 
 static struct dentry *dfs_dir_mtd;
 
-- 
2.17.1

