Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252C52CAB4D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392309AbgLATCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731264AbgLATCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:02:07 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7AEC061A47
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:01:27 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so4324429wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1dEJUDuhS7iOpzRVv86r79ENM/jPrgw7u7JsYCWkYfU=;
        b=k3zSsZ2YWE86WW2dJvbafkB+cKYCqj+/dXRMk6wSEbaAMzM17lWDFS6pKZw3wW/ZkT
         IApg1a77UrpF1g+dFfOv4VaGH6r2bM+qt34+ZnvEAridm3NFwuFVC79jILvR2m52/Rdj
         xH2s5y+bq76LkLZKL5JgWE00QArs6sKwTYW4HavqlMxeAMprz9Q9MEu60WwI/TDRCDJG
         UJzC3PHE3mJrcR5nMy8V/eZSUnjKQpDa/y1UVtina4mzbdKoCsks1WTfXfsU7Hp9Y8np
         u+HiKvx3bb+k29/W6sq2tg8D34uU0+X/BEf+exjDTt7mUlYqx1gAClQTUvzVdlcjwbpV
         VM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1dEJUDuhS7iOpzRVv86r79ENM/jPrgw7u7JsYCWkYfU=;
        b=p4yEwekzXH2ggZWvWR+uoNc1VrX4OvlBXdBGwmrB7AZ+YYsOZmjsqjc9vTIJbg8Qc0
         Uwby5I0klYGedIFI/OAE2iJZFd65TN8TlbG4ufLqzUkoFzjtCJKEvl6Zf3UVm4DTJpiy
         0bJ4Te0iMkD7M3Aq6p6boMw4enxs1v8/VRS5e5hLAL2tPFRxRRyjVVUCPcR1eLSB6gSk
         myxjYoCmaGTetJCkNQZSF6jzws6mMnlAx78jlnSKRauPFRykYDYjyjLx09Brs+aHGCIE
         3Q8D4102FisvraAWiAKNksExdt4WBN570eMFdIFcEW2Hb9GI50ZfNkrRmA5f3IE1m9fl
         Ir5w==
X-Gm-Message-State: AOAM5300ZZ1m48Cn2NMnywI1on+EaivAJ//UePrV9x4z0tnhlFQQItep
        AcnuiUxyK+nY2BZ1dtQNX0cJZw==
X-Google-Smtp-Source: ABdhPJwVIic5SLd7j1ro/o0Nph5ICWIcaGxb0s8+eZQnKPwDgH3dWds5cFeB8K26G+y69nIC9lCztw==
X-Received: by 2002:adf:902d:: with SMTP id h42mr5643737wrh.175.1606849286085;
        Tue, 01 Dec 2020 11:01:26 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3a84:7260:40a4:a590:1da6:9599])
        by smtp.googlemail.com with ESMTPSA id 138sm887733wma.41.2020.12.01.11.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:01:25 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 2/3] usb: dwc3: meson-g12a: fix shared reset control use
Date:   Tue,  1 Dec 2020 20:00:59 +0100
Message-Id: <20201201190100.17831-3-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201190100.17831-1-aouledameur@baylibre.com>
References: <20201201190100.17831-1-aouledameur@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reset_control_(de)assert() calls are called on a shared reset line when
reset_control_reset has been used. This is not allowed by the reset
framework.

Use reset_control_rearm() call in suspend() and remove() as a way to state
that the resource is no longer used, hence the shared reset line
may be triggered again by other devices. Use reset_control_rearm() also in
case probe fails after reset() has been called.

reset_control_rearm() keeps use of triggered_count sane in the reset
framework, use of reset_control_reset() on shared reset line should be
balanced with reset_control_rearm().

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
---
changes since v1: [1]
* None for this driver

IMPORTANT:
This patchset depends on this patch [2], it adds reset_control_rearm() call
to the reset framework API, it has been approved by the maintainer, and
will be applied to reset/next

There is currently an immutable branch with it [3]

[1]: https://lore.kernel.org/lkml/20201113000508.14702-1-aouledameur@baylibre.com/
[2]: https://lore.kernel.org/lkml/20201112230043.28987-1-aouledameur@baylibre.com/
[3]: git://git.pengutronix.de/git/pza/linux.git reset/shared-retrigger

 drivers/usb/dwc3/dwc3-meson-g12a.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 417e05381b5d..3fec8f591c93 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -750,7 +750,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	ret = dwc3_meson_g12a_get_phys(priv);
 	if (ret)
-		goto err_disable_clks;
+		goto err_rearm;
 
 	ret = priv->drvdata->setup_regmaps(priv, base);
 	if (ret)
@@ -759,7 +759,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	if (priv->vbus) {
 		ret = regulator_enable(priv->vbus);
 		if (ret)
-			goto err_disable_clks;
+			goto err_rearm;
 	}
 
 	/* Get dr_mode */
@@ -772,13 +772,13 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	ret = priv->drvdata->usb_init(priv);
 	if (ret)
-		goto err_disable_clks;
+		goto err_rearm;
 
 	/* Init PHYs */
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		ret = phy_init(priv->phys[i]);
 		if (ret)
-			goto err_disable_clks;
+			goto err_rearm;
 	}
 
 	/* Set PHY Power */
@@ -816,6 +816,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	for (i = 0 ; i < PHY_COUNT ; ++i)
 		phy_exit(priv->phys[i]);
 
+err_rearm:
+	reset_control_rearm(priv->reset);
+
 err_disable_clks:
 	clk_bulk_disable_unprepare(priv->drvdata->num_clks,
 				   priv->drvdata->clks);
@@ -843,6 +846,8 @@ static int dwc3_meson_g12a_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_set_suspended(dev);
 
+	reset_control_rearm(priv->reset);
+
 	clk_bulk_disable_unprepare(priv->drvdata->num_clks,
 				   priv->drvdata->clks);
 
@@ -883,7 +888,7 @@ static int __maybe_unused dwc3_meson_g12a_suspend(struct device *dev)
 		phy_exit(priv->phys[i]);
 	}
 
-	reset_control_assert(priv->reset);
+	reset_control_rearm(priv->reset);
 
 	return 0;
 }
@@ -893,7 +898,9 @@ static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
 	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
 	int i, ret;
 
-	reset_control_deassert(priv->reset);
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
 
 	ret = priv->drvdata->usb_init(priv);
 	if (ret)
-- 
2.17.1

