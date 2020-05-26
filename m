Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 467BC19EAC9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 13:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgDELaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 07:30:14 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:56596 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgDELaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:30:11 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Apr 2020 04:30:10 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg02-sd.qualcomm.com with ESMTP; 05 Apr 2020 04:30:07 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id ED6552165A; Sun,  5 Apr 2020 17:00:02 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaprak@codeaurora.org
Subject: [PATCH V2 7/8] mailbox: qcom: Add ipq6018 apcs compatible
Date:   Sun,  5 Apr 2020 16:59:24 +0530
Message-Id: <1586086165-19426-8-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586086165-19426-1-git-send-email-sivaprak@codeaurora.org>
References: <1586086165-19426-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm ipq6018 has apcs block, add compatible for the same.
Also, the apcs provides a clock controller functionality similar
to msm8916 but the clock driver is different.

Create a child platform device based on the apcs compatible for the
clock controller functionality.

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index eeebafd..19f6ba1 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -45,6 +45,16 @@ static const struct mbox_chan_ops qcom_apcs_ipc_ops = {
 	.send_data = qcom_apcs_ipc_send_data,
 };
 
+static const struct of_device_id apcs_clk_match_table[] = {
+	{ .compatible = "qcom,msm8916-apcs-kpss-global",
+	  .data = "qcom-apcs-msm8916-clk", },
+	{ .compatible = "qcom,qcs404-apcs-apps-global",
+	  .data = "qcom-apcs-msm8916-clk", },
+	{ .compatible = "qcom,ipq6018-apcs-apps-global",
+	  .data = "qcom,apss-ipq-clk", },
+	{}
+};
+
 static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 {
 	struct qcom_apcs_ipc *apcs;
@@ -54,11 +64,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 	void __iomem *base;
 	unsigned long i;
 	int ret;
-	const struct of_device_id apcs_clk_match_table[] = {
-		{ .compatible = "qcom,msm8916-apcs-kpss-global", },
-		{ .compatible = "qcom,qcs404-apcs-apps-global", },
-		{}
-	};
+	const struct of_device_id *clk_device;
 
 	apcs = devm_kzalloc(&pdev->dev, sizeof(*apcs), GFP_KERNEL);
 	if (!apcs)
@@ -93,9 +99,10 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (of_match_device(apcs_clk_match_table, &pdev->dev)) {
+	clk_device = of_match_device(apcs_clk_match_table, &pdev->dev);
+	if (clk_device) {
 		apcs->clk = platform_device_register_data(&pdev->dev,
-							  "qcom-apcs-msm8916-clk",
+							  (const char *)clk_device->data,
 							  PLATFORM_DEVID_NONE,
 							  NULL, 0);
 		if (IS_ERR(apcs->clk))
@@ -127,6 +134,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,sdm845-apss-shared", .data = (void *)12 },
 	{ .compatible = "qcom,sm8150-apss-shared", .data = (void *)12 },
 	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = (void *)8 },
+	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = (void *)8 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
-- 
2.7.4

