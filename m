Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE38D2CAB48
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392294AbgLATCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731301AbgLATCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:02:03 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B8FC0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:01:23 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so4355875wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G22eGyYxIipSs8w/AkbTh1vA6CiojhQuKpwoEPnVmtE=;
        b=PyDW5rz9AAyU3fm6J3ZjRcYcmz3GPTUIh6lMW7iKCGKKM+skNO8rt81pj6nZtrB19R
         FTuh7dU3kIxg3OcT4kjynAMMGRIHNVem2RgP5L+hF0GVXwM6aPHZ0ZjQJiyAf364bwuN
         LeU7hcuiUdWwVXTD/KOltCWNGdpPbwEJeJPPpfNdw4brncKHUp7kGIMU+thhEmTTKkGN
         +Z6mobzcoERS7bzx1/K8qWwuUprvVCa9x4IKFabe5pSZ/S1QD53yTs6LpahEgGfKKfZl
         05U8Hxnb0MJ4zT3OMVTZU9sthGhfxunD79G9V3p5aObrTy8sZMFlWp1A1Ly5tB7sAyhD
         Flew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G22eGyYxIipSs8w/AkbTh1vA6CiojhQuKpwoEPnVmtE=;
        b=SwsjacPjAHYP5sYO0iNLfBKaMJOl2sbGH2OYT1KgTC+QWki/sUVhRyt3WFNRhT0DGi
         m8rN+QxCaNLrIUUefeI9QyMrEg7ighn8MBy8O9+sOxqN6mpOHINPQvqi707NI25nE8Zv
         aWd8QBBSuwtzv5BI/rW8gGkibFlaK95GOlm14hOvhyKyzE6iw58DNPRlqWMXrILQlTkw
         7D6gNzxxokM9dslVLaU521FV/YgpDLmUaxceVzZA9pRYNOAbNTvVrL7r3UQFjoJ8Gb70
         7F0QfvODUOhQsR+UyU4DtueH7qG/AyTiH8PNSgMOiHaqQ3Ya4PmnGSg+uVs46V4lPC2P
         xYGQ==
X-Gm-Message-State: AOAM531Zk+N+rnDagCpota48YLMThp5O0FEVRV5lxB63SbtsgzLdOuQA
        Fc7RuKw7v6gvP6SvXbH3hVe4NA==
X-Google-Smtp-Source: ABdhPJw1Goa2Q0OjUHIOXSk8Lh0iFlfPPzooSWpjv2qA/Sds4esLvve/gf6qnlCpY7MINPiQdKNUhQ==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr5784812wrq.52.1606849281924;
        Tue, 01 Dec 2020 11:01:21 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3a84:7260:40a4:a590:1da6:9599])
        by smtp.googlemail.com with ESMTPSA id 138sm887733wma.41.2020.12.01.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:01:21 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
Date:   Tue,  1 Dec 2020 20:00:58 +0100
Message-Id: <20201201190100.17831-2-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201190100.17831-1-aouledameur@baylibre.com>
References: <20201201190100.17831-1-aouledameur@baylibre.com>
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
changes since v1: [1]
* Moved reset_control_rearm after clk_disable_unprepare to clean things up
in reverse order of initialization for phy: amlogic: meson drivers

IMPORTANT:
This patchset depends on this patch [2], it adds reset_control_rearm() call
to the reset framework API, it has been approved by the maintainer, and
will be applied to reset/next

There is currently an immutable branch with it [3]

[1]: https://lore.kernel.org/lkml/20201113000508.14702-1-aouledameur@baylibre.com/
[2]: https://lore.kernel.org/lkml/20201112230043.28987-1-aouledameur@baylibre.com/
[3]: git://git.pengutronix.de/git/pza/linux.git reset/shared-retrigger

 drivers/phy/amlogic/phy-meson-gxl-usb2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
index 43ec9bf24abf..1ddf5e5e4184 100644
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
@@ -125,6 +127,7 @@ static int phy_meson_gxl_usb2_exit(struct phy *phy)
 	struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
 
 	clk_disable_unprepare(priv->clk);
+	reset_control_rearm(priv->reset);
 
 	return 0;
 }
-- 
2.17.1

