Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47E2728D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgIUOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgIUOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:47:59 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BD5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:47:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 9C24023F02F;
        Mon, 21 Sep 2020 16:47:57 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.007
X-Spam-Level: 
X-Spam-Status: No, score=-3.007 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.107, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SSONkQh7ppLa; Mon, 21 Sep 2020 16:47:56 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 2F69123F029;
        Mon, 21 Sep 2020 16:47:56 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v2 08/32] auxdisplay: hd44780_common_print
Date:   Mon, 21 Sep 2020 16:46:20 +0200
Message-Id: <20200921144645.2061313-9-poeschel@lemonage.de>
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

We create a hd44780_common_print function. It is derived from the
original charlcd_print. charlcd_print becomes a device independent print
function, that then only calles via it's ops function pointers, into the
print function offered by drivers.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 28 +++++++++++++++-------------
 drivers/auxdisplay/charlcd.h        | 11 +++++++++++
 drivers/auxdisplay/hd44780.c        |  2 ++
 drivers/auxdisplay/hd44780_common.c | 13 +++++++++++++
 drivers/auxdisplay/hd44780_common.h |  1 +
 5 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 1b37d4bc38f9..72ed004a8980 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -167,18 +167,15 @@ static void charlcd_home(struct charlcd *lcd)
 
 static void charlcd_print(struct charlcd *lcd, char c)
 {
-	struct hd44780_common *hdc = lcd->drvdata;
+	if (lcd->char_conv)
+		c = lcd->char_conv[(unsigned char)c];
 
-	if (lcd->addr.x < hdc->bwidth) {
-		if (lcd->char_conv)
-			c = lcd->char_conv[(unsigned char)c];
-		hdc->write_data(hdc, c);
+	if (!lcd->ops->print(lcd, c))
 		lcd->addr.x++;
 
-		/* prevents the cursor from wrapping onto the next line */
-		if (lcd->addr.x == hdc->bwidth)
-			charlcd_gotoxy(lcd);
-	}
+	/* prevents the cursor from wrapping onto the next line */
+	if (lcd->addr.x == lcd->width)
+		charlcd_gotoxy(lcd);
 }
 
 static void charlcd_clear_fast(struct charlcd *lcd)
@@ -192,7 +189,7 @@ static void charlcd_clear_fast(struct charlcd *lcd)
 		lcd->ops->clear_fast(lcd);
 	else
 		for (pos = 0; pos < min(2, lcd->height) * hdc->hwidth; pos++)
-			hdc->write_data(hdc, ' ');
+			lcd->ops->print(lcd, ' ');
 
 	charlcd_home(lcd);
 }
@@ -433,12 +430,16 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		processed = 1;
 		break;
 	case 'k': {	/* kill end of line */
-		int x;
+		int x, xs, ys;
 
+		xs = lcd->addr.x;
+		ys = lcd->addr.y;
 		for (x = lcd->addr.x; x < hdc->bwidth; x++)
-			hdc->write_data(hdc, ' ');
+			lcd->ops->print(lcd, ' ');
 
 		/* restore cursor position */
+		lcd->addr.x = xs;
+		lcd->addr.y = ys;
 		charlcd_gotoxy(lcd);
 		processed = 1;
 		break;
@@ -591,7 +592,8 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 			 * go to the beginning of the next line
 			 */
 			for (; lcd->addr.x < hdc->bwidth; lcd->addr.x++)
-				hdc->write_data(hdc, ' ');
+				lcd->ops->print(lcd, ' ');
+
 			lcd->addr.x = 0;
 			lcd->addr.y = (lcd->addr.y + 1) % lcd->height;
 			charlcd_gotoxy(lcd);
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index ff4896af2189..874519f079b4 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -30,9 +30,20 @@ struct charlcd {
 	void *drvdata;
 };
 
+/**
+ * struct charlcd_ops - Functions used by charlcd. Drivers have to implement
+ * these.
+ * @clear_fast: Clear the whole display and set cursor to position 0, 0.
+ * @backlight: Turn backlight on or off. Optional.
+ * @print: just Print one character to the display at current cursor position.
+ * The cursor is advanced by charlcd.
+ * The buffered cursor position is advanced by charlcd. The cursor should not
+ * wrap to the next line at the end of a line.
+ */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
 	void (*backlight)(struct charlcd *lcd, enum charlcd_onoff on);
+	int (*print)(struct charlcd *lcd, int c);
 };
 
 struct charlcd *charlcd_alloc(void);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index dc4738563298..9680bb611639 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -126,6 +126,7 @@ static void hd44780_write_data_gpio8(struct hd44780_common *hdc, int data)
 
 static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.backlight	= hd44780_backlight,
+	.print		= hd44780_common_print,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -169,6 +170,7 @@ static void hd44780_write_data_gpio4(struct hd44780_common *hdc, int data)
 
 static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.backlight	= hd44780_backlight,
+	.print		= hd44780_common_print,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 285073a00302..da296c5ad7a5 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -2,8 +2,21 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include "charlcd.h"
 #include "hd44780_common.h"
 
+int hd44780_common_print(struct charlcd *lcd, int c)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (lcd->addr.x < hdc->bwidth) {
+		hdc->write_data(hdc, c);
+		return 0;
+	}
+
+	return 1;
+}
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 6c38ddf8f2ce..02d650903e35 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -14,5 +14,6 @@ struct hd44780_common {
 	void *hd44780;
 };
 
+int hd44780_common_print(struct charlcd *lcd, int c);
 struct hd44780_common *hd44780_common_alloc(void);
 
-- 
2.28.0

