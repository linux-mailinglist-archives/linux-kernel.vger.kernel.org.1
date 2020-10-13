Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27D828D385
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgJMSTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgJMSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:19:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D57C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:19:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y12so457534wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/7tcaBSc33elA/rgEtQckaex9Y37TpIvbkMTYD15FQ=;
        b=BdRLGXOLVtwcCJKHFN6LI1uz2W2nHnSEpCRh+ZLlcat9mhHmZBiIXd63grxdiihmc9
         Rzl1CP6E+6aF19o6YBDWhZf/F8Yig576Lp+0GwWRASCYZYeOVhcmkfVj+X/AiupkBRKO
         i/T9O4iECcpZjmChTnGsLJffcGbey9NzagrQMSmFVRha8gYIGw8CIXj/P7lRuaGx9l1V
         N2SRv/sgeRwFCwTY2Z/nfzHekT9VbSn9GuvkYPslkZUAfv/zXsq3A8BKYbBNLt3yymXk
         bLpzabmAzwfd4pL/T4eaWHhJJBw9a/YeyOJ9Pn5/Itc79u9DvzTG5/k9FC0gnQp4gZMY
         V9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/7tcaBSc33elA/rgEtQckaex9Y37TpIvbkMTYD15FQ=;
        b=U1jnMWSJ1n+Iu+D5zQwy1qZk9hUXN5nowBBpJm2y7AcJLqvyEu5fKYTAIPG3Y/1S+u
         T7GqDWh22QE+WXX24znZ6GP0aSVG3m1XAu7FMpMo2dtlRy3wNjeddmt6DTh5OxfJKIGV
         PqIJwyL5xQOlpl8D9WjNip0OV0H5iUbiwsnte3a458bsnex43AhP2Dble5OFs/AqX5RZ
         ycbWbmA2i5oDeq0Tpg7uK7epCESqh096bEVFzpCUBNtqAAydevI+Cjx646aVJqbccAHs
         HdlppqT/+v7pVIvQ/7qXBvJFdoReO4RdbifMKmJh6QtrapDqePOxjhLVcq1uCy78qLfg
         noIA==
X-Gm-Message-State: AOAM5330DEmK+GRXiGaJgOAHmayeSWnWIdkqbkF3b8xmIBUasx+uTPk2
        VwxRyb6Jli002zG4+nyDxnGbMK6xfDqmQlMn
X-Google-Smtp-Source: ABdhPJxZZitZjRw01kW+dkf7x7AY+4r6rKZrX9DRFpRSi9rssDlZuRg60T6qu6WkP0UpWaKM8+Gvuw==
X-Received: by 2002:adf:e88a:: with SMTP id d10mr1075084wrm.247.1602613171397;
        Tue, 13 Oct 2020 11:19:31 -0700 (PDT)
Received: from localhost.localdomain (26.165.185.81.rev.sfr.net. [81.185.165.26])
        by smtp.gmail.com with ESMTPSA id w11sm490261wrs.26.2020.10.13.11.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 11:19:30 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 1/2] drm/mediatek: mtk_hdmi: move 2 registers address into of_data
Date:   Tue, 13 Oct 2020 20:19:23 +0200
Message-Id: <20201013181924.4143303-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MT8167, the two registers SYS_CFG1C and SYS_CFG20 don't have the
same address as on MT8173. Add OF data in order to store the address
of these two registers.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

Changelog:
v2: no changes

 drivers/gpu/drm/mediatek/mtk_hdmi.c | 45 ++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index a97725680d4e..57370c036497 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -36,6 +36,11 @@
 
 #define NCTS_BYTES	7
 
