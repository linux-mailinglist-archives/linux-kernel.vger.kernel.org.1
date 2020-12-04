Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BDD2CE510
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389479AbgLDBYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:24:31 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:55222 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389546AbgLDBY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:24:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607045048; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hJnjGcVdVXRfhtw+a1oOePEQRYHTpsS2Nqst8Le7kxE=; b=E+Vy49pvTPJCR67ygkwM0Bs/L/+1CIpHqajNz2+FY152ANtC5vJ8LoJocp6N/k2tH58DVDDA
 hZmytdcj6GCMRe/MsHFnPhRV3sleIExsYsmCgyIry3q3eStxOyXD5IDVFBhK3Vqijzlp39K6
 /Knn9n7HisAVAkPiOl30RZU8tFs=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fc98f8f7d6a74e409b2983d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 04 Dec 2020 01:23:27
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1342AC433CA; Fri,  4 Dec 2020 01:23:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C19CC433C6;
        Fri,  4 Dec 2020 01:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C19CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, loic.poulain@linaro.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v4 1/8] bus: mhi: core: Allow sending the STOP channel command
Date:   Thu,  3 Dec 2020 17:23:10 -0800
Message-Id: <1607044997-19577-2-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607044997-19577-1-git-send-email-bbhatt@codeaurora.org>
References: <1607044997-19577-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to allow sending the STOP channel command. If a
client driver would like to STOP a channel and have the device
retain the channel context instead of issuing a RESET to it and
clearing the context, this would provide support for it after
the ability to send this command is exposed to clients.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 702c31b..a7bb8a7 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -1193,6 +1193,11 @@ int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
 		cmd_tre->dword[0] = MHI_TRE_CMD_RESET_DWORD0;
 		cmd_tre->dword[1] = MHI_TRE_CMD_RESET_DWORD1(chan);
 		break;
+	case MHI_CMD_STOP_CHAN:
+		cmd_tre->ptr = MHI_TRE_CMD_STOP_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_STOP_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_STOP_DWORD1(chan);
+		break;
 	case MHI_CMD_START_CHAN:
 		cmd_tre->ptr = MHI_TRE_CMD_START_PTR;
 		cmd_tre->dword[0] = MHI_TRE_CMD_START_DWORD0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

