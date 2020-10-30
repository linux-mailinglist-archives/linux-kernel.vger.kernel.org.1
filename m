Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647D029FC94
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 05:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgJ3EL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 00:11:27 -0400
Received: from z5.mailgun.us ([104.130.96.5]:20282 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgJ3ELS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 00:11:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604031078; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wkZr8yAMWfrDxLTJYk/pE4tcsp7MzV+FFMEPUJwqI/I=; b=Y05f5yQzyoAWpUZoOfYP4KTvLP8N3rFLt+kljwN4MK8MQaEeJ37JekvYTwLFJ1ZDPxXXOb4U
 yrfNFXlniRe+NrNYDhJcPJwsQlNbezyJ2NC3JxjamWtJeHWoD20z26+vElAnO9S+w9j0XB8s
 KJ70WKRKnZnP21TL1d2VM2SY/yM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f9b925d519f072fa43d6b6d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Oct 2020 04:11:09
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 677B4C433C9; Fri, 30 Oct 2020 04:11:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B14DC433C8;
        Fri, 30 Oct 2020 04:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B14DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v3 06/12] bus: mhi: core: Move to an error state on any firmware load failure
Date:   Thu, 29 Oct 2020 21:10:51 -0700
Message-Id: <1604031057-32820-7-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604031057-32820-1-git-send-email-bbhatt@codeaurora.org>
References: <1604031057-32820-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MHI to a firmware download error state for a failure to find
the firmware files or to load SBL or EBL image using BHI/BHIe. This
helps detect an error state sooner and shortens the wait for a
synchronous power up timeout.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/boot.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 7d6b3a7..cec5010 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -425,13 +425,13 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 						     !mhi_cntrl->seg_len))) {
 		dev_err(dev,
 			"No firmware image defined or !sbl_size || !seg_len\n");
-		return;
+		goto error_fw_load;
 	}
 
 	ret = request_firmware(&firmware, fw_name, dev);
 	if (ret) {
 		dev_err(dev, "Error loading firmware: %d\n", ret);
-		return;
+		goto error_fw_load;
 	}
 
 	size = (mhi_cntrl->fbc_download) ? mhi_cntrl->sbl_size : firmware->size;
@@ -443,7 +443,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	buf = mhi_alloc_coherent(mhi_cntrl, size, &dma_addr, GFP_KERNEL);
 	if (!buf) {
 		release_firmware(firmware);
-		return;
+		goto error_fw_load;
 	}
 
 	/* Download image using BHI */
@@ -451,17 +451,17 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	ret = mhi_fw_load_bhi(mhi_cntrl, dma_addr, size);
 	mhi_free_coherent(mhi_cntrl, size, buf, dma_addr);
 
-	if (!mhi_cntrl->fbc_download || ret || mhi_cntrl->ee == MHI_EE_EDL)
-		release_firmware(firmware);
-
 	/* Error or in EDL mode, we're done */
 	if (ret) {
 		dev_err(dev, "MHI did not load image over BHI, ret: %d\n", ret);
-		return;
+		release_firmware(firmware);
+		goto error_fw_load;
 	}
 
-	if (mhi_cntrl->ee == MHI_EE_EDL)
+	if (mhi_cntrl->ee == MHI_EE_EDL) {
+		release_firmware(firmware);
 		return;
+	}
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
 	mhi_cntrl->dev_state = MHI_STATE_RESET;
@@ -474,13 +474,17 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	if (mhi_cntrl->fbc_download) {
 		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
 					   firmware->size);
-		if (ret)
-			goto error_alloc_fw_table;
+		if (ret) {
+			release_firmware(firmware);
+			goto error_fw_load;
+		}
 
 		/* Load the firmware into BHIE vec table */
 		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
 	}
 
+	release_firmware(firmware);
+
 fw_load_ee_pthru:
 	/* Transitioning into MHI RESET->READY state */
 	ret = mhi_ready_state_transition(mhi_cntrl);
@@ -509,11 +513,11 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	ret = mhi_fw_load_bhie(mhi_cntrl,
 			       /* Vector table is the last entry */
 			       &image_info->mhi_buf[image_info->entries - 1]);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "MHI did not load image over BHIe, ret: %d\n",
 			ret);
-
-	release_firmware(firmware);
+		goto error_fw_load;
+	}
 
 	return;
 
@@ -521,6 +525,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
 	mhi_cntrl->fbc_image = NULL;
 
-error_alloc_fw_table:
-	release_firmware(firmware);
+error_fw_load:
+	mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
+	wake_up_all(&mhi_cntrl->state_event);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

