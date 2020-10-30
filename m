Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13D22A1184
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgJ3XXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:23:32 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:53736 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgJ3XXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:23:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604100211; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Ho4iHvxmTWIcmtuuwphVvom7WXPJL4FifrbWU5Xvb84=; b=Ogfe0XhO3BztdfIk+qSYdBSH1oP1OiSIAhy0lOI83kC8X37vFH07nP9b/4i3U/tkKyGfpY1X
 2y6SU3+HR2LSYr39JyHmEOxAOF65AtProUwpAvMAqZcwOjq/sb89yTykDMN2VDUr90N4LWdM
 qFpkh166y5ZwYZ+GJBKJuPTZrpo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f9ca073d5ed89ceee1391c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Oct 2020 23:23:31
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 99221C433F0; Fri, 30 Oct 2020 23:23:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CE09C433F0;
        Fri, 30 Oct 2020 23:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4CE09C433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org,
        rnayak@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: promote irq_hpd handle to handle link trainign correctly
Date:   Fri, 30 Oct 2020 16:23:24 -0700
Message-Id: <20201030232324.11170-1-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dongles, such as Apple, required link training done at irq_hpd
request instead of plugin request. This patch promote irq_hpd hanlder
to handle link training and setup hpd_state correctly.

Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 13b66266cd69..55627530957c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -469,7 +469,9 @@ static int dp_display_handle_irq_hpd(struct dp_display_private *dp)
 static int dp_display_usbpd_attention_cb(struct device *dev)
 {
 	int rc = 0;
+	u32 sink_request;
 	struct dp_display_private *dp;
+	struct dp_usbpd *hpd;
 
 	if (!dev) {
 		DRM_ERROR("invalid dev\n");
@@ -483,10 +485,24 @@ static int dp_display_usbpd_attention_cb(struct device *dev)
 		return -ENODEV;
 	}
 
+	hpd = dp->usbpd;
+
 	/* check for any test request issued by sink */
 	rc = dp_link_process_request(dp->link);
-	if (!rc)
-		dp_display_handle_irq_hpd(dp);
+	if (!rc) {
+		sink_request = dp->link->sink_request;
+		if (sink_request & DS_PORT_STATUS_CHANGED) {
+			dp->hpd_state = ST_CONNECT_PENDING;
+			hpd->hpd_high = 1;
+		}
+
+		rc = dp_display_handle_irq_hpd(dp);
+
+		if (rc && sink_request & DS_PORT_STATUS_CHANGED) {
+			hpd->hpd_high = 0;
+			dp->hpd_state = ST_DISCONNECTED;
+		}
+	}
 
 	return rc;
 }

base-commit: 0e162b10644605428cd2596c12f8ed410cf9d2d9
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

