Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7912E6EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgL2Iey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:34:54 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:27513 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgL2Iex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:34:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609230868; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/xH+QM/cA6wZt3vjwXZX4/z9l+hds6utzd84arUehbs=; b=Eld8SFnRCcr5wLzoVieYac9vk+VGAj9EKIe128CTaOkW/Et5q7Bk1+tA7ygnA1B8Fpytvc+n
 aS7GvR8GPVjGNABpBoEbAP42LZ7xPOH9kPKXJzaYq+G7LcnU0ID3yGuiHKqo3MGCokphE5QI
 5yN1zgQWkECkOVvSqpo3tFcKZIU=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5feae9e77bc801dc4fc2547c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Dec 2020 08:33:43
 GMT
Sender: mkshah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 05BD2C433C6; Tue, 29 Dec 2020 08:33:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EE21C433CA;
        Tue, 29 Dec 2020 08:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EE21C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dianders@chromium.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v2] drivers: qcom: rpmh-rsc: Do not read back the register write on trigger
Date:   Tue, 29 Dec 2020 14:03:21 +0530
Message-Id: <1609230801-31721-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

When triggering a TCS to send its contents, reading back the trigger
value may return an incorrect value. That is because, writing the
trigger may raise an interrupt which could be handled immediately and
the trigger value could be reset in the interrupt handler.

A write_tcs_reg_sync() would read back the value that is written and try
to match it to the value written to ensure that the value is written,
but if that value is different, we may see false error for same.

Fixes: 658628e7ef78 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs")
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- Add Fixes tag
- Add Reviewed-by tag
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 37969dc..0b082ec 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -364,7 +364,7 @@ static void __tcs_set_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)
 		enable = TCS_AMC_MODE_ENABLE;
 		write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
 		enable |= TCS_AMC_MODE_TRIGGER;
-		write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+		write_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, enable);
 	}
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

