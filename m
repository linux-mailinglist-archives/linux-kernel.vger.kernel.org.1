Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C4A297D57
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762146AbgJXQVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762114AbgJXQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:21:12 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA40C0613CE;
        Sat, 24 Oct 2020 09:21:12 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p9so4350521ilr.1;
        Sat, 24 Oct 2020 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ewdjBL0POYbkyERKt0JClct+9je8sQshxDRVp8rLQk=;
        b=grp7qtr2IS65QolRALjrQsJ9P4ieJ00Jkto8z93AVi+89gLb2EyxpH4duqYfrlB88j
         xS5+9PnWswtbQbEV+p7cWVUwxWFSU5zWcnb/kk572hW20TGbMgXBrCTjTdFaR3AedsRh
         7DkgJhqzj21vgQrulWIRAaIPjg7oijIg74ozFYKSXuTsuoiHwWCZLlelQzGLJHc0uEYe
         bwTi+p2P9Q7g5Shzn7SyRJVuxwQU7DVU5z89cMKsA+dNIJM4X6AXplwfA3Thk+uCF4Ac
         EHvF/95BaoCswI+kSNN2itmSZVDNCC51lmLKpDwP8lIwqc6R2LGGV2ZT7F7Tp01HcPBD
         +n4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ewdjBL0POYbkyERKt0JClct+9je8sQshxDRVp8rLQk=;
        b=kPul8zVSQzqiogErtZbiRHmk9WOBQYYX3Af0O+liAAuKrlLiKounjK1SU26dQpsAcP
         NI7Azb20atoWpdgIxpPXYRqekSIm3H0A05Yrmqhi3o9yNzoi7KqUcej44gLa3GSTuk/o
         M1ykzoHkgttY3hLIc6SNfXUTbeEWdMH/7uyPcDuyeJwNuC/4+p+4vXiGMt7Ggxsi5gGE
         0ln/V65SpRPXUc8h1utubxxjnItzBHNWZeNwfWvo0fE54hWUd6lv6hpnFUB0IjaJFNR/
         2TVVpW3PeQJOl6ZryVCiD3ytFRXCY1SVSeIRYm9JLwG7OvrT44A9pwnocfX/gfgQbB5N
         lZsg==
X-Gm-Message-State: AOAM533Irc+42yjEP4u5SAihCOcDKSwd4mp0vAh/Yxpk4NX5J0xxXAsP
        T02gQs+E9JrD0uEPUHHwzMsbOh3PSSrUvw==
X-Google-Smtp-Source: ABdhPJwi9oUTNHu72wgqV0Xr/QOjUGV/jwHh+j39fq7YVbNK7SRQodB35Gv4NCLo9a7fkGl+GZomsQ==
X-Received: by 2002:a92:7112:: with SMTP id m18mr5846165ilc.133.1603556470189;
        Sat, 24 Oct 2020 09:21:10 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id m86sm3028587ilb.44.2020.10.24.09.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 09:21:09 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     abel.vesa@nxp.com, marex@denx.de, Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [RFC 3/3] clk: imx: Add blk-ctl driver for i.MX8MN
