Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0708C2CA749
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391923AbgLAPjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391505AbgLAPjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:39:00 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5857C061A56
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:37:30 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so3301876wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AnsMipShbEp5shIcSQnSsR/KPaRGHHYiZS/KJVFuEzU=;
        b=d3V33ds+V2uGSuK1Is8LyL+zdVqoj2udYUXfK4dLGmW2Bu0VXwd6Sj3QW7fRQkkU61
         xeCDUXF7bmZbbXy6FJAepXvT+L7qt7YmfYXMlM6RoU36fxpIX412g1D75jtmKLAJzEUT
         a6R35abPN7caHzjaUW49Fh4bB72Zqlm12q1Axl82i31TjFrnel64kHCu1cv+Hy/Z0IKe
         KO++BNLnVTQJqWUoAdg8EuonQx8kXDLdLHMFaPaCXth25PGK1cSt7C983M0fgT2zTYNj
         EU4/OntdFvIGOPbnTDJDMuhAQlnwy4/HPaYJcKgaN9ROWfani0vDRlvsXdpjYa4CEOmL
         INMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnsMipShbEp5shIcSQnSsR/KPaRGHHYiZS/KJVFuEzU=;
        b=TP/f6WUOXgw2Dhaeelobmryb5wDS3YHac0HmsvdUJT/Ep/pKWoefTu/PiZ3+LKAM6U
         tivx2k/MLVU0/YVzAkf28dyvwEAShoz3izkP709ka253//48p7i73AzNL610r/nQvXb+
         i2XOAyfSdD3u/cgWvwQ4z+eVu33vY4+B6JzUN3eoxYjXQkyMbWD7zOk6fEW5nleV4jMF
         k2nNGvvwIuLJDKBDAkreDqM4QMEn/y22n2jMF41by8j4k5l1OfGg/qxePQYpauimIqxT
         DvE3jilK2emXT7iH30X+vXhFbAkCpChqVa5PLWRjpYYUvyqgpl3OP6e4QSUwGwmL+ptr
         VDbw==
X-Gm-Message-State: AOAM533IL0a1NSyvyMr4fKhVqosmVxacbBLGTjGmslntjcH5mv3ZI83F
        uvCBY9JvdS98QnxXZ25q9I9l2g==
X-Google-Smtp-Source: ABdhPJyt5IlNdbjrOGpmBV9L5vRASf03V/hmdFs2fwLA5QsQmAzOtR1xYDaA2k4qSSP6BP4ceEPuEg==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr4647417wru.151.1606837049436;
        Tue, 01 Dec 2020 07:37:29 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y7sm302171wmb.37.2020.12.01.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 07:37:28 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] arm64: dts: qcom: qrb5165-rb5: Add Audio support
Date:   Tue,  1 Dec 2020 15:37:06 +0000
Message-Id: <20201201153706.13450-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201201153706.13450-1-srinivas.kandagatla@linaro.org>
References: <20201201153706.13450-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for two WSA881X smart speakers attached via Soundwire
and a DMIC0 on the main board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 125 +++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index ce22d4fa383e..03229d5cb9d3 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -7,6 +7,8 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
 #include "pm8150b.dtsi"
@@ -120,6 +122,11 @@
 	};
 };
 
+&adsp {
+	status = "okay";
+	firmware-name = "qcom/sm8250/adsp.mdt";
+};
+
 &apps_rsc {
 	pm8009-rpmh-regulators {
 		compatible = "qcom,pm8009-rpmh-regulators";
@@ -483,6 +490,35 @@
 	status = "okay";
 };
 
+&q6afedai {
+	qi2s@16 {
+		reg = <16>;
+		qcom,sd-lines = <0 1 2 3>;
+	};
+};
+
+/* TERT I2S Uses 1 I2S SD Lines for audio on LT9611 HDMI Bridge */
+&q6afedai {
+	qi2s@20 {
+		reg = <20>;
+		qcom,sd-lines = <0>;
+	};
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+};
+
 &sdhc_2 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -497,6 +533,88 @@
 	no-emmc;
 };
 
+&swr0 {
+
+	left_spkr: wsa8810-left{
+		compatible = "sdw10217211000";
+		reg = <0 3>;
+		powerdown-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
+		#thermal-sensor-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		#sound-dai-cells = <0>;
+	};
+
+
+	right_spkr: wsa8810-right{
+		compatible = "sdw10217211000";
+		reg = <0 4>;
+		powerdown-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
+		#thermal-sensor-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		#sound-dai-cells = <0>;
+	};
+};
+
+&sound {
+	compatible = "qcom,qrb5165-rb5";
+	pinctrl-0 = <&tert_mi2s_sck_active
+			 &tert_mi2s_sd0_active
+			 &tert_mi2s_ws_active>;
+	pinctrl-names = "default";
+	model = "Qualcomm-RB5-WSA8815-Speakers-DMIC0";
+	audio-routing =
+		"SpkrLeft IN", "WSA_SPK1 OUT",
+		"SpkrRight IN", "WSA_SPK2 OUT",
+		"VA DMIC0", "vdd-micb",
+                "VA DMIC1", "vdd-micb",
+		"MM_DL1",  "MultiMedia1 Playback",
+		"MultiMedia3 Capture", "MM_UL3";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	dma-dai-link {
+		link-name = "WSA Playback";
+		cpu {
+			sound-dai = <&q6afedai WSA_CODEC_DMA_RX_0>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&wsamacro 0>;
+		};
+	};
+
+	va-dai-link {
+		link-name = "VA Capture";
+		cpu {
+			sound-dai = <&q6afedai VA_CODEC_DMA_TX_0>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&vamacro 0>;
+		};
+	};
+};
+
 /* CAN */
 &spi0 {
 	status = "okay";
@@ -792,3 +910,10 @@
 	vdda-phy-supply = <&vreg_l9a_1p2>;
 	vdda-pll-supply = <&vreg_l18a_0p92>;
 };
+
+&vamacro {
+	pinctrl-0 = <&cdc_dmic01_clk_active &cdc_dmic01_data_active>;
+	pinctrl-names = "default";
+	vdd-micb-supply = <&vreg_s4a_1p8>;
+	qcom,dmic-sample-rate = <600000>;
+};
-- 
2.21.0

