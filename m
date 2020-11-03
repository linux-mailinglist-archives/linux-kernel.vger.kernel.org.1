Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA22A4103
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgKCJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgKCJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:56 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2B3C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 338D923F511;
        Tue,  3 Nov 2020 10:58:55 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.943
X-Spam-Level: 
X-Spam-Status: No, score=-2.943 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.043, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ud_mFIkgAJRr; Tue,  3 Nov 2020 10:58:52 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 91FE123FB28;
        Tue,  3 Nov 2020 10:58:52 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 13/25] auxdisplay: Make use of enum for backlight on / off
Date:   Tue,  3 Nov 2020 10:58:16 +0100
Message-Id: <20201103095828.515831-14-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
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

