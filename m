Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E890B2A40F9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgKCJ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgKCJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:58 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4CC061A47
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 9D02123F6C7;
        Tue,  3 Nov 2020 10:58:57 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.942
X-Spam-Level: 
X-Spam-Status: No, score=-2.942 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.042, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 99Xk1jCgERyF; Tue,  3 Nov 2020 10:58:56 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 1ECEA240215;
        Tue,  3 Nov 2020 10:58:56 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 18/25] auxdisplay: Call charlcd_backlight in place
Date:   Tue,  3 Nov 2020 10:58:21 +0100
Message-Id: <20201103095828.515831-19-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
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

