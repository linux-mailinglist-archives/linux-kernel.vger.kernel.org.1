Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9658027598B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgIWOME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:12:04 -0400
Received: from foss.arm.com ([217.140.110.172]:47064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:12:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AFFF11D4;
        Wed, 23 Sep 2020 07:12:03 -0700 (PDT)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 194043F73B;
        Wed, 23 Sep 2020 07:11:59 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        qemu_oss@crudebyte.com
Cc:     groug@kaod.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        jianyong.wu@arm.com, Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH v2 1/4] fs/9p: fix create-unlink-getattr idiom
Date:   Wed, 23 Sep 2020 22:11:43 +0800
Message-Id: <20200923141146.90046-2-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923141146.90046-1-jianyong.wu@arm.com>
References: <20200923141146.90046-1-jianyong.wu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Van Hensbergen <ericvh@gmail.com>

Fixes several outstanding bug reports of not being able to getattr from an
open file after an unlink.  This patch cleans up transient fids on an unlink
and will search open fids on a client if it detects a dentry that appears to
have been unlinked.  This search is necessary because fstat does not pass fd
information through the VFS API to the filesystem, only the dentry which for
9p has an imperfect match to fids.

Inherent in this patch is also a fix for the qid handling on create/open
which apparently wasn't being set correctly and was necessary for the search
to succeed.

A possible optimization over this fix is to include accounting of open fids
with the inode in the private data (in a similar fashion to the way we track
transient fids with dentries).  This would allow a much quicker search for
a matching open fid.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
(changed v9fs_fid_find_global to v9fs_fid_find_inode in comment)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>

---
 fs/9p/fid.c       | 30 ++++++++++++++++++++++++++++++
 fs/9p/vfs_inode.c |  4 ++++
 net/9p/client.c   |  5 ++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 3d681a2c2731..3304984c0fad 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -38,6 +38,33 @@ void v9fs_fid_add(struct dentry *dentry, struct p9_fid *fid)
 	spin_unlock(&dentry->d_lock);
 }
 
+/**
+ * v9fs_fid_find_inode - search for a fid off of the client list
+ * @inode: return a fid pointing to a specific inode
+ * @uid: return a fid belonging to the specified user
+ *
+ */
+
+static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
+{
+	struct p9_client *clnt = v9fs_inode2v9ses(inode)->clnt;
+	struct p9_fid *fid, *fidptr, *ret = NULL;
+	unsigned long flags;
+
+	p9_debug(P9_DEBUG_VFS, " inode: %p\n", inode);
+
+	spin_lock_irqsave(&clnt->lock, flags);
+	list_for_each_entry_safe(fid, fidptr, &clnt->fidlist, flist) {
+		if (uid_eq(fid->uid, uid) &&
+		   (inode->i_ino == v9fs_qid2ino(&fid->qid))) {
+			ret = fid;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&clnt->lock, flags);
+	return ret;
+}
+
 /**
  * v9fs_fid_find - retrieve a fid that belongs to the specified uid
  * @dentry: dentry to look for fid in
@@ -65,6 +92,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 			}
 		}
 		spin_unlock(&dentry->d_lock);
+	} else {
+		if (dentry->d_inode)
+			ret = v9fs_fid_find_inode(dentry->d_inode, uid);
 	}
 
 	return ret;
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index ae0c38ad1fcb..31c2fddabb82 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -570,6 +570,10 @@ static int v9fs_remove(struct inode *dir, struct dentry *dentry, int flags)
 
 		v9fs_invalidate_inode_attr(inode);
 		v9fs_invalidate_inode_attr(dir);
+
+		/* invalidate all fids associated with dentry */
+		/* NOTE: This will not include open fids */
+		dentry->d_op->d_release(dentry);
 	}
 	return retval;
 }
diff --git a/net/9p/client.c b/net/9p/client.c
index 09f1ec589b80..1a3f72bf45fc 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1219,7 +1219,7 @@ struct p9_fid *p9_client_walk(struct p9_fid *oldfid, uint16_t nwname,
 	if (nwname)
 		memmove(&fid->qid, &wqids[nwqids - 1], sizeof(struct p9_qid));
 	else
-		fid->qid = oldfid->qid;
+		memmove(&fid->qid, &oldfid->qid, sizeof(struct p9_qid));
 
 	kfree(wqids);
 	return fid;
@@ -1272,6 +1272,7 @@ int p9_client_open(struct p9_fid *fid, int mode)
 		p9_is_proto_dotl(clnt) ? "RLOPEN" : "ROPEN",  qid.type,
 		(unsigned long long)qid.path, qid.version, iounit);
 
+	memmove(&fid->qid, &qid, sizeof(struct p9_qid));
 	fid->mode = mode;
 	fid->iounit = iounit;
 
@@ -1317,6 +1318,7 @@ int p9_client_create_dotl(struct p9_fid *ofid, const char *name, u32 flags, u32
 			(unsigned long long)qid->path,
 			qid->version, iounit);
 
+	memmove(&ofid->qid, qid, sizeof(struct p9_qid));
 	ofid->mode = mode;
 	ofid->iounit = iounit;
 
@@ -1362,6 +1364,7 @@ int p9_client_fcreate(struct p9_fid *fid, const char *name, u32 perm, int mode,
 				(unsigned long long)qid.path,
 				qid.version, iounit);
 
+	memmove(&fid->qid, &qid, sizeof(struct p9_qid));
 	fid->mode = mode;
 	fid->iounit = iounit;
 
-- 
2.17.1

