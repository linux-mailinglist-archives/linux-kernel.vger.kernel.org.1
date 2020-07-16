Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CD3221F38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 11:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgGPJAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 05:00:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7865 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgGPJAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:00:10 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EEC9AB6515A83DD13784;
        Thu, 16 Jul 2020 17:00:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 17:00:07 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] crypto: caam: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:04:03 +0800
Message-ID: <20200716090403.13507-1-miaoqinglang@huawei.com>
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
 drivers/crypto/caam/dpseci-debugfs.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/crypto/caam/dpseci-debugfs.c b/drivers/crypto/caam/dpseci-debugfs.c
index aa10841b6..0eca8c2fd 100644
--- a/drivers/crypto/caam/dpseci-debugfs.c
+++ b/drivers/crypto/caam/dpseci-debugfs.c
@@ -44,33 +44,14 @@ static int dpseci_dbg_fqs_show(struct seq_file *file, void *offset)
 	return 0;
 }
 
-static int dpseci_dbg_fqs_open(struct inode *inode, struct file *file)
-{
-	int err;
-	struct dpaa2_caam_priv *priv;
-
-	priv = (struct dpaa2_caam_priv *)inode->i_private;
-
-	err = single_open(file, dpseci_dbg_fqs_show, priv);
-	if (err < 0)
-		dev_err(priv->dev, "single_open() failed\n");
-
-	return err;
-}
-
-static const struct file_operations dpseci_dbg_fq_ops = {
-	.open = dpseci_dbg_fqs_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dpseci_dbg_fqs);
 
 void dpaa2_dpseci_debugfs_init(struct dpaa2_caam_priv *priv)
 {
 	priv->dfs_root = debugfs_create_dir(dev_name(priv->dev), NULL);
 
 	debugfs_create_file("fq_stats", 0444, priv->dfs_root, priv,
-			    &dpseci_dbg_fq_ops);
+			    &dpseci_dbg_fqs_fops);
 }
 
 void dpaa2_dpseci_debugfs_exit(struct dpaa2_caam_priv *priv)
-- 
2.17.1

