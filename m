Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D48269A01
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIOABH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:01:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62328 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgIOABF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:01:05 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 08F00XUQ002495;
        Tue, 15 Sep 2020 09:00:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Tue, 15 Sep 2020 09:00:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 08F00SmT002432
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Sep 2020 09:00:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 2/3] sticon: remove no-op sticon_set_origin()
Date:   Tue, 15 Sep 2020 09:00:18 +0900
Message-Id: <20200915000019.3422-2-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200915000019.3422-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200915000019.3422-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to call vc->vc_sw->con_set_origin() from set_origin()
if it is no-op.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/video/console/sticon.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 21a5c280c8c9..035a9733b3cc 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -217,11 +217,6 @@ static int sticon_switch(struct vc_data *conp)
     return 1;	/* needs refreshing */
 }
 
-static int sticon_set_origin(struct vc_data *conp)
-{
-    return 0;
-}
-
 static int sticon_blank(struct vc_data *c, int blank, int mode_switch)
 {
     if (blank == 0) {
@@ -229,7 +224,6 @@ static int sticon_blank(struct vc_data *c, int blank, int mode_switch)
 	    vga_is_gfx = 0;
 	return 1;
     }
-    sticon_set_origin(c);
     sti_clear(sticon_sti, 0,0, c->vc_rows, c->vc_cols, BLANK);
     if (mode_switch)
 	vga_is_gfx = 1;
@@ -334,7 +328,6 @@ static const struct consw sti_con = {
 	.con_scroll		= sticon_scroll,
 	.con_switch		= sticon_switch,
 	.con_blank		= sticon_blank,
-	.con_set_origin		= sticon_set_origin,
 	.con_save_screen	= sticon_save_screen, 
 	.con_build_attr		= sticon_build_attr,
 	.con_invert_region	= sticon_invert_region, 
-- 
2.25.1

