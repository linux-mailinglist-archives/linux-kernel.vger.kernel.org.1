Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C424268778
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgINIrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:47:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11832 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbgINIrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:47:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4A9E42DC6B1C9CF3D833;
        Mon, 14 Sep 2020 16:47:12 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 16:47:04 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: clean up kvfree
Date:   Mon, 14 Sep 2020 16:47:00 +0800
Message-ID: <20200914084700.44149-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 0b6d4ca04a86 ("f2fs: don't return vmalloc() memory from
f2fs_kmalloc()"), f2fs_k{m,z}alloc() will not return vmalloc()'ed
memory, so clean up to use kfree() instead of kvfree() to free
vmalloc()'ed memory.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/acl.c     |  6 +++---
 fs/f2fs/data.c    |  2 +-
 fs/f2fs/debug.c   |  2 +-
 fs/f2fs/dir.c     |  2 +-
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/gc.c      |  4 ++--
 fs/f2fs/inline.c  |  4 ++--
 fs/f2fs/namei.c   |  2 +-
 fs/f2fs/node.c    |  2 +-
 fs/f2fs/segment.c | 24 ++++++++++++------------
 fs/f2fs/xattr.c   |  8 ++++----
 11 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 217b290ae3a5..306413589827 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -160,7 +160,7 @@ static void *f2fs_acl_to_disk(struct f2fs_sb_info *sbi,
 	return (void *)f2fs_acl;
 
 fail:
-	kvfree(f2fs_acl);
+	kfree(f2fs_acl);
 	return ERR_PTR(-EINVAL);
 }
 
@@ -190,7 +190,7 @@ static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
 		acl = NULL;
 	else
 		acl = ERR_PTR(retval);
-	kvfree(value);
+	kfree(value);
 
 	return acl;
 }
@@ -240,7 +240,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 
 	error = f2fs_setxattr(inode, name_index, "", value, size, ipage, 0);
 
-	kvfree(value);
+	kfree(value);
 	if (!error)
 		set_cached_acl(inode, type, acl);
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 411029ec4fe8..db020a74fd84 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3570,7 +3570,7 @@ static void f2fs_dio_end_io(struct bio *bio)
 	bio->bi_private = dio->orig_private;
 	bio->bi_end_io = dio->orig_end_io;
 
-	kvfree(dio);
+	kfree(dio);
 
 	bio_endio(bio);
 }
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index f3cc34db86d7..a8357fd4f5fa 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -574,7 +574,7 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi)
 	list_del(&si->stat_list);
 	mutex_unlock(&f2fs_stat_mutex);
 
-	kvfree(si);
+	kfree(si);
 }
 
 void __init f2fs_create_root_stats(void)
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 069f498af1e3..703cf8e21fc0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1170,7 +1170,7 @@ static int f2fs_d_hash(const struct dentry *dentry, struct qstr *str)
 	}
 	str->hash = full_name_hash(dentry, norm, len);
 out:
-	kvfree(norm);
+	kfree(norm);
 	return ret;
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index dcc7d4d1268c..58e464cc15f0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3373,7 +3373,7 @@ static int f2fs_ioc_getfslabel(struct file *filp, unsigned long arg)
 				min(FSLABEL_MAX, count)))
 		err = -EFAULT;
 
-	kvfree(vbuf);
+	kfree(vbuf);
 	return err;
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 84b9dac942e3..05641a1e36cc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -152,7 +152,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(gc_th->f2fs_gc_task)) {
 		err = PTR_ERR(gc_th->f2fs_gc_task);
-		kvfree(gc_th);
+		kfree(gc_th);
 		sbi->gc_thread = NULL;
 	}
 out:
@@ -165,7 +165,7 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 	if (!gc_th)
 		return;
 	kthread_stop(gc_th->f2fs_gc_task);
-	kvfree(gc_th);
+	kfree(gc_th);
 	sbi->gc_thread = NULL;
 }
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 102df444f623..70384e31788d 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -524,7 +524,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 			!f2fs_has_inline_xattr(dir))
 		F2FS_I(dir)->i_inline_xattr_size = 0;
 
-	kvfree(backup_dentry);
+	kfree(backup_dentry);
 	return 0;
 recover:
 	lock_page(ipage);
@@ -535,7 +535,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	set_page_dirty(ipage);
 	f2fs_put_page(ipage, 1);
 
-	kvfree(backup_dentry);
+	kfree(backup_dentry);
 	return err;
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 84e4bbc1a64d..90565432559c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -707,7 +707,7 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	f2fs_handle_failed_inode(inode);
 out_free_encrypted_link:
 	if (disk_link.name != (unsigned char *)symname)
