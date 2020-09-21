Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB8D2728EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgIUOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgIUOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:48:13 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849A9C0613D8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:48:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 6A94D23F153;
        Mon, 21 Sep 2020 16:48:12 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.994
X-Spam-Level: 
X-Spam-Status: No, score=-2.994 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.094, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mW4g9Szo3Fb1; Mon, 21 Sep 2020 16:48:10 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id D25E623F1E5;
        Mon, 21 Sep 2020 16:48:09 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v2 29/32] auxdisplay: charlcd: replace last device specific stuff
Date:   Mon, 21 Sep 2020 16:46:41 +0200
Message-Id: <20200921144645.2061313-30-poeschel@lemonage.de>
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

These are the last bits left in charlcd.c that are device specific and
they are removed now.
In detail this is:
* bwidth, which is the width of the display buffer per line. This is
  replaced by width of the display.
* hwidth, which is the size of the display buffer as a whole. This is
  replaced by looping all chars of a line by all lines.
* the hd44780_common header include can go away.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 0137e741c5bb..78a61c3f1eb0 100644
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
 
@@ -199,7 +196,6 @@ static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
 static inline int handle_lcd_special_code(struct charlcd *lcd)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-	struct hd44780_common *hdc = lcd->drvdata;
 
 	/* LCD special codes */
 
@@ -327,7 +323,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 
 		xs = lcd->addr.x;
 		ys = lcd->addr.y;
-		for (x = lcd->addr.x; x < hdc->bwidth; x++)
+		for (x = lcd->addr.x; x < lcd->width; x++)
 			lcd->ops->print(lcd, ' ');
 
 		/* restore cursor position */
@@ -370,7 +366,6 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 static void charlcd_write_char(struct charlcd *lcd, char c)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-	struct hd44780_common *hdc = lcd->drvdata;
 
 	/* first, we'll test if we're in escape mode */
 	if ((c != '\n') && priv->esc_seq.len >= 0) {
@@ -411,7 +406,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 			 * flush the remainder of the current line and
 			 * go to the beginning of the next line
 			 */
-			for (; lcd->addr.x < hdc->bwidth; lcd->addr.x++)
+			for (; lcd->addr.x < lcd->width; lcd->addr.x++)
 				lcd->ops->print(lcd, ' ');
 
 			lcd->addr.x = 0;
-- 
2.28.0

