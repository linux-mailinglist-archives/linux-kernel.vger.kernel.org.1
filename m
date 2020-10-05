Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A55283611
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgJENC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgJENBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:46 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73EEC0613BF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:01:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id B09B5240289;
        Mon,  5 Oct 2020 15:01:43 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.954
X-Spam-Level: 
X-Spam-Status: No, score=-2.954 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.054, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xQijLWZfYp4Y; Mon,  5 Oct 2020 15:01:42 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id DE5AF2402A4;
        Mon,  5 Oct 2020 15:01:41 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 25/32] auxdisplay: Call charlcd_backlight in place
Date:   Mon,  5 Oct 2020 15:01:21 +0200
Message-Id: <20201005130128.3430804-13-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005130128.3430804-1-poeschel@lemonage.de>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This moves the call to charlcd_backlight from the end of the switch
into the actual case statement that originates the change of the
backlight. This is more consistent to what is now found in this switch.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index dca1b138a239..0f0568a4bd35 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -259,10 +259,16 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		break;
 	case '+':	/* Back light ON */
 		priv->flags |= LCD_FLAG_L;
+		if (priv->flags != oldflags)
+			charlcd_backlight(lcd, CHARLCD_ON);
+
 		processed = 1;
 		break;
 	case '-':	/* Back light OFF */
 		priv->flags &= ~LCD_FLAG_L;
+		if (priv->flags != oldflags)
+			charlcd_backlight(lcd, CHARLCD_OFF);
+
 		processed = 1;
 		break;
 	case '*':	/* Flash back light */
@@ -363,14 +369,6 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		break;
 	}
 
-	/* TODO: This indent party here got ugly, clean it! */
-	/* Check whether one flag was changed */
-	if (oldflags == priv->flags)
-		return processed;
-
-	if ((oldflags ^ priv->flags) & LCD_FLAG_L)
-		charlcd_backlight(lcd, !!(priv->flags & LCD_FLAG_L));
-
 	return processed;
 }
 
-- 
2.28.0

