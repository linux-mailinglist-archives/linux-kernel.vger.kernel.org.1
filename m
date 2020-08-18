Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0957248112
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHRI5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 04:57:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:37886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgHRI5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39376B02B;
        Tue, 18 Aug 2020 08:57:33 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/16] vc_screen: rewrite vcs_size to accept vc, not inode
Date:   Tue, 18 Aug 2020 10:56:55 +0200
Message-Id: <20200818085706.12163-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is weird to fetch the information from the inode over and over. Read
and write already have the needed information, so rewrite vcs_size to
accept a vc, attr and unicode and adapt vcs_lseek to that.

Also make sure all sites check the return value of vcs_size for errors.

And document it using kernel-doc.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 46 ++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index adc3c786b621..8aa0d50bcac7 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -202,39 +202,47 @@ static struct vc_data *vcs_vc(struct inode *inode, bool *viewed)
 	return vc_cons[currcons].d;
 }
 
-/*
- * Returns size for VC carried by inode.
+/**
+ * vcs_size -- return size for a VC in @vc
+ * @vc: which VC
+ * @attr: does it use attributes?
+ * @unicode: is it unicode?
+ *
  * Must be called with console_lock.
  */
-static int
-vcs_size(struct inode *inode)
+static int vcs_size(const struct vc_data *vc, bool attr, bool unicode)
 {
 	int size;
-	struct vc_data *vc;
 
 	WARN_CONSOLE_UNLOCKED();
 
-	vc = vcs_vc(inode, NULL);
-	if (!vc)
-		return -ENXIO;
-
 	size = vc->vc_rows * vc->vc_cols;
 
-	if (use_attributes(inode)) {
-		if (use_unicode(inode))
+	if (attr) {
+		if (unicode)
 			return -EOPNOTSUPP;
-		size = 2*size + HEADER_SIZE;
-	} else if (use_unicode(inode))
+
+		size = 2 * size + HEADER_SIZE;
+	} else if (unicode)
 		size *= 4;
+
 	return size;
 }
 
 static loff_t vcs_lseek(struct file *file, loff_t offset, int orig)
 {
+	struct inode *inode = file_inode(file);
+	struct vc_data *vc;
 	int size;
 
 	console_lock();
-	size = vcs_size(file_inode(file));
+	vc = vcs_vc(inode, NULL);
+	if (!vc) {
+		console_unlock();
+		return -ENXIO;
+	}
+
+	size = vcs_size(vc, use_attributes(inode), use_unicode(inode));
 	console_unlock();
 	if (size < 0)
 		return size;
@@ -295,7 +303,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 * as copy_to_user at the end of this loop
 		 * could sleep.
 		 */
-		size = vcs_size(inode);
+		size = vcs_size(vc, attr, uni_mode);
 		if (size < 0) {
 			if (read)
 				break;
@@ -480,7 +488,11 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (!vc)
 		goto unlock_out;
 
-	size = vcs_size(inode);
+	size = vcs_size(vc, attr, false);
+	if (size < 0) {
+		ret = size;
+		goto unlock_out;
+	}
 	ret = -EINVAL;
 	if (pos < 0 || pos > size)
 		goto unlock_out;
@@ -519,7 +531,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		 * the user buffer, so recheck.
 		 * Return data written up to now on failure.
 		 */
-		size = vcs_size(inode);
+		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)
 				break;
-- 
2.28.0

