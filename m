Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0069283359
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJEJcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgJEJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:32:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07BC0613A9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 02:32:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so5222637pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fDI/+G6YzcRAUdfhRVHVNn6nQKZstUfu/DicpDzu+YU=;
        b=DLM2CfrVbUiOz4tixTw3gBZP/cb2rIJjyII/tm2KLLftNsREzRcNUharWiURFgrj58
         DE/I8amrrAs+AewhYphlfQINMsqW+CXdyD54n8mILe7JYetJxeqrTJax1F1zcRn9IuhT
         nGX/UjWufCwSy/fu7cLxkS2CXMa6m/MWWAgC5JsQ89xVN5jPL7mMydfLbgaGSwG8DAfD
         ZPFBvIHZMjRH0ffAf3fQI4lBsa+bMXbVsDmEUmFn8XJMLMz9IlWtDYTsVPTORGIUopLy
         rPWoK+B7IBuXOEAmikn7AW0TeMnP5ppzkwWmkpn8OdHZSwYvbV3o5OELRF4zMrr0PiSf
         0Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fDI/+G6YzcRAUdfhRVHVNn6nQKZstUfu/DicpDzu+YU=;
        b=SsXmLC/ZBRUBho6FQP6+TDyaqhMXSIxye6SFj2QYkXaRgSvz8AtYhaBVWVWrKoXSTL
         HmnuNZBvJ1zEpW1DEwrHBK5N/nAFgpbxDNYd6wTx/MEAZIknwZhOVDnJLHaA5SCqOjHd
         LYv2FUaPCoEzme0FTl0ok6y3VcD2/lTF27OopVJzCPQ+7PRgKxWDTQ9x9ajJIJzn4X2Y
         OmEOrZkR29KxGu49ZtlK/6FxWZQ1Q+Ele2uxg9jK8EPQpNKiwj5qHtdq6q9eWehe2atG
         CtwnyoSlVMN2dnbcls2Nun/cENID3PoHBvOFrcfzon/GzsjjKjpw/BK0SnCWrOlqLTr7
         U3DQ==
X-Gm-Message-State: AOAM531zv8BPg5X3fR+uqXn4sUtxtF4i7eUcz0lymAp7A7qPQzRWXhXy
        GAuctIZx9p8lqIzsw21pb8K+
X-Google-Smtp-Source: ABdhPJzqzCR9aqlXAZQ36B97QURHUZj/kVw/soNEU+RH1DJPq+0Dd1SY2T/XGVXh1q3xCfGaGJykoQ==
X-Received: by 2002:a17:90a:a613:: with SMTP id c19mr16394942pjq.119.1601890353949;
        Mon, 05 Oct 2020 02:32:33 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 124sm11298894pfd.132.2020.10.05.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:32:33 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 4/5] PCI: qcom: Add SM8250 SoC support
Date:   Mon,  5 Oct 2020 15:01:51 +0530
Message-Id: <20201005093152.13489-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
References: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe IP (rev 1.9.0) on SM8250 SoC is similar to the one used on
SDM845. Hence the support is added reusing the members of ops_2_7_0.
The key difference between ops_2_7_0 and ops_1_9_0 is the config_sid
callback, which will be added in successive commit.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3aac77a295ba..3167ad66413d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1359,6 +1359,16 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 };
 
+/* Qcom IP rev.: 1.9.0 */
+static const struct qcom_pcie_ops ops_1_9_0 = {
+	.get_resources = qcom_pcie_get_resources_2_7_0,
+	.init = qcom_pcie_init_2_7_0,
+	.deinit = qcom_pcie_deinit_2_7_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.post_init = qcom_pcie_post_init_2_7_0,
+	.post_deinit = qcom_pcie_post_deinit_2_7_0,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 };
@@ -1476,6 +1486,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
+	{ .compatible = "qcom,pcie-sm8250", .data = &ops_1_9_0 },
 	{ }
 };
 
-- 
2.17.1

