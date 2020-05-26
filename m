Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052D11A121C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDGQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 12:51:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31780 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbgDGQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:51:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586278296; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hFSiKkJZ9nu472EA8ocqHRqoFfrxlmZqChgAOCPLZIc=; b=TvjUojyO9WwQxmbdJ0jYqBqHS2RxM8sn41Ph1jU6uzA9alVSj+C3JCP5/uWpAXYToevV7D1r
 kT3lndgg7fnQPidMAa4qdWRwtRpNqzASyU9ScAVhsBrT2aEthFnuldu6WxhiQDMXFF0eInm7
 ons9I/hDR0vf+gVr7qZVgh22H9c=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8caf8f.7ff7fa99d928-smtp-out-n01;
 Tue, 07 Apr 2020 16:51:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6BFCCC433BA; Tue,  7 Apr 2020 16:51:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EAD3C433F2;
        Tue,  7 Apr 2020 16:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EAD3C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 2/5] bus: mhi: core: Make sure to powerdown if mhi_sync_power_up fails
Date:   Tue,  7 Apr 2020 10:50:27 -0600
Message-Id: <1586278230-29565-3-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586278230-29565-1-git-send-email-jhugo@codeaurora.org>
References: <1586278230-29565-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powerdown is necessary if mhi_sync_power_up fails due to a timeout, to
clean up the resources.  Otherwise a BUG could be triggered when
attempting to clean up MSIs because the IRQ is still active from a
request_irq().

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/bus/mhi/core/pm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 3285c9e..fbffc6b 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -922,7 +922,11 @@ int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
 			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
 			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
 
-	return (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -EIO;
+	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -EIO;
+	if (ret)
+		mhi_power_down(mhi_cntrl, false);
+
+	return ret;
 }
 EXPORT_SYMBOL(mhi_sync_power_up);
 
-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
