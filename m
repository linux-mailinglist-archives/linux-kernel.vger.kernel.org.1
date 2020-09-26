Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06AD279704
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 06:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgIZEvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 00:51:53 -0400
Received: from z5.mailgun.us ([104.130.96.5]:49195 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730006AbgIZEvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 00:51:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601095912; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=DTXwOW1hmbrLyDmXb2wq+4otAe5l4L0w+uetysGZBWs=; b=wT9LL8q9o8guxKVs/vGEfDg5mF9jnm1GXeQNbn8mQ7gsb10VoHZoUXyWU+fIeezdjThT4tWj
 LkiDqSWv5usdVwuPfzkG+Ie36V6g8eJbvZ9iRDQWiDbYS4Hp3Ei1N9pvN6VbcpqzuCJKJfOv
 IR3cUBpq9SYZgDuWBIeKBHHzfZ4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f6ec8e6e064df29c647299e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 26 Sep 2020 04:51:50
 GMT
Sender: tanmay=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDA04C43385; Sat, 26 Sep 2020 04:51:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from linuxdisplay-lab-04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tanmay)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C708C433CA;
        Sat, 26 Sep 2020 04:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C708C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tanmay@codeaurora.org
From:   Tanmay Shah <tanmay@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc:     robdclark@gmail.com, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        seanpaul@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        aravindh@codeaurora.org, abhinavk@codeaurora.org,
        khsieh@codeaurora.org, Tanmay Shah <tanmay@codeaurora.org>
Subject: [PATCH] drm/msm/dp: DisplayPort PHY compliance tests fixup
Date:   Fri, 25 Sep 2020 21:50:48 -0700
Message-Id: <20200926045048.16175-1-tanmay@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bandwidth code was being used as test link rate. Fix this by converting
bandwidth code to test link rate

Do not reset voltage and pre-emphasis level during IRQ HPD attention
interrupt. Also fix pre-emphasis parsing during test link status process

Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  3 ---
 drivers/gpu/drm/msm/dp/dp_display.c |  1 +
 drivers/gpu/drm/msm/dp/dp_link.c    | 12 +++++++++++-
 drivers/gpu/drm/msm/dp/dp_link.h    |  1 +
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 2e3e1917351f..872b12689e31 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1643,9 +1643,6 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 	if (rc)
 		return rc;
 
-	ctrl->link->phy_params.p_level = 0;
-	ctrl->link->phy_params.v_level = 0;
-
 	while (--link_train_max_retries &&
 		!atomic_read(&ctrl->dp_ctrl.aborted)) {
 		rc = dp_ctrl_reinitialize_mainlink(ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e175aa3fd3a9..ae9989ece73f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -335,6 +335,7 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
 	dp->dp_display.max_pclk_khz = DP_MAX_PIXEL_CLK_KHZ;
 	dp->dp_display.max_dp_lanes = dp->parser->max_dp_lanes;
 
+	dp_link_reset_phy_params_vx_px(dp->link);
 	rc = dp_ctrl_on_link(dp->ctrl);
 	if (rc) {
 		DRM_ERROR("failed to complete DP link training\n");
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index c811da515fb3..49d7fad36fc4 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -869,6 +869,9 @@ static int dp_link_parse_vx_px(struct dp_link_private *link)
 		drm_dp_get_adjust_request_voltage(link->link_status, 0);
 	link->dp_link.phy_params.p_level =
 		drm_dp_get_adjust_request_pre_emphasis(link->link_status, 0);
+
+	link->dp_link.phy_params.p_level >>= DP_TRAIN_PRE_EMPHASIS_SHIFT;
+
 	DRM_DEBUG_DP("Requested: v_level = 0x%x, p_level = 0x%x\n",
 			link->dp_link.phy_params.v_level,
 			link->dp_link.phy_params.p_level);
@@ -911,7 +914,8 @@ static int dp_link_process_phy_test_pattern_request(
 			link->request.test_lane_count);
 
 	link->dp_link.link_params.num_lanes = link->request.test_lane_count;
-	link->dp_link.link_params.rate = link->request.test_link_rate;
+	link->dp_link.link_params.rate =
+		drm_dp_bw_code_to_link_rate(link->request.test_link_rate);
 
 	ret = dp_link_parse_vx_px(link);
 
@@ -1156,6 +1160,12 @@ int dp_link_adjust_levels(struct dp_link *dp_link, u8 *link_status)
 	return 0;
 }
 
+void dp_link_reset_phy_params_vx_px(struct dp_link *dp_link)
+{
+	dp_link->phy_params.v_level = 0;
+	dp_link->phy_params.p_level = 0;
+}
+
 u32 dp_link_get_test_bits_depth(struct dp_link *dp_link, u32 bpp)
 {
 	u32 tbd;
diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
index 49811b6221e5..9dd4dd926530 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.h
+++ b/drivers/gpu/drm/msm/dp/dp_link.h
@@ -135,6 +135,7 @@ static inline u32 dp_link_bit_depth_to_bpc(u32 tbd)
 	}
 }
 
+void dp_link_reset_phy_params_vx_px(struct dp_link *dp_link);
 u32 dp_link_get_test_bits_depth(struct dp_link *dp_link, u32 bpp);
 int dp_link_process_request(struct dp_link *dp_link);
 int dp_link_get_colorimetry_config(struct dp_link *dp_link);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

