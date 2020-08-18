Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD78924810B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 10:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHRI5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 04:57:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:37876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgHRI5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16796B02D;
        Tue, 18 Aug 2020 08:57:33 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/16] vc_screen: document and cleanup vcs_vc
Date:   Tue, 18 Aug 2020 10:56:54 +0200
Message-Id: <20200818085706.12163-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document parameters of vcs_vc and make viewed a bool.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 778f83ea2249..adc3c786b621 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -177,12 +177,14 @@ vcs_poll_data_get(struct file *file)
 	return poll;
 }
 
-/*
- * Returns VC for inode.
+/**
+ * vcs_vc -- return VC for @inode
+ * @inode: inode for which to return a VC
+ * @viewed: returns whether this console is currently foreground (viewed)
+ *
  * Must be called with console_lock.
  */
-static struct vc_data*
-vcs_vc(struct inode *inode, int *viewed)
+static struct vc_data *vcs_vc(struct inode *inode, bool *viewed)
 {
 	unsigned int currcons = console(inode);
 
@@ -191,11 +193,11 @@ vcs_vc(struct inode *inode, int *viewed)
 	if (currcons == 0) {
 		currcons = fg_console;
 		if (viewed)
-			*viewed = 1;
+			*viewed = true;
 	} else {
 		currcons--;
 		if (viewed)
-			*viewed = 0;
+			*viewed = false;
 	}
 	return vc_cons[currcons].d;
 }
@@ -247,10 +249,11 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	struct vc_data *vc;
 	struct vcs_poll_data *poll;
 	long pos, read;
-	int attr, uni_mode, row, col, maxcol, viewed;
+	int attr, uni_mode, row, col, maxcol;
 	unsigned short *org = NULL;
 	ssize_t ret;
 	char *con_buf;
+	bool viewed;
 
 	con_buf = (char *) __get_free_page(GFP_KERNEL);
 	if (!con_buf)
@@ -451,10 +454,11 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	long pos;
 	long attr, size, written;
 	char *con_buf0;
-	int col, maxcol, viewed;
+	int col, maxcol;
 	u16 *org0 = NULL, *org = NULL;
 	size_t ret;
 	char *con_buf;
+	bool viewed;
 
 	if (use_unicode(inode))
 		return -EOPNOTSUPP;
-- 
2.28.0

