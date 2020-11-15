Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D572B36D2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 17:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKOQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 11:52:36 -0500
Received: from m12-18.163.com ([220.181.12.18]:49922 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgKOQwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 11:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=eUxBN
        17tBg7g8E/CnvCpJYdFtBdlxX5nDDJwk3YrJZg=; b=ho6GsUr8/kghdZMblx5mP
        DSyHMzXf5XGqJ6n2iGq5k4tKrc7V1Pc4fvKGzdAzhKLtOtv08nVQangXxRBNmKXu
        3k0zmfv8O3YbZyK6Yncryw202u2yKwCIbtxip7zNs7pPuyvHF8F6DrdOVTU+T9+W
        Ni7v4Q32/iOoLnEdAyLW/Y=
Received: from localhost (unknown [101.86.213.176])
        by smtp14 (Coremail) with SMTP id EsCowAA3Cvi3XLFfkhEBEQ--.55110S2;
        Mon, 16 Nov 2020 00:52:07 +0800 (CST)
Date:   Mon, 16 Nov 2020 00:52:07 +0800
From:   Hui Su <sh_def@163.com>
To:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH v3] mm/shmem.c: make shmem_mapping() inline
Message-ID: <20201115165207.GA265355@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EsCowAA3Cvi3XLFfkhEBEQ--.55110S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWxAry7GFWDAF1rZF4UCFg_yoWrXF13pF
        4DAw45GF48XryFgayxZaykZryYga1kGay0yry3W3sayFn8Gry7tF1jkr1Yvry5Ary8J3y2
        qrWjkry5Ww1UtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRyv3nUUUUU=
X-Originating-IP: [101.86.213.176]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbByxfdX1PAPrl5jQAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_mapping() isn't worth an out-of-line call
from any callsite.

So make it inline by
- make shmem_aops global
- export shmem_aops
- inline the shmem_mapping()

and replace the direct call 'shmem_aops' with shmem_mapping()
in shmem.c.

v1->v2:
remove the inline for func declaration in shmem_fs.h

v2->v3:
make shmem_aops global, and export it to modules.

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/shmem_fs.h |  6 +++++-
 mm/shmem.c               | 16 ++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a5a5d1d4d7b1..d82b6f396588 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -67,7 +67,11 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct user_struct *user);
 #ifdef CONFIG_SHMEM
-extern bool shmem_mapping(struct address_space *mapping);
+extern const struct address_space_operations shmem_aops;
+static inline bool shmem_mapping(struct address_space *mapping)
+{
+	return mapping->a_ops == &shmem_aops;
+}
 #else
 static inline bool shmem_mapping(struct address_space *mapping)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index 537c137698f8..b7361fce50bc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -246,7 +246,7 @@ static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
 }
 
 static const struct super_operations shmem_ops;
-static const struct address_space_operations shmem_aops;
+const struct address_space_operations shmem_aops;
 static const struct file_operations shmem_file_operations;
 static const struct inode_operations shmem_inode_operations;
 static const struct inode_operations shmem_dir_inode_operations;
@@ -1152,7 +1152,7 @@ static void shmem_evict_inode(struct inode *inode)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
-	if (inode->i_mapping->a_ops == &shmem_aops) {
+	if (shmem_mapping(inode->i_mapping)) {
 		shmem_unacct_size(info->flags, inode->i_size);
 		inode->i_size = 0;
 		shmem_truncate_range(inode, 0, (loff_t)-1);
@@ -1858,7 +1858,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	/* shmem_symlink() */
-	if (mapping->a_ops != &shmem_aops)
+	if (!shmem_mapping(mapping))
 		goto alloc_nohuge;
 	if (shmem_huge == SHMEM_HUGE_DENY || sgp_huge == SGP_NOHUGE)
 		goto alloc_nohuge;
@@ -2352,11 +2352,6 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 	return inode;
 }
 
-bool shmem_mapping(struct address_space *mapping)
-{
-	return mapping->a_ops == &shmem_aops;
-}
-
 static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 				  pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
@@ -3865,7 +3860,7 @@ static void shmem_destroy_inodecache(void)
 	kmem_cache_destroy(shmem_inode_cachep);
 }
 
-static const struct address_space_operations shmem_aops = {
+const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
 	.set_page_dirty	= __set_page_dirty_no_writeback,
 #ifdef CONFIG_TMPFS
@@ -3877,6 +3872,7 @@ static const struct address_space_operations shmem_aops = {
 #endif
 	.error_remove_page = generic_error_remove_page,
 };
+EXPORT_SYMBOL(shmem_aops);
 
 static const struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
@@ -4312,7 +4308,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	struct page *page;
 	int error;
 
-	BUG_ON(mapping->a_ops != &shmem_aops);
+	BUG_ON(!shmem_mapping(mapping));
 	error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
 				  gfp, NULL, NULL, NULL);
 	if (error)
-- 
2.29.0


