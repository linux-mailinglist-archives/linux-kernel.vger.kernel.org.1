Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0FD1EC066
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 18:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgFBQtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 12:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:49:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834B6C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 09:49:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so4108704wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GoagIJL3Vw8sth9LuxPCBtODLWc2ATt5kjSVMu2uBe8=;
        b=sqP88Ltqe1/8g/7fTz1dKXjWcCmIKBH42ljaXnUdlTDaeBwaJgIckCkLWxs0Zv+v5W
         h+cuJZuBC8GQxdQVmG5vjIv3NsCyCcf2zqAPv1KZR6nyBUuV2aVYw1vi9bz4sJL9F8A6
         Tg3zr4l8PY56a2gTibITQwrJ8/0WwJWOk+orlQ7Y4aNxOYLomj1EJtC40lKLR3lySu0Y
         v3sn5mfjFM70YjVoiRDnWsqECP7B4S2SDzTusrXiAIqUdv0wuEyDvZPtrSilvusrop0g
         XnXLbs03CfinvZ5d6+8+3rrMj9TejwXnThQpS5d0Qy9HLXyy8v9fflTs2a8+ySztgV50
         8gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GoagIJL3Vw8sth9LuxPCBtODLWc2ATt5kjSVMu2uBe8=;
        b=geoKWLWVoBR5iZl1/jQca6oB17njrt+lOP3pL+upiqorSNGq6yXCAxFV3K79t2Ysvj
         pGTk60rPVXuYJhS+QT6FatbkkQqm3nItvS9VWqPUZptY2CU3t2C+AfMCaSKRQLZIGGmG
         jzqadiT1fBTsx7TizBBvHhhqNn1eQjIe/sWyYysAnkz+FzKUNrQfdB/PZqRg6hqJRIHI
         pw6vKQqgbuBYwKwRkKnj2VFCB6wNjYF2e4bsrQ05RmUrxZCFQsi6dCBo7TT4E1QWIg5K
         1crj56FwIYzIdWZHeJU5ZfTlIx6OhYPd86c4B7d0FSEGem+dpwN0Vw0TuFjUeZzW6fjf
         OkMA==
X-Gm-Message-State: AOAM530u4WElXZV9rbL6dSHpVx+yGny7Tj3Qvwpqaap8eRxaR7MjiXbe
        GW3zMg1us/9x6/J23282hZ0=
X-Google-Smtp-Source: ABdhPJwoAo3e9TwGBmORI1lr0SqGlX9yzw0XH8rkEUi4Zk8TBBcc/USuce7r2/iLXncZlZ9RKyb4TQ==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr25941781wrc.377.1591116584973;
        Tue, 02 Jun 2020 09:49:44 -0700 (PDT)
Received: from luca020400-arch.lan ([2001:b07:5d33:19f:e2b6:8927:31e7:d93f])
        by smtp.googlemail.com with ESMTPSA id l1sm5730829wrb.31.2020.06.02.09.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 09:49:44 -0700 (PDT)
From:   Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        freak07 <michalechner92@googlemail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: Fix ntfs_test_inode and ntfs_init_locked_inode function type
Date:   Tue,  2 Jun 2020 18:49:40 +0200
Message-Id: <20200602164940.855683-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200414150551.625799-1-luca.stefani.ge1@gmail.com>
References: <20200414150551.625799-1-luca.stefani.ge1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel is built with CFI we hit a __cfi_check_fail
while mounting a partition

Call trace:
__cfi_check_fail+0x1c/0x24
name_to_dev_t+0x0/0x404
iget5_locked+0x594/0x5e8
ntfs_fill_super+0xbfc/0x43ec
mount_bdev+0x30c/0x3cc
ntfs_mount+0x18/0x24
mount_fs+0x1b0/0x380
vfs_kern_mount+0x90/0x398
do_mount+0x5d8/0x1a10
SyS_mount+0x108/0x144
el0_svc_naked+0x34/0x38

Fixing iget5_locked and ilookup5 callers seems enough

Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Tested-by: freak07 <michalechner92@googlemail.com>
---
 fs/ntfs/dir.c   |  2 +-
 fs/ntfs/inode.c | 23 ++++++++++++-----------
 fs/ntfs/inode.h |  4 +---
 fs/ntfs/mft.c   |  5 ++---
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 3c4811469ae8..e278bfc5ee7f 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1503,7 +1503,7 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 	na.type = AT_BITMAP;
 	na.name = I30;
 	na.name_len = 4;
