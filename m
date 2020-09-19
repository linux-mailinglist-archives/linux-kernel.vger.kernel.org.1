Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1C270A39
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgISCvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:51:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbgISCvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:51:45 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5287579FF7BED6A4D298;
        Sat, 19 Sep 2020 10:51:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:51:35 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] soc: ti: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 19 Sep 2020 10:52:07 +0800
Message-ID: <20200919025207.17798-1-miaoqinglang@huawei.com>
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

 drivers/soc/ti/knav_dma.c        | 16 +++-------------
 drivers/soc/ti/knav_qmss_queue.c | 14 ++------------
 2 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 6285cd8ef..8c863ecb1 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -355,7 +355,7 @@ static void dma_debug_show_devices(struct seq_file *s,
 	}
 }
 
-static int dma_debug_show(struct seq_file *s, void *v)
+static int knav_dma_debug_show(struct seq_file *s, void *v)
 {
 	struct knav_dma_device *dma;
 
@@ -370,17 +370,7 @@ static int dma_debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int knav_dma_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dma_debug_show, NULL);
-}
-
-static const struct file_operations knav_dma_debug_ops = {
-	.open		= knav_dma_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(knav_dma_debug);
 
 static int of_channel_match_helper(struct device_node *np, const char *name,
 					const char **dma_instance)
@@ -778,7 +768,7 @@ static int knav_dma_probe(struct platform_device *pdev)
 	}
 
 	debugfs_create_file("knav_dma", S_IFREG | S_IRUGO, NULL, NULL,
-			    &knav_dma_debug_ops);
+			    &knav_dma_debug_fops);
 
 	device_ready = true;
 	return ret;
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index aa071d96e..a460f201b 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -478,17 +478,7 @@ static int knav_queue_debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int knav_queue_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, knav_queue_debug_show, NULL);
-}
-
-static const struct file_operations knav_queue_debug_ops = {
-	.open		= knav_queue_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(knav_queue_debug);
 
 static inline int knav_queue_pdsp_wait(u32 * __iomem addr, unsigned timeout,
 					u32 flags)
@@ -1878,7 +1868,7 @@ static int knav_queue_probe(struct platform_device *pdev)
 	}
 
 	debugfs_create_file("qmss", S_IFREG | S_IRUGO, NULL, NULL,
-			    &knav_queue_debug_ops);
+			    &knav_queue_debug_fops);
 	device_ready = true;
 	return 0;
 
-- 
2.23.0

