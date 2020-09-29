Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2358E27CD93
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbgI2Mp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:45:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733221AbgI2Mop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:44:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0E4F96135E49E978FB7F;
        Tue, 29 Sep 2020 20:44:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 20:44:35 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <yi.zhang@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ubifs: Fix a memleak after dumping authentication mount options
Date:   Tue, 29 Sep 2020 20:45:29 +0800
Message-ID: <20200929124531.941873-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a memory leak after dumping authentication mount options in error
handling branch.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: <stable@vger.kernel.org>  # 4.20+
Fixes: d8a22773a12c6d7 ("ubifs: Enable authentication support")
---
 fs/ubifs/super.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index a2420c900275..6f85cd618766 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1141,6 +1141,18 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
 	return 0;
 }
 
+/*
+ * ubifs_release_options - release mount parameters which have been dumped.
+ * @c: UBIFS file-system description object
+ */
+static void ubifs_release_options(struct ubifs_info *c)
+{
+	kfree(c->auth_key_name);
+	c->auth_key_name = NULL;
+	kfree(c->auth_hash_name);
+	c->auth_hash_name = NULL;
+}
+
 /**
  * destroy_journal - destroy journal data structures.
  * @c: UBIFS file-system description object
@@ -1650,8 +1662,7 @@ static void ubifs_umount(struct ubifs_info *c)
 	ubifs_lpt_free(c, 0);
 	ubifs_exit_authentication(c);
 
-	kfree(c->auth_key_name);
-	kfree(c->auth_hash_name);
+	ubifs_release_options(c);
 	kfree(c->cbuf);
 	kfree(c->rcvrd_mst_node);
 	kfree(c->mst_node);
@@ -2219,6 +2230,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 out_unlock:
 	mutex_unlock(&c->umount_mutex);
 out_close:
+	ubifs_release_options(c);
 	ubi_close_volume(c->ubi);
 out:
 	return err;
-- 
2.25.4

