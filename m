Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F20268333
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 05:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgINDih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 23:38:37 -0400
Received: from foss.arm.com ([217.140.110.172]:58162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgINDi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:38:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB7B1396;
        Sun, 13 Sep 2020 20:38:24 -0700 (PDT)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 29BBA3F718;
        Sun, 13 Sep 2020 20:38:21 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, justin.he@arm.com,
        jianyong.wu@arm.com
Subject: [PATCH RFC 4/4] 9p: fix race issue in fid contention.
Date:   Mon, 14 Sep 2020 11:37:54 +0800
Message-Id: <20200914033754.29188-5-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914033754.29188-1-jianyong.wu@arm.com>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric's and Greg's patch offer a mechanism to fix open-unlink-f*syscall
bug in 9p. But there is race issue in fid comtention.
As Greg's patch stores all of fids from opened files into according inode,
so all the lookup fid ops can retrieve fid from inode preferentially. But
there is no mechanism to handle the fid comtention issue. For example,
there are two threads get the same fid in the same time and one of them
clunk the fid before the other thread ready to discard the fid. In this
scenario, it will lead to some fatal problems, even kernel core dump.

I introduce a mechanism to fix this race issue. A counter field introduced
into p9_fid struct to store the reference counter to the fid. When a fid
is allocated from the inode, the counter will increase, and will decrease
at the end of its occupation. It is guaranteed that the fid won't be clunked
before the reference counter go down to 0, then we can avoid the clunked
fid to be used.
As there is no need to retrieve fid from inode in all conditions, a enum value
denotes the source of the fid is introduced to 9p_fid either. So we can only
handle the reference counter as to the fid obtained from inode.

tests:
race issue test from the old test case:
for file in {01..50}; do touch f.${file}; done
seq 1 1000 | xargs -n 1 -P 50 -I{} cat f.* > /dev/null

open-unlink-f*syscall test:
I have tested for f*syscall include: ftruncate fstat fchown fchmod faccessat.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 fs/9p/fid.c             | 27 +++++++++++++++++---------
 fs/9p/fid.h             | 24 +++++++++++++++++++----
 fs/9p/vfs_dentry.c      |  2 +-
 fs/9p/vfs_dir.c         | 23 +++++++++++++++++-----
 fs/9p/vfs_file.c        |  2 +-
 fs/9p/vfs_inode.c       | 42 ++++++++++++++++++++++++++++------------
 fs/9p/vfs_inode_dotl.c  | 43 +++++++++++++++++++++++++++--------------
 fs/9p/vfs_super.c       |  7 +++++--
 fs/9p/xattr.c           | 18 +++++++++++++----
 include/net/9p/client.h |  7 +++++++
 net/9p/client.c         |  2 ++
 11 files changed, 144 insertions(+), 53 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 0b23b0fe6c51..fd8cfa4776c9 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -60,6 +60,10 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
 			break;
 		}
 	}
+	if (ret && !IS_ERR(ret)) {
+		atomic_inc(&ret->count);
+		ret->s = FID_FROM_INODE;
+	}
 	spin_unlock(&inode->i_lock);
 	return ret;
 }
@@ -84,10 +88,13 @@ void v9fs_open_fid_add(struct inode *inode, struct p9_fid *fid)
  * @dentry: dentry to look for fid in
  * @uid: return fid that belongs to the specified user
  * @any: if non-zero, return any fid associated with the dentry
+ * @source: from which of inode or dentry caller want to retrieve fid, 0
+ * denotes dentry and other denotes inode. Only if the f* syscall related
+ * funcs are recommended to set to non-zero.
  *
  */
 
-static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
+static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any, int source)
 {
 	struct p9_fid *fid, *ret;
 
@@ -96,7 +103,7 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 		 any);
 	ret = NULL;
 
-	if (d_inode(dentry))
+	if (d_inode(dentry) && source)
 		ret = v9fs_fid_find_inode(d_inode(dentry), uid);
 
 	/* we'll recheck under lock if there's anything to look in */
@@ -109,6 +116,8 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 				break;
 			}
 		}
+		if (ret && !IS_ERR(ret))
+			ret->s = FID_FROM_DENTRY;
 		spin_unlock(&dentry->d_lock);
 	}
 
@@ -144,7 +153,7 @@ static int build_path_from_dentry(struct v9fs_session_info *v9ses,
 }
 
 static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
