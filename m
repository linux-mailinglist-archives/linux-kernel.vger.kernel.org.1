Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D2F277BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIXW1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:27:35 -0400
Received: from z5.mailgun.us ([104.130.96.5]:44350 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgIXW1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:27:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600986453; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=b6hd9vEIgBC8C/bv60YQcRE+YfZoPUVhrMqUKZ+BjDo=; b=O3Nn342VTRoyvkW0ob78CW1J3lO4Z9Xs52zAZwaodedsVIqPY8cxRnVEBRGLo7KzROH5hQRQ
 Ggw+N3GC0n1i3YMcJSbGHgpLitMHiaiNhrOeeDBK2uuXTSkIiDEjo9T/mqhEgdmZBXYCCwLb
 nzYCe88SbTfZrfP6ehZnSkQG2E0=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f6d1d54d106659f82e808c5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 22:27:32
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 144C8C433CB; Thu, 24 Sep 2020 22:27:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1243CC433CA;
        Thu, 24 Sep 2020 22:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1243CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: return correct connection status after suspend/resume
Date:   Thu, 24 Sep 2020 15:27:22 -0700
Message-Id: <20200924222722.27885-1-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return connection status base on hpd realtime state status

Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 13 +++++++
 drivers/gpu/drm/msm/dp/dp_catalog.h |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 58 ++++++++++++-----------------
 drivers/gpu/drm/msm/dp/dp_reg.h     |  2 +
 4 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index b15b4ce4ba35..4f3679b7e262 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -572,6 +572,19 @@ void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog)
 	dp_write_aux(catalog, REG_DP_DP_HPD_CTRL, DP_DP_HPD_CTRL_HPD_EN);
 }
 
+u32 dp_catalog_hpd_get_state_status(struct dp_catalog *dp_catalog)
+{
+	struct dp_catalog_private *catalog = container_of(dp_catalog,
+				struct dp_catalog_private, dp_catalog);
+	u32 status = 0;
+
+	status = dp_read_aux(catalog, REG_DP_DP_HPD_INT_STATUS);
+	status &= DP_DP_HPD_STATE_STATUS_BITS_MASK;
+	status >>= DP_DP_HPD_STATE_STATUS_BITS_SHIFT;
+
+	return status;
+}
+
 u32 dp_catalog_hpd_get_intr_status(struct dp_catalog *dp_catalog)
 {
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 4b7666f1fe6f..6d257dbebf29 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -97,6 +97,7 @@ void dp_catalog_ctrl_enable_irq(struct dp_catalog *dp_catalog, bool enable);
 void dp_catalog_hpd_config_intr(struct dp_catalog *dp_catalog,
 			u32 intr_mask, bool en);
 void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog);
+u32 dp_catalog_hpd_get_state_status(struct dp_catalog *dp_catalog);
 u32 dp_catalog_hpd_get_intr_status(struct dp_catalog *dp_catalog);
 void dp_catalog_ctrl_phy_reset(struct dp_catalog *dp_catalog);
 int dp_catalog_ctrl_update_vx_px(struct dp_catalog *dp_catalog, u8 v_level,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e175aa3fd3a9..1f16508d0387 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -114,8 +114,6 @@ struct dp_display_private {
 	struct dp_event event_list[DP_EVENT_Q_MAX];
 	spinlock_t event_lock;
 
-	struct completion resume_comp;
-
 	struct dp_audio *audio;
 };
 
@@ -508,9 +506,6 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 		return 0;
 	}
 
-	if (state == ST_SUSPENDED)
-		tout = DP_TIMEOUT_NONE;
-
 	atomic_set(&dp->hpd_state, ST_CONNECT_PENDING);
 
 	hpd->hpd_high = 1;
@@ -798,8 +793,6 @@ static int dp_display_enable(struct dp_display_private *dp, u32 data)
 	if (!rc)
 		dp_display->power_on = true;
 
-	/* complete resume_comp regardless it is armed or not */
-	complete(&dp->resume_comp);
 	return rc;
 }
 
@@ -1151,9 +1144,6 @@ static int dp_display_probe(struct platform_device *pdev)
 	}
 
 	mutex_init(&dp->event_mutex);
-
-	init_completion(&dp->resume_comp);
-
 	g_dp_display = &dp->dp_display;
 
 	/* Store DP audio handle inside DP display */
@@ -1189,6 +1179,26 @@ static int dp_display_remove(struct platform_device *pdev)
 
 static int dp_pm_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dp_display_private *dp = platform_get_drvdata(pdev);
+	u32 status;
+
+	if (!dp) {
+		DRM_ERROR("DP driver bind failed. Invalid driver data\n");
+		return -EINVAL;
+	}
+
+	dp_display_host_init(dp);
+
+	dp_catalog_ctrl_hpd_config(dp->catalog);
+
+	status = dp_catalog_hpd_get_state_status(dp->catalog);
+
+	if (status)
+		dp->dp_display.is_connected = true;
+	else
+		dp->dp_display.is_connected = false;
+
 	return 0;
 }
 
@@ -1202,6 +1212,9 @@ static int dp_pm_suspend(struct device *dev)
 		return -EINVAL;
 	}
 
+	if (dp->core_initialized == true)
+		dp_display_disable(dp, 0);
+
 	atomic_set(&dp->hpd_state, ST_SUSPENDED);
 
 	return 0;
@@ -1317,19 +1330,6 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 	return 0;
 }
 
-static int dp_display_wait4resume_done(struct dp_display_private *dp)
-{
-	int ret = 0;
-
-	reinit_completion(&dp->resume_comp);
-	if (!wait_for_completion_timeout(&dp->resume_comp,
-				WAIT_FOR_RESUME_TIMEOUT_JIFFIES)) {
-		DRM_ERROR("wait4resume_done timedout\n");
-		ret = -ETIMEDOUT;
-	}
-	return ret;
-}
-
 int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
 {
 	int rc = 0;
@@ -1359,14 +1359,6 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
 	}
 
 	state =  atomic_read(&dp_display->hpd_state);
-	if (state == ST_SUSPENDED) {
-		/* start link training */
-		dp_add_event(dp_display, EV_HPD_PLUG_INT, 0, 0);
-		mutex_unlock(&dp_display->event_mutex);
-
-		/* wait until dp interface is up */
-		goto resume_done;
-	}
 
 	dp_display_enable(dp_display, 0);
 
@@ -1388,10 +1380,6 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
 	mutex_unlock(&dp_display->event_mutex);
 
 	return rc;
-
-resume_done:
-	dp_display_wait4resume_done(dp_display);
-	return rc;
 }
 
 int msm_dp_display_pre_disable(struct msm_dp *dp, struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 43042ff90a19..268602803d9a 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -32,6 +32,8 @@
 #define DP_DP_IRQ_HPD_INT_ACK			(0x00000002)
 #define DP_DP_HPD_REPLUG_INT_ACK		(0x00000004)
 #define DP_DP_HPD_UNPLUG_INT_ACK		(0x00000008)
+#define DP_DP_HPD_STATE_STATUS_BITS_MASK	(0x0000000F)
+#define DP_DP_HPD_STATE_STATUS_BITS_SHIFT	(0x1C)
 
 #define REG_DP_DP_HPD_INT_MASK			(0x0000000C)
 #define DP_DP_HPD_PLUG_INT_MASK			(0x00000001)

base-commit: 3c0f462da069af12211901ddf26f7e16e6951d9b
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

