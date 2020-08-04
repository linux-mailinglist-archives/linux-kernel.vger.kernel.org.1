Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFCF23B52F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 08:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgHDGpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 02:45:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32997 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbgHDGpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:45:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596523500; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XmJH39xHxGzqc9cW6zMj6jwMI/4VMzKJQ3bqRMaAXf0=; b=DEEJiMuxYhAQSsGysT9av2nTIdJcUevgam2TSW6Pw3te8eufqgnURcaXci1SPKZC2PU4D2UZ
 +yYX42WHM38KFE/gQj/X8PjfYA0KxcrBjBu2yieFZneYvWpuqE6KAGNZyRJwVAIlDhwxyItm
 aMpbAH+2FIOifvNYfAxzErA+JqI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5f2903eba8da23d867be1041 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 06:44:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AEE0AC433B1; Tue,  4 Aug 2020 06:44:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38444C433C9;
        Tue,  4 Aug 2020 06:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38444C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 1/2] drm/msm/mdp4: Remove unused downstream bus scaling apis
Date:   Tue,  4 Aug 2020 12:14:42 +0530
Message-Id: <022b1bd31f86bc5df60cf8a875cd3c3cc110a00a.1596523009.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1596523009.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1596523009.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM bus scaling has moved on to use interconnect framework
and downstream bus scaling apis are not present anymore.
Remove them as they are nop anyways in the current code,
no functional change.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 .../gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  | 51 -------------------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h      | 13 -----
 .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c | 47 -----------------
 3 files changed, 111 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
index 5d8956055286..88645dbc3785 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
@@ -25,54 +25,9 @@ static struct mdp4_kms *get_kms(struct drm_encoder *encoder)
 	return to_mdp4_kms(to_mdp_kms(priv->kms));
 }
 
-#ifdef DOWNSTREAM_CONFIG_MSM_BUS_SCALING
-#include <mach/board.h>
-/* not ironically named at all.. no, really.. */
-static void bs_init(struct mdp4_dtv_encoder *mdp4_dtv_encoder)
-{
-	struct drm_device *dev = mdp4_dtv_encoder->base.dev;
-	struct lcdc_platform_data *dtv_pdata = mdp4_find_pdata("dtv.0");
-
-	if (!dtv_pdata) {
-		DRM_DEV_ERROR(dev->dev, "could not find dtv pdata\n");
-		return;
-	}
-
-	if (dtv_pdata->bus_scale_table) {
-		mdp4_dtv_encoder->bsc = msm_bus_scale_register_client(
-				dtv_pdata->bus_scale_table);
-		DBG("bus scale client: %08x", mdp4_dtv_encoder->bsc);
-		DBG("lcdc_power_save: %p", dtv_pdata->lcdc_power_save);
-		if (dtv_pdata->lcdc_power_save)
-			dtv_pdata->lcdc_power_save(1);
-	}
-}
-
-static void bs_fini(struct mdp4_dtv_encoder *mdp4_dtv_encoder)
-{
-	if (mdp4_dtv_encoder->bsc) {
-		msm_bus_scale_unregister_client(mdp4_dtv_encoder->bsc);
-		mdp4_dtv_encoder->bsc = 0;
-	}
-}
-
-static void bs_set(struct mdp4_dtv_encoder *mdp4_dtv_encoder, int idx)
-{
-	if (mdp4_dtv_encoder->bsc) {
-		DBG("set bus scaling: %d", idx);
-		msm_bus_scale_client_update_request(mdp4_dtv_encoder->bsc, idx);
-	}
-}
-#else
-static void bs_init(struct mdp4_dtv_encoder *mdp4_dtv_encoder) {}
-static void bs_fini(struct mdp4_dtv_encoder *mdp4_dtv_encoder) {}
-static void bs_set(struct mdp4_dtv_encoder *mdp4_dtv_encoder, int idx) {}
-#endif
-
 static void mdp4_dtv_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct mdp4_dtv_encoder *mdp4_dtv_encoder = to_mdp4_dtv_encoder(encoder);
-	bs_fini(mdp4_dtv_encoder);
 	drm_encoder_cleanup(encoder);
 	kfree(mdp4_dtv_encoder);
 }
@@ -162,8 +117,6 @@ static void mdp4_dtv_encoder_disable(struct drm_encoder *encoder)
 	clk_disable_unprepare(mdp4_dtv_encoder->hdmi_clk);
 	clk_disable_unprepare(mdp4_dtv_encoder->mdp_clk);
 
-	bs_set(mdp4_dtv_encoder, 0);
-
 	mdp4_dtv_encoder->enabled = false;
 }
 
@@ -185,8 +138,6 @@ static void mdp4_dtv_encoder_enable(struct drm_encoder *encoder)
 			MDP4_DMA_CONFIG_PACK(0x21));
 	mdp4_crtc_set_intf(encoder->crtc, INTF_LCDC_DTV, 1);
 
