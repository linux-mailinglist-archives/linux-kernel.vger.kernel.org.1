Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFFE2EA7F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbhAEJs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbhAEJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:26 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2869EC061382
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:26 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id v19so20918651pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ShXu7/U7Beq0uWc9RaEN3HI3oScB32KORyGyOVEnVV0=;
        b=L7g9QoMhsM/md3H09TU/qGKLV6n/fvcMcaIst+541H1zvXZzIDdYziOSFMDCX0dZz1
         74GHHV0h0ZRnjOiZUNkfZlMmDT7ocfRKvyolc8pifvHNLgm3vHzrqDyEw8e+qfyyiFCI
         KqTlVIvbs5U8y31sxrbsloQi7gj8hlbz5ANitzbFNGU+86BpTwnhx6OfiwY10iZADxn6
         kHbyjXg8TY7Jb/NnvqpZKNtFX+oK9NSe0yzZZ1pEMUju7zW/lek6xTNNpWWuW/aPNatY
         /ocVvr+VSLe/+JIGc1GzTod37CmtdjdkZ4EkorcOnoyypSdryJTdsz7HpQmgHYSDIWxU
         hsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ShXu7/U7Beq0uWc9RaEN3HI3oScB32KORyGyOVEnVV0=;
        b=s0pbs/d3ukJuDOp/x48kh7xRBIm6/H/p7PUT+bziy3oTYmGyCtIA9PXVjOQCNziKKf
         9rXlj+hIkzORaQuR6lKbKeRLLLzstp/ouchkujVWs7kyqzq478hSG0gz3Ff2P8w/RkH6
         D4JZGE3MK2nXDeV+dTQy4vRo5MhJcuVXZSejBS0z5KUen+9MAsNJYhKB23R8urg4nHIS
         HPoPe0ESJoW5CMk8LDBQasKP+a+wnRr5DhAgOb52cWWDpWs1VarAoz0JuS6Aw7Lfp9kE
         Qd6Ku8sNf9fBoOad8Prl2x/m5IC8k1vi2GL9hTqrRIcKXr+gviGe6GclLvLNLEhjgOUv
         LQ2Q==
X-Gm-Message-State: AOAM530L/U9k7js59qyY0CQuChMS+i4aUHA/GobdDC9IEd/MYkobBLEh
        5qgfFAZR4dtXHo33QY6db8ou
X-Google-Smtp-Source: ABdhPJxELuUoNRACruwC2BnEkNekuLylw3gP4BzwYrKw7zVoF0qPZ8uVrnGprcjbw2PRLHCacLXhIw==
X-Received: by 2002:a63:6241:: with SMTP id w62mr75713052pgb.67.1609840045688;
        Tue, 05 Jan 2021 01:47:25 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:25 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/18] ARM: dts: qcom: sdx55: Add spmi node
Date:   Tue,  5 Jan 2021 15:16:31 +0530
Message-Id: <20210105094636.10301-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

This adds SPMI node to SDX55 dts.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 1a6947753972..f3864471ba4c 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -226,6 +226,25 @@ pdc: interrupt-controller@b210000 {
 			interrupt-controller;
 		};
 
+		spmi_bus: qcom,spmi@c440000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0c440000 0x0000d00>,
+			      <0x0c600000 0x2000000>,
+			      <0x0e600000 0x0100000>,
+			      <0x0e700000 0x00a0000>,
+			      <0x0c40a000 0x0000700>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			cell-index = <0>;
+		};
+
 		tlmm: pinctrl@f100000 {
 			compatible = "qcom,sdx55-pinctrl";
 			reg = <0xf100000 0x300000>;
-- 
2.25.1

