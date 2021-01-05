Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5462EAAE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbhAEMaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbhAEM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:28:34 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B185C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:17 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n25so21201245pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmxpNL0ax3CbXgwGX4yKsIjyic6JD68tauKRRiHGHbo=;
        b=pGFZctsBG3/uj9kXM4G7y2KW9MJp+bo2qj8Of67FLlZhfsyRe6t8xLGyb9RuCRERc5
         kvwU9/e096z/bgfCWk7KQhwsLrusufxiyH52hXT0GTzbgKyDECP730/3c3Ngcj7fSMDP
         lzk1K1Do+lQeczuHqHYPDS4AF71ttLqBn1ReHcWhWFepoRzlVopXPxicxMVIE0RH7wvm
         KpfY27Dw9/3ou6GK7ECtD2Ly+Y4GSqUL+NJ540JHQNEFsp5U5YlMpsow6zPrZPMrWTl1
         TsllrxWPEqCIKDEVnd8Nb5zwLpFzl0IcU/0ZLFGfOgGTvBvan2ss72yP+OPKWcjb8rkj
         NSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmxpNL0ax3CbXgwGX4yKsIjyic6JD68tauKRRiHGHbo=;
        b=cmqp76AxeU/ctp4ONDU8EU2pR+MOQJ6zOsTDkcF7CAEDp4lqGHDttljZYAEfCcXMRH
         oCR4kbKi7ujiGldxf3/+Pd+F8NBUzRom/A9mt82PFNtqJwoEi4VxnqF4bl7Wt3b7fnG4
         uyoTWavG3fPcsS39vUsRuYhVHCpWjvC+drNhardnTQ2U9uzDTz4oavPo2xkPQepoXBJj
         prM6wg32TKlvvVq6Q/709xqKJFfbZ9Fiiskia5hG+KCqZVcGNetuFfmLQvI9FYmH1Qep
         deUTdTEbsfM1uuc/YuVAfFcAMPIrguIRjkcKFLMWxSkMG54CCXSyrFEaVBeswtbWxzWi
         tflA==
X-Gm-Message-State: AOAM532SIOgyHk6rHW9vs6Cyw6jj3n5R0ZjKOdk8Anyqrl/b61244V9b
        GeReshOyFEsEVJ7D4Ap6kmgdgww79YFZ
X-Google-Smtp-Source: ABdhPJws2bilunacB+DeD5wSc0i+4QvR1VstRuNW+Q0n+pDfcDGrDUj1ogIvAL+sSzKhPTvfhjUmVQ==
X-Received: by 2002:a65:6484:: with SMTP id e4mr32579788pgv.401.1609849636937;
        Tue, 05 Jan 2021 04:27:16 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 06/18] ARM: dts: qcom: sdx55: Enable ARM SMMU
Date:   Tue,  5 Jan 2021 17:56:37 +0530
Message-Id: <20210105122649.13581-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add a node for the ARM SMMU found in the SDX55.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 3f8e98bfc020..927f43a7414c 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -185,6 +185,30 @@ tlmm: pinctrl@f100000 {
 			#interrupt-cells = <2>;
 		};
 
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,sdx55-smmu-500", "arm,mmu-500";
+			reg = <0x15000000 0x20000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		intc: interrupt-controller@17800000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.25.1

