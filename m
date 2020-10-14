Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C138728EA92
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbgJOB7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732522AbgJOB7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:59:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7BC0613DC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:13:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so494018pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XXXVW8LaNsSK90nR0fVqNTLLxxo+uN8rx6WyyMCGIqU=;
        b=QfFbFDAWvdwuJNtRGDEJ+4jQLfUu4dtYrqt375pRq+u0Dv2ZX2eDJlK45YLFadyX+m
         hpWDEVApkwfktJTstvyeNq1QJX+M8OGBGETL2KOqGWC1sh2+yk4MBRtbyMSQZoxNFX/i
         ZGPe0JO6EfJFxshk65T9Mxn+11MAkDIRtJTw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XXXVW8LaNsSK90nR0fVqNTLLxxo+uN8rx6WyyMCGIqU=;
        b=m+xE6a7OV3x3iSnU28/nQXOyICCdtPaDDtGNrg582GUn3fe2kwy4cAgAUn+kQksYLR
         YSRMn/TBcUNx/Vg7zMoESoY763F0yCtVVakMOmJR0ntxa4K8uKC5nsj8esO7h8n5Z+0w
         kh1ctr+xCkMgbNsipUv7J6qGCaPJryKLYddBnSHN2au8tsmTQ+GVCf3TFqhZCp/tpa/E
         bLakxvD7kpqEhsHLBdySFqi59/iwoZQ4L7v5n+dA3dcEFKmZ+U632+Pzf3zlya1pVwgs
         jlCeBOrJcH+c3sNdANxBkwTT8lhxR/iT6lrgL+YKBZKlQ+R230yq4N/yIDfxfOFLLlXd
         Z1Cw==
X-Gm-Message-State: AOAM532Dm0teuml4yMbFD0O0swHoVZmkzNpH7CoXsOotYHbboN0Fulsf
        YUCJhQzfVS65wTz1YF4bFyvHuQ==
X-Google-Smtp-Source: ABdhPJyWzB7PQNM2L2E7jMBzdy13qHYz2fsBChWv51asF/Dv9wMqyArFHgIaMI2T7Sc9RZwlGiO/5Q==
X-Received: by 2002:a17:90b:1392:: with SMTP id hr18mr1017220pjb.182.1602710010286;
        Wed, 14 Oct 2020 14:13:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id p19sm517713pfn.204.2020.10.14.14.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 14:13:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] clk: qcom: lpasscc-sc7810: Use devm in probe
Date:   Wed, 14 Oct 2020 14:05:21 -0700
Message-Id: <20201014140507.v3.1.I4567b5e7e17bbb15ef063d447cb83fd43746cb18@changeid>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's convert the lpass clock control driver to use devm.  This is a
few more lines of code, but it will be useful in a later patch which
disentangles the two devices handled by this driver.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("clk: qcom: lpasscc-sc7810: Use devm in probe") new for v3.

 drivers/clk/qcom/lpasscorecc-sc7180.c | 38 +++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 228d08f5d26f..abcf36006926 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -412,40 +412,44 @@ static const struct of_device_id lpass_core_cc_sc7180_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, lpass_core_cc_sc7180_match_table);
 
+static void lpass_pm_runtime_disable(void *data)
+{
+	pm_runtime_disable(data);
+}
+
+static void lapss_pm_clk_destroy(void *data)
+{
+	pm_clk_destroy(data);
+}
+
 static int lpass_core_sc7180_probe(struct platform_device *pdev)
 {
 	int (*clk_probe)(struct platform_device *p);
 	int ret;
 
 	pm_runtime_enable(&pdev->dev);
+	ret = devm_add_action_or_reset(&pdev->dev, lpass_pm_runtime_disable, &pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = pm_clk_create(&pdev->dev);
 	if (ret)
-		goto disable_pm_runtime;
+		return ret;
+	ret = devm_add_action_or_reset(&pdev->dev, lapss_pm_clk_destroy, &pdev->dev);
+	if (ret)
+		return ret;
 
 	ret = pm_clk_add(&pdev->dev, "iface");
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to acquire iface clock\n");
-		goto destroy_pm_clk;
+		return ret;
 	}
 
-	ret = -EINVAL;
 	clk_probe = of_device_get_match_data(&pdev->dev);
 	if (!clk_probe)
-		goto destroy_pm_clk;
-
-	ret = clk_probe(pdev);
-	if (ret)
-		goto destroy_pm_clk;
-
-	return 0;
-
-destroy_pm_clk:
-	pm_clk_destroy(&pdev->dev);
-
-disable_pm_runtime:
-	pm_runtime_disable(&pdev->dev);
+		return -EINVAL;
 
-	return ret;
+	return clk_probe(pdev);
 }
 
 static const struct dev_pm_ops lpass_core_cc_pm_ops = {
-- 
2.28.0.1011.ga647a8990f-goog