-					       kuid_t uid, int any)
+					       kuid_t uid, int any, int source)
 {
 	struct dentry *ds;
 	const unsigned char **wnames, *uname;
@@ -154,7 +163,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 
 	v9ses = v9fs_dentry2v9ses(dentry);
 	access = v9ses->flags & V9FS_ACCESS_MASK;
-	fid = v9fs_fid_find(dentry, uid, any);
+	fid = v9fs_fid_find(dentry, uid, any, source);
 	if (fid)
 		return fid;
 	/*
@@ -164,7 +173,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 	 */
 	down_read(&v9ses->rename_sem);
 	ds = dentry->d_parent;
-	fid = v9fs_fid_find(ds, uid, any);
+	fid = v9fs_fid_find(ds, uid, any, 0);
 	if (fid) {
 		/* Found the parent fid do a lookup with that */
 		fid = p9_client_walk(fid, 1, &dentry->d_name.name, 1);
@@ -173,7 +182,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 	up_read(&v9ses->rename_sem);
 
 	/* start from the root and try to do a lookup */
-	fid = v9fs_fid_find(dentry->d_sb->s_root, uid, any);
+	fid = v9fs_fid_find(dentry->d_sb->s_root, uid, any, 0);
 	if (!fid) {
 		/* the user is not attached to the fs yet */
 		if (access == V9FS_ACCESS_SINGLE)
@@ -258,7 +267,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
  * the fs yet, attach now and walk from the root.
  */
 
-struct p9_fid *v9fs_fid_lookup(struct dentry *dentry)
+struct p9_fid *v9fs_fid_lookup(struct dentry *dentry, int source)
 {
 	kuid_t uid;
 	int  any, access;
@@ -284,7 +293,7 @@ struct p9_fid *v9fs_fid_lookup(struct dentry *dentry)
 		any = 0;
 		break;
 	}
-	return v9fs_fid_lookup_with_uid(dentry, uid, any);
+	return v9fs_fid_lookup_with_uid(dentry, uid, any, source);
 }
 
 struct p9_fid *v9fs_writeback_fid(struct dentry *dentry)
@@ -292,7 +301,7 @@ struct p9_fid *v9fs_writeback_fid(struct dentry *dentry)
 	int err;
 	struct p9_fid *fid;
 
-	fid = clone_fid(v9fs_fid_lookup_with_uid(dentry, GLOBAL_ROOT_UID, 0));
+	fid = clone_fid(v9fs_fid_lookup_with_uid(dentry, GLOBAL_ROOT_UID, 0, 0));
 	if (IS_ERR(fid))
 		goto error_out;
 	/*
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index dfa11df02818..bea25fd2b983 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -8,10 +8,26 @@
 #define FS_9P_FID_H
 #include <linux/list.h>
 
-struct p9_fid *v9fs_fid_lookup(struct dentry *dentry);
+struct p9_fid *v9fs_fid_lookup(struct dentry *dentry, int source);
+static inline int fid_atomic_dec(struct p9_fid *fid)
+{
+	if (fid && !IS_ERR(fid) && (fid->s & FID_FROM_INODE)) {
+		if (atomic_sub_return(1, &fid->count) < 0) {
+			pr_err("fid counter should be positive\n");
+			while (atomic_inc_and_test(&fid->count));
+			return -1;
+		}
+	}
+	return 0;
+}
+
 static inline struct p9_fid *v9fs_parent_fid(struct dentry *dentry)
 {
-	return v9fs_fid_lookup(dentry->d_parent);
+	/*
+	 * The "*at syscall" often need parent fd, so let's search
+	 * fid from inode first.
+	 */
+	return v9fs_fid_lookup(dentry->d_parent, 1);
 }
 void v9fs_fid_add(struct dentry *dentry, struct p9_fid *fid);
 struct p9_fid *v9fs_writeback_fid(struct dentry *dentry);
@@ -20,8 +36,8 @@ static inline struct p9_fid *clone_fid(struct p9_fid *fid)
 {
 	return IS_ERR(fid) ? fid :  p9_client_walk(fid, 0, NULL, 1);
 }
-static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
+static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry, int source)
 {
-	return clone_fid(v9fs_fid_lookup(dentry));
+	return clone_fid(v9fs_fid_lookup(dentry, source));
 }
 #endif
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 7d6f69aefd45..17bb872d7203 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -76,7 +76,7 @@ static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 	if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
 		int retval;
 		struct v9fs_session_info *v9ses;