+struct mtk_hdmi_data {
+	uint32_t sys_cfg1c;
+	uint32_t sys_cfg20;
+};
+
 enum mtk_hdmi_clk_id {
 	MTK_HDMI_CLK_HDMI_PIXEL,
 	MTK_HDMI_CLK_HDMI_PLL,
@@ -146,6 +151,7 @@ struct hdmi_audio_param {
 };
 
 struct mtk_hdmi {
+	const struct mtk_hdmi_data *data;
 	struct drm_bridge bridge;
 	struct drm_bridge *next_bridge;
 	struct drm_connector conn;
@@ -244,21 +250,24 @@ static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
 	 */
 	if (hdmi_phy->conf && hdmi_phy->conf->tz_disabled)
 		regmap_update_bits(hdmi->sys_regmap,
-				   hdmi->sys_offset + HDMI_SYS_CFG20,
+				   hdmi->sys_offset + hdmi->data->sys_cfg20,
 				   0x80008005, enable ? 0x80000005 : 0x8000);
 	else
 		arm_smccc_smc(MTK_SIP_SET_AUTHORIZED_SECURE_REG, 0x14000904,
 			      0x80000000, 0, 0, 0, 0, 0, &res);
 
-	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG20,
+	regmap_update_bits(hdmi->sys_regmap,
+			   hdmi->sys_offset + hdmi->data->sys_cfg20,
 			   HDMI_PCLK_FREE_RUN, enable ? HDMI_PCLK_FREE_RUN : 0);
-	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG1C,
+	regmap_update_bits(hdmi->sys_regmap,
+			   hdmi->sys_offset + hdmi->data->sys_cfg1c,
 			   HDMI_ON | ANLG_ON, enable ? (HDMI_ON | ANLG_ON) : 0);
 }
 
 static void mtk_hdmi_hw_1p4_version_enable(struct mtk_hdmi *hdmi, bool enable)
 {
-	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG20,
+	regmap_update_bits(hdmi->sys_regmap,
+			   hdmi->sys_offset + hdmi->data->sys_cfg20,
 			   HDMI2P0_EN, enable ? 0 : HDMI2P0_EN);
 }
 
@@ -274,12 +283,15 @@ static void mtk_hdmi_hw_aud_unmute(struct mtk_hdmi *hdmi)
 
 static void mtk_hdmi_hw_reset(struct mtk_hdmi *hdmi)
 {
-	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG1C,
+	regmap_update_bits(hdmi->sys_regmap,
+			   hdmi->sys_offset + hdmi->data->sys_cfg1c,
 			   HDMI_RST, HDMI_RST);
-	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG1C,
+	regmap_update_bits(hdmi->sys_regmap,
+			   hdmi->sys_offset + hdmi->data->sys_cfg1c,
 			   HDMI_RST, 0);
 	mtk_hdmi_clear_bits(hdmi, GRL_CFG3, CFG3_CONTROL_PACKET_DELAY);
-	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG1C,
+	regmap_update_bits(hdmi->sys_regmap,
+			   hdmi->sys_offset + hdmi->data->sys_cfg1c,
 			   ANLG_ON, ANLG_ON);
 }
 
@@ -362,16 +374,19 @@ static void mtk_hdmi_hw_send_aud_packet(struct mtk_hdmi *hdmi, bool enable)
 
 static void mtk_hdmi_hw_config_sys(struct mtk_hdmi *hdmi)
 {
-	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG20,
+	regmap_update_bits(hdmi->sys_regmap,
+			   hdmi->sys_offset + hdmi->data->sys_cfg20,
 			   HDMI_OUT_FIFO_EN | MHL_MODE_ON, 0);
 	usleep_range(2000, 4000);
-	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG20,
+	regmap_update_bits(hdmi->sys_regmap,
+			   hdmi->sys_offset + hdmi->data->sys_cfg20,
 			   HDMI_OUT_FIFO_EN | MHL_MODE_ON, HDMI_OUT_FIFO_EN);
 }
 
 static void mtk_hdmi_hw_set_deep_color_mode(struct mtk_hdmi *hdmi)
 {
-	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG20,
+	regmap_update_bits(hdmi->sys_regmap,
+			   hdmi->sys_offset + hdmi->data->sys_cfg20,
 			   DEEP_COLOR_MODE_MASK | DEEP_COLOR_EN,
 			   COLOR_8BIT_MODE);
 }
@@ -1733,6 +1748,7 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hdmi->dev = dev;
+	hdmi->data = of_device_get_match_data(dev);
 
 	ret = mtk_hdmi_dt_parse_pdata(hdmi, pdev);
 	if (ret)
@@ -1813,8 +1829,15 @@ static int mtk_hdmi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(mtk_hdmi_pm_ops,
 			 mtk_hdmi_suspend, mtk_hdmi_resume);
 
+
+static struct mtk_hdmi_data mt8173_hdmi_driver_data = {
+	.sys_cfg1c = HDMI_SYS_CFG1C,
+	.sys_cfg20 = HDMI_SYS_CFG20,
+};
+
 static const struct of_device_id mtk_drm_hdmi_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-hdmi", },
+	{ .compatible = "mediatek,mt8173-hdmi",
+	  .data = &mt8173_hdmi_driver_data },
 	{}
 };
 
-- 
2.28.0