Date:   Sat, 24 Oct 2020 11:20:15 -0500
Message-Id: <20201024162016.1003041-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201024162016.1003041-1-aford173@gmail.com>
References: <20201024162016.1003041-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is intended to work with the multimedia block which
contains display and camera subsystems:
  LCDIF
  ISI
  MIPI CSI
  MIPI DSI

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/clk/imx/clk-blk-ctl-imx8mn.c | 80 ++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/clk/imx/clk-blk-ctl-imx8mn.c b/drivers/clk/imx/clk-blk-ctl-imx8mn.c
new file mode 100644
index 000000000000..917514212270
--- /dev/null
+++ b/drivers/clk/imx/clk-blk-ctl-imx8mn.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Compass Eletronics Group, LLC
+ */
+
+#include <dt-bindings/clock/imx8mn-clock.h>
+#include <dt-bindings/reset/imx8mn-reset.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "clk.h"
+#include "clk-blk-ctl.h"
+
+#define IMX_MEDIA_BLK_CTL_SFT_RSTN		0x0
+#define IMX_MEDIA_BLK_CTL_CLK_EN		0x4
+#define IMX_MEDIA_BLK_CTL_MIPI_RST		0x8
+
+static struct imx_blk_ctl_hw imx8mn_media_blk_ctl_hws[] = {
+	/* clocks */
+	IMX_BLK_CTL_CLK_GATE("mipi_dsi_pclk", IMX8MN_CLK_MEDIA_BLK_CTL_MIPI_DSI_PCLK, 0x4, 0, "dsi_core"),
+	IMX_BLK_CTL_CLK_GATE("mipi_dsi_clkref", IMX8MN_CLK_MEDIA_BLK_CTL_MIPI_DSI_CLKREF, 0x4, 1, "dsi_phy_ref"),
+	IMX_BLK_CTL_CLK_GATE("mipi_csi_pclk", IMX8MN_CLK_MEDIA_BLK_CTL_MIPI_CSI_PCLK, 0x4, 2, "camera_pixel_clk"),
+	IMX_BLK_CTL_CLK_GATE("mipi_csi_aclk", IMX8MN_CLK_MEDIA_BLK_CTL_MIPI_CSI_ACLK, 0x4, 3, "media_cam1_pix_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("lcdif_pixel_clk", IMX8MN_CLK_MEDIA_BLK_CTL_LCDIF_PIXEL, 0x4, 4, "disp_pixel"),
+	IMX_BLK_CTL_CLK_GATE("lcdif_apb_clk", IMX8MN_CLK_MEDIA_BLK_CTL_LCDIF_APB, 0x4, 5, "disp_apb"),
+	IMX_BLK_CTL_CLK_GATE("isi_proc_clk", IMX8MN_CLK_MEDIA_BLK_CTL_ISI_PROC, 0x4, 6, "disp_axi_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("isi_apb_clk", IMX8MN_CLK_MEDIA_BLK_CTL_ISI_APB, 0x4, 7, "disp_apb_root_clk"),
+	IMX_BLK_CTL_CLK_GATE("bus_blk_clk", IMX8MN_CLK_MEDIA_BLK_CTL_BUS_BLK, 0x4, 8, "disp_axi_root_clk"),
+	
+	/* resets */
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_DSI_PCLK, 0, 0),
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_DSI_CLKREF, 0, 1),
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_CSI_PCLK, 0, 2),
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_CSI_ACLK, 0, 3),
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_LCDIF_PIXEL, 0, 4),
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_LCDIF_APB, 0, 5),
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_ISI_PROC, 0, 6),
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_ISI_APB, 0, 7),
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_BUS_BLK, 0, 8),
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_S_RESET, 0x8, 16),
+	IMX_BLK_CTL_RESET(IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_M_RESET, 0x8, 17),
+};
+
+const struct imx_blk_ctl_dev_data imx8mn_media_blk_ctl_dev_data __initconst = {
+	.hws = imx8mn_media_blk_ctl_hws,
+	.hws_num = ARRAY_SIZE(imx8mn_media_blk_ctl_hws),
+	.clocks_max = IMX8MN_CLK_MEDIA_BLK_CTL_END,
+	.resets_max = IMX8MN_MEDIA_BLK_CTL_RESET_NUM,
+	.pm_runtime_saved_regs_num = 3,
+	.pm_runtime_saved_regs = {
+		IMX_MEDIA_BLK_CTL_SFT_RSTN,
+		IMX_MEDIA_BLK_CTL_CLK_EN,
+		IMX_MEDIA_BLK_CTL_MIPI_RST,
+	},
+};
+
+static const struct of_device_id imx8mn_blk_ctl_of_match[] = {
+	{
+		.compatible = "fsl,imx8mn-media-blk-ctl",
+		.data = &imx8mn_media_blk_ctl_dev_data
+	},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx8mn_blk_ctl_of_match);
+
+static struct platform_driver imx_blk_ctl_driver = {
+	.probe = imx_blk_ctl_probe,
+	.driver = {
+		.name = "imx8mn-blk-ctl",
+		.of_match_table = of_match_ptr(imx8mn_blk_ctl_of_match),
+		.pm = &imx_blk_ctl_pm_ops,
+	},
+};
+module_platform_driver(imx_blk_ctl_driver);
-- 
2.25.1

