Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C02728EA95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbgJOB7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbgJOB7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:59:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5286C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:13:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gm14so455818pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCnQG1cBhMq8sAEfp9YHwGGr20fDNSgoS19LMKh/BP8=;
        b=oVDjvWnuq1U6NeeWwlpTVoVBHcOhNPJwfmQuSij8FuzR03FnSwtAezNIrY+JS2xK5K
         vIb0Io2w7OqoXINqo7E/25Yms26wCE/zJN/L2M5fDt9uyO2JDS5vEbtJl75H4FMnamKt
         Asoyph0LcVWoPqpHLQfb/wtylUabh0MDV14NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCnQG1cBhMq8sAEfp9YHwGGr20fDNSgoS19LMKh/BP8=;
        b=aKFS6VcHYDMZMVduaH5XQIlv8+cOQP9/VKW7enEm44EV7TUBwfd3sH89XFTh9eX+3U
         zs0KUnhtU1KD+37wGXNcOBqxvjyoO4x+CYc/t8s0b74GRAPW3AdP52j8qAeKzq9mLqzi
         ZgnMjVz6pICCLX/eoo9fqstz5hZ0gh926okUGr/K9NH0D1AL+LHLc+ECT/PYApIdEq6d
         /a5xHfht6oBxTuR4FhqjX2dGIyk0TNmS2JZqoPX84e6m6+OvOzwElz0Ymj5KjkDQqrF7
         EF5YNf20ZCkYRBh+JE2FqaP2KO6Z3X4uMEfmXGHbPGHcbonrgQGXVReEokxXJXS1fcBf
         IPfw==
X-Gm-Message-State: AOAM533+WlsjPAAojlvInqtEujumlkf4ZEBZOpIwzbYG3TqATlN83PJx
        3sSRVb92L7dJjyKVKP7CFBPNEw==
X-Google-Smtp-Source: ABdhPJzmnhmXwPmAM9QvkGG3hYxCXL8UxTqQTC8Zzu5uRBiRSDcAniSEJ0ogn4kjvYagyoaJx+ixeQ==
X-Received: by 2002:a17:90b:128f:: with SMTP id fw15mr1013609pjb.107.1602710013501;
        Wed, 14 Oct 2020 14:13:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id p19sm517713pfn.204.2020.10.14.14.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 14:13:32 -0700 (PDT)
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
Subject: [PATCH v3 3/3] clk: qcom: lpasscc-sc7180: Re-configure the PLL in case lost
Date:   Wed, 14 Oct 2020 14:05:23 -0700
Message-Id: <20201014140507.v3.3.Id0cc5d859e2422082a29a7909658932c857f5a81@changeid>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201014140507.v3.1.I4567b5e7e17bbb15ef063d447cb83fd43746cb18@changeid>
References: <20201014140507.v3.1.I4567b5e7e17bbb15ef063d447cb83fd43746cb18@changeid>
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

Changes in v3:
- Now based on a series which disentangles the two clock devices.
- Use dev_get_regmap().
- Better comment about reading PLL_L_VAL.

Changes in v2:
- Don't needlessly have a 2nd copy of dev_pm_ops and jam it in.
- Check the return value of pm_clk_resume()
- l_val should be unsigned int.

 drivers/clk/qcom/lpasscorecc-sc7180.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 48d370e2108e..e12d4c2b1b70 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -388,6 +388,25 @@ static int lpass_create_pm_clks(struct platform_device *pdev)
 	return ret;
 }
 
+static int lpass_core_cc_pm_clk_resume(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, "lpass_core_cc");
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
@@ -457,7 +476,7 @@ static const struct of_device_id lpass_core_cc_sc7180_match_table[] = {
 MODULE_DEVICE_TABLE(of, lpass_core_cc_sc7180_match_table);
 
 static const struct dev_pm_ops lpass_core_cc_pm_ops = {
-	SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
+	SET_RUNTIME_PM_OPS(pm_clk_suspend, lpass_core_cc_pm_clk_resume, NULL)
 };
 
 static struct platform_driver lpass_core_cc_sc7180_driver = {
-- 
2.28.0.1011.ga647a8990f-goog