-		kvfree(disk_link.name);
+		kfree(disk_link.name);
 	return err;
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cb1b5b61a1da..85efa13fc3c3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3257,7 +3257,7 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 	kvfree(nm_i->nat_bitmap_mir);
 #endif
 	sbi->nm_info = NULL;
-	kvfree(nm_i);
+	kfree(nm_i);
 }
 
 int __init f2fs_create_node_manager_caches(void)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6335523090e9..13ecd2c2c361 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -728,7 +728,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
 		err = PTR_ERR(fcc->f2fs_issue_flush);
-		kvfree(fcc);
+		kfree(fcc);
 		SM_I(sbi)->fcc_info = NULL;
 		return err;
 	}
@@ -747,7 +747,7 @@ void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
 		kthread_stop(flush_thread);
 	}
 	if (free) {
-		kvfree(fcc);
+		kfree(fcc);
 		SM_I(sbi)->fcc_info = NULL;
 	}
 }
@@ -2105,7 +2105,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(dcc->f2fs_issue_discard)) {
 		err = PTR_ERR(dcc->f2fs_issue_discard);
-		kvfree(dcc);
+		kfree(dcc);
 		SM_I(sbi)->dcc_info = NULL;
 		return err;
 	}
@@ -2129,7 +2129,7 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 	if (unlikely(atomic_read(&dcc->discard_cmd_cnt)))
 		f2fs_issue_discard_timeout(sbi);
 
-	kvfree(dcc);
+	kfree(dcc);
 	SM_I(sbi)->dcc_info = NULL;
 }
 
@@ -5151,7 +5151,7 @@ static void destroy_dirty_segmap(struct f2fs_sb_info *sbi)
 
 	destroy_victim_secmap(sbi);
 	SM_I(sbi)->dirty_info = NULL;
-	kvfree(dirty_i);
+	kfree(dirty_i);
 }
 
 static void destroy_curseg(struct f2fs_sb_info *sbi)
@@ -5163,10 +5163,10 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
 		return;
 	SM_I(sbi)->curseg_array = NULL;
 	for (i = 0; i < NR_CURSEG_TYPE; i++) {
-		kvfree(array[i].sum_blk);
-		kvfree(array[i].journal);
+		kfree(array[i].sum_blk);
+		kfree(array[i].journal);
 	}
-	kvfree(array);
+	kfree(array);
 }
 
 static void destroy_free_segmap(struct f2fs_sb_info *sbi)
@@ -5177,7 +5177,7 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
 	SM_I(sbi)->free_info = NULL;
 	kvfree(free_i->free_segmap);
 	kvfree(free_i->free_secmap);
-	kvfree(free_i);
+	kfree(free_i);
 }
 
 static void destroy_sit_info(struct f2fs_sb_info *sbi)
@@ -5189,7 +5189,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 
 	if (sit_i->sentries)
 		kvfree(sit_i->bitmap);
-	kvfree(sit_i->tmp_map);
+	kfree(sit_i->tmp_map);
 
 	kvfree(sit_i->sentries);
 	kvfree(sit_i->sec_entries);
@@ -5201,7 +5201,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 	kvfree(sit_i->sit_bitmap_mir);
 	kvfree(sit_i->invalid_segmap);
 #endif
-	kvfree(sit_i);
+	kfree(sit_i);
 }
 
 void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi)
@@ -5217,7 +5217,7 @@ void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi)
 	destroy_free_segmap(sbi);
 	destroy_sit_info(sbi);
 	sbi->sm_info = NULL;
-	kvfree(sm_info);
+	kfree(sm_info);
 }
 
 int __init f2fs_create_segment_manager_caches(void)
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 1b0736ce0918..65afcc3cc68a 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -39,7 +39,7 @@ static void xattr_free(struct f2fs_sb_info *sbi, void *xattr_addr,
 	if (is_inline)
 		kmem_cache_free(sbi->inline_xattr_slab, xattr_addr);
 	else
-		kvfree(xattr_addr);
+		kfree(xattr_addr);
 }
 
 static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
@@ -425,7 +425,7 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 	*base_addr = txattr_addr;
 	return 0;
 fail:
-	kvfree(txattr_addr);
+	kfree(txattr_addr);
 	return err;
 }
 
@@ -610,7 +610,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	}
 	error = buffer_size - rest;
 cleanup:
-	kvfree(base_addr);
+	kfree(base_addr);
 	return error;
 }
 
@@ -750,7 +750,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (!error && S_ISDIR(inode->i_mode))
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 exit:
-	kvfree(base_addr);
+	kfree(base_addr);
 	return error;
 }
 
-- 
2.26.2

