Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60CB205081
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 13:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbgFWLRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 07:17:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49034 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732525AbgFWLQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:16:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 193BF6F357166CCBA0C2;
        Tue, 23 Jun 2020 19:16:52 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 23 Jun 2020
 19:16:43 +0800
From:   Chen Tao <chentao107@huawei.com>
To:     <dhowells@redhat.com>
CC:     <linux-afs@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH -next] afs: Fix the memory leak in afs_mkdir
Date:   Tue, 23 Jun 2020 19:15:28 +0800
Message-ID: <20200623111528.205681-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the memory leak in afs_mkdir not freeing scb
in error path.

Fixes: a58823ac45896 ("afs: Fix application of status and callback to be under same lock")
Signed-off-by: Chen Tao <chentao107@huawei.com>
---
 fs/afs/dir.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index d1e1caa23c8b..ab5472ad1da8 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1599,17 +1599,17 @@ static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	if (dentry->d_name.len >= AFSNAMEMAX)
 		goto error;
 
-	key = afs_request_key(dvnode->volume->cell);
-	if (IS_ERR(key)) {
-		ret = PTR_ERR(key);
-		goto error;
-	}
-
 	ret = -ENOMEM;
 	scb = kcalloc(2, sizeof(struct afs_status_cb), GFP_KERNEL);
 	if (!scb)
 		goto error_scb;
 
+	key = afs_request_key(dvnode->volume->cell);
+	if (IS_ERR(key)) {
+		ret = PTR_ERR(key);
+		goto error_scb;
+	}
+
 	ret = -ERESTARTSYS;
 	if (afs_begin_vnode_operation(&fc, dvnode, key, true)) {
 		data_version = dvnode->status.data_version + 1;
@@ -1645,10 +1645,10 @@ static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	_leave(" = 0");
 	return 0;
 
-error_scb:
-	kfree(scb);
 error_key:
 	key_put(key);
+error_scb:
+	kfree(scb);
 error:
 	d_drop(dentry);
 	_leave(" = %d", ret);
-- 
2.22.0

