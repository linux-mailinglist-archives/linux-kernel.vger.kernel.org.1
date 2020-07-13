Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AE621B307
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 12:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGJKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 06:16:01 -0400
Received: from foss.arm.com ([217.140.110.172]:37054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgGJKQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:16:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1304A31B;
        Fri, 10 Jul 2020 03:16:00 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9F513F9AB;
        Fri, 10 Jul 2020 03:15:56 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Steve.Capper@arm.com,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com,
        wei.chen@arm.com
Subject: [PATCH v4] 9p: retrieve fid from file when file instance exist.
Date:   Fri, 10 Jul 2020 18:15:48 +0800
Message-Id: <20200710101548.10108-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current setattr implementation in 9p, fid is always retrieved
from dentry no matter file instance exists or not. If so, there may be
some info related to opened file instance dropped. So it's better
to retrieve fid from file instance when it is passed to setattr.

for example:
fd=open("tmp", O_RDWR);
ftruncate(fd, 10);

The file context related with the fd will be lost as fid is always
retrieved from dentry, then the backend can't get the info of
file context. It is against the original intention of user and
may lead to bug.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 fs/9p/vfs_inode.c      | 9 +++++++--
 fs/9p/vfs_inode_dotl.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index c9255d399917..cd004dee2214 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1090,7 +1090,7 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 {
 	int retval;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid;
+	struct p9_fid *fid = NULL;
 	struct p9_wstat wstat;
 
 	p9_debug(P9_DEBUG_VFS, "\n");
@@ -1100,7 +1100,12 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 
 	retval = -EPERM;
 	v9ses = v9fs_dentry2v9ses(dentry);
-	fid = v9fs_fid_lookup(dentry);
+	if (iattr->ia_valid & ATTR_FILE) {
+		fid = iattr->ia_file->private_data;
+		WARN_ON(!fid);
+	}
+	if (!fid)
+		fid = v9fs_fid_lookup(dentry);
 	if(IS_ERR(fid))
 		return PTR_ERR(fid);
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 60328b21c5fb..0028eccb665a 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -540,7 +540,7 @@ static int v9fs_mapped_iattr_valid(int iattr_valid)
 int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 {
 	int retval;
-	struct p9_fid *fid;
+	struct p9_fid *fid = NULL;
 	struct p9_iattr_dotl p9attr;
 	struct inode *inode = d_inode(dentry);
 
@@ -560,7 +560,12 @@ int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 	p9attr.mtime_sec = iattr->ia_mtime.tv_sec;
 	p9attr.mtime_nsec = iattr->ia_mtime.tv_nsec;
 
-	fid = v9fs_fid_lookup(dentry);
+	if (iattr->ia_valid & ATTR_FILE) {
+		fid = iattr->ia_file->private_data;
+		WARN_ON(!fid);
+	}
+	if (!fid)
+		fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
 
-- 
2.17.1

