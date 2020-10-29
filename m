Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1B029EAB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgJ2Lde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:33:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:57126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgJ2Lc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51F79B212;
        Thu, 29 Oct 2020 11:32:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/17] vt: keyboard, union perm checks in vt_do_kdsk_ioctl
Date:   Thu, 29 Oct 2020 12:32:12 +0100
Message-Id: <20201029113222.32640-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do the permission check on a single place. That is where perm is really
checked.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c1709b8dbb52..823df9bb52b1 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2004,16 +2004,13 @@ int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
 	if (copy_from_user(&kbe, user_kbe, sizeof(struct kbentry)))
 		return -EFAULT;
 
-	if (!capable(CAP_SYS_TTY_CONFIG))
-		perm = 0;
-
 	switch (cmd) {
 	case KDGKBENT:
 		return put_user(vt_kdgkbent(kb->kbdmode, kbe.kb_index,
 					kbe.kb_table),
 				&user_kbe->kb_value);
 	case KDSKBENT:
-		if (!perm)
+		if (!perm || !capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
 		return vt_kdskbent(kb->kbdmode, kbe.kb_index, kbe.kb_table,
 				kbe.kb_value);
-- 
2.29.1