-	bs_set(mdp4_dtv_encoder, 1);
-
 	DBG("setting mdp_clk=%lu", pc);
 
 	ret = clk_set_rate(mdp4_dtv_encoder->mdp_clk, pc);
@@ -252,8 +203,6 @@ struct drm_encoder *mdp4_dtv_encoder_init(struct drm_device *dev)
 		goto fail;
 	}
 
-	bs_init(mdp4_dtv_encoder);
-
 	return encoder;
 
 fail:
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
index 18933bd81c77..e8ee92ab7956 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
@@ -222,17 +222,4 @@ static inline struct clk *mpd4_lvds_pll_init(struct drm_device *dev)
 }
 #endif
 
-#ifdef DOWNSTREAM_CONFIG_MSM_BUS_SCALING
-/* bus scaling data is associated with extra pointless platform devices,
- * "dtv", etc.. this is a bit of a hack, but we need a way for encoders
- * to find their pdata to make the bus-scaling stuff work.
- */
-static inline void *mdp4_find_pdata(const char *devname)
-{
-	struct device *dev;
-	dev = bus_find_device_by_name(&platform_bus_type, NULL, devname);
-	return dev ? dev->platform_data : NULL;
-}
-#endif
-
 #endif /* __MDP4_KMS_H__ */
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index 871f3514ef69..10eb3e5b218e 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -30,51 +30,10 @@ static struct mdp4_kms *get_kms(struct drm_encoder *encoder)
 	return to_mdp4_kms(to_mdp_kms(priv->kms));
 }
 
-#ifdef DOWNSTREAM_CONFIG_MSM_BUS_SCALING
-#include <mach/board.h>
-static void bs_init(struct mdp4_lcdc_encoder *mdp4_lcdc_encoder)
-{
-	struct drm_device *dev = mdp4_lcdc_encoder->base.dev;
-	struct lcdc_platform_data *lcdc_pdata = mdp4_find_pdata("lvds.0");
-
-	if (!lcdc_pdata) {
-		DRM_DEV_ERROR(dev->dev, "could not find lvds pdata\n");
-		return;
-	}
-
-	if (lcdc_pdata->bus_scale_table) {
-		mdp4_lcdc_encoder->bsc = msm_bus_scale_register_client(
-				lcdc_pdata->bus_scale_table);
-		DBG("lvds : bus scale client: %08x", mdp4_lcdc_encoder->bsc);
-	}
-}
-
-static void bs_fini(struct mdp4_lcdc_encoder *mdp4_lcdc_encoder)
-{
-	if (mdp4_lcdc_encoder->bsc) {
-		msm_bus_scale_unregister_client(mdp4_lcdc_encoder->bsc);
-		mdp4_lcdc_encoder->bsc = 0;
-	}
-}
-
-static void bs_set(struct mdp4_lcdc_encoder *mdp4_lcdc_encoder, int idx)
-{
-	if (mdp4_lcdc_encoder->bsc) {
-		DBG("set bus scaling: %d", idx);
-		msm_bus_scale_client_update_request(mdp4_lcdc_encoder->bsc, idx);
-	}
-}
-#else
-static void bs_init(struct mdp4_lcdc_encoder *mdp4_lcdc_encoder) {}
-static void bs_fini(struct mdp4_lcdc_encoder *mdp4_lcdc_encoder) {}
-static void bs_set(struct mdp4_lcdc_encoder *mdp4_lcdc_encoder, int idx) {}
-#endif
-
 static void mdp4_lcdc_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct mdp4_lcdc_encoder *mdp4_lcdc_encoder =
 			to_mdp4_lcdc_encoder(encoder);
-	bs_fini(mdp4_lcdc_encoder);
 	drm_encoder_cleanup(encoder);
 	kfree(mdp4_lcdc_encoder);
 }
@@ -348,8 +307,6 @@ static void mdp4_lcdc_encoder_disable(struct drm_encoder *encoder)
 			DRM_DEV_ERROR(dev->dev, "failed to disable regulator: %d\n", ret);
 	}
 
-	bs_set(mdp4_lcdc_encoder, 0);
-
 	mdp4_lcdc_encoder->enabled = false;
 }
 
@@ -382,8 +339,6 @@ static void mdp4_lcdc_encoder_enable(struct drm_encoder *encoder)
 	mdp4_crtc_set_config(encoder->crtc, config);
 	mdp4_crtc_set_intf(encoder->crtc, INTF_LCDC_DTV, 0);
 
-	bs_set(mdp4_lcdc_encoder, 1);
-
 	for (i = 0; i < ARRAY_SIZE(mdp4_lcdc_encoder->regs); i++) {
 		ret = regulator_enable(mdp4_lcdc_encoder->regs[i]);
 		if (ret)
@@ -480,8 +435,6 @@ struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
 	}
 	mdp4_lcdc_encoder->regs[2] = reg;
 
-	bs_init(mdp4_lcdc_encoder);
-
 	return encoder;
 
 fail:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

