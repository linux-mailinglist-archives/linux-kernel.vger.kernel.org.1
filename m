Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF2A27598D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgIWOMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:12:13 -0400
Received: from foss.arm.com ([217.140.110.172]:47104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:12:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 798ED1396;
        Wed, 23 Sep 2020 07:12:10 -0700 (PDT)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 892233F73B;
        Wed, 23 Sep 2020 07:12:07 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        qemu_oss@crudebyte.com
Cc:     groug@kaod.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        jianyong.wu@arm.com
Subject: [PATCH v2 3/4] fs/9p: search open fids first
Date:   Wed, 23 Sep 2020 22:11:45 +0800
Message-Id: <20200923141146.90046-4-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923141146.90046-1-jianyong.wu@arm.com>
References: <20200923141146.90046-1-jianyong.wu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kurz <groug@kaod.org>

A previous patch fixed the "create-unlink-getattr" idiom: if getattr is
called on an unlinked file, we try to find an open fid attached to the
corresponding inode.

We have a similar issue with file permissions and setattr:

open("./test.txt", O_RDWR|O_CREAT, 0666) = 4
chmod("./test.txt", 0)                  = 0
truncate("./test.txt", 0)               = -1 EACCES (Permission denied)
ftruncate(4, 0)                         = -1 EACCES (Permission denied)

The failure is expected with truncate() but not with ftruncate().

This happens because the lookup code does find a matching fid in the
dentry list. Unfortunately, this is not an open fid and the server
will be forced to rely on the path name, rather than on an open file
descriptor. This is the case in QEMU: the setattr operation will use
truncate() and fail because of bad write permissions.

This patch changes the logic in the lookup code, so that we consider
open fids first. It gives a chance to the server to match this open
fid to an open file descriptor and use ftruncate() instead of truncate().
This does not change the current behaviour for truncate() and other
path name based syscalls, since file permissions are checked earlier
in the VFS layer.

With this patch, we get:

open("./test.txt", O_RDWR|O_CREAT, 0666) = 4
chmod("./test.txt", 0)                  = 0
truncate("./test.txt", 0)               = -1 EACCES (Permission denied)
ftruncate(4, 0)                         = 0

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 fs/9p/fid.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index d11dd430590d..0b23b0fe6c51 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -95,8 +95,12 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 		 dentry, dentry, from_kuid(&init_user_ns, uid),
 		 any);
 	ret = NULL;
+
+	if (d_inode(dentry))
+		ret = v9fs_fid_find_inode(d_inode(dentry), uid);
+
 	/* we'll recheck under lock if there's anything to look in */
-	if (dentry->d_fsdata) {
+	if (!ret && dentry->d_fsdata) {
 		struct hlist_head *h = (struct hlist_head *)&dentry->d_fsdata;
 		spin_lock(&dentry->d_lock);
 		hlist_for_each_entry(fid, h, dlist) {
@@ -106,9 +110,6 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 			}
 		}
 		spin_unlock(&dentry->d_lock);
-	} else {
-		if (dentry->d_inode)
-			ret = v9fs_fid_find_inode(dentry->d_inode, uid);
 	}
 
 	return ret;
-- 
2.17.1