-		fid = v9fs_fid_lookup(dentry);
+		fid = v9fs_fid_lookup(dentry, 0);
 		if (IS_ERR(fid))
 			return PTR_ERR(fid);
 
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index d82d8a346f86..f817c6a5fb42 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -19,6 +19,7 @@
 #include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
+#include <linux/delay.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
@@ -206,15 +207,27 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 int v9fs_dir_release(struct inode *inode, struct file *filp)
 {
 	struct p9_fid *fid;
+	int count;
 
 	fid = filp->private_data;
 	p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
 		 inode, filp, fid ? fid->fid : -1);
-	spin_lock(&inode->i_lock);
-	hlist_del(&fid->ilist);
-	spin_unlock(&inode->i_lock);
-	if (fid)
-		p9_client_clunk(fid);
+	if (fid) {
+		spin_lock(&inode->i_lock);
+		hlist_del(&fid->ilist);
+		spin_unlock(&inode->i_lock);
+		/*
+		 * Here we wait up to 10ms, if the counter won't down to 0
+		 * the fid will be left behind.
+		 */
+		count = 100;
+		while (count > 0 && fid->count.counter > 0) {
+			count--;
+			udelay(100);
+		}
+		if (fid->count.counter <= 0)
+			p9_client_clunk(fid);
+	}
 	return 0;
 }
 
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index b42cc1752cd1..efc3f5cc1c14 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -59,7 +59,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 					v9fs_proto_dotu(v9ses));
 	fid = file->private_data;
 	if (!fid) {
-		fid = v9fs_fid_clone(file_dentry(file));
+		fid = v9fs_fid_clone(file_dentry(file), 0);
 		if (IS_ERR(fid))
 			return PTR_ERR(fid);
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 6b243ffcbcf0..f8718b9b1915 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -551,9 +551,10 @@ static int v9fs_remove(struct inode *dir, struct dentry *dentry, int flags)
 	if (v9fs_proto_dotl(v9ses))
 		retval = p9_client_unlinkat(dfid, dentry->d_name.name,
 					    v9fs_at_to_dotl_flags(flags));
+	fid_atomic_dec(dfid);
 	if (retval == -EOPNOTSUPP) {
 		/* Try the one based on path */
-		v9fid = v9fs_fid_clone(dentry);
+		v9fid = v9fs_fid_clone(dentry, 0);
 		if (IS_ERR(v9fid))
 			return PTR_ERR(v9fid);
 		retval = p9_client_remove(v9fid);
@@ -616,12 +617,14 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 	if (IS_ERR(ofid)) {
 		err = PTR_ERR(ofid);
 		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
+		fid_atomic_dec(dfid);
 		return ERR_PTR(err);
 	}
 
 	err = p9_client_fcreate(ofid, name, perm, mode, extension);
 	if (err < 0) {
 		p9_debug(P9_DEBUG_VFS, "p9_client_fcreate failed %d\n", err);
+		fid_atomic_dec(dfid);
 		goto error;
 	}
 
@@ -633,6 +636,7 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 			p9_debug(P9_DEBUG_VFS,
 				   "p9_client_walk failed %d\n", err);
 			fid = NULL;
+			fid_atomic_dec(dfid);
 			goto error;
 		}
 		/*
@@ -643,11 +647,13 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS,
 				   "inode creation failed %d\n", err);
+			fid_atomic_dec(dfid);
 			goto error;
 		}
 		v9fs_fid_add(dentry, fid);
 		d_instantiate(dentry, inode);
 	}
+	fid_atomic_dec(dfid);
 	return ofid;
 error:
 	if (ofid)
@@ -760,6 +766,7 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 	 */
 	name = dentry->d_name.name;
 	fid = p9_client_walk(dfid, 1, &name, 1);
+	fid_atomic_dec(dfid);
 	if (fid == ERR_PTR(-ENOENT))
 		inode = NULL;
 	else if (IS_ERR(fid))
@@ -910,7 +917,7 @@ v9fs_vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct inode *old_inode;
 	struct inode *new_inode;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *oldfid;
+	struct p9_fid *oldfid, *dfid;
 	struct p9_fid *olddirfid;
 	struct p9_fid *newdirfid;
 	struct p9_wstat wstat;
@@ -923,17 +930,23 @@ v9fs_vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	old_inode = d_inode(old_dentry);
 	new_inode = d_inode(new_dentry);
 	v9ses = v9fs_inode2v9ses(old_inode);
-	oldfid = v9fs_fid_lookup(old_dentry);
+	oldfid = v9fs_fid_lookup(old_dentry, 1);
 	if (IS_ERR(oldfid))
 		return PTR_ERR(oldfid);
 
-	olddirfid = clone_fid(v9fs_parent_fid(old_dentry));
+	dfid = v9fs_parent_fid(old_dentry);
+	olddirfid = clone_fid(dfid);
+	if (dfid && !IS_ERR(dfid))
+		fid_atomic_dec(dfid);
 	if (IS_ERR(olddirfid)) {
 		retval = PTR_ERR(olddirfid);
 		goto done;
 	}
 
-	newdirfid = clone_fid(v9fs_parent_fid(new_dentry));
+	dfid = v9fs_parent_fid(new_dentry);
+	newdirfid = clone_fid(dfid);
+	if (dfid && !IS_ERR(dfid))
+		fid_atomic_dec(dfid);
 	if (IS_ERR(newdirfid)) {
 		retval = PTR_ERR(newdirfid);
 		goto clunk_olddir;
@@ -990,6 +1003,7 @@ v9fs_vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	p9_client_clunk(olddirfid);
 
 done:
+	fid_atomic_dec(oldfid);
 	return retval;
 }
 
@@ -1017,11 +1031,12 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
 		generic_fillattr(d_inode(dentry), stat);
 		return 0;
 	}
