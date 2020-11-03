Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497842A4107
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgKCKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgKCJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:51 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFFDC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 1B5B423FA1F;
        Tue,  3 Nov 2020 10:58:50 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.944
X-Spam-Level: 
X-Spam-Status: No, score=-2.944 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.044, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HqWMh0NLHsgg; Tue,  3 Nov 2020 10:58:48 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 3D86123F2AD;
        Tue,  3 Nov 2020 10:58:48 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 07/25] auxdisplay: Move addr out of charlcd_priv
Date:   Tue,  3 Nov 2020 10:58:10 +0100
Message-Id: <20201103095828.515831-8-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Move out the struct addr from struct charlcd_priv into the less private
struct charlcd. This member is used to pass position information. The
individual drivers need to be able to read this information, so we move
this out of charlcd_priv to charlcd structure.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c | 61 +++++++++++++++---------------------
 drivers/auxdisplay/charlcd.h |  6 ++++
 2 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index ce6622f71c34..1b37d4bc38f9 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -72,12 +72,6 @@ struct charlcd_priv {
 	/* contains the LCD config state */
 	unsigned long int flags;
 
-	/* Contains the LCD X and Y offset */
-	struct {
-		unsigned long int x;
-		unsigned long int y;
-	} addr;
-
 	/* Current escape sequence and it's length or -1 if outside */
 	struct {
 		char buf[LCD_ESCAPE_LEN + 1];
@@ -148,7 +142,6 @@ EXPORT_SYMBOL_GPL(charlcd_poke);
 
 static void charlcd_gotoxy(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 	struct hd44780_common *hdc = lcd->drvdata;
 	unsigned int addr;
 
@@ -156,37 +149,34 @@ static void charlcd_gotoxy(struct charlcd *lcd)
 	 * we force the cursor to stay at the end of the
 	 * line if it wants to go farther
 	 */
-	addr = priv->addr.x < hdc->bwidth ? priv->addr.x & (hdc->hwidth - 1)
+	addr = lcd->addr.x < hdc->bwidth ? lcd->addr.x & (hdc->hwidth - 1)
 					  : hdc->bwidth - 1;
-	if (priv->addr.y & 1)
+	if (lcd->addr.y & 1)
 		addr += hdc->hwidth;
-	if (priv->addr.y & 2)
+	if (lcd->addr.y & 2)
 		addr += hdc->bwidth;
 	hdc->write_cmd(hdc, LCD_CMD_SET_DDRAM_ADDR | addr);
 }
 
 static void charlcd_home(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-
-	priv->addr.x = 0;
-	priv->addr.y = 0;
+	lcd->addr.x = 0;
+	lcd->addr.y = 0;
 	charlcd_gotoxy(lcd);
 }
 
 static void charlcd_print(struct charlcd *lcd, char c)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 	struct hd44780_common *hdc = lcd->drvdata;
 
-	if (priv->addr.x < hdc->bwidth) {
+	if (lcd->addr.x < hdc->bwidth) {
 		if (lcd->char_conv)
 			c = lcd->char_conv[(unsigned char)c];
 		hdc->write_data(hdc, c);
-		priv->addr.x++;
+		lcd->addr.x++;
 
 		/* prevents the cursor from wrapping onto the next line */
-		if (priv->addr.x == hdc->bwidth)
+		if (lcd->addr.x == hdc->bwidth)
 			charlcd_gotoxy(lcd);
 	}
 }
@@ -210,12 +200,11 @@ static void charlcd_clear_fast(struct charlcd *lcd)
 /* clears the display and resets X/Y */
 static void charlcd_clear_display(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 	struct hd44780_common *hdc = lcd->drvdata;
 
 	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
-	priv->addr.x = 0;
-	priv->addr.y = 0;
+	lcd->addr.x = 0;
+	lcd->addr.y = 0;
 	/* we must wait a few milliseconds (15) */
 	long_sleep(15);
 }
@@ -415,21 +404,21 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		processed = 1;
 		break;
 	case 'l':	/* Shift Cursor Left */
-		if (priv->addr.x > 0) {
+		if (lcd->addr.x > 0) {
 			/* back one char if not at end of line */
-			if (priv->addr.x < hdc->bwidth)
+			if (lcd->addr.x < hdc->bwidth)
 				hdc->write_cmd(hdc, LCD_CMD_SHIFT);
-			priv->addr.x--;
+			lcd->addr.x--;
 		}
 		processed = 1;
 		break;
 	case 'r':	/* shift cursor right */
-		if (priv->addr.x < lcd->width) {
+		if (lcd->addr.x < lcd->width) {
 			/* allow the cursor to pass the end of the line */
-			if (priv->addr.x < (hdc->bwidth - 1))
+			if (lcd->addr.x < (hdc->bwidth - 1))
 				hdc->write_cmd(hdc,
 					LCD_CMD_SHIFT | LCD_CMD_SHIFT_RIGHT);
-			priv->addr.x++;
+			lcd->addr.x++;
 		}
 		processed = 1;
 		break;
@@ -446,7 +435,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	case 'k': {	/* kill end of line */
 		int x;
 
-		for (x = priv->addr.x; x < hdc->bwidth; x++)
+		for (x = lcd->addr.x; x < hdc->bwidth; x++)
 			hdc->write_data(hdc, ' ');
 
 		/* restore cursor position */
@@ -519,7 +508,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 			break;
 
 		/* If the command is valid, move to the new address */
-		if (parse_xy(esc, &priv->addr.x, &priv->addr.y))
+		if (parse_xy(esc, &lcd->addr.x, &lcd->addr.y))
 			charlcd_gotoxy(lcd);
 
 		/* Regardless of its validity, mark as processed */
@@ -577,15 +566,15 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 			break;
 		case '\b':
 			/* go back one char and clear it */
-			if (priv->addr.x > 0) {
+			if (lcd->addr.x > 0) {
 				/*
 				 * check if we're not at the
 				 * end of the line
 				 */
-				if (priv->addr.x < hdc->bwidth)
+				if (lcd->addr.x < hdc->bwidth)
 					/* back one char */
 					hdc->write_cmd(hdc, LCD_CMD_SHIFT);
-				priv->addr.x--;
+				lcd->addr.x--;
 			}
 			/* replace with a space */
 			hdc->write_data(hdc, ' ');
@@ -601,15 +590,15 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 			 * flush the remainder of the current line and
 			 * go to the beginning of the next line
 			 */
-			for (; priv->addr.x < hdc->bwidth; priv->addr.x++)
+			for (; lcd->addr.x < hdc->bwidth; lcd->addr.x++)
 				hdc->write_data(hdc, ' ');
-			priv->addr.x = 0;
-			priv->addr.y = (priv->addr.y + 1) % lcd->height;
+			lcd->addr.x = 0;
+			lcd->addr.y = (lcd->addr.y + 1) % lcd->height;
 			charlcd_gotoxy(lcd);
 			break;
 		case '\r':
 			/* go to the beginning of the same line */
-			priv->addr.x = 0;
+			lcd->addr.x = 0;
 			charlcd_gotoxy(lcd);
 			break;
 		case '\t':
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index ad6fd2733523..ff4896af2189 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -21,6 +21,12 @@ struct charlcd {
 	int height;
 	int width;
 
+	/* Contains the LCD X and Y offset */
+	struct {
+		unsigned long x;
+		unsigned long y;
+	} addr;
+
 	void *drvdata;
 };
 
-- 
2.28.0

