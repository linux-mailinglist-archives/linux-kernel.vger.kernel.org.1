Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4855426C439
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 17:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgIPPbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 11:31:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24396 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgIPP3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:29:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600270079; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=dDGHebymEtnWtj+KEzXL3GxkzGbLGkG+sDA+wM+k1Ts=; b=QKqDbLt5XRu6z44XD9nSRoCIdw1lsMtvdvxkuYbdC0vnkjibRL3HU+LTz2SzbAwPskgeARSa
 tiK8FVadpXV0x9nvtTyR46767kCoT9BjDyJIaCT+WD1SPBcZ8BBseD9FCWDYc0rdtci1Y+7h
 yokH0mgwQ1qHurDVHO26YVPI7jk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f6226e632925f96e1cef48c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 14:53:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D468AC433FE; Wed, 16 Sep 2020 14:53:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C76CC433F0;
        Wed, 16 Sep 2020 14:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C76CC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, evgreen@chromium.org, swboyd@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2] remoteproc: qcom_q6v5: Assign mpss region to Q6 before MBA boot
Date:   Wed, 16 Sep 2020 20:22:52 +0530
Message-Id: <20200916145252.16024-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On secure devices which support warm reset, the MBA firmware requires
access to the modem region to clear them out. Hence provide Q6 access
to this region before MBA boot. This will be a nop during a modem SSR.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

V2:
 * Fixup comments as suggested by Bjorn. 

 drivers/remoteproc/qcom_q6v5_mss.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index c401bcc263fa..f989ca81d374 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -931,6 +931,16 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 		goto assert_reset;
 	}
 
+	/* Some versions of the MBA firmware will upon boot wipe the MPSS region as well, so provide
+	 * the Q6 access to this region.
+	 */
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false, true,
+				      qproc->mpss_phys, qproc->mpss_size);
+	if (ret) {
+		dev_err(qproc->dev, "assigning Q6 access to mpss memory failed: %d\n", ret);
+		goto disable_active_clks;
+	}
+
 	/* Assign MBA image access in DDR to q6 */
 	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false, true,
 				      qproc->mba_phys, qproc->mba_size);
@@ -1137,8 +1147,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 
 	/**
 	 * In case of a modem subsystem restart on secure devices, the modem
-	 * memory can be reclaimed only after MBA is loaded. For modem cold
-	 * boot this will be a nop
+	 * memory can be reclaimed only after MBA is loaded.
 	 */
 	q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, true, false,
 				qproc->mpss_phys, qproc->mpss_size);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

