Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECB2D2A83
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgLHMPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgLHMPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:15:43 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA56C0611C5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 04:14:26 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id n7so12038344pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 04:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dWWkPOWcjIUOLcJfFo8bbt5YdJAUuNIEGrPeCzwaMaQ=;
        b=Fqn8RNMjud0Hec2D6vQ4aXgHuRNhVX7pX/pW9ZV8Q6L/mMZwzTcl70P5ooYzbkkbwb
         jvWQ+IZALlfnURAOI0XtQwR/OJ6ZQc4BblNni/LgNrBKjmBaj+OeBnSXXZisUmS9OBkM
         Ni9YKJT5gwRedyIdhS+jTC++LUsF46QWx8apYk8JiexrjyoavHDYAz7ZbFCTyZys7MdB
         LaxtalGsVcIkj4E6S0tp7VT6ijrXHju58uU/KgY0O/M+wSJmWpnflTwGYjToQknvzMnm
         C/JdX/3zYSBar3uLcIP8hTJbDTp+xJPF6AGlbhs8hDvwmANXFxQ9G1B4nrBDQx93jLlE
         bOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWWkPOWcjIUOLcJfFo8bbt5YdJAUuNIEGrPeCzwaMaQ=;
        b=Z+6LhUxhpTL4mNVQrNOhARg6k1asKBUaD7C8NepqCgPMsTQEuQbPPL8T/lZXIl8Kzs
         C1XLd9p0yAt93MGd4C1K2D9vM2DDXAAmAA6Zaud6sLUwCsioBxBiazXtj5Zt9t07ikuQ
         0vhA5h39p5meHJ97R8HOhgayDxT2ivB5QESQYKNeLRgW4DT9b9zGfQIQZ+wKfZ1AVlV/
         Yf9xbMHeGCAS7LsR0WlFAJlF/6PuO86STChpHVbuDibbFNBifv37MigIIDUjdzXbelbB
         GqEL8tVNDq3GoLVP9dq7sfL12rNjD58DUuDR5qnqF/Rl1dHdXTHfC3dyddzxaBjMq8qM
         PLAw==
X-Gm-Message-State: AOAM531/qThC3M4uVEM6Xkl673z8uc/CBHIbGuWWivzmRVvjAwWPce8G
        dLxFx88mPNjs1TonQdNAXzuc
X-Google-Smtp-Source: ABdhPJyWiYkEB6a0EV8T4Bw52WTuVk0Aw2q71L1ojmSSKOWiSnptqPh+ffVigkEMo8Zpyxnp+OhpcQ==
X-Received: by 2002:aa7:8f35:0:b029:19b:1258:ec5d with SMTP id y21-20020aa78f350000b029019b1258ec5dmr20439747pfr.9.1607429666157;
        Tue, 08 Dec 2020 04:14:26 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id v3sm3489889pjn.7.2020.12.08.04.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 04:14:25 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To:     lorenzo.pieralisi@arm.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        devicetree@vger.kernel.org, truong@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/3] PCI: qcom: Add SM8250 SoC support
Date:   Tue,  8 Dec 2020 17:44:01 +0530
Message-Id: <20201208121402.178011-3-mani@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208121402.178011-1-mani@kernel.org>
References: <20201208121402.178011-1-mani@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

The PCIe IP (rev 1.9.0) on SM8250 SoC is similar to the one used on
SDM845. Hence the support is added reusing the members of ops_2_7_0.
The key difference between ops_2_7_0 and ops_1_9_0 is the config_sid
callback, which will be added in successive commit.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e49791c4f846..750ff7378870 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1348,6 +1348,16 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
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
 	.start_link = qcom_pcie_start_link,
@@ -1446,6 +1456,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
+	{ .compatible = "qcom,pcie-sm8250", .data = &ops_1_9_0 },
 	{ }
 };
 
-- 
2.25.1

