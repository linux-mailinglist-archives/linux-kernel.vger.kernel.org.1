Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA3A2728F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgIUOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgIUOsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:48:11 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD612C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:48:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 927B123F122;
        Mon, 21 Sep 2020 16:48:09 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.997
X-Spam-Level: 
X-Spam-Status: No, score=-2.997 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.097, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b-sX9eMTKTHM; Mon, 21 Sep 2020 16:48:08 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 1F5AF23F160;
        Mon, 21 Sep 2020 16:48:08 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v2 25/32] auxdisplay: Call charlcd_backlight in place
Date:   Mon, 21 Sep 2020 16:46:37 +0200
Message-Id: <20200921144645.2061313-26-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921144645.2061313-1-poeschel@lemonage.de>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This moves the call to charlcd_backlight from the end of the switch
into the actual case statement that originates the change of the
backlight. This is more consistent to what is now found in this switch.

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

