Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA42A40E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKCJ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgKCJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:46 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4DEC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 8A29023F2CA;
        Tue,  3 Nov 2020 10:58:43 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.945
X-Spam-Level: 
X-Spam-Status: No, score=-2.945 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.045, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p0sevBTqwlZc; Tue,  3 Nov 2020 10:58:42 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id D414123F3FE;
        Tue,  3 Nov 2020 10:58:41 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 01/25] auxdisplay: Use an enum for charlcd  backlight on/off ops
Date:   Tue,  3 Nov 2020 10:58:04 +0100
Message-Id: <20201103095828.515831-2-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

We use an enum for calling the functions in charlcd, that turn the
backlight on or off. This enum is generic and can be used for other
charlcd turn on / turn off operations as well.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v5:
- Fix a commit message typo: of -> on
---
 drivers/auxdisplay/charlcd.c | 2 +-
 drivers/auxdisplay/charlcd.h | 7 ++++++-
 drivers/auxdisplay/hd44780.c | 2 +-
 drivers/auxdisplay/panel.c   | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 5aee0f546351..8aaee0fea9ab 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -101,7 +101,7 @@ static void long_sleep(int ms)
 }
 
 /* turn the backlight on or off */
-static void charlcd_backlight(struct charlcd *lcd, int on)
+static void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 00911ad0f3de..c66f038e5d2b 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -9,6 +9,11 @@
 #ifndef _CHARLCD_H
 #define _CHARLCD_H
 
+enum charlcd_onoff {
+	CHARLCD_OFF = 0,
+	CHARLCD_ON,
+};
+
 struct charlcd {
 	const struct charlcd_ops *ops;
 	const unsigned char *char_conv;	/* Optional */
@@ -30,7 +35,7 @@ struct charlcd_ops {
 	/* Optional */
 	void (*write_cmd_raw4)(struct charlcd *lcd, int cmd);	/* 4-bit only */
 	void (*clear_fast)(struct charlcd *lcd);
-	void (*backlight)(struct charlcd *lcd, int on);
+	void (*backlight)(struct charlcd *lcd, enum charlcd_onoff on);
 };
 
 struct charlcd *charlcd_alloc(unsigned int drvdata_size);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index bcbe13092327..5982158557bb 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -37,7 +37,7 @@ struct hd44780 {
 	struct gpio_desc *pins[PIN_NUM];
 };
 
-static void hd44780_backlight(struct charlcd *lcd, int on)
+static void hd44780_backlight(struct charlcd *lcd, enum charlcd_onoff on)
 {
 	struct hd44780 *hd = lcd->drvdata;
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 1c82d824ae00..de623ae219f1 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -708,7 +708,7 @@ static void lcd_send_serial(int byte)
 }
 
 /* turn the backlight on or off */
-static void lcd_backlight(struct charlcd *charlcd, int on)
+static void lcd_backlight(struct charlcd *charlcd, enum charlcd_onoff on)
 {
 	if (lcd.pins.bl == PIN_NONE)
 		return;
-- 
2.28.0

