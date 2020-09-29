Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE527BF37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgI2IXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgI2IXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:23:07 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C655220739;
        Tue, 29 Sep 2020 08:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601367786;
        bh=7luurs8JgQnoP9+X7r6HhLN7YjvPLnF20aYzggoZCzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8uysvlQ+a1GVqssPt4pk8Te4CCtzqs6uhFfWeT4/L8ymgBF6Je7VCOGFX2InHvoT
         wArmBik7TMFnLQ0RwaECkDGNnLhvOARD6pwMWI3tM3czOnTBltrgnF+T0M7YoC2+K8
         YWFZWWunsscjEqbNF3xahFoU3gY1mVw6EbcBh0VQ=
Date:   Tue, 29 Sep 2020 01:23:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2 1/2] f2fs: compress: introduce page array slab cache
Message-ID: <20200929082306.GA1567825@google.com>
References: <20200914090514.50102-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914090514.50102-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found a bug related to the number of page pointer allocation related to
nr_cpages.

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index f086ac43ca825..3a18666725fef 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -20,22 +20,20 @@
 static struct kmem_cache *cic_entry_slab;
 static struct kmem_cache *dic_entry_slab;
 
-static void *page_array_alloc(struct inode *inode)
+static void *page_array_alloc(struct inode *inode, int nr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	unsigned int size = sizeof(struct page *) <<
-				F2FS_I(inode)->i_log_cluster_size;
+	unsigned int size = sizeof(struct page *) * nr;
 
 	if (likely(size == sbi->page_array_slab_size))
 		return kmem_cache_zalloc(sbi->page_array_slab, GFP_NOFS);
 	return f2fs_kzalloc(sbi, size, GFP_NOFS);
 }
 
-static void page_array_free(struct inode *inode, void *pages)
+static void page_array_free(struct inode *inode, void *pages, int nr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	unsigned int size = sizeof(struct page *) <<
-				F2FS_I(inode)->i_log_cluster_size;
+	unsigned int size = sizeof(struct page *) * nr;
 
 	if (!pages)
 		return;
@@ -162,13 +160,13 @@ int f2fs_init_compress_ctx(struct compress_ctx *cc)
 	if (cc->rpages)
 		return 0;
 
-	cc->rpages = page_array_alloc(cc->inode);
+	cc->rpages = page_array_alloc(cc->inode, cc->cluster_size);
 	return cc->rpages ? 0 : -ENOMEM;
 }
 
 void f2fs_destroy_compress_ctx(struct compress_ctx *cc)
 {
-	page_array_free(cc->inode, cc->rpages);
+	page_array_free(cc->inode, cc->rpages, cc->cluster_size);
 	cc->rpages = NULL;
 	cc->nr_rpages = 0;
 	cc->nr_cpages = 0;
@@ -602,7 +600,8 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	struct f2fs_inode_info *fi = F2FS_I(cc->inode);
 	const struct f2fs_compress_ops *cops =
 				f2fs_cops[fi->i_compress_algorithm];
-	unsigned int max_len, nr_cpages;
+	unsigned int max_len, new_nr_cpages;
+	struct page **new_cpages;
 	int i, ret;
 
 	trace_f2fs_compress_pages_start(cc->inode, cc->cluster_idx,
@@ -617,7 +616,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	max_len = COMPRESS_HEADER_SIZE + cc->clen;
 	cc->nr_cpages = DIV_ROUND_UP(max_len, PAGE_SIZE);
 
-	cc->cpages = page_array_alloc(cc->inode);
+	cc->cpages = page_array_alloc(cc->inode, cc->nr_cpages);
 	if (!cc->cpages) {
 		ret = -ENOMEM;
 		goto destroy_compress_ctx;
@@ -659,16 +658,28 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	for (i = 0; i < COMPRESS_DATA_RESERVED_SIZE; i++)
 		cc->cbuf->reserved[i] = cpu_to_le32(0);
 
-	nr_cpages = DIV_ROUND_UP(cc->clen + COMPRESS_HEADER_SIZE, PAGE_SIZE);
+	new_nr_cpages = DIV_ROUND_UP(cc->clen + COMPRESS_HEADER_SIZE, PAGE_SIZE);
+
+	/* Now we're going to cut unnecessary tail pages */
+	new_cpages = page_array_alloc(cc->inode, new_nr_cpages);
+	if (new_cpages) {
+		ret = -ENOMEM;
+		goto out_vunmap_cbuf;
+	}
 
 	/* zero out any unused part of the last page */
 	memset(&cc->cbuf->cdata[cc->clen], 0,
-	       (nr_cpages * PAGE_SIZE) - (cc->clen + COMPRESS_HEADER_SIZE));
+			(new_nr_cpages * PAGE_SIZE) -
+			(cc->clen + COMPRESS_HEADER_SIZE));
 
 	vm_unmap_ram(cc->cbuf, cc->nr_cpages);
 	vm_unmap_ram(cc->rbuf, cc->cluster_size);
 
-	for (i = nr_cpages; i < cc->nr_cpages; i++) {
+	for (i = 0; i < cc->nr_cpages; i++) {
+		if (i < new_nr_cpages) {
+			new_cpages[i] = cc->cpages[i];
+			continue;
+		}
 		f2fs_compress_free_page(cc->cpages[i]);
 		cc->cpages[i] = NULL;
 	}
@@ -676,7 +687,9 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	if (cops->destroy_compress_ctx)
 		cops->destroy_compress_ctx(cc);
 
-	cc->nr_cpages = nr_cpages;
+	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
+	cc->cpages = new_cpages;
+	cc->nr_cpages = new_nr_cpages;
 
 	trace_f2fs_compress_pages_end(cc->inode, cc->cluster_idx,
 							cc->clen, ret);
@@ -691,7 +704,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 		if (cc->cpages[i])
 			f2fs_compress_free_page(cc->cpages[i]);
 	}
-	page_array_free(cc->inode, cc->cpages);
+	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
 	cc->cpages = NULL;
 destroy_compress_ctx:
 	if (cops->destroy_compress_ctx)
@@ -730,7 +743,7 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 		goto out_free_dic;
 	}
 
-	dic->tpages = page_array_alloc(dic->inode);
+	dic->tpages = page_array_alloc(dic->inode, dic->cluster_size);
 	if (!dic->tpages) {
 		ret = -ENOMEM;
 		goto out_free_dic;
@@ -1203,7 +1216,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	cic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	cic->inode = inode;
 	atomic_set(&cic->pending_pages, cc->nr_cpages);
-	cic->rpages = page_array_alloc(cc->inode);
+	cic->rpages = page_array_alloc(cc->inode, cc->cluster_size);
 	if (!cic->rpages)
 		goto out_put_cic;
 
@@ -1301,7 +1314,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	return 0;
 
 out_destroy_crypt:
-	page_array_free(cc->inode, cic->rpages);
+	page_array_free(cc->inode, cic->rpages, cc->cluster_size);
 
 	for (--i; i >= 0; i--)
 		fscrypt_finalize_bounce_page(&cc->cpages[i]);
@@ -1345,7 +1358,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
 		end_page_writeback(cic->rpages[i]);
 	}
 
-	page_array_free(cic->inode, cic->rpages);
+	page_array_free(cic->inode, cic->rpages, cic->nr_rpages);
 	kmem_cache_free(cic_entry_slab, cic);
 }
 
