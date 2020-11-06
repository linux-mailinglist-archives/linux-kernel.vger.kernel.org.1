Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F982A8B6D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 01:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbgKFAfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 19:35:06 -0500
Received: from z5.mailgun.us ([104.130.96.5]:32973 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732181AbgKFAfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 19:35:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604622905; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=0Q7uxO1LWtRVx9R2bTxwSjQpiLhY9g+LOFjgEIfMAVc=; b=oRXuc0Lnix9vXi8sEC2cunlQZmbcguFEhh8IHwcLUsGRvT+mb8kb41AVl7vnZ8ToB9y6jSoE
 1q5q8sqt2BHaA+sPSvnpI2oahljrupFNeT2hQObPxhj+gxmwRa+wMzmaCvF4djpq+RPIBUey
 a8EUy/XA3jlsQ6oRVAkmfjTePHA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fa49a20f00e907e28cb57e9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 00:34:40
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EDEADC433C6; Fri,  6 Nov 2020 00:34:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53769C433C8;
        Fri,  6 Nov 2020 00:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53769C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 5/6] bus: mhi: core: Rename RDDM download function to use proper words
Date:   Thu,  5 Nov 2020 16:34:28 -0800
Message-Id: <1604622869-40212-6-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604622869-40212-1-git-send-email-bbhatt@codeaurora.org>
References: <1604622869-40212-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mhi_download_rddm_img() uses a shorter version of the word image.
Expand it and rename the function to mhi_download_rddm_image().

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/boot.c | 4 ++--
 include/linux/mhi.h         | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 6b6fd96..16244cc 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -147,7 +147,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
 }
 
 /* Download RDDM image from device */
-int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
+int mhi_download_rddm_image(struct mhi_controller *mhi_cntrl, bool in_panic)
 {
 	void __iomem *base = mhi_cntrl->bhie;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
@@ -169,7 +169,7 @@ int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
 
 	return (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
 }
-EXPORT_SYMBOL_GPL(mhi_download_rddm_img);
+EXPORT_SYMBOL_GPL(mhi_download_rddm_image);
 
 static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 			    const struct mhi_buf *mhi_buf)
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 9225d55..52b3c60 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -645,12 +645,12 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl);
 int mhi_pm_resume(struct mhi_controller *mhi_cntrl);
 
 /**
- * mhi_download_rddm_img - Download ramdump image from device for
- *                         debugging purpose.
+ * mhi_download_rddm_image - Download ramdump image from device for
+ *                           debugging purpose.
  * @mhi_cntrl: MHI controller
  * @in_panic: Download rddm image during kernel panic
  */
-int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic);
+int mhi_download_rddm_image(struct mhi_controller *mhi_cntrl, bool in_panic);
 
 /**
  * mhi_force_rddm_mode - Force device into rddm mode
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

