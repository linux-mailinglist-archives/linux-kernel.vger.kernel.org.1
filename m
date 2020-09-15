Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1F2699FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgIOAAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:00:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62109 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgIOAAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:00:52 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 08F00X12002488;
        Tue, 15 Sep 2020 09:00:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Tue, 15 Sep 2020 09:00:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 08F00SmS002432
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Sep 2020 09:00:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 1/3] newport_con: remove no-op newport_set_origin()
Date:   Tue, 15 Sep 2020 09:00:17 +0900
Message-Id: <20200915000019.3422-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to call vc->vc_sw->con_set_origin() from set_origin()
if it is no-op.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/video/console/newport_con.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 72f146d047d9..3f22fb79fa24 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -676,11 +676,6 @@ static bool newport_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 	return true;
 }
 
-static int newport_set_origin(struct vc_data *vc)
-{
-	return 0;
-}
-
 static void newport_save_screen(struct vc_data *vc) { }
 
 const struct consw newport_con = {
@@ -697,7 +692,6 @@ const struct consw newport_con = {
 	.con_blank	  = newport_blank,
 	.con_font_set	  = newport_font_set,
 	.con_font_default = newport_font_default,
-	.con_set_origin	  = newport_set_origin,
 	.con_save_screen  = newport_save_screen
 };
 
-- 
2.25.1

