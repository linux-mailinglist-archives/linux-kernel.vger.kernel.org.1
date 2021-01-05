Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786592EA7F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbhAEJsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbhAEJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98387C061386
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id lb18so1357259pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yrapoIFWFXnJoruSV2ugYcl0aEsm2fIqrky/FpMYSA=;
        b=qlhdQ8cRfEICJzNXfyrwuTB/RiPDsQiWC+hkxh1OVKSUwgWFTqN/UJ1nhW2pqDZoln
         LfDl/ant7/GuiHO/DZsEkOnCtmZLhehydy77kTTm/ZYCAmuRHGBT3DEB6hwzxDSMb54Y
         mVKYRrbmKClkuGVlawy9eBelXdEH3NXSKvZiMY1ipBOCbVse32YBEeyW74eniRFM5aby
         kNZlG9GZ6VZqkpCPvm1h6cOi5gD6nIQiT3wa7Fe8MNWgH8KApQAH6948TQKz8Orkr5nx
         s7bkJmhc6K8LAyph5fLJrsmIaaIV9IRmtrcfnFigCbRtU1mC8b0EhcyFv31MY26sKC6k
         DabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yrapoIFWFXnJoruSV2ugYcl0aEsm2fIqrky/FpMYSA=;
        b=dYpH84y7KxsNs4+jPJHB95u4xteAbub+e5ngjXnPjZqnIzyP5f/sWCc6Y2qi3n8HBa
         MZI6dtY/xJvPK5un7S9c9AHW2ZJwuHTeaUMqagQ/I/3m5mSDccaX5tNpd4UZTcxx0SMa
         hFuKygi/KKg0tB6oNdI6bsSAm805igslEvZVwKd8grIZTWpKFluEQ1ifaN41bMSkfyHp
         Qn23lN15IJ/A3/KdIE/YOHeeJ1xDg0+QH/bL4SS/wSGcnvhplv5Ixc1i61F1/3N8fZOa
         xJvAXDq2kgZpRW1COLFr4MFsX/8oUYkJk8sx4vtt0l/stFS6ErR7dDPbm/6PKChx7zxu
         vcJg==
X-Gm-Message-State: AOAM53077W4Pi1JoKzt3X47AwNavDmwC/zegWxfiUBKXG0HCHB+3Hc/l
        S0nIoSWuCsTlkuWRW5cv5TJa
X-Google-Smtp-Source: ABdhPJzKWmiil4fR+Q4rtWe8mogH8p36j3nOgjgWSKU+MfsqoGyXK8cVyc7wmZobBze0aujdicq2og==
X-Received: by 2002:a17:90a:fcc:: with SMTP id 70mr3213905pjz.168.1609840059098;
        Tue, 05 Jan 2021 01:47:39 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 17/18] ARM: dts: qcom: Add PMIC pmx55 dts
Date:   Tue,  5 Jan 2021 15:16:35 +0530
Message-Id: <20210105094636.10301-18-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

This adds DTS for PMIC PMX55 found in Qualcomm platforms.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-pmx55.dtsi | 91 +++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-pmx55.dtsi

diff --git a/arch/arm/boot/dts/qcom-pmx55.dtsi b/arch/arm/boot/dts/qcom-pmx55.dtsi
new file mode 100644
index 000000000000..05f033334716
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-pmx55.dtsi
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020, Linaro Limited
+ */
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmic@8 {
+		compatible = "qcom,pmx55", "qcom,spmi-pmic";
+		reg = <0x8 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		power-on@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x0800>;
+
+			status = "disabled";
+		};
+
+		pmx55_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x8 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			io-channels = <&pmx55_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmx55_adc: adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			interrupts = <0x8 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			ref-gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			vref-1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			die-temp@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
+			};
+
+			chg-temp@9 {
+				reg = <ADC5_CHG_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "chg_temp";
+			};
+		};
+
+		pmx55_gpios: gpio@c000 {
+			compatible = "qcom,pmx55-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <0x8 0xc0 0x0 IRQ_TYPE_NONE>,
+				     <0x8 0xc1 0x0 IRQ_TYPE_NONE>,
+				     <0x8 0xc3 0x0 IRQ_TYPE_NONE>,
+				     <0x8 0xc4 0x0 IRQ_TYPE_NONE>,
+				     <0x8 0xc5 0x0 IRQ_TYPE_NONE>,
+				     <0x8 0xc7 0x0 IRQ_TYPE_NONE>,
+				     <0x8 0xc8 0x0 IRQ_TYPE_NONE>;
+		};
+	};
+
+	pmic@9 {
+		compatible = "qcom,pmx55", "qcom,spmi-pmic";
+		reg = <0x9 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.25.1

