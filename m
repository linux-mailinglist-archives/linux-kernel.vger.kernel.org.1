Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5A22B9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGWWhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 18:37:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15620 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbgGWWhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:37:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595543832; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hzCCILvdutEOoElZcexPsK0xDQiZOeHuVxRPtnS4sYA=; b=Y1djkcJSrLLlultGrlUgtDBy5wqjVxFRuPsz4jpg9ND+Yh7j4koC5cFMgqY9qs62MIFMaOvf
 LUYHY/SNqCOLohOk9NG67bkD1tBkTA7Nz3b6jFqvbXgeJ1JMYleHvDRjzB3VHPoLcdJot07k
 UzkoGiUKTGvJ10g9DJg1uCwmLYI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5f1a1105c7a053446acc9eac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 23 Jul 2020 22:36:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80187C433A0; Thu, 23 Jul 2020 22:36:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8465C43395;
        Thu, 23 Jul 2020 22:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8465C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v5 02/10] bus: mhi: core: Abort suspends due to outgoing pending packets
Date:   Thu, 23 Jul 2020 15:36:34 -0700
Message-Id: <1595543802-17859-3-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595543802-17859-1-git-send-email-bbhatt@codeaurora.org>
References: <1595543802-17859-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing check to abort suspends if a client driver has pending
outgoing packets to send to the device. This allows better utilization
of the MHI bus wherein clients on the host are not left waiting for
longer suspend or resume cycles to finish for data transfers.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 7960980..661d704 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -686,7 +686,8 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 
 	/* Return busy if there are any pending resources */
-	if (atomic_read(&mhi_cntrl->dev_wake))
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_cntrl->pending_pkts))
 		return -EBUSY;
 
 	/* Take MHI out of M2 state */
@@ -712,7 +713,8 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
 
-	if (atomic_read(&mhi_cntrl->dev_wake)) {
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_cntrl->pending_pkts)) {
 		write_unlock_irq(&mhi_cntrl->pm_lock);
 		return -EBUSY;
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

