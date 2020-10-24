Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79DE297A49
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758875AbgJXCCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 22:02:08 -0400
Received: from z5.mailgun.us ([104.130.96.5]:42199 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758868AbgJXCCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 22:02:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603504927; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=r6WXm7fUc75JQS+4QRhVTKuODgDJjkWKH6z/JMqj3q8=; b=eK4eIkt1JJbWJaqOR/1KPMPxxQ7R7C8ck55yqEm8aKSoN5m4cBqE5cKxUnDYA9/yocyebBp+
 1VeSIC0OI68Iiku9x8kQSzYoGjqT9FjpaKH/fcjMkw+vCQ7sUG2SlL3tjMxtddIni+rbyIyH
 WOOBM/RGFVhdhpzFKHkXOFHNeGo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f938ad307e168223374798d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 24 Oct 2020 02:00:51
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 57EE8C433FE; Sat, 24 Oct 2020 02:00:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 996F3C433CB;
        Sat, 24 Oct 2020 02:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 996F3C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v1 1/2] bus: mhi: core: Count number of HW channels supported by controller
Date:   Fri, 23 Oct 2020 19:00:42 -0700
Message-Id: <1603504843-38557-2-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603504843-38557-1-git-send-email-hemantk@codeaurora.org>
References: <1603504843-38557-1-git-send-email-hemantk@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device provides the total number of HW channels it supports using MHI
configuration register. Host supported HW channels shall not exceed
that value. In order to make this check, a counter is needed to store
total number of HW channels required by host.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/init.c     | 2 ++
 drivers/bus/mhi/core/internal.h | 1 +
 include/linux/mhi.h             | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 0ffdebd..70fd6af 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -725,6 +725,8 @@ static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
 		mhi_chan = &mhi_cntrl->mhi_chan[chan];
 		mhi_chan->name = ch_cfg->name;
 		mhi_chan->chan = chan;
+		if (chan >= MHI_HW_CHAN_START_IDX)
+			mhi_cntrl->hw_chan++;
 
 		mhi_chan->tre_ring.elements = ch_cfg->num_elements;
 		if (!mhi_chan->tre_ring.elements)
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 7989269..3d8e480 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -454,6 +454,7 @@ enum mhi_pm_state {
 #define PRIMARY_CMD_RING		0
 #define MHI_DEV_WAKE_DB			127
 #define MHI_MAX_MTU			0xffff
+#define MHI_HW_CHAN_START_IDX		100
 #define MHI_RANDOM_U32_NONZERO(bmsk)	(prandom_u32_max(bmsk) + 1)
 
 enum mhi_er_type {
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index d4841e5..ea441d2 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -389,6 +389,7 @@ struct mhi_controller {
 	struct list_head lpm_chans;
 	int *irq;
 	u32 max_chan;
+	u32 hw_chan;
 	u32 total_ev_rings;
 	u32 hw_ev_rings;
 	u32 sw_ev_rings;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

