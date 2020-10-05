Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714F72835C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJEM2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgJEM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:54 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06359C0613AB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:27:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id E25B423FD2C;
        Mon,  5 Oct 2020 14:27:52 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.976
X-Spam-Level: 
X-Spam-Status: No, score=-2.976 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.076, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x0_WG5ERSx14; Mon,  5 Oct 2020 14:27:51 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id C2D952403F8;
        Mon,  5 Oct 2020 14:27:51 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 12/32] auxdisplay: make charlcd_backlight visible to hd44780_common
Date:   Mon,  5 Oct 2020 14:27:12 +0200
Message-Id: <20201005122732.3429347-13-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005122732.3429347-1-poeschel@lemonage.de>
References: <20201005122732.3429347-1-poeschel@lemonage.de>
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
index 0b3dafbbae72..e5b22e72fdc8 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -55,6 +55,7 @@ struct charlcd_ops {
 	int (*clear_display)(struct charlcd *lcd);
 };
 
+void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
 struct charlcd *charlcd_alloc(void);
 void charlcd_free(struct charlcd *lcd);
 
-- 
2.28.0

