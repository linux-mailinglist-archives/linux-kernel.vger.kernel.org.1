Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8155A279585
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgIZAVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgIZAVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:21:11 -0400
Received: from localhost.localdomain (unknown [49.65.245.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6ADD20708;
        Sat, 26 Sep 2020 00:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601079670;
        bh=w3xgP3gAwRlU3vYJVUANpQQUeyeF3V/RiVdViNeNL1I=;
        h=From:To:Cc:Subject:Date:From;
        b=MEqMR1fJJSFuBupHaRkT/QxkloTXml0X4aPZtjmQL2HY5wvyhGg0EnRppPBWfEG5w
         MeYrJO/NM/2mMdryIZWeP5L1qRJOwCyX1AHGK2zr2AQyU/dl0gbKCwE63Su1geYdHt
         dxFObno/6muCr3JKV0D0vtz+NXtvKtemEx00aAJI=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove unneeded parameter in find_in_block()
Date:   Sat, 26 Sep 2020 08:20:46 +0800
Message-Id: <20200926002046.6560-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

We can relocate @res_page assignment in find_in_block() to
its caller, so unneeded parameter could be removed for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ceb4431b5669..8d98597d3960 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -190,21 +190,15 @@ static unsigned long dir_block_index(unsigned int level,
 static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 				struct page *dentry_page,
 				const struct f2fs_filename *fname,
-				int *max_slots,
-				struct page **res_page)
+				int *max_slots)
 {
 	struct f2fs_dentry_block *dentry_blk;
-	struct f2fs_dir_entry *de;
 	struct f2fs_dentry_ptr d;
 
 	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
 
 	make_dentry_ptr_block(dir, &d, dentry_blk);
-	de = f2fs_find_target_dentry(&d, fname, max_slots);
-	if (de)
-		*res_page = dentry_page;
-
-	return de;
+	return f2fs_find_target_dentry(&d, fname, max_slots);
 }
 
 #ifdef CONFIG_UNICODE
@@ -330,10 +324,11 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 			}
 		}
 
-		de = find_in_block(dir, dentry_page, fname, &max_slots,
-				   res_page);
-		if (de)
+		de = find_in_block(dir, dentry_page, fname, &max_slots);
+		if (de) {
+			*res_page = dentry_page;
 			break;
+		}
 
 		if (max_slots >= s)
 			room = true;
-- 
2.22.0

