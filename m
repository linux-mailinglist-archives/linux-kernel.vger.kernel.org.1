Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024C82832E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgJEJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgJEJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:13:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85169C0613AD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 02:13:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 7so5598957pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fDI/+G6YzcRAUdfhRVHVNn6nQKZstUfu/DicpDzu+YU=;
        b=d9bz47JgnJiFUcgB211LwtgUwhHPQhyh9/XFm5+nlyFOpZ1jCtRbT7OmQVvhLxp/r4
         /69YSJOqsXwFPikcT2T+Q6Vt7P8+pyzUjlmndWGoopbPNXbmUDVPVprZpEKc9lz7A3M+
         Nq1kkhgvj83RhkXiEKO8f4zOIRhO2v8QgXtMhM87ukJmHIj1A3hacaxMQE0gQBgxHUPv
         sJfj5nu4UyPQlv+yairhfRQkHyS++SkeWMU8ZWmqTCu99xt7qfnYg/df+zX/CZHBCVIy
         D4kPlHRdhEIrCKHY2ECPU1kQTXZgXEIWbdj/9c+gE890C5MfulSUnKNNRp3csHIFhGDT
         nOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fDI/+G6YzcRAUdfhRVHVNn6nQKZstUfu/DicpDzu+YU=;
        b=AbttAQoo5g1GgdWTDdhI48BUX8J9vcxaSDJj1JiLvoIWiKLC5nV1rSVTEw+EtoLvAy
         UA9VekOd/c4rbTgwmSSHEm5e5Zc8RCXIo1wjGwQU2jkoXcS4AG00VEYk4v3NvOI0/ftS
         48kdDYeEAQfBouwhmP5taD1QGSIs/oeS1JiTIt4d6HErR7gyjRmGkmhPHRkjPrXmvhAH
         BFdA6vC3xGTOQG2C563+U8jpPONKkncmki2s1RQgZkW1IhCd6A5P8wc4HB6DGfZGCC/I
         Ua36yR5eFVaZiyHkbFcYhAW387hdnUqiSdtQzt11QxQ5aGh7uU/Q8Gjir0ohTNN3KgHl
         0l7A==
X-Gm-Message-State: AOAM5337f5EB4zyWF9wUd8nLLFCo4JzukhspunTQGTlk0fgQEGt+ulgb
        PJ7q9iAL1IGngOXM1IpJ+kZj
X-Google-Smtp-Source: ABdhPJxo+602esRBU+BOkFIg2QQ1Fmyybrx83Zyf+kMJg6mBs3F7oarAgC3fXbs5mIry1U/r8RghWA==
X-Received: by 2002:aa7:9787:0:b029:13e:d13d:a05c with SMTP id o7-20020aa797870000b029013ed13da05cmr16056855pfp.34.1601889199992;
        Mon, 05 Oct 2020 02:13:19 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id c7sm11255028pfj.84.2020.10.05.02.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:13:19 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 4/5] PCI: qcom: Add SM8250 SoC support
Date:   Mon,  5 Oct 2020 14:42:35 +0530
Message-Id: <20201005091236.31770-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005091236.31770-1-manivannan.sadhasivam@linaro.org>
References: <20201005091236.31770-1-manivannan.sadhasivam@linaro.org>
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

