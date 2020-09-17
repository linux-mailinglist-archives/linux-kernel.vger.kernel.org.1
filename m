Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C976C26DC19
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgIQMyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:54:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60012 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbgIQMu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:50:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 378DBCDBDF05DB0CBCB5;
        Thu, 17 Sep 2020 20:50:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 20:50:36 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] memory: emif: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 17 Sep 2020 20:51:13 +0800
Message-ID: <20200917125113.103550-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Along with this change, we get additionally:
        .owner          = THIS_MODULE,
        .llseek         = seq_lseek,

1. The llseek method is used to change the current read/write position
in a file which can be ignored if you don't use it.
2. The owner is not even a method. Instead, it is a pointer to the
module that “owns” this structure; it is used by the kernel to maintain
the module's usage count which can be ignored.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: based on linux-next(20200917), and can be applied to
    mainline cleanly now.

 drivers/memory/emif.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 5c4d8319c..ddb1879f0 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -131,16 +131,7 @@ static int emif_regdump_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int emif_regdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, emif_regdump_show, inode->i_private);
-}
-
-static const struct file_operations emif_regdump_fops = {
-	.open			= emif_regdump_open,
-	.read			= seq_read,
-	.release		= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(emif_regdump);
 
 static int emif_mr4_show(struct seq_file *s, void *unused)
 {
@@ -150,16 +141,7 @@ static int emif_mr4_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int emif_mr4_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, emif_mr4_show, inode->i_private);
-}
-
-static const struct file_operations emif_mr4_fops = {
-	.open			= emif_mr4_open,
-	.read			= seq_read,
-	.release		= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(emif_mr4);
 
 static int __init_or_module emif_debugfs_init(struct emif_data *emif)
 {
-- 
2.23.0

