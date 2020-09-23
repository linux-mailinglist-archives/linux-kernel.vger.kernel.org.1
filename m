Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84E27598C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIWOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:12:10 -0400
Received: from foss.arm.com ([217.140.110.172]:47086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:12:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0907912FC;
        Wed, 23 Sep 2020 07:12:07 -0700 (PDT)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CAFBB3F73B;
        Wed, 23 Sep 2020 07:12:03 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        qemu_oss@crudebyte.com
Cc:     groug@kaod.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        jianyong.wu@arm.com, Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH v2 2/4] fs/9p: track open fids
Date:   Wed, 23 Sep 2020 22:11:44 +0800
Message-Id: <20200923141146.90046-3-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923141146.90046-1-jianyong.wu@arm.com>
References: <20200923141146.90046-1-jianyong.wu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kurz <gkurz@linux.vnet.ibm.com>

This patch adds accounting of open fids in a list hanging off the i_private
field of the corresponding inode. This allows faster lookups compared to
searching the full 9p client list.

The lookup code is modified accordingly.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 fs/9p/fid.c             | 32 +++++++++++++++++++++++---------
 fs/9p/fid.h             |  1 +
 fs/9p/vfs_dir.c         |  3 +++
 fs/9p/vfs_file.c        |  1 +
 fs/9p/vfs_inode.c       |  6 +++++-
 fs/9p/vfs_inode_dotl.c  |  1 +
 include/net/9p/client.h |  1 +
 7 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 3304984c0fad..d11dd430590d 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -39,7 +39,7 @@ void v9fs_fid_add(struct dentry *dentry, struct p9_fid *fid)
 }
 
 /**
- * v9fs_fid_find_inode - search for a fid off of the client list
+ * v9fs_fid_find_inode - search for an open fid off of the inode list
  * @inode: return a fid pointing to a specific inode
  * @uid: return a fid belonging to the specified user
  *
@@ -47,24 +47,38 @@ void v9fs_fid_add(struct dentry *dentry, struct p9_fid *fid)
 
 static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
 {
-	struct p9_client *clnt = v9fs_inode2v9ses(inode)->clnt;
-	struct p9_fid *fid, *fidptr, *ret = NULL;
-	unsigned long flags;
+	struct hlist_head *h;
+	struct p9_fid *fid, *ret = NULL;
 
 	p9_debug(P9_DEBUG_VFS, " inode: %p\n", inode);
 
-	spin_lock_irqsave(&clnt->lock, flags);
-	list_for_each_entry_safe(fid, fidptr, &clnt->fidlist, flist) {
-		if (uid_eq(fid->uid, uid) &&
-		   (inode->i_ino == v9fs_qid2ino(&fid->qid))) {
+	spin_lock(&inode->i_lock);
+	h = (struct hlist_head *)&inode->i_private;
+	hlist_for_each_entry(fid, h, ilist) {
+		if (uid_eq(fid->uid, uid)) {
 			ret = fid;
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&clnt->lock, flags);
+	spin_unlock(&inode->i_lock);
 	return ret;
 }
 
+/**
+ * v9fs_open_fid_add - add an open fid to an inode
+ * @dentry: inode that the fid is being added to
+ * @fid: fid to add
+ *
+ */
+
+void v9fs_open_fid_add(struct inode *inode, struct p9_fid *fid)
+{
+	spin_lock(&inode->i_lock);
+	hlist_add_head(&fid->ilist, (struct hlist_head *)&inode->i_private);
+	spin_unlock(&inode->i_lock);
+}
+
+
 /**
  * v9fs_fid_find - retrieve a fid that belongs to the specified uid
  * @dentry: dentry to look for fid in
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 928b1093f511..dfa11df02818 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -15,6 +15,7 @@ static inline struct p9_fid *v9fs_parent_fid(struct dentry *dentry)
 }
 void v9fs_fid_add(struct dentry *dentry, struct p9_fid *fid);
 struct p9_fid *v9fs_writeback_fid(struct dentry *dentry);
+void v9fs_open_fid_add(struct inode *inode, struct p9_fid *fid);
 static inline struct p9_fid *clone_fid(struct p9_fid *fid)
 {
 	return IS_ERR(fid) ? fid :  p9_client_walk(fid, 0, NULL, 1);
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 674d22bf4f6f..d82d8a346f86 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -210,6 +210,9 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 	fid = filp->private_data;
 	p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
 		 inode, filp, fid ? fid->fid : -1);
+	spin_lock(&inode->i_lock);
+	hlist_del(&fid->ilist);
+	spin_unlock(&inode->i_lock);
 	if (fid)
 		p9_client_clunk(fid);
 	return 0;
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 92cd1d80218d..b42cc1752cd1 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -96,6 +96,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	mutex_unlock(&v9inode->v_mutex);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		v9fs_cache_inode_set_cookie(inode, file);
+	v9fs_open_fid_add(inode, fid);
 	return 0;
 out_error:
 	p9_client_clunk(file->private_data);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 31c2fddabb82..6b243ffcbcf0 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -256,6 +256,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 	inode->i_rdev = rdev;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 	inode->i_mapping->a_ops = &v9fs_addr_operations;
+	inode->i_private = NULL;
 
 	switch (mode & S_IFMT) {
 	case S_IFIFO:
@@ -796,6 +797,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid, *inode_fid;
 	struct dentry *res = NULL;
+	struct inode *inode;
 
 	if (d_in_lookup(dentry)) {
 		res = v9fs_vfs_lookup(dir, dentry, 0);
@@ -824,7 +826,8 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	}
 
 	v9fs_invalidate_inode_attr(dir);
-	v9inode = V9FS_I(d_inode(dentry));
+	inode = d_inode(dentry);
+	v9inode = V9FS_I(inode);
 	mutex_lock(&v9inode->v_mutex);
 	if ((v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) &&
 	    !v9inode->writeback_fid &&
@@ -852,6 +855,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	file->private_data = fid;
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		v9fs_cache_inode_set_cookie(d_inode(dentry), file);
+	v9fs_open_fid_add(inode, fid);
 
 	file->f_mode |= FMODE_CREATED;
 out:
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 0028eccb665a..08f2e089fb0e 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -342,6 +342,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	file->private_data = ofid;
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		v9fs_cache_inode_set_cookie(inode, file);
+	v9fs_open_fid_add(inode, ofid);
 	file->f_mode |= FMODE_CREATED;
 out:
 	v9fs_put_acl(dacl, pacl);
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index dd5b5bd781a4..ce7882da8e86 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -152,6 +152,7 @@ struct p9_fid {
 	void *rdir;
 
 	struct hlist_node dlist;	/* list of all fids attached to a dentry */
+	struct hlist_node ilist;
 };
 
 /**
-- 
2.17.1

