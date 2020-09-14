Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E4B268776
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgINIrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:47:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbgINIrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:47:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6726A9A8E8870377E53E;
        Mon, 14 Sep 2020 16:46:59 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 16:46:51 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: compress: introduce cic/dic slab cache
Date:   Mon, 14 Sep 2020 16:46:45 +0800
Message-ID: <20200914084645.44063-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914084645.44063-1-yuchao0@huawei.com>
References: <20200914084645.44063-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two slab caches: "f2fs_cic_entry" and "f2fs_dic_entry" for memory
allocation of compress_io_ctx and decompress_io_ctx structure.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 67 +++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/f2fs.h     |  4 +++
 fs/f2fs/super.c    |  6 +++++
 3 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c6fcd68df71a..10a9f39b9d6a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -17,6 +17,9 @@
 #include "node.h"
 #include <trace/events/f2fs.h>
 
+static struct kmem_cache *cic_entry_slab;
+static struct kmem_cache *dic_entry_slab;
+
 static void *page_array_alloc(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -1193,7 +1196,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 	fio.version = ni.version;
 
-	cic = f2fs_kzalloc(sbi, sizeof(struct compress_io_ctx), GFP_NOFS);
+	cic = kmem_cache_zalloc(cic_entry_slab, GFP_NOFS);
 	if (!cic)
 		goto out_put_dnode;
 
@@ -1308,7 +1311,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		f2fs_put_page(cc->cpages[i], 1);
 	}
 out_put_cic:
-	kfree(cic);
+	kmem_cache_free(cic_entry_slab, cic);
 out_put_dnode:
 	f2fs_put_dnode(&dn);
 out_unlock_op:
@@ -1343,7 +1346,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
 	}
 
 	page_array_free(cic->inode, cic->rpages);
-	kfree(cic);
+	kmem_cache_free(cic_entry_slab, cic);
 }
 
 static int f2fs_write_raw_pages(struct compress_ctx *cc,
@@ -1457,18 +1460,17 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 
 struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	struct decompress_io_ctx *dic;
 	pgoff_t start_idx = start_idx_of_cluster(cc);
 	int i;
 
-	dic = f2fs_kzalloc(sbi, sizeof(struct decompress_io_ctx), GFP_NOFS);
+	dic = kmem_cache_zalloc(dic_entry_slab, GFP_NOFS);
 	if (!dic)
 		return ERR_PTR(-ENOMEM);
 
 	dic->rpages = page_array_alloc(cc->inode);
 	if (!dic->rpages) {
-		kfree(dic);
+		kmem_cache_free(dic_entry_slab, dic);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1533,7 +1535,7 @@ void f2fs_free_dic(struct decompress_io_ctx *dic)
 	}
 
 	page_array_free(dic->inode, dic->rpages);
-	kfree(dic);
+	kmem_cache_free(dic_entry_slab, dic);
 }
 
 void f2fs_decompress_end_io(struct page **rpages,
@@ -1583,3 +1585,54 @@ void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi)
 {
 	kmem_cache_destroy(sbi->page_array_slab);
 }
+
+static int __init f2fs_init_cic_cache(void)
+{
+	cic_entry_slab = f2fs_kmem_cache_create("f2fs_cic_entry",
+					sizeof(struct compress_io_ctx));
+	if (!cic_entry_slab)
+		return -ENOMEM;
+	return 0;
+}
+
+static void f2fs_destroy_cic_cache(void)
+{
+	kmem_cache_destroy(cic_entry_slab);
+}
+
+static int __init f2fs_init_dic_cache(void)
+{
+	dic_entry_slab = f2fs_kmem_cache_create("f2fs_dic_entry",
+					sizeof(struct decompress_io_ctx));
+	if (!dic_entry_slab)
+		return -ENOMEM;
+	return 0;
+}
+
+static void f2fs_destroy_dic_cache(void)
+{
+	kmem_cache_destroy(dic_entry_slab);
+}
+
+int __init f2fs_init_compress_cache(void)
+{
+	int err;
+
+	err = f2fs_init_cic_cache();
+	if (err)
+		goto out;
+	err = f2fs_init_dic_cache();
+	if (err)
+		goto free_cic;
+	return 0;
+free_cic:
+	f2fs_destroy_cic_cache();
+out:
+	return -ENOMEM;
+}
+
+void f2fs_destroy_compress_cache(void)
+{
+	f2fs_destroy_dic_cache();
+	f2fs_destroy_cic_cache();
+}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3cfed2d8bd05..bd2be57a22f2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3938,6 +3938,8 @@ void f2fs_destroy_compress_ctx(struct compress_ctx *cc);
 void f2fs_init_compress_info(struct f2fs_sb_info *sbi);
 int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi);
 void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
+int __init f2fs_init_compress_cache(void);
+void f2fs_destroy_compress_cache(void);
 #else
 static inline bool f2fs_is_compressed_page(struct page *page) { return false; }
 static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
@@ -3956,6 +3958,8 @@ static inline int f2fs_init_compress_mempool(void) { return 0; }
 static inline void f2fs_destroy_compress_mempool(void) { }
 static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi) { }
+static inline int __init f2fs_init_compress_cache(void) { }
+static inline void f2fs_destroy_compress_cache(void) { }
 #endif
 
 static inline void set_compress_context(struct inode *inode)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d7336914d2b3..427ce4cbd124 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4047,7 +4047,12 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_compress_mempool();
 	if (err)
 		goto free_bioset;
+	err = f2fs_init_compress_cache();
+	if (err)
+		goto free_compress_mempool;
 	return 0;
+free_compress_mempool:
+	f2fs_destroy_compress_mempool();
 free_bioset:
 	f2fs_destroy_bioset();
 free_bio_enrty_cache:
@@ -4079,6 +4084,7 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
+	f2fs_destroy_compress_cache();
 	f2fs_destroy_compress_mempool();
 	f2fs_destroy_bioset();
 	f2fs_destroy_bio_entry_cache();
-- 
2.26.2

