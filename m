Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965752CAE40
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgLAVRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:17:52 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:12779 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgLAVRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:17:52 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2020 16:17:50 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606857239;
        s=strato-dkim-0002; d=democraticnet.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=q80JdNZwyYYJKMOzg9dsQCsXyvWPHb/55ZXSFd6hQeU=;
        b=AOWnvPQOFgCrpapM15C4Ypg1LaJg+G8ZfRXTmQPOgTWGBMHEynZ+S2oXd8DlQHrdnZ
        QkvVBJB8yUjkCp2J2sbAVEC1DCAgPtdSGF0POXO4N0vt4UKotG0hIMF1kC4nHXsq24CR
        5zMOrMH04eQ+AgROgPmnkWGPttVwPtgD4PmTYMTYexkwDFDZXQl/9lyigpP3XqUHOIFw
        Qujqyb66lqqL9APU5AzOMx2nSpl20DVZ5cjqKStcF6KBOo75U6QwHRsV0exaz/usf21i
        s7yBaM2N763RTCxN2ZEqO1gWq5S1TC2DkVfrQmonteO/gAvGfoMGyKHUPrJGFm+yR1qG
        vEOw==
X-RZG-AUTH: ":JWICemCsfvJRrHNHja8+ZutGesFIMaj90QtNvevV9ebGYZ5CqLBsbjOrqFSSSmR6Z6PNV/p6UZwP+3EdtfwIekk6icuFHP9U4Ql8vbtBm1bp"
X-RZG-CLASS-ID: mo00
Received: from joris.fritz.box
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id 90a3a0wB1L6155h
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 22:06:01 +0100 (CET)
From:   info@democraticnet.de
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joris Gutjahr <joris.gutjahr@protonmail.com>
Subject: [PATCH] Updating the documentation of struct file_system_type
Date:   Tue,  1 Dec 2020 22:05:51 +0100
Message-Id: <20201201210551.8306-1-info@democraticnet.de>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joris Gutjahr <joris.gutjahr@protonmail.com>

In the documentation of struct file_system_type,
using the definition of the struct of the kernel v5.10-rc6.

Signed-off-by: Joris Gutjahr <joris.gutjahr@protonmail.com>
---
 Documentation/filesystems/vfs.rst | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ca52c82e5bb5..364ef3dcb649 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -107,22 +107,30 @@ file /proc/filesystems.
 struct file_system_type
 -----------------------
 
-This describes the filesystem.  As of kernel 2.6.39, the following
-members are defined:
+This describes the filesystem.  As of kernel v5.10, the following
+members are defined: (compare: include/linux/fs.h)
 
 .. code-block:: c
 
-	struct file_system_operations {
+	struct file_system_type {
 		const char *name;
 		int fs_flags;
+        int (*init_fs_context)(struct fs_context*);
+        const struct fs_parameter_spec *parameters;
 		struct dentry *(*mount) (struct file_system_type *, int,
 					 const char *, void *);
 		void (*kill_sb) (struct super_block *);
 		struct module *owner;
 		struct file_system_type * next;
-		struct list_head fs_supers;
+		struct hlist_head fs_supers;
 		struct lock_class_key s_lock_key;
 		struct lock_class_key s_umount_key;
+        struct lock_class_key s_vfs_rename_key;
+        struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
+
+        struct lock_class_key i_lock_key;
+        struct lock_class_key i_mutex_key;
+        struct lock_class_key i_mutex_dir_key;
 	};
 
 ``name``
@@ -132,6 +140,12 @@ members are defined:
 ``fs_flags``
 	various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
 
+``init_fs_context``
+    TODO
+
+``fs_parameter_spec``
+    TODO
+
 ``mount``
 	the method to call when a new instance of this filesystem should
 	be mounted
@@ -148,7 +162,11 @@ members are defined:
 ``next``
 	for internal VFS use: you should initialize this to NULL
 
-  s_lock_key, s_umount_key: lockdep-specific
+``fs_supers``
+    TODO
+
+
+  s_lock_key, s_umount_key, s_vfs_rename_key, s_writers_key, i_lock_key, i_mutex_key, i_mutex_dir_key: lockdep-specific
 
 The mount() method has the following arguments:
 
-- 
2.17.1

