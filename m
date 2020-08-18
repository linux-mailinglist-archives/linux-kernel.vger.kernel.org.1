Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C541B24812A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgHRI6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 04:58:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:37988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgHRI5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14519B03B;
        Tue, 18 Aug 2020 08:57:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/16] vs_screen: kill tmp_count from vcs_read
Date:   Tue, 18 Aug 2020 10:57:01 +0200
Message-Id: <20200818085706.12163-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both tmp_count computations and the single use can be eliminated using
min(). Do so.

Side note: we need HEADER_SIZE to be unsigned for min() not to complain.
Fix that too as all its other uses do not mind.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index c62c590ed816..8ebb6724a804 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -53,7 +53,7 @@
 #undef attr
 #undef org
 #undef addr
-#define HEADER_SIZE	4
+#define HEADER_SIZE	4u
 
 #define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
 
@@ -361,8 +361,6 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			}
 		} else {
 			if (p < HEADER_SIZE) {
-				unsigned int tmp_count;
-
 				/* clamp header values if they don't fit */
 				con_buf0[0] = min(vc->vc_rows, 0xFFu);
 				con_buf0[1] = min(vc->vc_cols, 0xFFu);
@@ -375,12 +373,8 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 					orig_count = this_round - p;
 				}
 
-				tmp_count = HEADER_SIZE;
-				if (tmp_count > this_round)
-					tmp_count = this_round;
-
 				/* Advance state pointers and move on. */
-				this_round -= tmp_count;
+				this_round -= min(HEADER_SIZE, this_round);
 				p = HEADER_SIZE;
 				con_buf0 = con_buf + HEADER_SIZE;
 				/* If this_round >= 0, then p is even... */
-- 
2.28.0