-	fid = v9fs_fid_lookup(dentry);
+	fid = v9fs_fid_lookup(dentry, 1);
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
 
 	st = p9_client_stat(fid);
+	fid_atomic_dec(fid);
 	if (IS_ERR(st))
 		return PTR_ERR(st);
 
@@ -1042,7 +1057,7 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
 
 static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 {
-	int retval;
+	int retval, use_dentry = 0;
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL;
 	struct p9_wstat wstat;
@@ -1058,11 +1073,12 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 		fid = iattr->ia_file->private_data;
 		WARN_ON(!fid);
 	}
-	if (!fid)
-		fid = v9fs_fid_lookup(dentry);
+	if (!fid) {
+		fid = v9fs_fid_lookup(dentry, 1);
+		use_dentry = 1;
+	}
 	if(IS_ERR(fid))
 		return PTR_ERR(fid);
-
 	v9fs_blank_wstat(&wstat);
 	if (iattr->ia_valid & ATTR_MODE)
 		wstat.mode = unixmode2p9mode(v9ses, iattr->ia_mode);
@@ -1089,6 +1105,8 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 		filemap_write_and_wait(d_inode(dentry)->i_mapping);
 
 	retval = p9_client_wstat(fid, &wstat);
+	if (use_dentry)
+		fid_atomic_dec(fid);
 	if (retval < 0)
 		return retval;
 
