Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F41D937D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 11:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgESJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:41:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB9C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 02:41:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DF3312A03BE
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] drm/mediatek: mtk_hdmi: Remove debug messages for function calls
Date:   Tue, 19 May 2020 11:41:15 +0200
Message-Id: <20200519094115.2448092-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Equivalent information can be nowadays obtained using function tracer

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/mediatek/mtk_hdmi.c            | 12 +-----------
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  4 ----
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index b0555a7cb3b4..172d67294435 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1634,8 +1634,6 @@ static int mtk_hdmi_audio_startup(struct device *dev, void *data)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	mtk_hdmi_audio_enable(hdmi);
 
 	return 0;
@@ -1645,8 +1643,6 @@ static void mtk_hdmi_audio_shutdown(struct device *dev, void *data)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	mtk_hdmi_audio_disable(hdmi);
 }
 
@@ -1655,8 +1651,6 @@ mtk_hdmi_audio_digital_mute(struct device *dev, void *data, bool enable)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s(%d)\n", __func__, enable);
-
 	if (enable)
 		mtk_hdmi_hw_aud_mute(hdmi);
 	else
@@ -1669,8 +1663,6 @@ static int mtk_hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf,
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	memcpy(buf, hdmi->conn.eld, min(sizeof(hdmi->conn.eld), len));
 
 	return 0;
@@ -1770,7 +1762,6 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 		goto err_bridge_remove;
 	}
 
-	dev_dbg(dev, "mediatek hdmi probe success\n");
 	return 0;
 
 err_bridge_remove:
@@ -1793,7 +1784,7 @@ static int mtk_hdmi_suspend(struct device *dev)
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
 
 	mtk_hdmi_clk_disable_audio(hdmi);
-	dev_dbg(dev, "hdmi suspend success!\n");
+
 	return 0;
 }
 
@@ -1808,7 +1799,6 @@ static int mtk_hdmi_resume(struct device *dev)
 		return ret;
 	}
 
-	dev_dbg(dev, "hdmi resume success!\n");
 	return 0;
 }
 #endif
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
index b55f51675205..1c3575372230 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
@@ -159,8 +159,6 @@ static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
 {
 	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
 
-	dev_dbg(hdmi_phy->dev, "%s\n", __func__);
-
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PLL_AUTOK_EN);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_PLL_POSDIV);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON3, RG_HDMITX_MHLCK_EN);
@@ -178,8 +176,6 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
 {
 	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
 
-	dev_dbg(hdmi_phy->dev, "%s\n", __func__);
-
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PLL_TXDIV_EN);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PLL_BIAS_LPF_EN);
 	usleep_range(100, 150);
-- 
2.26.2

