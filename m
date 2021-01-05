Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15B92EA7E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbhAEJsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbhAEJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:09 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B338C0617A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:46:58 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 11so18077677pfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3M1yGDo9sOujbh6Y3dKya3WVnGla1Jyt0Z8LN2HYb8=;
        b=zVLBsCEZVSKHzFSBJpDt4PhMHWiQWM8pz6sEWsrfLZiG8wj4EJWFPF6X1jbRjhbT6z
         VCID1BBm71TAQ7c5dgcHytArrVx2BilzHUM+B0elapFZyP4VO+Vcbh4j/x441M+2qG6q
         YcEomPTSWJ/lGJ4fDsOVGsf7d/Jx23DDijLPMwivdnypDXXkJsq02Vxp7QIISMJDco0p
         tNVXtZEIWCQllsTCFCgVsIMDnCp0a5mXiKSdOAigclZq2dtAN24nhhbboe2jTmF0GAl5
         paewjsFn7RfDzvhz2THJQi1V907xZm1WETfC97cGo+5jfhsHf7gVz8zpBqU5gZ6y3bmv
         V4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3M1yGDo9sOujbh6Y3dKya3WVnGla1Jyt0Z8LN2HYb8=;
        b=in0LwHCESThWQpF1GEAazwdBVV5ihl3wRxN+P5uRAbHKOhN3egTh7Ia5x4GCbYL+wt
         j4dFAWUu4Q83azL9GxNFbR+ru/BW4UKZz4mGF9k8FLZuTPnk5M4mtoh/Fnb2vomXe9zT
         R9ROJb+bvPz7qACKFU0g1FAmJPV1uA2Y667eFxWEEJlKEbbJYh3oNslyB9I+7JRrKChi
         0xMhWXT96YATyURs5plB3Oa8aacl1AhBomF5m/n9o1Lj4y3nwzvSHHexSZze11jumiC8
         u090TUz19VHFrTITAA06/PnyIAsI57uHZZl49sVh50QBD8/c1bZOX2tcaigI0+7kTDcf
         ik3Q==
X-Gm-Message-State: AOAM531nZtd/0wu+1+JVprSrb04o+nRsMvn7LnLQo6ruEQrWQyJP7TEj
        DgUrLGWAydT3bCDjQsr8WWQH
X-Google-Smtp-Source: ABdhPJz1wRVcPPniGpDOVmQYEaphG/URWLA7is8aZLf+whTfMN+TbY3yTMP7oBdasIaFmw4YfPTSdg==
X-Received: by 2002:a63:4082:: with SMTP id n124mr59428987pga.340.1609840017829;
        Tue, 05 Jan 2021 01:46:57 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:46:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/18] ARM: dts: qcom: sdx55: Add support for SDHCI controller
Date:   Tue,  5 Jan 2021 15:16:22 +0530
Message-Id: <20210105094636.10301-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for SDHCI controller found in Qualcomm SDX55 SoC.
The SDHCI controller used in this SoC is based on the MSM SDHCI v5 IP.
Hence, the support is added by reusing the existing sdhci driver with
"qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index eeb6bf392f93..3f8e98bfc020 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -154,6 +154,18 @@ blsp1_uart3: serial@831000 {
 			status = "disabled";
 		};
 
+		sdhc_1: sdhci@8804000 {
+			compatible = "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x08804000 0x1000>;
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>;
+			clock-names = "iface", "core";
+			status = "disabled";
+		};
+
 		pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx55-pdc", "qcom,pdc";
 			reg = <0x0b210000 0x30000>;
-- 
2.25.1

