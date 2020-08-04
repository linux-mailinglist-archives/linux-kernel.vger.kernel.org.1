Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CBF23B65C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 10:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgHDIIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 04:08:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47524 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgHDIIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:08:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596528500; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=f5kfQP1eboY+NaqkYe/LSy+Eh7biZgr189iHUfCZn/U=; b=ZTyEAxfRaRCa5szUYgM2ryw+QPUaof06nZlDauqG/A1B4oOlutbAhLXR+ukTxzC8NwS1/jAZ
 UC7RXqlBHjtKJu8OUwseVZhhARl//uixRop9vNx2iT1TDASwe3SyInRV9hGbV24INaVe0h74
 OdeSFhG2a/++15LVodgbKHzSKBA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f29176b781ba1c5e2998828 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 08:08:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D492C433A1; Tue,  4 Aug 2020 08:08:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rohkumar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6FB3BC433C9;
        Tue,  4 Aug 2020 08:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FB3BC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v5 02/12] ASoC: qcom: lpass-cpu: Move ahbix clk to platform specific function
Date:   Tue,  4 Aug 2020 13:37:23 +0530
Message-Id: <1596528453-11437-3-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596528453-11437-1-git-send-email-rohitkr@codeaurora.org>
References: <1596528453-11437-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahbix clock is optional clock and not needed for all platforms.
Move it to lpass-apq8016/ipq806x as it is not needed for sc7180.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-apq8016.c | 27 ++++++++++++++++++++++++++
 sound/soc/qcom/lpass-cpu.c     | 40 ++++++++++-----------------------------
 sound/soc/qcom/lpass-ipq806x.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 30 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 8210e37..fe4c258 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -185,7 +185,33 @@ static int apq8016_lpass_init(struct platform_device *pdev)
 		return ret;
 	}
 
+	drvdata->ahbix_clk = devm_clk_get(dev, "ahbix-clk");
+	if (IS_ERR(drvdata->ahbix_clk)) {
+		dev_err(dev, "error getting ahbix-clk: %ld\n",
+				PTR_ERR(drvdata->ahbix_clk));
+		ret = PTR_ERR(drvdata->ahbix_clk);
+		goto err_ahbix_clk;
+	}
+
+	ret = clk_set_rate(drvdata->ahbix_clk, LPASS_AHBIX_CLOCK_FREQUENCY);
+	if (ret) {
+		dev_err(dev, "error setting rate on ahbix_clk: %d\n", ret);
+		goto err_ahbix_clk;
+	}
+	dev_dbg(dev, "set ahbix_clk rate to %lu\n",
+			clk_get_rate(drvdata->ahbix_clk));
+
+	ret = clk_prepare_enable(drvdata->ahbix_clk);
+	if (ret) {
+		dev_err(dev, "error enabling ahbix_clk: %d\n", ret);
+		goto err_ahbix_clk;
+	}
+
 	return 0;
+
+err_ahbix_clk:
+	clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
+	return ret;
 }
 
 static int apq8016_lpass_exit(struct platform_device *pdev)
@@ -193,6 +219,7 @@ static int apq8016_lpass_exit(struct platform_device *pdev)
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
 
 	clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
+	clk_disable_unprepare(drvdata->ahbix_clk);
 
 	return 0;
 }
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index e00a4af..f0c7e93 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -566,8 +566,13 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		return PTR_ERR(drvdata->lpaif_map);
 	}
 
-	if (variant->init)
-		variant->init(pdev);
+	if (variant->init) {
+		ret = variant->init(pdev);
+		if (ret) {
+			dev_err(dev, "error initializing variant: %d\n", ret);
+			return ret;
+		}
+	}
 
 	for (i = 0; i < variant->num_dai; i++) {
 		dai_id = variant->dai_driver[i].id;
@@ -594,46 +599,22 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		}
 	}
 
