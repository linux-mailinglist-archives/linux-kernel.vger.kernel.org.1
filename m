Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393E629E7FB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgJ2J6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgJ2J6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:58:04 -0400
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0320C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:58:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id C82FA23FA1C;
        Thu, 29 Oct 2020 10:58:02 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.947
X-Spam-Level: 
X-Spam-Status: No, score=-2.947 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.047, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JP1uUGrsaXMp; Thu, 29 Oct 2020 10:58:01 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 4FEF923F5FF;
        Thu, 29 Oct 2020 10:58:01 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v5 12/25] auxdisplay: make charlcd_backlight visible to hd44780_common
Date:   Thu, 29 Oct 2020 10:57:16 +0100
Message-Id: <20201029095731.311528-11-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029095731.311528-1-poeschel@lemonage.de>
References: <20201029095231.311083-1-poeschel@lemonage.de>
 <20201029095731.311528-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

hd44780_common wants to use the charlcd_backlight function, so make it
visible.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c | 3 ++-
 drivers/auxdisplay/charlcd.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index fc0daf4987d5..154419513186 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -91,7 +91,7 @@ static void long_sleep(int ms)
 }
 
 /* turn the backlight on or off */
-static void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on)
+void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 
@@ -103,6 +103,7 @@ static void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on)
 		lcd->ops->backlight(lcd, on);
 	mutex_unlock(&priv->bl_tempo_lock);
 }
+EXPORT_SYMBOL_GPL(charlcd_backlight);
 
 static void charlcd_bl_off(struct work_struct *work)
 {
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index a6c32c4d1aac..a3210305cae7 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -56,6 +56,7 @@ struct charlcd_ops {
 	int (*clear_display)(struct charlcd *lcd);
 };
 
+void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
 struct charlcd *charlcd_alloc(void);
 void charlcd_free(struct charlcd *lcd);
 
-- 
2.28.0

