Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F922728F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgIUOtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgIUOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:48:12 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21704C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:48:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 0940623F13F;
        Mon, 21 Sep 2020 16:48:11 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.996
X-Spam-Level: 
X-Spam-Status: No, score=-2.996 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.096, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ssxE-O_eCNgY; Mon, 21 Sep 2020 16:48:09 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 6EF0123F06F;
        Mon, 21 Sep 2020 16:48:09 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v2 28/32] auxdisplay: hd44780: Remove clear_fast
Date:   Mon, 21 Sep 2020 16:46:40 +0200
Message-Id: <20200921144645.2061313-29-poeschel@lemonage.de>
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

We remove the hd44780_clear_fast (display) clear implementation. charlcd
will fall back to use hd44780_common_clear_display then, which is much
much faster.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/hd44780.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 207ed23e02ce..2e5e7c993933 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -38,18 +38,6 @@ struct hd44780 {
 	struct gpio_desc *pins[PIN_NUM];
 };
 
-static void hd44780_clear_fast(struct charlcd *lcd)
-{
-	struct hd44780_common *hdc = lcd->drvdata;
-	int pos;
-
-	hd44780_common_home(lcd);
-	for (pos = 0; pos < min(2, lcd->height) * hdc->hwidth; pos++)
-		hd44780_common_print(lcd, ' ');
-
-	hd44780_common_home(lcd);
-}
-
 static void hd44780_backlight(struct charlcd *lcd, enum charlcd_onoff on)
 {
 	struct hd44780_common *hdc = lcd->drvdata;
@@ -137,7 +125,6 @@ static void hd44780_write_data_gpio8(struct hd44780_common *hdc, int data)
 }
 
 static const struct charlcd_ops hd44780_ops_gpio8 = {
-	.clear_fast	= hd44780_clear_fast,
 	.backlight	= hd44780_backlight,
 	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
@@ -194,7 +181,6 @@ static void hd44780_write_data_gpio4(struct hd44780_common *hdc, int data)
 }
 
 static const struct charlcd_ops hd44780_ops_gpio4 = {
-	.clear_fast	= hd44780_clear_fast,
 	.backlight	= hd44780_backlight,
 	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
-- 
2.28.0

