Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8E428358E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgJEMOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgJEMMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:12:31 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B61C0613B0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:12:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 11B5723FD2C;
        Mon,  5 Oct 2020 14:12:27 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.989
X-Spam-Level: 
X-Spam-Status: No, score=-2.989 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.089, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lButTQ8Cprdw; Mon,  5 Oct 2020 14:12:26 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id 0795123F789;
        Mon,  5 Oct 2020 14:12:25 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v3 13/32] auxdisplay: Make use of enum for backlight on / off
Date:   Mon,  5 Oct 2020 14:11:41 +0200
Message-Id: <20201005121200.3427363-14-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005121200.3427363-1-poeschel@lemonage.de>
References: <20201005121200.3427363-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

To turn the backlight on or off use our new enum CHARLCD_ON /
CHARLCD_OFF.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 154419513186..9631f70e8128 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -115,7 +115,7 @@ static void charlcd_bl_off(struct work_struct *work)
 	if (priv->bl_tempo) {
 		priv->bl_tempo = false;
 		if (!(priv->flags & LCD_FLAG_L))
-			priv->lcd.ops->backlight(&priv->lcd, 0);
+			priv->lcd.ops->backlight(&priv->lcd, CHARLCD_OFF);
 	}
 	mutex_unlock(&priv->bl_tempo_lock);
 }
@@ -132,7 +132,7 @@ void charlcd_poke(struct charlcd *lcd)
 
 	mutex_lock(&priv->bl_tempo_lock);
 	if (!priv->bl_tempo && !(priv->flags & LCD_FLAG_L))
-		lcd->ops->backlight(lcd, 1);
+		lcd->ops->backlight(lcd, CHARLCD_ON);
 	priv->bl_tempo = true;
 	schedule_delayed_work(&priv->bl_work, LCD_BL_TEMPO_PERIOD * HZ);
 	mutex_unlock(&priv->bl_tempo_lock);
@@ -829,7 +829,7 @@ int charlcd_unregister(struct charlcd *lcd)
 	the_charlcd = NULL;
 	if (lcd->ops->backlight) {
 		cancel_delayed_work_sync(&priv->bl_work);
-		priv->lcd.ops->backlight(&priv->lcd, 0);
+		priv->lcd.ops->backlight(&priv->lcd, CHARLCD_OFF);
 	}
 
 	return 0;
-- 
2.28.0