-	bmp_vi = ilookup5(vi->i_sb, vi->i_ino, (test_t)ntfs_test_inode, &na);
+	bmp_vi = ilookup5(vi->i_sb, vi->i_ino, ntfs_test_inode, &na);
 	if (bmp_vi) {
  		write_inode_now(bmp_vi, !datasync);
 		iput(bmp_vi);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index d4359a1df3d5..34c919bc0dfe 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -30,7 +30,7 @@
 /**
  * ntfs_test_inode - compare two (possibly fake) inodes for equality
  * @vi:		vfs inode which to test
- * @na:		ntfs attribute which is being tested with
+ * @data:		data which is being tested with
  *
  * Compare the ntfs attribute embedded in the ntfs specific part of the vfs
  * inode @vi for equality with the ntfs attribute @na.
@@ -43,8 +43,9 @@
  * NOTE: This function runs with the inode_hash_lock spin lock held so it is not
  * allowed to sleep.
  */
-int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
+int ntfs_test_inode(struct inode *vi, void *data)
 {
+	ntfs_attr *na = data;
 	ntfs_inode *ni;
 
 	if (vi->i_ino != na->mft_no)
@@ -72,7 +73,7 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
 /**
  * ntfs_init_locked_inode - initialize an inode
  * @vi:		vfs inode to initialize
- * @na:		ntfs attribute which to initialize @vi to
+ * @data:		data which to initialize @vi to
  *
  * Initialize the vfs inode @vi with the values from the ntfs attribute @na in
  * order to enable ntfs_test_inode() to do its work.
@@ -87,8 +88,9 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
  * NOTE: This function runs with the inode->i_lock spin lock held so it is not
  * allowed to sleep. (Hence the GFP_ATOMIC allocation.)
  */
-static int ntfs_init_locked_inode(struct inode *vi, ntfs_attr *na)
+static int ntfs_init_locked_inode(struct inode *vi, void *data)
 {
+	ntfs_attr *na = data;
 	ntfs_inode *ni = NTFS_I(vi);
 
 	vi->i_ino = na->mft_no;
@@ -131,7 +133,6 @@ static int ntfs_init_locked_inode(struct inode *vi, ntfs_attr *na)
 	return 0;
 }
 
-typedef int (*set_t)(struct inode *, void *);
 static int ntfs_read_locked_inode(struct inode *vi);
 static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi);
 static int ntfs_read_locked_index_inode(struct inode *base_vi,
@@ -164,8 +165,8 @@ struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no)
 	na.name = NULL;
 	na.name_len = 0;
 
-	vi = iget5_locked(sb, mft_no, (test_t)ntfs_test_inode,
-			(set_t)ntfs_init_locked_inode, &na);
+	vi = iget5_locked(sb, mft_no, ntfs_test_inode,
+			ntfs_init_locked_inode, &na);
 	if (unlikely(!vi))
 		return ERR_PTR(-ENOMEM);
 
@@ -225,8 +226,8 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
 	na.name = name;
 	na.name_len = name_len;
 
-	vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
-			(set_t)ntfs_init_locked_inode, &na);
+	vi = iget5_locked(base_vi->i_sb, na.mft_no, ntfs_test_inode,
+			ntfs_init_locked_inode, &na);
 	if (unlikely(!vi))
 		return ERR_PTR(-ENOMEM);
 
@@ -280,8 +281,8 @@ struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
 	na.name = name;
 	na.name_len = name_len;
 
-	vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
-			(set_t)ntfs_init_locked_inode, &na);
+	vi = iget5_locked(base_vi->i_sb, na.mft_no, ntfs_test_inode,
+			ntfs_init_locked_inode, &na);
 	if (unlikely(!vi))
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index 98e670fbdd31..363e4e820673 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -253,9 +253,7 @@ typedef struct {
 	ATTR_TYPE type;
 } ntfs_attr;
 
-typedef int (*test_t)(struct inode *, void *);
-
-extern int ntfs_test_inode(struct inode *vi, ntfs_attr *na);
+extern int ntfs_test_inode(struct inode *vi, void *data);
 
 extern struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no);
 extern struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 3aac5c917afe..1f1dbf4c41b5 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -958,7 +958,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 		 * dirty code path of the inode dirty code path when writing
 		 * $MFT occurs.
 		 */
-		vi = ilookup5_nowait(sb, mft_no, (test_t)ntfs_test_inode, &na);
+		vi = ilookup5_nowait(sb, mft_no, ntfs_test_inode, &na);
 	}
 	if (vi) {
 		ntfs_debug("Base inode 0x%lx is in icache.", mft_no);
@@ -1019,8 +1019,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 		vi = igrab(mft_vi);
 		BUG_ON(vi != mft_vi);
 	} else
-		vi = ilookup5_nowait(sb, na.mft_no, (test_t)ntfs_test_inode,
-				&na);
+		vi = ilookup5_nowait(sb, na.mft_no, ntfs_test_inode, &na);
 	if (!vi) {
 		/*
 		 * The base inode is not in icache, write this extent mft
-- 
2.27.0

