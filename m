Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91CC29BAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807591AbgJ0QMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:12:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53138 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1802026AbgJ0QGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:06:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id c194so1889708wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gXSEQ4RUigdrvEfUyIgbTcDJA4ZN5o0EgF33NFMe/HI=;
        b=Z7PBAuqgcEVXrYXq5zpM+K2aVf6AMg0r/JAMVFHkIIX/SHkuy21wembDxlSchyeVQh
         skD9R5Gul6GtMbRtqXsI+hBPJj2U0IUVhsxaZ1nGFh3tgll1CkOvokBHZMgal5o10fFO
         +oRUWXI9R7Pr1xIfIN4Sq5jUmRkZ2JP3ro70EHknjrLAnlrD9DnwrP8tRqYdDJm4Fb7d
         QarJtt56QEdZRJJnvD/cAG8DaqgCJf9xdNx08meoEWciBLS6UaSTN/a8fE1egL2q1ksd
         wZBetg/t1OPkekJaTkVjbJL94qD6ETjcTrM0/PEfrYQdK7TXRYlFLsJ0YYwUfNnA7tVC
         LNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXSEQ4RUigdrvEfUyIgbTcDJA4ZN5o0EgF33NFMe/HI=;
        b=JG9yUjVKFaKy393m0dOhzPSqs2UpFN0TE8ed/f5pbZ3AYofGZyvgiHo/n2mV9d5App
         qHGo5mtf9knfM2g+wbAxHJUEYNIdrmPkdu1v2BaYisEBzddSgs5w2N6qoWQUX9ZhhkYm
         3sTV2PWoHSBdUVn6SWZPH1nWHn354NWdh06az6+LoF0+RcGngGVP+6VHFIaNG8QR51r/
         p758kj0BRPd7qcq21CXXfr+HSGsag4NJfycwi0a/LbAQ+KkOPo0GDSowxRzVCmd1WNZJ
         26RAQyL9nXe1UfCjC0IZY5w+mc+C9Dc5SfIQEgB6LOFw/Xcd4+kuC0nQcNLbhR/p8acD
         4n6g==
X-Gm-Message-State: AOAM532GmjHTOudGwxXBJO4dbGB+pTMG7Cp0V9TBkmivnamn7qAd9fWt
        Hr/di/t9LroeVd6JRVGIwhbVzw==
X-Google-Smtp-Source: ABdhPJxihresPsw4/wvhbg7EfhnGhObn99mfaRvDs9xBb/F2uJ0PuDX4OWXZtPU1lCMWjoAHckfkaQ==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr3644718wmi.140.1603814797773;
        Tue, 27 Oct 2020 09:06:37 -0700 (PDT)
Received: from localhost.localdomain (159.174.185.81.rev.sfr.net. [81.185.174.159])
        by smtp.gmail.com with ESMTPSA id u15sm2656988wrm.77.2020.10.27.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:06:37 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: mediatek: mmsys: Add support for MT8167 SoC
Date:   Tue, 27 Oct 2020 17:06:30 +0100
Message-Id: <20201027160631.608503-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027160631.608503-1-fparent@baylibre.com>
References: <20201027160631.608503-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add routing table for DSI on MT8167 SoC. The registers are mostly
incompatible with the current defines, so new one for MT8167 are added.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

This patch depends on the patch series
"soc: mediatek: Prepare MMSYS for DDP routing using tables"

[0] https://lore.kernel.org/patchwork/cover/1317813/

 drivers/soc/mediatek/mtk-mmsys.c | 50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index f00d6d08c9c5..9890990a74a9 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -85,6 +85,22 @@
 #define DSI_SEL_IN_RDMA				0x1
 #define DSI_SEL_IN_MASK				0x1
 
+/* MT8167 */
+#define MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0x030
+#define MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN	0x038
+#define MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x058
+#define MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN		0x064
+#define MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN	0x06c
+
+#define MT8167_DITHER_MOUT_EN_RDMA0			BIT(0)
+#define MT8167_DITHER_MOUT_EN_MASK			0x7
+
+#define MT8167_RDMA0_SOUT_DSI0				0x2
+#define MT8167_RDMA0_SOUT_MASK				0x3
+
+#define MT8167_DSI0_SEL_IN_RDMA0			0x1
+#define MT8167_DSI0_SEL_IN_MASK				0x3
+
 struct mtk_mmsys_routes {
 	u32 from_comp;
 	u32 to_comp;
@@ -124,6 +140,30 @@ struct mtk_mmsys {
 	const struct mtk_mmsys_driver_data *data;
 };
 
+static const struct mtk_mmsys_routes mt8167_mmsys_routing_table[] = {
+	{
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
+		MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
+		OVL0_MOUT_EN_COLOR0, OVL0_MOUT_EN_COLOR0
+	}, {
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_RDMA0,
+		MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN,
+		MT8167_DITHER_MOUT_EN_MASK, MT8167_DITHER_MOUT_EN_RDMA0
+	}, {
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
+		MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN,
+		COLOR0_SEL_IN_OVL0, COLOR0_SEL_IN_OVL0
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI0,
+		MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN,
+		MT8167_DSI0_SEL_IN_MASK, MT8167_DSI0_SEL_IN_RDMA0
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI0,
+		MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN,
+		MT8167_RDMA0_SOUT_MASK, MT8167_RDMA0_SOUT_DSI0
+	},
+};
+
 static const struct mtk_mmsys_routes mt8173_mmsys_routing_table[] = {
 	{
 		DDP_COMPONENT_BLS, DDP_COMPONENT_DSI0,
@@ -288,6 +328,12 @@ static const struct mtk_mmsys_routes mt8173_mmsys_routing_table[] = {
 	}
 };
 
+static const struct mtk_mmsys_driver_data mt8167_mmsys_driver_data = {
+	.clk_driver = "clk-mt8167-mm",
+	.routes = mt8167_mmsys_routing_table,
+	.num_routes = ARRAY_SIZE(mt8167_mmsys_routing_table),
+};
+
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.clk_driver = "clk-mt8173-mm",
 	.routes = mt8173_mmsys_routing_table,
@@ -385,6 +431,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt6797-mmsys",
 		.data = &mt6797_mmsys_driver_data,
 	},
+	{
+		.compatible = "mediatek,mt8167-mmsys",
+		.data = &mt8167_mmsys_driver_data,
+	},
 	{
 		.compatible = "mediatek,mt8173-mmsys",
 		.data = &mt8173_mmsys_driver_data,
-- 
2.28.0

