Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD79D27CD91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbgI2MpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:45:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728701AbgI2Mot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:44:49 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 09F14FBF6EE64F5A029C;
        Tue, 29 Sep 2020 20:44:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 20:44:36 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <yi.zhang@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ubifs: mount_ubifs: Release authentication resource in error handling path
Date:   Tue, 29 Sep 2020 20:45:31 +0800
Message-ID: <20200929124531.941873-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200929124531.941873-1-chengzhihao1@huawei.com>
References: <20200929124531.941873-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release the authentication related resource in some error handling
branches in mount_ubifs().

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: <stable@vger.kernel.org>  # 4.20+
Fixes: d8a22773a12c6d7 ("ubifs: Enable authentication support")
---
 fs/ubifs/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 9796f5df2f7f..732218ef6656 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1331,7 +1331,7 @@ static int mount_ubifs(struct ubifs_info *c)
 
 	err = ubifs_read_superblock(c);
 	if (err)
-		goto out_free;
+		goto out_auth;
 
 	c->probing = 0;
 
@@ -1343,18 +1343,18 @@ static int mount_ubifs(struct ubifs_info *c)
 		ubifs_err(c, "'compressor \"%s\" is not compiled in",
 			  ubifs_compr_name(c, c->default_compr));
 		err = -ENOTSUPP;
-		goto out_free;
+		goto out_auth;
 	}
 
 	err = init_constants_sb(c);
 	if (err)
-		goto out_free;
+		goto out_auth;
 
 	sz = ALIGN(c->max_idx_node_sz, c->min_io_size) * 2;
 	c->cbuf = kmalloc(sz, GFP_NOFS);
 	if (!c->cbuf) {
 		err = -ENOMEM;
-		goto out_free;
+		goto out_auth;
 	}
 
 	err = alloc_wbufs(c);
@@ -1629,6 +1629,8 @@ static int mount_ubifs(struct ubifs_info *c)
 	free_wbufs(c);
 out_cbuf:
 	kfree(c->cbuf);
+out_auth:
+	ubifs_exit_authentication(c);
 out_free:
 	kfree(c->write_reserve_buf);
 	kfree(c->bu.buf);
-- 
2.25.4

