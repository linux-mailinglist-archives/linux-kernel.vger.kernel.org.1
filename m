Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB051F9067
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgFOHto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 03:49:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:40056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgFOHtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A0CECB0BE;
        Mon, 15 Jun 2020 07:49:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 36/38] vt_ioctl: move vt_io_fontreset out of vt_io_ioctl
Date:   Mon, 15 Jun 2020 09:49:08 +0200
Message-Id: <20200615074910.19267-36-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This also eliminates the ifdeffery by using if and __is_defined.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 44 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index f671e94a94a9..ecf96f5e616d 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -518,6 +518,31 @@ static inline int do_fontx_ioctl(int cmd,
 	return -EINVAL;
 }
 
+static int vt_io_fontreset(struct console_font_op *op)
+{
+	int ret;
+
+	if (__is_defined(BROKEN_GRAPHICS_PROGRAMS)) {
+		/*
+		 * With BROKEN_GRAPHICS_PROGRAMS defined, the default font is
+		 * not saved.
+		 */
+		return -ENOSYS;
+	}
+
+	op->op = KD_FONT_OP_SET_DEFAULT;
+	op->data = NULL;
+	ret = con_font_op(vc_cons[fg_console].d, op);
+	if (ret)
+		return ret;
+
+	console_lock();
+	con_set_default_unimap(vc_cons[fg_console].d);
+	console_unlock();
+
+	return 0;
+}
+
 static inline int do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud,
 		int perm, struct vc_data *vc)
 {
@@ -581,24 +606,7 @@ static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
 		if (!perm)
 			return -EPERM;
 
-#ifdef BROKEN_GRAPHICS_PROGRAMS
-		/* With BROKEN_GRAPHICS_PROGRAMS defined, the default
-		   font is not saved. */
-		return -ENOSYS;
-#else
-		{
-		int ret;
-		op.op = KD_FONT_OP_SET_DEFAULT;
-		op.data = NULL;
-		ret = con_font_op(vc_cons[fg_console].d, &op);
-		if (ret)
-			return ret;
-		console_lock();
-		con_set_default_unimap(vc_cons[fg_console].d);
-		console_unlock();
-		break;
-		}
-#endif
+		return vt_io_fontreset(&op);
 
 	case PIO_SCRNMAP:
 		if (!perm)
-- 
2.27.0

