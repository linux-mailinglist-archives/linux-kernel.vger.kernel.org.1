Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282B62A5829
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgKCUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:49:43 -0500
Received: from z5.mailgun.us ([104.130.96.5]:50770 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731603AbgKCUtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:49:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604436575; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=G7R58XQghOvRHKSp4QYRhaBuVDGOZgFKpr4YuVFG5hk=; b=t4QDgtNbWW/h2MYtP5nYNs+PMC0JzNiO9oi4LLeGtX8b/mYHmMT3Xwvq4CSj1dM2v34WlMH1
 Fss04IQiSLFZdZs96dvZF5mAgkSE9906DwU0SGv8fImLDXUkKukEbQkiFEgw6kq43VUvXHsT
 gtJWQ3mibD++M2fZbaFhM1Q9TMA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fa1c25f23306fb602cb02ea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 20:49:35
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 04B15C384FA; Tue,  3 Nov 2020 20:49:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 066EDC384FA;
        Tue,  3 Nov 2020 20:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 066EDC384FA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>, tanmay@codeaurora.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/msm/dp: skip checking LINK_STATUS_UPDATED bit
Date:   Tue,  3 Nov 2020 12:49:01 -0800
Message-Id: <20201103204902.11899-3-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103204902.11899-1-khsieh@codeaurora.org>
References: <20201103204902.11899-1-khsieh@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dongle will not clear LINK_STATUS_UPDATED bit after
DPCD read which cause link training failed. This patch
just read 6 bytes of DPCD link status from sink and return
without checking LINK_STATUS_UPDATED bit.
Only 8 bits are used to represent link rate at sinker DPCD.
The really link rate is 2.7Mb times the 8 bits value.
For example, 0x0A at DPCD is equal to 2.7Gb (10 * 2.7Mb).
This patch also convert 8 bits value of DPCD to really link
rate to fix worng link rate error during phy compliance test.

Fixes: fd4a29bed29b (drm/msm/dp: DisplayPort PHY compliance tests fixup)
Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 20 ++++++--------------
 drivers/gpu/drm/msm/dp/dp_link.c | 29 ++++++++++++++---------------
 2 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index c7af040ce252..b9ca844ce2ad 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1061,23 +1061,15 @@ static bool dp_ctrl_train_pattern_set(struct dp_ctrl_private *ctrl,
 static int dp_ctrl_read_link_status(struct dp_ctrl_private *ctrl,
 				    u8 *link_status)
 {
-	int len = 0;
-	u32 const offset = DP_LANE_ALIGN_STATUS_UPDATED - DP_LANE0_1_STATUS;
-	u32 link_status_read_max_retries = 100;
-
-	while (--link_status_read_max_retries) {
-		len = drm_dp_dpcd_read_link_status(ctrl->aux,
-			link_status);
-		if (len != DP_LINK_STATUS_SIZE) {
-			DRM_ERROR("DP link status read failed, err: %d\n", len);
-			return len;
-		}
+	int ret = 0, len;
 
-		if (!(link_status[offset] & DP_LINK_STATUS_UPDATED))
-			return 0;
+	len = drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
+	if (len != DP_LINK_STATUS_SIZE) {
+		DRM_ERROR("DP link status read failed, err: %d\n", len);
+		ret = -EINVAL;
 	}
 
-	return -ETIMEDOUT;
+	return ret;
 }
 
 static int dp_ctrl_link_train_1(struct dp_ctrl_private *ctrl,
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 49d7fad36fc4..be986da78c4a 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -773,7 +773,8 @@ static int dp_link_process_link_training_request(struct dp_link_private *link)
 			link->request.test_lane_count);
 
 	link->dp_link.link_params.num_lanes = link->request.test_lane_count;
-	link->dp_link.link_params.rate = link->request.test_link_rate;
+	link->dp_link.link_params.rate = 
+		drm_dp_bw_code_to_link_rate(link->request.test_link_rate);
 
 	return 0;
 }
@@ -943,22 +944,20 @@ static u8 get_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
  */
 static int dp_link_process_link_status_update(struct dp_link_private *link)
 {
-	if (!(get_link_status(link->link_status,
-				DP_LANE_ALIGN_STATUS_UPDATED) &
-				DP_LINK_STATUS_UPDATED) ||
-			(drm_dp_clock_recovery_ok(link->link_status,
-					link->dp_link.link_params.num_lanes) &&
-			drm_dp_channel_eq_ok(link->link_status,
-					link->dp_link.link_params.num_lanes)))
-		return -EINVAL;
+       bool channel_eq_done = drm_dp_channel_eq_ok(link->link_status,
+                       link->dp_link.link_params.num_lanes);
 
-	DRM_DEBUG_DP("channel_eq_done = %d, clock_recovery_done = %d\n",
-			drm_dp_clock_recovery_ok(link->link_status,
-			link->dp_link.link_params.num_lanes),
-			drm_dp_clock_recovery_ok(link->link_status,
-			link->dp_link.link_params.num_lanes));
+       bool clock_recovery_done = drm_dp_clock_recovery_ok(link->link_status,
+                       link->dp_link.link_params.num_lanes);
 
-	return 0;
+       DRM_DEBUG_DP("channel_eq_done = %d, clock_recovery_done = %d\n",
+                        channel_eq_done, clock_recovery_done);
+
+       if (channel_eq_done && clock_recovery_done)
+               return -EINVAL;
+
+
+       return 0;
 }
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

