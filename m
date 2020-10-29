Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE80829E814
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgJ2J7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgJ2J6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:58:10 -0400
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73769C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:58:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id F0ECB2402AE;
        Thu, 29 Oct 2020 10:58:07 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.946
X-Spam-Level: 
X-Spam-Status: No, score=-2.946 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.046, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4SRVBTOXfBZv; Thu, 29 Oct 2020 10:58:05 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 7C96324029E;
        Thu, 29 Oct 2020 10:58:05 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v5 18/25] auxdisplay: Call charlcd_backlight in place
Date:   Thu, 29 Oct 2020 10:57:22 +0100
Message-Id: <20201029095731.311528-17-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029095731.311528-1-poeschel@lemonage.de>
References: <20201029095231.311083-1-poeschel@lemonage.de>
 <20201029095731.311528-1-poeschel@lemonage.de>
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

