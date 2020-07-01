Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD2621021E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 04:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgGACid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 22:38:33 -0400
Received: from foss.arm.com ([217.140.110.172]:41908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgGACic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:38:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEDA731B;
        Tue, 30 Jun 2020 19:38:31 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.40.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4E723F73C;
        Tue, 30 Jun 2020 19:38:28 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Steve.Capper@arm.com,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com,
        wei.chen@arm.com
Subject: [PATCH v2] 9p: retrieve fid from file when file instance exist.
Date:   Wed,  1 Jul 2020 10:38:21 +0800
Message-Id: <20200701023821.5387-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current setattr implementation in 9p, fid is always retrieved
from dentry no matter file instance exists or not. There may be
some info related to opened file instance dropped. so it's better
to retrieve fid from file instance if file instance is passed to setattr.

for example:
fd=open("tmp", O_RDWR);
ftruncate(fd, 10);

The file context related with fd will be lost as fid is always
retrieved from dentry, then the backend can't get the info of
file context. It is against the original intention of user and
may lead to bug.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 fs/9p/vfs_inode.c      | 6 +++++-
 fs/9p/vfs_inode_dotl.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index c9255d399917..b33574d347fa 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1100,7 +1100,11 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 
 	retval = -EPERM;
 	v9ses = v9fs_dentry2v9ses(dentry);
-	fid = v9fs_fid_lookup(dentry);
+	if (iattr->ia_valid & ATTR_FILE) {
+		fid = iattr->ia_file->private_data;
+		WARN_ON(!fid);
+	} else
+		fid = v9fs_fid_lookup(dentry);
 	if(IS_ERR(fid))
 		return PTR_ERR(fid);
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 60328b21c5fb..ae714f1a630f 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -560,7 +560,11 @@ int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 	p9attr.mtime_sec = iattr->ia_mtime.tv_sec;
 	p9attr.mtime_nsec = iattr->ia_mtime.tv_nsec;
 
-	fid = v9fs_fid_lookup(dentry);
+	if (iattr->ia_valid & ATTR_FILE) {
+		fid = iattr->ia_file->private_data;
+		WARN_ON(!fid);
+	} else
+		fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
 
-- 
2.17.1

