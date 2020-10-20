Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FFB28EA1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbgJOBah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732257AbgJOB3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:29:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F4DC0D942E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:13:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o7so581100pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqRdEIfaW1cSjL9M5tOy5HvQpahMFQmaQASv402ubfE=;
        b=TE8dv7eTCHypqfsa/XxveRdbShZgYmuGPccz20vGOOCcT4WqLHhp7KGORzYLtv7jJd
         FcXWgFMQKdjgc4217Axx7WNbh9d6skIQpvMd5AOGeDimPY7B4hSclIa6OMroQar1XjYH
         lxymnJ0kaRge07OjRg3HGukXkWH9wWawNmAWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqRdEIfaW1cSjL9M5tOy5HvQpahMFQmaQASv402ubfE=;
        b=JjmuPDeegoG8+BDNyeOj7Sv/DMSJrLcaA7q3N/0QMxu4+bxGXMLl0GZCVK1PnmqZqJ
         poBFhd+JPloJ+6av6T9sITmmaG9ezQyCHdXZXjRsEPt2pl2JKap0HWOjR5QZSpVAtE2W
         /JQESgiSkaRWPDstbyWP2smtV81CpG4ZiVxACPnamyVTwrvmRcm0Y058YLJAbaBBOUO2
         6tIxy/utTCojgUCDTVYiqrOJWe4PdG9GXdTUSv5Q+P16SwlD5P36awTgkTrWs88XkndK
         3K3/dFCY1hV8821fluBpk3erXJK55MmmJPOJVMIJ/lNIp4W4zzHbj5vLt1/acNHoym1R
         Nk5w==
X-Gm-Message-State: AOAM532ITx2SJp/UFy0OSLtjPL82kTZ5E5MQ7vbCJyE2o/dRXhFUF7fi
        t5leqXPGSqmUp1XLPyt2Ta00+r0Meznbig==
X-Google-Smtp-Source: ABdhPJyq2aRyoyAEO/ytsdUTIC9Ptwmc8zbbHavJW1I1k8IE+039pcPqcMP+EGTV5Y6cas/Trqym2Q==
X-Received: by 2002:a63:d008:: with SMTP id z8mr1127511pgf.357.1602720825012;
        Wed, 14 Oct 2020 17:13:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id r16sm726485pjo.19.2020.10.14.17.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:13:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Taniya Das <tdas@codeaurora.org>, linux-soc@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] clk: qcom: lpasscc-sc7180: Re-configure the PLL in case lost
Date:   Wed, 14 Oct 2020 17:13:29 -0700
Message-Id: <20201014171259.v4.3.Id0cc5d859e2422082a29a7909658932c857f5a81@changeid>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201014171259.v4.1.I4567b5e7e17bbb15ef063d447cb83fd43746cb18@changeid>
References: <20201014171259.v4.1.I4567b5e7e17bbb15ef063d447cb83fd43746cb18@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <tdas@codeaurora.org>

In the case where the PLL configuration is lost, then the pm runtime
resume will reconfigure before usage.

Fixes: edab812d802d ("clk: qcom: lpass: Add support for LPASS clock controller for SC7180")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- Put regmap names in "static const char *" globals.

Changes in v3:
- Now based on a series which disentangles the two clock devices.
- Use dev_get_regmap().
- Better comment about reading PLL_L_VAL.

Changes in v2:
- Don't needlessly have a 2nd copy of dev_pm_ops and jam it in.
- Check the return value of pm_clk_resume()
- l_val should be unsigned int.

 drivers/clk/qcom/lpasscorecc-sc7180.c | 28 ++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 4ed766ca08bb..d7586858760c 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -21,6 +21,9 @@
 #include "common.h"
 #include "gdsc.h"
 
+static const char *lpass_audio_cc_regmap_name = "lpass_audio_cc";
+static const char *lpass_core_cc_regmap_name = "lpass_core_cc";
+
 enum {
 	P_BI_TCXO,
 	P_LPASS_LPAAUDIO_DIG_PLL_OUT_ODD,
@@ -388,6 +391,25 @@ static int lpass_create_pm_clks(struct platform_device *pdev)
 	return ret;
 }
 
+static int lpass_core_cc_pm_clk_resume(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, lpass_core_cc_regmap_name);
+	unsigned int l_val;
+	int ret;
+
+	ret = pm_clk_resume(dev);
+	if (ret)
+		return ret;
+
+	/* If PLL_L_VAL was cleared then we should re-init the whole PLL */
+	regmap_read(regmap, 0x1004, &l_val);
+	if (!l_val)
+		clk_fabia_pll_configure(&lpass_lpaaudio_dig_pll, regmap,
+				&lpass_lpaaudio_dig_pll_config);
+
+	return 0;
+}
+
 static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 {
 	const struct qcom_cc_desc *desc;
@@ -398,13 +420,13 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	lpass_core_cc_sc7180_regmap_config.name = "lpass_audio_cc";
+	lpass_core_cc_sc7180_regmap_config.name = lpass_audio_cc_regmap_name;
 	desc = &lpass_audio_hm_sc7180_desc;
 	ret = qcom_cc_probe_by_index(pdev, 1, desc);
 	if (ret)
 		return ret;
 
-	lpass_core_cc_sc7180_regmap_config.name = "lpass_core_cc";
+	lpass_core_cc_sc7180_regmap_config.name = lpass_core_cc_regmap_name;
 	regmap = qcom_cc_map(pdev, &lpass_core_cc_sc7180_desc);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -457,7 +479,7 @@ static const struct of_device_id lpass_core_cc_sc7180_match_table[] = {
 MODULE_DEVICE_TABLE(of, lpass_core_cc_sc7180_match_table);
 
 static const struct dev_pm_ops lpass_core_cc_pm_ops = {
-	SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
+	SET_RUNTIME_PM_OPS(pm_clk_suspend, lpass_core_cc_pm_clk_resume, NULL)
 };
 
 static struct platform_driver lpass_core_cc_sc7180_driver = {
-- 
2.28.0.1011.ga647a8990f-goog

