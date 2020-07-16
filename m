Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0A3221F43
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGPJCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 05:02:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7765 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgGPJCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:02:13 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CB66EB804518257F882E;
        Thu, 16 Jul 2020 17:02:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 17:02:06 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] pktcdvd: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:06:01 +0800
Message-ID: <20200716090601.13945-1-miaoqinglang@huawei.com>
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
 drivers/block/pktcdvd.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index c81f63714..6a79770db 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -452,23 +452,12 @@ static void pkt_sysfs_cleanup(void)
 
  *******************************************************************/
 
-static int pkt_debugfs_seq_show(struct seq_file *m, void *p)
+static int pkt_debugfs_show(struct seq_file *m, void *p)
 {
 	return pkt_seq_show(m, p);
 }
 
-static int pkt_debugfs_fops_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pkt_debugfs_seq_show, inode->i_private);
-}
-
-static const struct file_operations debug_fops = {
-	.open		= pkt_debugfs_fops_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.owner		= THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(pkt_debugfs);
 
 static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 {
@@ -479,7 +468,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444,
-					     pd->dfs_d_root, pd, &debug_fops);
+					     pd->dfs_d_root, pd, &pkt_debugfs_fops);
 }
 
 static void pkt_debugfs_dev_remove(struct pktcdvd_device *pd)
-- 
2.17.1

