Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3596729419A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437241AbgJTRnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437219AbgJTRnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:43:06 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D123C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c194so2702425wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=twq11JCTg4YQPPBb170KYVskL+0y3cSGC0QSvk3HH7Y=;
        b=Y0K8WJVBkIOPg/vWN/gU1vxXt++vSz7StmVppBiSGnmhyGQBKOMQ8hAIb04Afhwj6a
         62+XiBskbzrvJhI4iA0oRmM8jG4MwFzf8EzwA9mCx+eRDjY5tuMZVIjPVJ8rJQ2l4mjy
         apDGCrIAKYw2L5zy+NC2R9nsPefpTGiANnp5FUzPb6gSHYA1D1/yvF9vZW62tnEW5JcL
         xwFxp2jAZEsl/dwdQzPJ5USMd9KZCSRimXYGtlaWRbKTSqVErYT5qC9uimgEP7SMH445
         ob07PhCQGEjZ7ZEZ1pg47Ci1z5OU9XyECBPwHRgN1OQ1psyp6Mqkj4qX5B7Dx+Smj61Z
         eOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twq11JCTg4YQPPBb170KYVskL+0y3cSGC0QSvk3HH7Y=;
        b=dfC/fjXihFFK6bSp0pXzhKNd9IiPuf7b6Ut28kVFgStgJiLwoDU1aLJfeOUfB4BE+e
         JcU43oMxMZGsis7wne5YlDRBdT6I2Mq7mxqCvF9hz+DMzL3vafmiScOTd692v9Un4qTB
         JHqxA5Rwe8SFbyD5+IJFuNFZa5U2+G5BUCCYzYtfhX0kT4ZnFJ3w/XWMHwVKrYhHEFJs
         Wv4gBEh4OUGcDpg3vyANDyqeJEadxJ7blOb3WD8e0Hv+yASju7xxCwgvsPagxGC7yEOg
         dR7TKTYNkzWbSidAVYRFsQV0zEAJF0vDuUjEV3PlFEue4FY5IZDlhlgnlbg8l4wicGsx
         IQ0Q==
X-Gm-Message-State: AOAM531Tx1atwGTg+6DiINSkYZcIwUQ1LoINevz8iCV1H+RCX2bZNFSI
        J0ru4gQ4/yL8Yngco3w654gxsw==
X-Google-Smtp-Source: ABdhPJyenmhTxFRDWjoJTAfZ9z3NaV+DCbnu64Fauv9XbNcdJIz9d1gaggKnqTTQxm1DBo/NklsnPQ==
X-Received: by 2002:a1c:de8a:: with SMTP id v132mr2244614wmg.173.1603215785045;
        Tue, 20 Oct 2020 10:43:05 -0700 (PDT)
Received: from localhost.localdomain (199.170.185.81.rev.sfr.net. [81.185.170.199])
        by smtp.gmail.com with ESMTPSA id v123sm3297756wme.7.2020.10.20.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:43:04 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 5/8] drm/mediatek: dsi: add support for mipi26m clk
Date:   Tue, 20 Oct 2020 19:42:50 +0200
Message-Id: <20201020174253.3757771-6-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020174253.3757771-1-fparent@baylibre.com>
References: <20201020174253.3757771-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8167 SoC needs an additional clock to be enabled. Add support for
the mipi26m clk.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 461643c05689..08786734df8e 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -193,6 +193,7 @@ struct mtk_dsi {
 	struct clk *engine_clk;
 	struct clk *digital_clk;
 	struct clk *hs_clk;
+	struct clk *mipi26m;
 
 	u32 data_rate;
 
@@ -653,6 +654,12 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 		goto err_disable_engine_clk;
 	}
 
+	ret = clk_prepare_enable(dsi->mipi26m);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable mipi26m clock: %d\n", ret);
+		goto err_phy_power_off;
+	}
+
 	mtk_dsi_enable(dsi);
 
 	if (dsi->driver_data->has_shadow_ctl)
@@ -710,6 +717,7 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 
 	clk_disable_unprepare(dsi->engine_clk);
 	clk_disable_unprepare(dsi->digital_clk);
+	clk_disable_unprepare(dsi->mipi26m);
 
 	phy_power_off(dsi->phy);
 }
@@ -1086,6 +1094,8 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 		goto err_unregister_host;
 	}
 
+	dsi->mipi26m = devm_clk_get_optional(dev, "mipi26m");
+
 	dsi->hs_clk = devm_clk_get(dev, "hs");
 	if (IS_ERR(dsi->hs_clk)) {
 		ret = PTR_ERR(dsi->hs_clk);
-- 
2.28.0

