Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C6429700A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464363AbgJWNKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372613AbgJWNKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:10:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B73207FF;
        Fri, 23 Oct 2020 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603458605;
        bh=EAEuMz7S+DWhpBKwI5zz9PLNyfTyZDr9VDSIr05anXA=;
        h=From:To:Cc:Subject:Date:From;
        b=PRY6054g5Xkp2C+GcpAjSGy/HTTSuQ32WgPdecY4kYq5K66eBTir5iekis4+awULo
         eh9AhqywPBGbJyqubFLQPOnoYa9XcUYJd6LrSAaIcA1QTLGfaGeaA12hdOKUG++432
         uQSDx3LfiXx5w95MOp/0updUBuPUuQ1mPl4SxRWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] debugfs: remove return value of debugfs_create_devm_seqfile()
Date:   Fri, 23 Oct 2020 15:10:37 +0200
Message-Id: <20201023131037.2500765-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_devm_seqfile(), as it's
not needed, so make the return value void, so that no one tries to do so
in the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.rst |  2 +-
 fs/debugfs/file.c                     | 15 +++++++--------
 include/linux/debugfs.h               | 18 ++++++++----------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
index 728ab57a611a..0f2292e367e6 100644
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -199,7 +199,7 @@ of its elements. Note: Once array is created its size can not be changed.
 
 There is a helper function to create device related seq_file::
 
-   struct dentry *debugfs_create_devm_seqfile(struct device *dev,
+   void debugfs_create_devm_seqfile(struct device *dev,
 				const char *name,
 				struct dentry *parent,
 				int (*read_fn)(struct seq_file *s,
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index a768a09430c3..686e0ad28788 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1127,24 +1127,23 @@ static const struct file_operations debugfs_devm_entry_ops = {
  *	file will be created in the root of the debugfs filesystem.
  * @read_fn: function pointer called to print the seq_file content.
  */
-struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
-					   struct dentry *parent,
-					   int (*read_fn)(struct seq_file *s,
-							  void *data))
+void debugfs_create_devm_seqfile(struct device *dev, const char *name,
+				 struct dentry *parent,
+				 int (*read_fn)(struct seq_file *s, void *data))
 {
 	struct debugfs_devm_entry *entry;
 
 	if (IS_ERR(parent))
-		return ERR_PTR(-ENOENT);
+		return;
 
 	entry = devm_kzalloc(dev, sizeof(*entry), GFP_KERNEL);
 	if (!entry)
-		return ERR_PTR(-ENOMEM);
+		return;
 
 	entry->read = read_fn;
 	entry->dev = dev;
 
-	return debugfs_create_file(name, S_IRUGO, parent, entry,
-				   &debugfs_devm_entry_ops);
+	debugfs_create_file(name, S_IRUGO, parent, entry,
+			    &debugfs_devm_entry_ops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_devm_seqfile);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 851dd1f9a8a5..d6c4cc9ecc77 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -144,10 +144,9 @@ void debugfs_create_u32_array(const char *name, umode_t mode,
 			      struct dentry *parent,
 			      struct debugfs_u32_array *array);
 
-struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
-					   struct dentry *parent,
-					   int (*read_fn)(struct seq_file *s,
-							  void *data));
+void debugfs_create_devm_seqfile(struct device *dev, const char *name,
+				 struct dentry *parent,
+				 int (*read_fn)(struct seq_file *s, void *data));
 
 bool debugfs_initialized(void);
 
@@ -327,13 +326,12 @@ static inline void debugfs_create_u32_array(const char *name, umode_t mode,
 {
 }
 
-static inline struct dentry *debugfs_create_devm_seqfile(struct device *dev,
-							 const char *name,
-							 struct dentry *parent,
-					   int (*read_fn)(struct seq_file *s,
-							  void *data))
+static inline void debugfs_create_devm_seqfile(struct device *dev,
+					       const char *name,
+					       struct dentry *parent,
+					       int (*read_fn)(struct seq_file *s,
+							      void *data))
 {
-	return ERR_PTR(-ENODEV);
 }
 
 static inline ssize_t debugfs_read_file_bool(struct file *file,
-- 
2.29.0

