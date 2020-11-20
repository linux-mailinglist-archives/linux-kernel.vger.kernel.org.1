Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B63B2BB0BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgKTQkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:40:40 -0500
Received: from z5.mailgun.us ([104.130.96.5]:49020 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbgKTQkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:40:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605890439; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=u5J0GfVy+/VyMT1PA9pFklPWc/9n5dvJShGZaqKDPRo=; b=V3C43Gxmxdb1HPSaciLyE4QB5xa1K2i1QtjdZckDlTsyZC+SUxpXvzBaJBaPiCeC/sJWYDvT
 x3cZdCp0sc1s2R6Sm661ruEI7UQ5R+VirEsNZkDYSggjheoSNRT0oVZKLRB8ZEYcvKzbXpKg
 vEhSAwiPq7Y2dCKdtJpJkliu8Nc=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fb7f181ba50d14f8812a3c9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 16:40:33
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86925C433ED; Fri, 20 Nov 2020 16:40:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6EC2EC433C6;
        Fri, 20 Nov 2020 16:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EC2EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] clk: qcom: lpasscc: Introduce pm autosuspend for SC7180
Date:   Fri, 20 Nov 2020 22:10:17 +0530
Message-Id: <1605890417-721-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPASSCC driver's suspend/resume is invoked multiple number of times
and thus allow the device to autosuspend for 500ms.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/lpasscorecc-sc7180.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 9081649..2e0ecc3 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -370,7 +370,10 @@ static int lpass_create_pm_clks(struct platform_device *pdev)
 {
 	int ret;

+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
 	pm_runtime_enable(&pdev->dev);
+
 	ret = devm_add_action_or_reset(&pdev->dev, lpass_pm_runtime_disable, &pdev->dev);
 	if (ret)
 		return ret;
@@ -423,7 +426,12 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 	clk_fabia_pll_configure(&lpass_lpaaudio_dig_pll, regmap,
 				&lpass_lpaaudio_dig_pll_config);

-	return qcom_cc_really_probe(pdev, &lpass_core_cc_sc7180_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &lpass_core_cc_sc7180_desc, regmap);
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
+	return ret;
 }

 static int lpass_hm_core_probe(struct platform_device *pdev)
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

