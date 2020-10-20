Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF729317C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbgJSWtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbgJSWtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:49:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29872C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:49:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id h7so877082pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=efUrOwTRA3BqBF2FggcKJlwY1p4PVpP44S+k5JyEkE0=;
        b=iXm1sX0YLiS63r393oCcXhZBNWg3vSTU8jq7EdqNmtHhgllUjEWsZofY4ien3gc1W3
         XWyZui8wbPrrx+taXZekwGCAKfob1taYeYpEbiDrdupEHgoTB4ZwXb0szNrmGwSNSMqs
         OLe7DqgNuL2riAFeLud7G5TH2bd5SrDOtuQ7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=efUrOwTRA3BqBF2FggcKJlwY1p4PVpP44S+k5JyEkE0=;
        b=WCgOkXa/fDq3OGfQBV2DikKVMv7pWsqG4o9fSmCW8ubBZElGdvU2hUeZ97G0XCpiXJ
         cjd7HWHirOqxTcGj9hd6lt2r8ZRDOAMNJokIZmk+OVk5BMkfWDtA7AVvVNIjjg/H4GmG
         j7AgP2kdp2nerNPjvvRDgHlelIdwRLdipMgsuWjLHZbFBKx1b2JB/bA8sX7Zld63GEUm
         ZWQ1Ma6W13VvYPan5xfcKCrzU1jOgfiPiIOs6RVfKQp8XIGXR4830f08hmuhek2TyInY
         uHIPZWBfZ1/2J1pQUN6zVxBgHe1OtwAa0uKlDgtaNl7QmmHZtEBRT1gxts+zzXRNq5LY
         cvNA==
X-Gm-Message-State: AOAM531jjqgfKjgHufJiIRvtvLQznvMmcXWi3imr8GeL5/Ia+i5D4tfq
        I+RyZ8DUsfzkUPS4jgMIBdi5VA==
X-Google-Smtp-Source: ABdhPJyB+/FQD7MGSEJBOYV2Uf7DvE6YPL0wWYb8MoYQmkPANysW3PyUNzYkmJc/hbJ4kOCr+omy5A==
X-Received: by 2002:a63:3d8b:: with SMTP id k133mr62633pga.413.1603147792743;
        Mon, 19 Oct 2020 15:49:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id in6sm19912pjb.42.2020.10.19.15.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:49:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-soc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] clk: qcom: lpasscc-sc7810: Use devm in probe
Date:   Mon, 19 Oct 2020 15:49:34 -0700
Message-Id: <20201019154857.v5.1.I4567b5e7e17bbb15ef063d447cb83fd43746cb18@changeid>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
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

(no changes since v4)

Changes in v4:
- Fixed typo lapss => lpass
- Moved lpass_pm_runtime_disable() lpass_pm_clk_destroy() in file.

Changes in v3:
- ("clk: qcom: lpasscc-sc7810: Use devm in probe") new for v3.

 drivers/clk/qcom/lpasscorecc-sc7180.c | 38 +++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 228d08f5d26f..2d15e33ec837 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -356,6 +356,16 @@ static const struct qcom_cc_desc lpass_audio_hm_sc7180_desc = {
 	.num_gdscs = ARRAY_SIZE(lpass_audio_hm_sc7180_gdscs),
 };
 
+static void lpass_pm_runtime_disable(void *data)
+{
+	pm_runtime_disable(data);
+}
+
+static void lpass_pm_clk_destroy(void *data)
+{
+	pm_clk_destroy(data);
+}
+
 static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 {
 	const struct qcom_cc_desc *desc;
@@ -418,34 +428,28 @@ static int lpass_core_sc7180_probe(struct platform_device *pdev)
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
+	ret = devm_add_action_or_reset(&pdev->dev, lpass_pm_clk_destroy, &pdev->dev);
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
2.29.0.rc1.297.gfa9743e501-goog

