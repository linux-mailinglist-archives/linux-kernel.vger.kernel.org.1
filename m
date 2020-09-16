Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A833E26C565
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIPQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgIPQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:33:28 -0400
Received: from localhost.localdomain (unknown [117.89.211.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E0EE222EA;
        Wed, 16 Sep 2020 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600265192;
        bh=GwEG5JAQu1nqxOmIoloCzGY63Zh2Vov4E+GWDy/ADE4=;
        h=From:To:Cc:Subject:Date:From;
        b=PFqwM0gq4Zhl0SbDFWlzadJHoOohdmF9fx0z1xVZRP3rJ2uQVw+PWiOqn10w6r97H
         faV7ZlpUiJ5/kCEL39IjJTT4rh4t2U/MWlXSxYcnpDIScbQIJ9Q9owTVtFwVUK3gM0
         U9RAbQV3xXYr9rPPxU3gFj/HffhroLXHPouWqgMs=
From:   Chao Yu <chao@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     hsiangkao@redhat.com, linux-kernel@vger.kernel.org,
        chao@kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] erofs: remove unneeded parameter
Date:   Wed, 16 Sep 2020 22:06:04 +0800
Message-Id: <20200916140604.3799-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

In below call path, no page will be cached into @pagepool list
or grabbed from @pagepool list:
- z_erofs_readpage
 - z_erofs_do_read_page
  - preload_compressed_pages
  - erofs_allocpage

Let's get rid of this unneeded parameter.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/erofs/utils.c |  2 +-
 fs/erofs/zdata.c | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index de9986d2f82f..7a6e5456b0b8 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -11,7 +11,7 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
 {
 	struct page *page;
 
-	if (!list_empty(pool)) {
+	if (pool && !list_empty(pool)) {
 		page = lru_to_page(pool);
 		DBG_BUGON(page_ref_count(page) != 1);
 		list_del(&page->lru);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6c939def00f9..f218f58f4159 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -153,8 +153,7 @@ static DEFINE_MUTEX(z_pagemap_global_lock);
 
 static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     struct address_space *mc,
-				     enum z_erofs_cache_alloctype type,
-				     struct list_head *pagepool)
+				     enum z_erofs_cache_alloctype type)
 {
 	const struct z_erofs_pcluster *pcl = clt->pcl;
 	const unsigned int clusterpages = BIT(pcl->clusterbits);
@@ -562,8 +561,7 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
 }
 
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page,
-				struct list_head *pagepool)
+				struct page *page)
 {
 	struct inode *const inode = fe->inode;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
@@ -621,7 +619,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		cache_strategy = DONTALLOC;
 
 	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
-				 cache_strategy, pagepool);
+				 cache_strategy);
 
 hitted:
 	/*
@@ -653,7 +651,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	/* should allocate an additional staging page for pagevec */
 	if (err == -EAGAIN) {
 		struct page *const newpage =
-			erofs_allocpage(pagepool, GFP_NOFS | __GFP_NOFAIL);
+			erofs_allocpage(NULL, GFP_NOFS | __GFP_NOFAIL);
 
 		newpage->mapping = Z_EROFS_MAPPING_STAGING;
 		err = z_erofs_attach_page(clt, newpage,
@@ -1282,7 +1280,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
-	err = z_erofs_do_read_page(&f, page, &pagepool);
+	err = z_erofs_do_read_page(&f, page);
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
@@ -1341,7 +1339,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		/* traversal in reverse order */
 		head = (void *)page_private(page);
 
-		err = z_erofs_do_read_page(&f, page, &pagepool);
+		err = z_erofs_do_read_page(&f, page);
 		if (err)
 			erofs_err(inode->i_sb,
 				  "readahead error at page %lu @ nid %llu",
-- 
2.22.0

