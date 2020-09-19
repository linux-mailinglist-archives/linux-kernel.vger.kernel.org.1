Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE77270A2E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgISCvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:51:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISCvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:51:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6CD1AF5C343726E64B09;
        Sat, 19 Sep 2020 10:51:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:51:07 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] block: aoe: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 19 Sep 2020 10:51:39 +0800
Message-ID: <20200919025139.16921-1-miaoqinglang@huawei.com>
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

 drivers/block/aoe/aoeblk.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 5ca7216e9..3502a8325 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -110,7 +110,7 @@ static ssize_t aoedisk_show_payload(struct device *dev,
 	return snprintf(page, PAGE_SIZE, "%lu\n", d->maxbcnt);
 }
 
-static int aoedisk_debugfs_show(struct seq_file *s, void *ignored)
+static int aoe_debugfs_show(struct seq_file *s, void *ignored)
 {
 	struct aoedev *d;
 	struct aoetgt **t, **te;
@@ -154,10 +154,7 @@ static int aoedisk_debugfs_show(struct seq_file *s, void *ignored)
 	return 0;
 }
 
-static int aoe_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, aoedisk_debugfs_show, inode->i_private);
-}
+DEFINE_SHOW_ATTRIBUTE(aoe_debugfs);
 
 static DEVICE_ATTR(state, 0444, aoedisk_show_state, NULL);
 static DEVICE_ATTR(mac, 0444, aoedisk_show_mac, NULL);
@@ -186,13 +183,6 @@ static const struct attribute_group *aoe_attr_groups[] = {
 	NULL,
 };
 
-static const struct file_operations aoe_debugfs_fops = {
-	.open = aoe_debugfs_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 static void
 aoedisk_add_debugfs(struct aoedev *d)
 {
-- 
2.23.0

