Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED452CE507
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbgLDBYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:24:16 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:60610 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389460AbgLDBYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:24:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607045035; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=I0QnJWmIMnuok9uHRc1PVQwYIdeYos3kqOLg6ugIC30=; b=nokuR9mXCcpvcpUC/6CJLZq/RfH6EKLlm2ydNDAI6rpAvCdC+rqiOYk4W0aAWidHZY5154Wg
 n5lzu0wJDEg/y6A8BR/5lBf+rkPKoMH2g7q6otkkxRAJ0VAnuHkxnU/8rSsmss/syWyG+Uiq
 /oJ4keIA9jhf+GZyMKTnzPIxGkM=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fc98f92dc0fd8a31774d5e8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 04 Dec 2020 01:23:29
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5E55C43461; Fri,  4 Dec 2020 01:23:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36BB9C433ED;
        Fri,  4 Dec 2020 01:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36BB9C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, loic.poulain@linaro.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v4 6/8] bus: mhi: core: Check channel execution environment before issuing reset
Date:   Thu,  3 Dec 2020 17:23:15 -0800
Message-Id: <1607044997-19577-7-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607044997-19577-1-git-send-email-bbhatt@codeaurora.org>
References: <1607044997-19577-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A client can attempt to unprepare certain channels for transfer even
after the execution environment they are supposed to run in has changed.
In the event that happens, the device need not be notified of the reset
and the host can proceed with clean up for the channel context and
memory allocated for it on the host as the device will no longer be able
to respond to such a request.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 064f313..f4026af 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -1320,11 +1320,24 @@ static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
 	/* no more processing events for this channel */
 	mutex_lock(&mhi_chan->mutex);
 
+	if (!(BIT(mhi_cntrl->ee) & mhi_chan->ee_mask)) {
+		dev_err(dev,
+			"Current EE: %s Required EE Mask: 0x%x for chan: %s\n",
+			TO_MHI_EXEC_STR(mhi_cntrl->ee), mhi_chan->ee_mask,
+			mhi_chan->name);
+		goto exit_unprepare_channel;
+	}
+
 	ret = mhi_update_channel_state(mhi_cntrl, mhi_chan,
 				       MHI_CH_STATE_TYPE_RESET);
 	if (ret)
 		dev_err(dev, "Failed to reset channel, still resetting\n");
 
+exit_unprepare_channel:
+	write_lock_irq(&mhi_chan->lock);
+	mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+	write_unlock_irq(&mhi_chan->lock);
+
 	if (!mhi_chan->offload_ch) {
 		mhi_reset_chan(mhi_cntrl, mhi_chan);
 		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

