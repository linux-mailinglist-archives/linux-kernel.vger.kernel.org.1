Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB6E2CD13E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbgLCIZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388221AbgLCIZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:25:41 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6318C061A4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 00:24:54 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n10so948059pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 00:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbfQj5yx8q5vsWWQ52FX9cwcSvHIrWrBDYdeg/Q55J4=;
        b=CC0LDk6MjaniNohllz1X8vF+6zibKnjaUx1UZusXT8g4PvOPFVhlFnPKG5iMoMlTes
         VZTT3FxsHMM0NAZJHNq0pIWQpyPcuO/f5V8263/cLsUcUPTOxTEQNcq++aIVashDczax
         rbeUvp4tBFyvoD4jU7tuyRCmjYopbPDK7mfuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbfQj5yx8q5vsWWQ52FX9cwcSvHIrWrBDYdeg/Q55J4=;
        b=E3MnoGtSZpVMszKDR9Xbe4WozQ3Ginfkoy1sy5oYTSIBiB73/69Ta9bwNyJB7h5hYX
         Buq5QPx03N7vTsnGus80uFzUiivO8dpSHakWUrVl/pxS9AVPwQP5odRge8oD9fYPJzt4
         Fj4NaCOLEYI+Vp6ffws3NfTQWFwTzxwEDf9amyjAa6UyfCdti59SoaLXEQMjS7x6Kcfr
         A+vDiGqOkJZ5bk1LtknAZ47bLa08gIixEFSrF4+jLbwlYVJdDSW57qiZt+QJbQ7pFp7l
         C222EAUtGpx+hAATFFXz9pW2w/MWy6H23OyB8oVadCw6RuvZxOmaNb3HzUErHtToJ2yp
         4Rng==
X-Gm-Message-State: AOAM5336TkFKeJTloFJAr5BNdU6Jx8t7dcEhc6Vjw5nOt1v15mAYrauS
        Z6kmXxabxE6uq9NWs2cW/PrIyg==
X-Google-Smtp-Source: ABdhPJwD4kYBEvN44OH+eyu4iXyYp+S5tYey6LADtEcblFq79I2Cyce9ZL7pLKKrJ1KH9iN4MWofgw==
X-Received: by 2002:a62:a11a:0:b029:18a:df9e:f537 with SMTP id b26-20020a62a11a0000b029018adf9ef537mr2173912pff.29.1606983893429;
        Thu, 03 Dec 2020 00:24:53 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id e66sm815128pfe.165.2020.12.03.00.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 00:24:52 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: mtk_dpi: Create connector for bridges
Date:   Thu,  3 Dec 2020 16:24:45 +0800
Message-Id: <20201203082445.1342763-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to a9d9fea74be2 ("drm/mediatek: mtk_dsi: Create connector for bridges"):

Use the drm_bridge_connector helper to create a connector for pipelines
that use drm_bridge. This allows splitting connector operations across
multiple bridges when necessary, instead of having the last bridge in
the chain creating the connector and handling all connector operations
internally.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 52f11a63a330..189377e342fa 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -20,6 +20,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_of.h>
 #include <drm/drm_simple_kms_helper.h>
@@ -66,6 +67,7 @@ struct mtk_dpi {
 	struct drm_encoder encoder;
 	struct drm_bridge bridge;
 	struct drm_bridge *next_bridge;
+	struct drm_connector *connector;
 	void __iomem *regs;
 	struct device *dev;
 	struct clk *engine_clk;
@@ -603,12 +605,21 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
 
 	dpi->encoder.possible_crtcs = mtk_drm_find_possible_crtc_by_comp(drm_dev, dpi->ddp_comp);
 
-	ret = drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL, 0);
+	ret = drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret) {
 		dev_err(dev, "Failed to attach bridge: %d\n", ret);
 		goto err_cleanup;
 	}
 
+	dpi->connector = drm_bridge_connector_init(drm_dev, &dpi->encoder);
+	if (IS_ERR(dpi->connector)) {
+		dev_err(dev, "Unable to create bridge connector\n");
+		ret = PTR_ERR(dpi->connector);
+		goto err_cleanup;
+	}
+	drm_connector_attach_encoder(dpi->connector, &dpi->encoder);
+
 	dpi->bit_num = MTK_DPI_OUT_BIT_NUM_8BITS;
 	dpi->channel_swap = MTK_DPI_OUT_CHANNEL_SWAP_RGB;
 	dpi->yc_map = MTK_DPI_OUT_YC_MAP_RGB;
-- 
2.29.2.576.ga3fc446d84-goog

