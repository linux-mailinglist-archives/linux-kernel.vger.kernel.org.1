Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C90F221F40
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgGPJAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 05:00:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgGPJAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:00:52 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 58EE47094AE4D8256181;
        Thu, 16 Jul 2020 17:00:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 17:00:43 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] rsxx: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:04:32 +0800
Message-ID: <20200716090432.13691-1-miaoqinglang@huawei.com>
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

From: Liu Shixin <liushixin2@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/block/rsxx/core.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index e631749e1..9c35fa35b 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -150,16 +150,6 @@ static int rsxx_attr_stats_show(struct seq_file *m, void *p)
 	return 0;
 }
 
-static int rsxx_attr_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rsxx_attr_stats_show, inode->i_private);
-}
-
-static int rsxx_attr_pci_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rsxx_attr_pci_regs_show, inode->i_private);
-}
-
 static ssize_t rsxx_cram_read(struct file *fp, char __user *ubuf,
 			      size_t cnt, loff_t *ppos)
 {
@@ -206,21 +196,8 @@ static const struct file_operations debugfs_cram_fops = {
 	.write		= rsxx_cram_write,
 };
 
-static const struct file_operations debugfs_stats_fops = {
-	.owner		= THIS_MODULE,
-	.open		= rsxx_attr_stats_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations debugfs_pci_regs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= rsxx_attr_pci_regs_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(rsxx_attr_stats);
+DEFINE_SHOW_ATTRIBUTE(rsxx_attr_pci_regs);
 
 static void rsxx_debugfs_dev_new(struct rsxx_cardinfo *card)
 {
@@ -234,13 +211,13 @@ static void rsxx_debugfs_dev_new(struct rsxx_cardinfo *card)
 
 	debugfs_stats = debugfs_create_file("stats", 0444,
 					    card->debugfs_dir, card,
-					    &debugfs_stats_fops);
+					    &rsxx_attr_stats_fops);
 	if (IS_ERR_OR_NULL(debugfs_stats))
 		goto failed_debugfs_stats;
 
 	debugfs_pci_regs = debugfs_create_file("pci_regs", 0444,
 					       card->debugfs_dir, card,
-					       &debugfs_pci_regs_fops);
+					       &rsxx_attr_pci_regs_fops);
 	if (IS_ERR_OR_NULL(debugfs_pci_regs))
 		goto failed_debugfs_pci_regs;
 
-- 
2.17.1

