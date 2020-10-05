Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4A428360F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgJENCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgJENBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:47 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E9C0613B9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:01:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id BD1A223F802;
        Mon,  5 Oct 2020 15:01:45 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.953
X-Spam-Level: 
X-Spam-Status: No, score=-2.953 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.053, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8DFX1_id4zbZ; Mon,  5 Oct 2020 15:01:44 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 1656024029E;
        Mon,  5 Oct 2020 15:01:44 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 29/32] auxdisplay: Change gotoxy calling interface
Date:   Mon,  5 Oct 2020 15:01:25 +0200
Message-Id: <20201005130128.3430804-17-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005130128.3430804-1-poeschel@lemonage.de>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Change the calling interface for gotoxy from supplying the x and y
coordinates in the charlcd struct to explicitly supplying x and y in
the function arguments. This is more intuitive and allows for moving
the cursor to positions independent from the position saved in the
charlcd struct.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 10 +++++-----
 drivers/auxdisplay/charlcd.h        |  2 +-
 drivers/auxdisplay/hd44780_common.c | 15 ++++++---------
 drivers/auxdisplay/hd44780_common.h |  2 +-
 4 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 59f21401d6a9..ef10b5ca0e16 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -119,7 +119,7 @@ static void charlcd_print(struct charlcd *lcd, char c)
 
 	/* prevents the cursor from wrapping onto the next line */
 	if (lcd->addr.x == lcd->width)
-		lcd->ops->gotoxy(lcd);
+		lcd->ops->gotoxy(lcd, lcd->addr.x - 1, lcd->addr.y);
 }
 
 static void charlcd_clear_display(struct charlcd *lcd)
@@ -325,7 +325,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		/* restore cursor position */
 		lcd->addr.x = xs;
 		lcd->addr.y = ys;
-		lcd->ops->gotoxy(lcd);
+		lcd->ops->gotoxy(lcd, lcd->addr.x, lcd->addr.y);
 		processed = 1;
 		break;
 	}
@@ -349,7 +349,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 
 		/* If the command is valid, move to the new address */
 		if (parse_xy(esc, &lcd->addr.x, &lcd->addr.y))
-			lcd->ops->gotoxy(lcd);
+			lcd->ops->gotoxy(lcd, lcd->addr.x, lcd->addr.y);
 
 		/* Regardless of its validity, mark as processed */
 		processed = 1;
@@ -407,12 +407,12 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 
 			lcd->addr.x = 0;
 			lcd->addr.y = (lcd->addr.y + 1) % lcd->height;
-			lcd->ops->gotoxy(lcd);
+			lcd->ops->gotoxy(lcd, lcd->addr.x, lcd->addr.y);
 			break;
 		case '\r':
 			/* go to the beginning of the same line */
 			lcd->addr.x = 0;
-			lcd->ops->gotoxy(lcd);
+			lcd->ops->gotoxy(lcd, lcd->addr.x, lcd->addr.y);
 			break;
 		case '\t':
 			/* print a space instead of the tab */
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 024f7188b5cc..26f4ad178852 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -78,7 +78,7 @@ struct charlcd {
 struct charlcd_ops {
 	void (*backlight)(struct charlcd *lcd, enum charlcd_onoff on);
 	int (*print)(struct charlcd *lcd, int c);
-	int (*gotoxy)(struct charlcd *lcd);
+	int (*gotoxy)(struct charlcd *lcd, unsigned int x, unsigned int y);
 	int (*home)(struct charlcd *lcd);
 	int (*clear_display)(struct charlcd *lcd);
 	int (*init_display)(struct charlcd *lcd);
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index fbce8835a650..b949bbd8063a 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -49,7 +49,7 @@ int hd44780_common_print(struct charlcd *lcd, int c)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_print);
 
-int hd44780_common_gotoxy(struct charlcd *lcd)
+int hd44780_common_gotoxy(struct charlcd *lcd, unsigned int x, unsigned int y)
 {
 	struct hd44780_common *hdc = lcd->drvdata;
 	unsigned int addr;
@@ -58,11 +58,10 @@ int hd44780_common_gotoxy(struct charlcd *lcd)
 	 * we force the cursor to stay at the end of the
 	 * line if it wants to go farther
 	 */
-	addr = lcd->addr.x < hdc->bwidth ? lcd->addr.x & (hdc->hwidth - 1)
-					  : hdc->bwidth - 1;
-	if (lcd->addr.y & 1)
+	addr = x < hdc->bwidth ? x & (hdc->hwidth - 1) : hdc->bwidth - 1;
+	if (y & 1)
 		addr += hdc->hwidth;
-	if (lcd->addr.y & 2)
+	if (y & 2)
 		addr += hdc->bwidth;
 	hdc->write_cmd(hdc, LCD_CMD_SET_DDRAM_ADDR | addr);
 	return 0;
@@ -71,9 +70,7 @@ EXPORT_SYMBOL_GPL(hd44780_common_gotoxy);
 
 int hd44780_common_home(struct charlcd *lcd)
 {
-	lcd->addr.x = 0;
-	lcd->addr.y = 0;
-	return hd44780_common_gotoxy(lcd);
+	return hd44780_common_gotoxy(lcd, 0, 0);
 }
 EXPORT_SYMBOL_GPL(hd44780_common_home);
 
@@ -347,7 +344,7 @@ int hd44780_common_redefine_char(struct charlcd *lcd, char *esc)
 		hdc->write_data(hdc, cgbytes[addr]);
 
 	/* ensures that we stop writing to CGRAM */
-	lcd->ops->gotoxy(lcd);
+	lcd->ops->gotoxy(lcd, lcd->addr.x, lcd->addr.y);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(hd44780_common_redefine_char);
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index d3758230b7fd..7a7f316d15aa 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -16,7 +16,7 @@ struct hd44780_common {
 };
 
 int hd44780_common_print(struct charlcd *lcd, int c);
-int hd44780_common_gotoxy(struct charlcd *lcd);
+int hd44780_common_gotoxy(struct charlcd *lcd, unsigned int x, unsigned int y);
 int hd44780_common_home(struct charlcd *lcd);
 int hd44780_common_clear_display(struct charlcd *lcd);
 int hd44780_common_init_display(struct charlcd *lcd);
-- 
2.28.0

