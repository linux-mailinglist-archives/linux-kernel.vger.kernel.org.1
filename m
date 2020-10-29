Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43D29EAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgJ2LdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:33:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:57252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbgJ2Lc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0942CB225;
        Thu, 29 Oct 2020 11:32:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 14/17] vt: keyboard, union perm checks in vt_do_kdgkb_ioctl
Date:   Thu, 29 Oct 2020 12:32:19 +0100
Message-Id: <20201029113222.32640-14-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do the permission check on a single place. That is where perm is
really checked.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 648bdfb05e25..1de0d5217aed 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2040,9 +2040,6 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 	char *kbs;
 	int ret;
 
-	if (!capable(CAP_SYS_TTY_CONFIG))
-		perm = 0;
-
 	if (get_user(kb_func, &user_kdgkb->kb_func))
 		return -EFAULT;
 
@@ -2067,7 +2064,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		break;
 	}
 	case KDSKBSENT:
-		if (!perm)
+		if (!perm || !capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
 
 		kbs = strndup_user(user_kdgkb->kb_string,
-- 
2.29.1