@@ -1203,7 +1221,7 @@ static const char *v9fs_vfs_get_link(struct dentry *dentry,
 		return ERR_PTR(-ECHILD);
 
 	v9ses = v9fs_dentry2v9ses(dentry);
-	fid = v9fs_fid_lookup(dentry);
+	fid = v9fs_fid_lookup(dentry, 0);
 	p9_debug(P9_DEBUG_VFS, "%pd\n", dentry);
 
 	if (IS_ERR(fid))
@@ -1303,7 +1321,7 @@ v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
 	p9_debug(P9_DEBUG_VFS, " %lu,%pd,%pd\n",
 		 dir->i_ino, dentry, old_dentry);
 
-	oldfid = v9fs_fid_clone(old_dentry);
+	oldfid = v9fs_fid_clone(old_dentry, 0);
 	if (IS_ERR(oldfid))
 		return PTR_ERR(oldfid);
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 08f2e089fb0e..be68db87ef61 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -296,6 +296,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 
 	/* instantiate inode and assign the unopened fid to the dentry */
 	fid = p9_client_walk(dfid, 1, &name, 1);
+	fid_atomic_dec(dfid);
 	if (IS_ERR(fid)) {
 		err = PTR_ERR(fid);
 		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
@@ -394,7 +395,6 @@ static int v9fs_vfs_mkdir_dotl(struct inode *dir,
 		dfid = NULL;
 		goto error;
 	}
-
 	gid = v9fs_get_fsgid_for_create(dir);
 	mode = omode;
 	/* Update mode based on ACL value */
@@ -452,6 +452,7 @@ static int v9fs_vfs_mkdir_dotl(struct inode *dir,
 	if (fid)
 		p9_client_clunk(fid);
 	v9fs_put_acl(dacl, pacl);
+	fid_atomic_dec(dfid);
 	return err;
 }
 
@@ -470,7 +471,7 @@ v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
 		generic_fillattr(d_inode(dentry), stat);
 		return 0;
 	}
-	fid = v9fs_fid_lookup(dentry);
+	fid = v9fs_fid_lookup(dentry, 1);
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
 
@@ -479,6 +480,7 @@ v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
 	 */
 
 	st = p9_client_getattr_dotl(fid, P9_STATS_ALL);
+	fid_atomic_dec(fid);
 	if (IS_ERR(st))
 		return PTR_ERR(st);
 
@@ -540,7 +542,7 @@ static int v9fs_mapped_iattr_valid(int iattr_valid)
 
 int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 {
-	int retval;
+	int retval, use_dentry = 0;
 	struct p9_fid *fid = NULL;
 	struct p9_iattr_dotl p9attr;
 	struct inode *inode = d_inode(dentry);
@@ -565,8 +567,10 @@ int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 		fid = iattr->ia_file->private_data;
 		WARN_ON(!fid);
 	}
-	if (!fid)
-		fid = v9fs_fid_lookup(dentry);
+	if (!fid) {
+		fid = v9fs_fid_lookup(dentry, 1);
+		use_dentry = 1;
+	}
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
 
@@ -575,8 +579,10 @@ int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 		filemap_write_and_wait(inode->i_mapping);
 
 	retval = p9_client_setattr(fid, &p9attr);
-	if (retval < 0)
+	if (retval < 0) {
+		fid_atomic_dec(fid);
 		return retval;
+	}
 
 	if ((iattr->ia_valid & ATTR_SIZE) &&
 	    iattr->ia_size != i_size_read(inode))
@@ -588,9 +594,13 @@ int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 	if (iattr->ia_valid & ATTR_MODE) {
 		/* We also want to update ACL when we update mode bits */
 		retval = v9fs_acl_chmod(inode, fid);
-		if (retval < 0)
+		if (retval < 0) {
+			fid_atomic_dec(fid);
 			return retval;
+		}
 	}
+	if (use_dentry)
+		fid_atomic_dec(fid);
 	return 0;
 }
 
@@ -741,7 +751,7 @@ v9fs_vfs_symlink_dotl(struct inode *dir, struct dentry *dentry,
 error:
 	if (fid)
 		p9_client_clunk(fid);
-
+	fid_atomic_dec(dfid);
 	return err;
 }
 
