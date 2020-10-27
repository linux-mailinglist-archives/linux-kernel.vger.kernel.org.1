Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0E29AAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750175AbgJ0LfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:35:18 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:50592 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411767AbgJ0LfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:35:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603798517; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=80VjFtcHJmmKKdKN4NkUpi73cDwAskFrHfK10HG4QSk=; b=KhSWtrY0jkoNRV5IpEvFVq1+CLYLXO1U05zSTMRnIKl9PqsoDLSwSCSTD2pvdSsGMrHYKhm4
 ortY4a6b2t2LcWBmxSy61iNE1nHMPnokySaXEe5i4Su1/TEkDLJUN3Aa0yn4p1ntSKImuJFV
 +GobCU8X241w/Q9F4WQU/+FahYQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f9805da856acb9b0926bcbe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Oct 2020 11:34:50
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61C05C433FE; Tue, 27 Oct 2020 11:34:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC47AC433CB;
        Tue, 27 Oct 2020 11:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC47AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=srivasam@codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH v2] Asoc: qcom: lpass-sc7180: Fix MI2S bitwidth field bit positions
Date:   Tue, 27 Oct 2020 17:04:34 +0530
Message-Id: <1603798474-4897-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>

Update SC7180 lpass_variant structure with proper I2S bitwidth
field bit positions, as bitwidth denotes 0 to 1 bits,
but previously used only 0 bit.

Fixes: cba62c8b49be ("ASoC: qcom: Add support for SC7180 lpass variant")
Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
Changes Since v1:
    -- Commit message is changed

 sound/soc/qcom/lpass-sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index c6292f9e..bc998d5 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -188,7 +188,7 @@ static struct lpass_variant sc7180_data = {
 	.micmode		= REG_FIELD_ID(0x1000, 4, 8, 3, 0x1000),
 	.micmono		= REG_FIELD_ID(0x1000, 3, 3, 3, 0x1000),
 	.wssrc			= REG_FIELD_ID(0x1000, 2, 2, 3, 0x1000),
-	.bitwidth		= REG_FIELD_ID(0x1000, 0, 0, 3, 0x1000),
+	.bitwidth		= REG_FIELD_ID(0x1000, 0, 1, 3, 0x1000),
 
 	.rdma_dyncclk		= REG_FIELD_ID(0xC000, 21, 21, 5, 0x1000),
 	.rdma_bursten		= REG_FIELD_ID(0xC000, 20, 20, 5, 0x1000),
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

