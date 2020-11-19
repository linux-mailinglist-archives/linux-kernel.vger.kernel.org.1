Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE42B9769
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgKSQHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbgKSQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:07:20 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2800DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:07:20 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E42A7C01B; Thu, 19 Nov 2020 17:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1605802038; bh=eK6/Q/abk4MPm5E1E9fU+K69kfbIstGf/YUDyuJZEG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqbGoote7pDVzt+aCgVzGUEojP1xi9hk+JdvrMw6yr+451nTk80Nt+DnBs5e+IbC7
         r8FIRiCE/TJOPXgv7OSuzIW5GvKyFDFQe18RJpSKPXVLCbRuOXcMlEbAj0SLwUTdfM
         BS9tsAXx5puT04bx0YSfIBWn7MSwuX5XHZTIdyHPxmYi3d1VWXGjkKasFj9K5t96ge
         /LmKup1BqrOjKs7iv5XCCy8YLXC3Exly515Y+FpJvUpBpaXxZIlVyVacicOad/e+Xi
         7Lja1p76du44tIaL5wvbYX9N1aCaEJO/mDDRFm8mnrw3/hoOeKpD8TgEkAylAX5z5H
         muS8ALvu6vGUQ==
From:   Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jianyong Wu <jianyong.wu@arm.com>, lucho@ionkov.net,
        justin.he@arm.com, ericvh@gmail.com, qemu_oss@crudebyte.com,
        groug@kaod.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 2/2] 9p: Fix writeback fid incorrectly being attached to dentry
Date:   Thu, 19 Nov 2020 17:06:52 +0100
Message-Id: <1605802012-31133-3-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1605802012-31133-1-git-send-email-asmadeus@codewreck.org>
References: <20201103104116.GA19587@nautica>
 <1605802012-31133-1-git-send-email-asmadeus@codewreck.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9fs_dir_release needs fid->ilist to have been initialized for filp's
fid, not the inode's writeback fid's.

With refcounting this can be improved on later but this appears to fix
null deref issues.

Fixes: xxx ("fs/9p: track open fids")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
(note: fixes tag can't be filled here, will be corrected later)
 fs/9p/vfs_file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index b0ef225cecd0..c5e49c88688d 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -46,7 +46,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	int err;
 	struct v9fs_inode *v9inode;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid;
+	struct p9_fid *fid, *writeback_fid;
 	int omode;
 
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
@@ -85,13 +85,13 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		 * because we want write after unlink usecase
 		 * to work.
 		 */
-		fid = v9fs_writeback_fid(file_dentry(file));
+		writeback_fid = v9fs_writeback_fid(file_dentry(file));
 		if (IS_ERR(fid)) {
 			err = PTR_ERR(fid);
 			mutex_unlock(&v9inode->v_mutex);
 			goto out_error;
 		}
-		v9inode->writeback_fid = (void *) fid;
+		v9inode->writeback_fid = (void *) writeback_fid;
 	}
 	mutex_unlock(&v9inode->v_mutex);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
-- 
2.28.0

