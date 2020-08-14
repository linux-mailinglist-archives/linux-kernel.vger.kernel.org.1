Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB16244852
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHNKx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 06:53:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57956 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgHNKxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:53:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597402432; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=x7wA4+lvojLjr8mShenRnk8ElOYsHwhXwXEZ2cLlr/Q=; b=USSgOmET0T1dULPhdk8gsZm2zmci8JsbLPpg7yace3AP82/qJOqSYJlcHE8v6EWTLFFxCSYR
 vsIhNWfJ+avZgeXJ1xHhQZxnlOSF7w0AImsWanTp2Kqg20ec0bjRcO+GNTOgUbqfCVxJZq6X
 r5em3dqcGCgPp68c6MeARzPq0Qo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f366d36440a07969a0a9c0f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 10:53:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7057C43391; Fri, 14 Aug 2020 10:53:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rohkumar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 971E4C433C6;
        Fri, 14 Aug 2020 10:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 971E4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ajit Pandey <ajitp@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v6 01/12] ASoC: qcom: Add common array to initialize soc based core clocks
Date:   Fri, 14 Aug 2020 16:22:57 +0530
Message-Id: <1597402388-14112-2-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597402388-14112-1-git-send-email-rohitkr@codeaurora.org>
References: <1597402388-14112-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Pandey <ajitp@codeaurora.org>

LPASS variants have their own soc specific clocks that needs to be
enabled for MI2S audio support. Added a common variable in drvdata to
initialize such clocks using bulk clk api. Such clock names is
defined in variants specific data and needs to fetched during init.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-apq8016.c | 39 +++++++++++++++++++--------------------
 sound/soc/qcom/lpass.h         | 10 +++++++---
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index b3610d0..8210e37 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -161,32 +161,27 @@ static int apq8016_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
 static int apq8016_lpass_init(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
+	struct lpass_variant *variant = drvdata->variant;
 	struct device *dev = &pdev->dev;
-	int ret;
+	int ret, i;
 
-	drvdata->pcnoc_mport_clk = devm_clk_get(dev, "pcnoc-mport-clk");
-	if (IS_ERR(drvdata->pcnoc_mport_clk)) {
-		dev_err(dev, "error getting pcnoc-mport-clk: %ld\n",
-			PTR_ERR(drvdata->pcnoc_mport_clk));
-		return PTR_ERR(drvdata->pcnoc_mport_clk);
-	}
 
-	ret = clk_prepare_enable(drvdata->pcnoc_mport_clk);
+	drvdata->clks = devm_kcalloc(dev, variant->num_clks,
+				     sizeof(*drvdata->clks), GFP_KERNEL);
+	drvdata->num_clks = variant->num_clks;
+
+	for (i = 0; i < drvdata->num_clks; i++)
+		drvdata->clks[i].id = variant->clk_name[i];
+
+	ret = devm_clk_bulk_get(dev, drvdata->num_clks, drvdata->clks);
 	if (ret) {
-		dev_err(dev, "Error enabling pcnoc-mport-clk: %d\n", ret);
+		dev_err(dev, "Failed to get clocks %d\n", ret);
 		return ret;
 	}
 
-	drvdata->pcnoc_sway_clk = devm_clk_get(dev, "pcnoc-sway-clk");
-	if (IS_ERR(drvdata->pcnoc_sway_clk)) {
-		dev_err(dev, "error getting pcnoc-sway-clk: %ld\n",
-			PTR_ERR(drvdata->pcnoc_sway_clk));
-		return PTR_ERR(drvdata->pcnoc_sway_clk);
-	}
-
-	ret = clk_prepare_enable(drvdata->pcnoc_sway_clk);
+	ret = clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
 	if (ret) {
-		dev_err(dev, "Error enabling pcnoc_sway_clk: %d\n", ret);
+		dev_err(dev, "apq8016 clk_enable failed\n");
 		return ret;
 	}
 
@@ -197,8 +192,7 @@ static int apq8016_lpass_exit(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(drvdata->pcnoc_mport_clk);
-	clk_disable_unprepare(drvdata->pcnoc_sway_clk);
+	clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
 
 	return 0;
 }
@@ -219,6 +213,11 @@ static struct lpass_variant apq8016_data = {
 	.wrdma_reg_stride	= 0x1000,
 	.wrdma_channel_start	= 5,
 	.wrdma_channels		= 2,
+	.clk_name		= (const char*[]) {
+				   "pcnoc-mport-clk",
+				   "pcnoc-sway-clk",
+				  },
+	.num_clks		= 2,
 	.dai_driver		= apq8016_lpass_cpu_dai_driver,
 	.num_dai		= ARRAY_SIZE(apq8016_lpass_cpu_dai_driver),
 	.dai_osr_clk_names	= (const char *[]) {
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index bd19ec5..450020e 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -51,9 +51,9 @@ struct lpass_data {
 	/* used it for handling interrupt per dma channel */
 	struct snd_pcm_substream *substream[LPASS_MAX_DMA_CHANNELS];
 
-	/* 8016 specific */
-	struct clk *pcnoc_mport_clk;
-	struct clk *pcnoc_sway_clk;
+	/* SOC specific clock list */
+	struct clk_bulk_data *clks;
+	int num_clks;
 
 };
 
@@ -89,6 +89,10 @@ struct lpass_variant {
 	int num_dai;
 	const char * const *dai_osr_clk_names;
 	const char * const *dai_bit_clk_names;
+
+	/* SOC specific clocks configuration */
+	const char **clk_name;
+	int num_clks;
 };
 
 /* register the platform driver from the CPU DAI driver */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

