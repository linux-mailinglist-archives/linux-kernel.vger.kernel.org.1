Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63182B12FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgKMAGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:06:17 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AAC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:06:16 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so7878107wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SvCqmojrOXPepsO1Q95hNkBgZWVIPjMyxB/8gJJcRy8=;
        b=eRuvBfW/w0YfQpAsNIggfETPocDNMewqXmrdbtLfYLawNTApaaz3vjA7PFcQiYyjG9
         dBaxdtuJUg9MvD94wZ1pZgIO5iK27fR6W3rhtr0P6/If0yO5Ixg++OgCzU1y6YuiIYMb
         RvZT6p6bWEzkirTINIWVSbRKEhpBxs0wCRrXHX+6ENfirp6DHb/QAJGUPG835JL+Hirv
         r9f4IUXkJGDCv0hWhbNA0Pm+27sLmdQZC8z+QFlDozejv74Mg0tbyowPRl9pSAm0ZWhD
         TO/mORp1bpQJuaXWlt1mXhXvDxXodpShZoiDAEIPwxEytiZiaJpyvWvGhxxWN6pxeZM6
         a8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SvCqmojrOXPepsO1Q95hNkBgZWVIPjMyxB/8gJJcRy8=;
        b=PLufJyNvwRa19FbTmTFlMfRPRbCjf3BxvMGHZbWSExt/lAJ83p2Qn0UGD902t0psFv
         XN4uEX1Je5RPqNfO5UcbSnwy3NYmPXtH2g8aF05y5Zio6CAolWA/qtztGtFqm/lOVgIi
         9GbkiKKPOXPf6KG26H9l3RdnHj+9RYbq7aRCuBdQJgzmyDUn1eF+mrUic9KxESkJSBia
         ugXy7XFbLmwhcbvqpbNJWZ1KclApDecKgU6Z4CAiK3MUbkfqZBhy7FRsfsXB2LFJr0vE
         j7X0PHI9VEQr8oSM8sJuh+9yH4QiNr7k9w1n19acP3tFD0r6T0lcAATA6qQ1XUxJ+mQ/
         l8Ww==
X-Gm-Message-State: AOAM532Fw0yBa+JN38GHraRQX30SbyEhdjJKfIkILpA0G2wemD2pmYhl
        CfCuUoV22pFR+e19CC1WahWwxg==
X-Google-Smtp-Source: ABdhPJzAFcpXiDgVQFWzpsy/4A2RLg4B3ufujHE7pwk5uARBCcBmbVQ4mOIR9n0l9zMSEXD2xN1i9g==
X-Received: by 2002:a5d:654c:: with SMTP id z12mr2349004wrv.46.1605225975556;
        Thu, 12 Nov 2020 16:06:15 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3a84:7260:5d3c:83d5:8524:33ca])
        by smtp.googlemail.com with ESMTPSA id t11sm2010114wrm.8.2020.11.12.16.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:06:14 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
Date:   Fri, 13 Nov 2020 01:05:06 +0100
Message-Id: <20201113000508.14702-2-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113000508.14702-1-aouledameur@baylibre.com>
References: <20201113000508.14702-1-aouledameur@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use reset_control_rearm() call if an error occurs in case
phy_meson_gxl_usb2_init() fails after reset() has been called ; or in case
phy_meson_gxl_usb2_exit() is called i.e the resource is no longer used
and the reset line may be triggered again by other devices.

reset_control_rearm() keeps use of triggered_count sane in the reset
framework. Therefore, use of reset_control_reset() on shared reset line
should be balanced with reset_control_rearm().

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
---
Important:
Please DO NOT merge before this patch [0] is merged, it adds 
reset_control_rearm() call to the reset framework API.

[0] https://lore.kernel.org/lkml/20201112230043.28987-1-aouledameur@baylib
re.com/

 drivers/phy/amlogic/phy-meson-gxl-usb2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
index 43ec9bf24abf..e366c0b1e339 100644
--- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
@@ -114,8 +114,10 @@ static int phy_meson_gxl_usb2_init(struct phy *phy)
 		return ret;
 
 	ret = clk_prepare_enable(priv->clk);
-	if (ret)
+	if (ret) {
+		reset_control_rearm(priv->reset);
 		return ret;
+	}
 
 	return 0;
 }
@@ -124,6 +126,7 @@ static int phy_meson_gxl_usb2_exit(struct phy *phy)
 {
 	struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
 
+	reset_control_rearm(priv->reset);
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
-- 
2.17.1

