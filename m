Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D059E282FD1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 06:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJEEtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 00:49:15 -0400
Received: from z5.mailgun.us ([104.130.96.5]:42550 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgJEEtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 00:49:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601873354; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=OyZzbSCMZvuV3yEOZsiya4LXwpjTPN3Uu7YR7mN2EKQ=; b=vhvPChzvCfr9fEFS1bVFulm/UHIt2ae3OtRxWBwHe5HUegWYXHTQLtkwaNmg7irz5leDnE4a
 6BeU01ItOrPQUZnblz09d+EO291PxunN6J8dwJsS57mnGb1fBJUq6rpAgZskUZ+ZSVO16LvW
 EEBDRWa6UKEW6bAdYjEzwB+fNrc=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f7aa5c9ef891f1ee2cbbc7b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Oct 2020 04:49:13
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFD4EC433FE; Mon,  5 Oct 2020 04:49:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDDF3C433A1;
        Mon,  5 Oct 2020 04:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDDF3C433A1
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
        Srinivasa Rao <srivasam@codeaurora.org>
Subject: [PATCH v10 4/7] Asoc: qcom: lpass:Update lpaif_dmactl members order
Date:   Mon,  5 Oct 2020 10:18:27 +0530
Message-Id: <1601873310-1894-5-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601873310-1894-1-git-send-email-srivasam@codeaurora.org>
References: <1601873310-1894-1-git-send-email-srivasam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>

Update the lpaif_dmactl struct members order to match
HDMI reg map members sequence. Separate Interface reg map
as it is used for I2S control but not for HDMI control,
to make use of bulk API, which makes code more readable.

Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivasa Rao <srivasam@codeaurora.org>
---
 sound/soc/qcom/lpass-platform.c | 8 ++++----
 sound/soc/qcom/lpass.h          | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index e7cf4e5..db0d959 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -71,13 +71,13 @@ static int lpass_platform_alloc_dmactl_fields(struct device *dev,
 	rd_dmactl = drvdata->rd_dmactl;
 	wr_dmactl = drvdata->wr_dmactl;
 
-	rval = devm_regmap_field_bulk_alloc(dev, map, &rd_dmactl->bursten,
-					    &v->rdma_bursten, 6);
+	rval = devm_regmap_field_bulk_alloc(dev, map, &rd_dmactl->intf,
+					    &v->rdma_intf, 6);
 	if (rval)
 		return rval;
 
-	return devm_regmap_field_bulk_alloc(dev, map, &wr_dmactl->bursten,
-					    &v->wrdma_bursten, 6);
+	return devm_regmap_field_bulk_alloc(dev, map, &wr_dmactl->intf,
+					    &v->wrdma_intf, 6);
 }
 
 static int lpass_platform_pcmops_open(struct snd_soc_component *component,
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 51c9991..7089d4c 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -31,9 +31,9 @@ struct lpaif_i2sctl {
 
 
 struct lpaif_dmactl {
+	struct regmap_field *intf;
 	struct regmap_field *bursten;
 	struct regmap_field *wpscnt;
-	struct regmap_field *intf;
 	struct regmap_field *fifowm;
 	struct regmap_field *enable;
 	struct regmap_field *dyncclk;
@@ -110,17 +110,17 @@ struct lpass_variant {
 	struct reg_field bitwidth;
 
 	/* RD_DMA Register fields */
+	struct reg_field rdma_intf;
 	struct reg_field rdma_bursten;
 	struct reg_field rdma_wpscnt;
-	struct reg_field rdma_intf;
 	struct reg_field rdma_fifowm;
 	struct reg_field rdma_enable;
 	struct reg_field rdma_dyncclk;
 
 	/* WR_DMA Register fields */
+	struct reg_field wrdma_intf;
 	struct reg_field wrdma_bursten;
 	struct reg_field wrdma_wpscnt;
-	struct reg_field wrdma_intf;
 	struct reg_field wrdma_fifowm;
 	struct reg_field wrdma_enable;
 	struct reg_field wrdma_dyncclk;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