@@ -1442,7 +1455,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 
 		err = f2fs_write_compressed_pages(cc, submitted,
 							wbc, io_type);
-		page_array_free(cc->inode, cc->cpages);
+		page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
 		cc->cpages = NULL;
 		if (!err)
 			return 0;
@@ -1468,7 +1481,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	if (!dic)
 		return ERR_PTR(-ENOMEM);
 
-	dic->rpages = page_array_alloc(cc->inode);
+	dic->rpages = page_array_alloc(cc->inode, cc->cluster_size);
 	if (!dic->rpages) {
 		kmem_cache_free(dic_entry_slab, dic);
 		return ERR_PTR(-ENOMEM);
@@ -1487,7 +1500,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 		dic->rpages[i] = cc->rpages[i];
 	dic->nr_rpages = cc->cluster_size;
 
-	dic->cpages = page_array_alloc(dic->inode);
+	dic->cpages = page_array_alloc(dic->inode, dic->nr_cpages);
 	if (!dic->cpages)
 		goto out_free;
 
@@ -1522,7 +1535,7 @@ void f2fs_free_dic(struct decompress_io_ctx *dic)
 				continue;
 			f2fs_compress_free_page(dic->tpages[i]);
 		}
-		page_array_free(dic->inode, dic->tpages);
+		page_array_free(dic->inode, dic->tpages, dic->cluster_size);
 	}
 
 	if (dic->cpages) {
@@ -1531,10 +1544,10 @@ void f2fs_free_dic(struct decompress_io_ctx *dic)
 				continue;
 			f2fs_compress_free_page(dic->cpages[i]);
 		}
-		page_array_free(dic->inode, dic->cpages);
+		page_array_free(dic->inode, dic->cpages, dic->nr_cpages);
 	}
 
-	page_array_free(dic->inode, dic->rpages);
+	page_array_free(dic->inode, dic->rpages, dic->nr_rpages);
 	kmem_cache_free(dic_entry_slab, dic);
 }
 
-- 
2.28.0.709.gb0816b6eb0-goog

