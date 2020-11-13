Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3A32B1305
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKMAGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgKMAGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:06:53 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA3C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:06:52 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so7829551wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QaQFi8Mdamg7GyyTVitR5xuLU194FCgV474jmD+Lyb4=;
        b=Shcm3pj2Uvc3XBjCZRyitzZxAEnuJLPvO+5voLfyqAbAjNB9CQ6Jm5rWY+2CU9ofVF
         mFbzhtbNTXLwCLrJ+au4Af/0NLPei492LW8qtAj2qhVQviPXrZELa01A0h+ITsaoy5wx
         mzJgPC/CCp6QgrpUjwjiDenZT3tUubjls6hZ5MHzkawKluASBWU45FIXz33GjmLlLJWm
         V7q4smKL2nW0cqPrve2FjM7b0oRCQG8qMPWnfGOTFtp6jTP0awC0hGvBKGpOipKGVumn
         QRcbLnLRvVhicUwyraGCLX845/1tWmRi/KyKoRl8NlGSztUeNqDtDQ9id8T410ipuxpf
         h1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QaQFi8Mdamg7GyyTVitR5xuLU194FCgV474jmD+Lyb4=;
        b=hJ77fByeiubs2RRstiGjoE10eBG+NyHnZVJUjco8GBhv6i943h+Gna7M01653SZGo1
         Pd5tnxLD4IRCTFCCnDR0UVSF7rZx7urqPydpN6x0F5AebK7WygBDECU5h8iPB6kojaF+
         D19cwGrYDDyeaBc6LxZ9xK1L/TG9dVSdNgz2uEYcpiJU21Pd9EvqlMTbFm5DBjWuYHTM
         dxl6VoRVxHmVGfF9AWKeKuLKvhy4mdQWTg7ldH+UISv9NMy6nJF6X0KUKjZQOE4Sim25
         y+YoPhVHcyCGRKrj7t294LhhckMUGBNLqHkNli3PrXdtt6RnB9VlKCrzyky1GiaGFpnQ
         XPZw==
X-Gm-Message-State: AOAM5337BsWmVyDuoKAUZU4kcrgwLNKdFihK0h2heImibDhoq56LeG1m
        ZEJMqSXe/yCDEcIV/oZRpp3sFg==
X-Google-Smtp-Source: ABdhPJxZ1ra0ZfKE6leDhsxONvD1vjbTzP3c9vegGedkTs74gyZWSSsupIzIjbUB9vjMC64hdvHkFQ==
X-Received: by 2002:adf:b109:: with SMTP id l9mr2305827wra.279.1605226011626;
        Thu, 12 Nov 2020 16:06:51 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3a84:7260:5d3c:83d5:8524:33ca])
        by smtp.googlemail.com with ESMTPSA id t11sm2010114wrm.8.2020.11.12.16.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:06:51 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 3/3] phy: amlogic: meson8b-usb2: fix shared reset control use
Date:   Fri, 13 Nov 2020 01:05:08 +0100
Message-Id: <20201113000508.14702-4-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113000508.14702-1-aouledameur@baylibre.com>
References: <20201113000508.14702-1-aouledameur@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use reset_control_rearm() call if an error occurs in case
phy_meson8b_usb2_power_on() fails after reset() has been called, or in
case phy_meson8b_usb2_power_off() is called i.e the resource is no longer
used and the reset line may be triggered again by other devices.

reset_control_rearm() keeps use of triggered_count sane in the reset
framework, use of reset_control_reset() on shared reset line should
be balanced with reset_control_rearm().

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
---
Important:
Please DO NOT merge before this patch [0] is merged, it adds 
reset_control_rearm() call to the reset framework API.

 drivers/phy/amlogic/phy-meson8b-usb2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 03c061dd5f0d..2a6c53f52423 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -154,12 +154,14 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 	ret = clk_prepare_enable(priv->clk_usb_general);
 	if (ret) {
 		dev_err(&phy->dev, "Failed to enable USB general clock\n");
+		reset_control_rearm(priv->reset);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(priv->clk_usb);
 	if (ret) {
 		dev_err(&phy->dev, "Failed to enable USB DDR clock\n");
+		reset_control_rearm(priv->reset);
 		clk_disable_unprepare(priv->clk_usb_general);
 		return ret;
 	}
@@ -197,6 +199,7 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 			regmap_read(priv->regmap, REG_ADP_BC, &reg);
 			if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
 				dev_warn(&phy->dev, "USB ID detect failed!\n");
+				reset_control_rearm(priv->reset);
 				clk_disable_unprepare(priv->clk_usb);
 				clk_disable_unprepare(priv->clk_usb_general);
 				return -EINVAL;
@@ -216,6 +219,7 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
 				   REG_DBG_UART_SET_IDDQ,
 				   REG_DBG_UART_SET_IDDQ);
 
+	reset_control_rearm(priv->reset);
 	clk_disable_unprepare(priv->clk_usb);
 	clk_disable_unprepare(priv->clk_usb_general);
 
-- 
2.17.1

