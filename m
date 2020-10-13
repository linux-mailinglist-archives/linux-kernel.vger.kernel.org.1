Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169AA28D3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 20:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbgJMSdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 14:33:50 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:54734 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731047AbgJMSdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:33:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602614029; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UlQQZJMTNWAVSa+0hA2FXSLe0acOMZ4vnePW50VY0bY=; b=qi+ZmgEhzO7bLZbVErCEl6TtuK4ELGpNFgOo1okR3/BP6vq6mbCOOm7Kw0U8guNHSQIjolji
 aZ0+8kS9PN0pWk2ZcaNmikO1AzozJw/Gqf0WWFvMPfkxsR/u/gRXbZWR0C7o4d90KqJJtjiy
 l42Gkv490vKa3ywkhB5xgUg6BzA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f85f309d6d00c7a9e1e2eda (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 13 Oct 2020 18:33:45
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 736D4C433FF; Tue, 13 Oct 2020 18:33:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D3C6C433F1;
        Tue, 13 Oct 2020 18:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D3C6C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v0] clk: qcom: lpasscc: Re-configure the PLL in case lost
Date:   Wed, 14 Oct 2020 00:03:28 +0530
Message-Id: <1602614008-2421-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602614008-2421-1-git-send-email-tdas@codeaurora.org>
References: <1602614008-2421-1-git-send-email-tdas@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case where the PLL configuration is lost, then the pm runtime
resume will reconfigure before usage.

Fixes: edab812d802d ("clk: qcom: lpass: Add support for LPASS clock controller for SC7180")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/lpasscorecc-sc7180.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 228d08f..5804a93 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -356,6 +356,25 @@ static const struct qcom_cc_desc lpass_audio_hm_sc7180_desc = {
 	.num_gdscs = ARRAY_SIZE(lpass_audio_hm_sc7180_gdscs),
 };

+static int lpass_core_cc_pm_clk_resume(struct device *dev)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	int l_val;
+
+	pm_clk_resume(dev);
+
+	/* Read PLL_L_VAL */
+	regmap_read(regmap, 0x1004, &l_val);
+	if (!l_val)
+		clk_fabia_pll_configure(&lpass_lpaaudio_dig_pll, regmap,
+				&lpass_lpaaudio_dig_pll_config);
+	return 0;
+}
+
+static const struct dev_pm_ops lpass_core_pm_ops = {
+	SET_RUNTIME_PM_OPS(pm_clk_suspend, lpass_core_cc_pm_clk_resume, NULL)
+};
+
 static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 {
 	const struct qcom_cc_desc *desc;
@@ -386,6 +405,9 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 	clk_fabia_pll_configure(&lpass_lpaaudio_dig_pll, regmap,
 				&lpass_lpaaudio_dig_pll_config);

+	pdev->dev.driver->pm = &lpass_core_pm_ops;
+	dev_set_drvdata(&pdev->dev, regmap);
+
 	return qcom_cc_really_probe(pdev, &lpass_core_cc_sc7180_desc, regmap);
 }

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