@@ -769,12 +779,15 @@ v9fs_vfs_link_dotl(struct dentry *old_dentry, struct inode *dir,
 	if (IS_ERR(dfid))
 		return PTR_ERR(dfid);
 
-	oldfid = v9fs_fid_lookup(old_dentry);
-	if (IS_ERR(oldfid))
+	oldfid = v9fs_fid_lookup(old_dentry, 0);
+	if (IS_ERR(oldfid)) {
+		fid_atomic_dec(dfid);
 		return PTR_ERR(oldfid);
+	}
 
 	err = p9_client_link(dfid, oldfid, dentry->d_name.name);
-
+	fid_atomic_dec(dfid);
+	fid_atomic_dec(oldfid);
 	if (err < 0) {
 		p9_debug(P9_DEBUG_VFS, "p9_client_link failed %d\n", err);
 		return err;
@@ -784,10 +797,9 @@ v9fs_vfs_link_dotl(struct dentry *old_dentry, struct inode *dir,
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
 		/* Get the latest stat info from server. */
 		struct p9_fid *fid;
-		fid = v9fs_fid_lookup(old_dentry);
+		fid = v9fs_fid_lookup(old_dentry, 0);
 		if (IS_ERR(fid))
 			return PTR_ERR(fid);
-
 		v9fs_refresh_inode_dotl(fid, d_inode(old_dentry));
 	}
 	ihold(d_inode(old_dentry));
@@ -830,7 +842,6 @@ v9fs_vfs_mknod_dotl(struct inode *dir, struct dentry *dentry, umode_t omode,
 		dfid = NULL;
 		goto error;
 	}
-
 	gid = v9fs_get_fsgid_for_create(dir);
 	mode = omode;
 	/* Update mode based on ACL value */
@@ -887,6 +898,7 @@ v9fs_vfs_mknod_dotl(struct inode *dir, struct dentry *dentry, umode_t omode,
 	if (fid)
 		p9_client_clunk(fid);
 	v9fs_put_acl(dacl, pacl);
+	fid_atomic_dec(dfid);
 	return err;
 }
 
@@ -911,10 +923,11 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
 
 	p9_debug(P9_DEBUG_VFS, "%pd\n", dentry);
 
-	fid = v9fs_fid_lookup(dentry);
+	fid = v9fs_fid_lookup(dentry, 0);
 	if (IS_ERR(fid))
 		return ERR_CAST(fid);
 	retval = p9_client_readlink(fid, &target);
+	fid_atomic_dec(fid);
 	if (retval)
 		return ERR_PTR(retval);
 	set_delayed_call(done, kfree_link, target);
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 74df32be4c6a..ef35d4f07c40 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -241,7 +241,7 @@ static int v9fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct p9_rstatfs rs;
 	int res;
 
-	fid = v9fs_fid_lookup(dentry);
+	fid = v9fs_fid_lookup(dentry, 1);
 	if (IS_ERR(fid)) {
 		res = PTR_ERR(fid);
 		goto done;
@@ -262,10 +262,13 @@ static int v9fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 			buf->f_fsid.val[1] = (rs.fsid >> 32) & 0xFFFFFFFFUL;
 			buf->f_namelen = rs.namelen;
 		}
-		if (res != -ENOSYS)
+		if (res != -ENOSYS) {
+			fid_atomic_dec(fid);
 			goto done;
+		}
 	}
 	res = simple_statfs(dentry, buf);
+	fid_atomic_dec(fid);
 done:
 	return res;
 }
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index ac8ff8ca4c11..f4e90a2dc975 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -71,14 +71,17 @@ ssize_t v9fs_xattr_get(struct dentry *dentry, const char *name,
 		       void *buffer, size_t buffer_size)
 {
 	struct p9_fid *fid;
+	int ret;
 
 	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu\n",
 		 name, buffer_size);
-	fid = v9fs_fid_lookup(dentry);
+	fid = v9fs_fid_lookup(dentry, 1);
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
+	ret = v9fs_fid_xattr_get(fid, name, buffer, buffer_size);
+	fid_atomic_dec(fid);
 
-	return v9fs_fid_xattr_get(fid, name, buffer, buffer_size);
+	return ret;
 }
 
 /*
@@ -96,8 +99,15 @@ ssize_t v9fs_xattr_get(struct dentry *dentry, const char *name,
 int v9fs_xattr_set(struct dentry *dentry, const char *name,
 		   const void *value, size_t value_len, int flags)
 {
-	struct p9_fid *fid = v9fs_fid_lookup(dentry);
-	return v9fs_fid_xattr_set(fid, name, value, value_len, flags);
+	int ret;
+	struct p9_fid *fid;
+
+	fid  = v9fs_fid_lookup(dentry, 1);
+	if (IS_ERR(fid))
+		return PTR_ERR(fid);
+	ret = v9fs_fid_xattr_set(fid, name, value, value_len, flags);
+	fid_atomic_dec(fid);
+	return ret;
 }
 
 int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index ce7882da8e86..831cb1a903b1 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -140,14 +140,21 @@ struct p9_client {
  *
  * TODO: This needs lots of explanation.
  */
+enum fid_source {
+	FID_FROM_OTHER,
+	FID_FROM_INODE,
+	FID_FROM_DENTRY,
+};
 
 struct p9_fid {
 	struct p9_client *clnt;
 	u32 fid;
+	atomic_t count;
 	int mode;
 	struct p9_qid qid;
 	u32 iounit;
 	kuid_t uid;
+	enum fid_source s;
 
 	void *rdir;
 
diff --git a/net/9p/client.c b/net/9p/client.c
index 1a3f72bf45fc..51f1277ba58d 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -901,6 +901,8 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 	fid->clnt = clnt;
 	fid->rdir = NULL;
 	fid->fid = 0;
+	fid->s = 0;
+	atomic_set(&fid->count, 0);
 
 	idr_preload(GFP_KERNEL);
 	spin_lock_irq(&clnt->lock);
-- 
2.17.1

