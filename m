Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C392728F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgIUOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgIUOsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:48:11 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B7C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:48:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 8A34523F1E9;
        Mon, 21 Sep 2020 16:48:10 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.997
X-Spam-Level: 
X-Spam-Status: No, score=-2.997 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.097, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GhCOw9TT8dIE; Mon, 21 Sep 2020 16:48:08 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 94FCD23F02F;
        Mon, 21 Sep 2020 16:48:08 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v2 26/32] auxdisplay: Move clear_fast to hd44780
Date:   Mon, 21 Sep 2020 16:46:38 +0200
Message-Id: <20200921144645.2061313-27-poeschel@lemonage.de>
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

Move device specific clear_fast to hd44780. The other hd44780 driver is
panel and it provides it's own implementations of clear_fast, so we do
not move to hd44780_common in this case.
This also provides a standard naive fallback implementation in charlcd
if a driver does not provide clear_fast.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c | 19 +++++++++++--------
 drivers/auxdisplay/hd44780.c | 14 ++++++++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 0f0568a4bd35..ef448c42abbd 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -127,18 +127,21 @@ static void charlcd_print(struct charlcd *lcd, char c)
 
 static void charlcd_clear_fast(struct charlcd *lcd)
 {
-	struct hd44780_common *hdc = lcd->drvdata;
-	int pos;
-
-	charlcd_home(lcd);
+	int x, y;
 
 	if (lcd->ops->clear_fast)
 		lcd->ops->clear_fast(lcd);
-	else
-		for (pos = 0; pos < min(2, lcd->height) * hdc->hwidth; pos++)
-			lcd->ops->print(lcd, ' ');
+	else {
+		for (y = 0; y < lcd->height; y++) {
+			lcd->addr.x = 0;
+			lcd->addr.y = y;
+			lcd->ops->gotoxy(lcd);
+			for (x = 0; x < lcd->width; x++)
+				lcd->ops->print(lcd, ' ');
+		}
 
-	charlcd_home(lcd);
+		lcd->ops->home(lcd);
+	}
 }
 
 /*
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 2e5e7c993933..207ed23e02ce 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -38,6 +38,18 @@ struct hd44780 {
 	struct gpio_desc *pins[PIN_NUM];
 };
 
+static void hd44780_clear_fast(struct charlcd *lcd)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+	int pos;
+
+	hd44780_common_home(lcd);
+	for (pos = 0; pos < min(2, lcd->height) * hdc->hwidth; pos++)
+		hd44780_common_print(lcd, ' ');
+
+	hd44780_common_home(lcd);
+}
+
 static void hd44780_backlight(struct charlcd *lcd, enum charlcd_onoff on)
 {
 	struct hd44780_common *hdc = lcd->drvdata;
@@ -125,6 +137,7 @@ static void hd44780_write_data_gpio8(struct hd44780_common *hdc, int data)
 }
 
 static const struct charlcd_ops hd44780_ops_gpio8 = {
+	.clear_fast	= hd44780_clear_fast,
 	.backlight	= hd44780_backlight,
 	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
@@ -181,6 +194,7 @@ static void hd44780_write_data_gpio4(struct hd44780_common *hdc, int data)
 }
 
 static const struct charlcd_ops hd44780_ops_gpio4 = {
+	.clear_fast	= hd44780_clear_fast,
 	.backlight	= hd44780_backlight,
 	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
-- 
2.28.0