-	drvdata->ahbix_clk = devm_clk_get(dev, "ahbix-clk");
-	if (IS_ERR(drvdata->ahbix_clk)) {
-		dev_err(dev, "error getting ahbix-clk: %ld\n",
-			PTR_ERR(drvdata->ahbix_clk));
-		return PTR_ERR(drvdata->ahbix_clk);
-	}
-
-	ret = clk_set_rate(drvdata->ahbix_clk, LPASS_AHBIX_CLOCK_FREQUENCY);
-	if (ret) {
-		dev_err(dev, "error setting rate on ahbix_clk: %d\n", ret);
-		return ret;
-	}
-	dev_dbg(dev, "set ahbix_clk rate to %lu\n",
-		clk_get_rate(drvdata->ahbix_clk));
-
-	ret = clk_prepare_enable(drvdata->ahbix_clk);
-	if (ret) {
-		dev_err(dev, "error enabling ahbix_clk: %d\n", ret);
-		return ret;
-	}
-
 	ret = devm_snd_soc_register_component(dev,
 					      &lpass_cpu_comp_driver,
 					      variant->dai_driver,
 					      variant->num_dai);
 	if (ret) {
 		dev_err(dev, "error registering cpu driver: %d\n", ret);
-		goto err_clk;
+		goto err;
 	}
 
 	ret = asoc_qcom_lpass_platform_register(pdev);
 	if (ret) {
 		dev_err(dev, "error registering platform driver: %d\n", ret);
-		goto err_clk;
+		goto err;
 	}
 
-	return 0;
-
-err_clk:
-	clk_disable_unprepare(drvdata->ahbix_clk);
+err:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_platform_probe);
@@ -645,7 +626,6 @@ int asoc_qcom_lpass_cpu_platform_remove(struct platform_device *pdev)
 	if (drvdata->variant->exit)
 		drvdata->variant->exit(pdev);
 
-	clk_disable_unprepare(drvdata->ahbix_clk);
 
 	return 0;
 }
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 1987605..b7c0586 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -55,6 +55,47 @@ static struct snd_soc_dai_driver ipq806x_lpass_cpu_dai_driver = {
 	.ops    = &asoc_qcom_lpass_cpu_dai_ops,
 };
 
+static int ipq806x_lpass_init(struct platform_device *pdev)
+{
+	struct lpass_data *drvdata = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	drvdata->ahbix_clk = devm_clk_get(dev, "ahbix-clk");
+	if (IS_ERR(drvdata->ahbix_clk)) {
+		dev_err(dev, "error getting ahbix-clk: %ld\n",
+				PTR_ERR(drvdata->ahbix_clk));
+		ret = PTR_ERR(drvdata->ahbix_clk);
+		goto err_ahbix_clk;
+	}
+
+	ret = clk_set_rate(drvdata->ahbix_clk, LPASS_AHBIX_CLOCK_FREQUENCY);
+	if (ret) {
+		dev_err(dev, "error setting rate on ahbix_clk: %d\n", ret);
+		goto err_ahbix_clk;
+	}
+	dev_dbg(dev, "set ahbix_clk rate to %lu\n",
+			clk_get_rate(drvdata->ahbix_clk));
+
+	ret = clk_prepare_enable(drvdata->ahbix_clk);
+	if (ret) {
+		dev_err(dev, "error enabling ahbix_clk: %d\n", ret);
+		goto err_ahbix_clk;
+	}
+
+err_ahbix_clk:
+	return ret;
+}
+
+static int ipq806x_lpass_exit(struct platform_device *pdev)
+{
+	struct lpass_data *drvdata = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(drvdata->ahbix_clk);
+
+	return 0;
+}
+
 static int ipq806x_lpass_alloc_dma_channel(struct lpass_data *drvdata, int dir)
 {
 	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
@@ -90,6 +131,8 @@ static struct lpass_variant ipq806x_data = {
 	.dai_bit_clk_names	= (const char *[]) {
 				"mi2s-bit-clk",
 				},
+	.init			= ipq806x_lpass_init,
+	.exit			= ipq806x_lpass_exit,
 	.alloc_dma_channel	= ipq806x_lpass_alloc_dma_channel,
 	.free_dma_channel	= ipq806x_lpass_free_dma_channel,
 };
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

