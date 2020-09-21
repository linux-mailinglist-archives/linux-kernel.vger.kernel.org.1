Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8C27290F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgIUOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgIUOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:48:01 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A808C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:48:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 4A5BE23F029;
        Mon, 21 Sep 2020 16:48:00 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.005
X-Spam-Level: 
X-Spam-Status: No, score=-3.005 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.105, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pwPg5ZL2XwQz; Mon, 21 Sep 2020 16:47:59 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 1588123F183;
        Mon, 21 Sep 2020 16:47:59 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v2 12/32] auxdisplay: make charlcd_backlight visible to hd44780_common
Date:   Mon, 21 Sep 2020 16:46:24 +0200
Message-Id: <20200921144645.2061313-13-poeschel@lemonage.de>
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

hd44780_common wants to use the charlcd_backlight function, so make it
visible.

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

