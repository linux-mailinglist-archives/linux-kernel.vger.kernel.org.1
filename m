Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB44270A35
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgISCvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:51:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43006 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgISCvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:51:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AEF99E751C36A18264AC;
        Sat, 19 Sep 2020 10:51:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:51:29 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] pktcdvd: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 19 Sep 2020 10:52:01 +0800
Message-ID: <20200919025201.17465-1-miaoqinglang@huawei.com>
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

 drivers/block/pktcdvd.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 17f2e6ff1..a40c397c7 100644
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
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.owner		= THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(pkt_debugfs);
 
 static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 {
@@ -478,8 +467,8 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pd->dfs_d_root)
 		return;
 
-	pd->dfs_f_info = debugfs_create_file("info", 0444,
-					     pd->dfs_d_root, pd, &debug_fops);
+	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
+					     pd, &pkt_debugfs_fops);
 }
 
 static void pkt_debugfs_dev_remove(struct pktcdvd_device *pd)
-- 
2.23.0

