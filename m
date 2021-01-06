Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0F2EBE03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbhAFMzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbhAFMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:37 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B09C061377
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:54:49 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id c132so2182690pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b0jqBat3BonuQvaOdiiTz0KA0EHm42GNNSe+AuL4HxE=;
        b=u5MrPQNT9IIqcQbzJQZx7ResLriMMT3qfuRwH2ffzSxl/SZJ6WLfg3RWW9U0sKgVpo
         8EO2rBwoYDBKEpzE0z356GDn42McauraHfr2FeB7B3js5ZDYskxysU3i+wybqvsBhsTj
         dFlgqtAC3ny0v/J0nqzHRLAd6eaMRao8EM4Ah6r+Pi7ylLZFQ1PYgPoJCKsLxHD+gBGx
         qV1qUxbQevYJjiLFqv+CKReO7FBucut4GdL28mH2o7OgtjGTMDeuW//d86XSnJMMVmCc
         Mz+fx2n7j+KzoL1kK2zD+NCveem+ZdIAGpkXrpAISUw9+3hUV5hQ3zNvZl7DBAIUsJ9N
         Z92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b0jqBat3BonuQvaOdiiTz0KA0EHm42GNNSe+AuL4HxE=;
        b=Ai4ZMMTAsMcUF6gjvD5xJpq3KVNzSc4BTCdYynTTHlpmMS8ttC57OEgbZHJMa5vFNR
         19ENp+Plsa4vrMTuPZG/3qoPnqMkADjVWX55YHSh4P1XY/lhGk65G87FlTshLZOWYtLL
         GunzmnVbkkLSv/RnyupwAjFjpJ9DkA0nU4oVldZvyD7W1YwhrDM3+luoBtH4i01cyxXl
         gKzvP8a2DzvesYc1M1h/G1D7+J4sGNYjBLbCjcr82EqHa7ZAsEjDgp2Uqcfh9mSWDJEX
         Q89QSqNwcDoQwAMd6X+OE5xHUKWamCtlaX3/bKOyWmtPWAYnZsXtW6ausmzRAIDKvnIg
         Ehog==
X-Gm-Message-State: AOAM531ld6Wq6TpOSCXPeCb5RCSJTxJnB6/+X4AQ8I8MCGZLqcL0JHlp
        oNJGE5Ukm3VtZIMaBdKubhIi
X-Google-Smtp-Source: ABdhPJzL4UpIcoQQft4bDSprEfpkaFa9oFVGGhbvc5lJRrfc9tjJO0ei4rgIaN5sIYPHXlRH7A3hFw==
X-Received: by 2002:a62:97:0:b029:1ab:93bf:43a1 with SMTP id 145-20020a6200970000b02901ab93bf43a1mr3679852pfa.75.1609937689402;
        Wed, 06 Jan 2021 04:54:49 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:54:48 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 17/18] ARM: dts: qcom: Add PMIC pmx55 dts
Date:   Wed,  6 Jan 2021 18:23:21 +0530
Message-Id: <20210106125322.61840-18-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
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
 arch/arm/boot/dts/qcom-pmx55.dtsi | 84 +++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-pmx55.dtsi

diff --git a/arch/arm/boot/dts/qcom-pmx55.dtsi b/arch/arm/boot/dts/qcom-pmx55.dtsi
new file mode 100644
index 000000000000..6571b88d018a
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-pmx55.dtsi
@@ -0,0 +1,84 @@
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

