Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B656A2A40F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgKCJ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgKCJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:59:02 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A68C061A47
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:59:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 5161423FCF2;
        Tue,  3 Nov 2020 10:59:00 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.941
X-Spam-Level: 
X-Spam-Status: No, score=-2.941 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.041, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kA2DW8Owidve; Tue,  3 Nov 2020 10:58:58 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 86FF623FF41;
        Tue,  3 Nov 2020 10:58:58 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 21/25] auxdisplay: charlcd: replace last device specific stuff
Date:   Tue,  3 Nov 2020 10:58:24 +0100
Message-Id: <20201103095828.515831-22-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

These are the last bits left in charlcd.c that are device specific and
they are removed now.
In detail this is:
* bwidth, which is the width of the display buffer per line. This is
  replaced by width of the display.
* hwidth, which is the size of the display buffer as a whole. This is
  replaced by looping all chars of a line by all lines.
* the hd44780_common header include can go away.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 077c01e87127..59f21401d6a9 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -20,7 +20,6 @@
 #include <generated/utsrelease.h>
 
 #include "charlcd.h"
-#include "hd44780_common.h"
 
 /* Keep the backlight on this many seconds for each flash */
 #define LCD_BL_TEMPO_PERIOD	4
@@ -112,8 +111,6 @@ static void charlcd_home(struct charlcd *lcd)
 
 static void charlcd_print(struct charlcd *lcd, char c)
 {
-	struct hd44780_common *hdc = lcd->drvdata;
-
 	if (lcd->char_conv)
 		c = lcd->char_conv[(unsigned char)c];
 
@@ -121,7 +118,7 @@ static void charlcd_print(struct charlcd *lcd, char c)
 		lcd->addr.x++;
 
 	/* prevents the cursor from wrapping onto the next line */
-	if (lcd->addr.x == hdc->bwidth)
+	if (lcd->addr.x == lcd->width)
 		lcd->ops->gotoxy(lcd);
 }
 
@@ -195,7 +192,6 @@ static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
 static inline int handle_lcd_special_code(struct charlcd *lcd)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-	struct hd44780_common *hdc = lcd->drvdata;
 
 	/* LCD special codes */
 
@@ -323,7 +319,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 
 		xs = lcd->addr.x;
 		ys = lcd->addr.y;
-		for (x = lcd->addr.x; x < hdc->bwidth; x++)
+		for (x = lcd->addr.x; x < lcd->width; x++)
 			lcd->ops->print(lcd, ' ');
 
 		/* restore cursor position */
@@ -366,7 +362,6 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 static void charlcd_write_char(struct charlcd *lcd, char c)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-	struct hd44780_common *hdc = lcd->drvdata;
 
 	/* first, we'll test if we're in escape mode */
 	if ((c != '\n') && priv->esc_seq.len >= 0) {
@@ -407,7 +402,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 			 * flush the remainder of the current line and
 			 * go to the beginning of the next line
 			 */
-			for (; lcd->addr.x < hdc->bwidth; lcd->addr.x++)
+			for (; lcd->addr.x < lcd->width; lcd->addr.x++)
 				lcd->ops->print(lcd, ' ');
 
 			lcd->addr.x = 0;
-- 
2.28.0

