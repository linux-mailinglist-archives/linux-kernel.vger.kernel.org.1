Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123E22CA73E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391835AbgLAPij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390571AbgLAPii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:38:38 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC22C061A4B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:37:26 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 64so3267196wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJcaGNZBGsHMeZykogFq86M34T6M8SXdsetUo9MhrkE=;
        b=buTxQDpbYVAsi1CaU0F23z++LRUjSLD33FuvRbhYdR3i5zYmUnuL5nRW1agjQ6EKcD
         FV2imeVMQz2CCh4BPAIJyrobyjdOiGbiEzVtrf8Auy3reP6rFVlLu76q+JXewvnNBCQ4
         8Z9IeJjaXGh6ZOmri24r8yT8RG5CBO+JOzgu5bX22J3hxCriLFguxxEOQC3Xm6J0sqis
         zkU1oTSLAx7w549yg8aDuROCn1T0wRUhFznTq6UgN2+XY3vDPSSuxA/ceT7NsjtlnEhk
         1gebS2dk/lWEi3o17WpGKfr4z47Ze8VSPNEi4ChPQDksKa82bTCC4VsfrWTz31JKKmKz
         QSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJcaGNZBGsHMeZykogFq86M34T6M8SXdsetUo9MhrkE=;
        b=LTmYAPOWNw0JZWmrIi2t5nMFyS6yr4pQWBBOdpJItPkYBwm7mz9CRigncH2Wf/pGvt
         j8mA22dSSVw6TkLQantuNdSVf9MIi1MRwZjG8DvTekp33oNxwwtOZAgYR/chE5SpGaXY
         G8gHer0vXAfkj7C+HViDEDN7o2WRmRgvTO5XJ/11ZNF4D3kchUmsk66tTFoeJO7oL+F3
         4gsPUXIWCBpEQjIMugxN7WQbLoN1AJuzU6YSUGpvGrGi9wjeGpvq6HAwe2Z66whc1fwO
         9SGTZLK2Rq6D/6/008jQ23807D5RtHvsD7rAY0h4H6HueT77oD02bsQ/SXEaEGd7nJwc
         iDUg==
X-Gm-Message-State: AOAM532GNt0yPWwwf6EzzNfi8e/rcZcVedJoEjWvHwuHZCZWJEKt0q5K
        2nqezCY6CiBc6M4HBqNjgk9V9Q==
X-Google-Smtp-Source: ABdhPJwL3qO2Qg+JtU39QjHcpdu0TMK7Zwq+4vdamdcw+1XXroFiPIZTRVlXZuktewGec+2P5vvdlQ==
X-Received: by 2002:a5d:530d:: with SMTP id e13mr4646676wrv.92.1606837045510;
        Tue, 01 Dec 2020 07:37:25 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y7sm302171wmb.37.2020.12.01.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 07:37:24 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] arm64: dts: qcom: sm8250: add lpass lpi pin controller node
Date:   Tue,  1 Dec 2020 15:37:03 +0000
Message-Id: <20201201153706.13450-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201201153706.13450-1-srinivas.kandagatla@linaro.org>
References: <20201201153706.13450-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LPASS LPI pinctrl node required for Audio functionality on RB5.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 95 ++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index ec5b53b8f656..4e1309b6571e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2607,6 +2607,101 @@
 			clock-names = "core", "audio", "bus";
 		};
 
+		lpass_tlmm: pinctrl@33c0000{
+			compatible = "qcom,sm8250-lpass-lpi-pinctrl";
+			reg = <0 0x33c0000 0x0 0x20000>,
+				 <0 0x3550000 0x0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 14>;
+
+			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "core", "audio";
+
+			wsa_swr_clk_pin {
+				wsa_swr_clk_sleep: wsa_swr_clk_sleep {
+					mux {
+						pins = "gpio10";
+						function = "wsa_swr_clk";
+						drive-strength = <2>;
+						input-enable;
+						bias-pull-down;
+					};
+				};
+
+				wsa_swr_clk_active: wsa_swr_clk_active {
+					mux {
+						pins = "gpio10";
+						function = "wsa_swr_clk";
+						drive-strength = <2>;
+						slew-rate = <1>;
+						bias-disable;
+					};
+				};
+			};
+
+			wsa_swr_data_pin {
+				wsa_swr_data_sleep: wsa_swr_data_sleep {
+					mux {
+						pins = "gpio11";
+						function = "wsa_swr_data";
+						drive-strength = <2>;
+						input-enable;
+						bias-pull-down;
+					};
+				};
+
+				wsa_swr_data_active: wsa_swr_data_active {
+					mux {
+						pins = "gpio11";
+						function = "wsa_swr_data";
+						drive-strength = <2>;
+						slew-rate = <1>;
+						bias-bus-hold;
+					};
+				};
+			};
+
+	                cdc_dmic01_data_active: dmic01_data_active {
+	                        mux {
+	                                pins = "gpio7";
+					function = "dmic1_data";
+	                                drive-strength = <8>;
+	                                input-enable;
+	                        };
+	                };
+
+	                cdc_dmic01_data_sleep: dmic01_data_sleep {
+	                        mux {
+	                                pins = "gpio7";
+					function = "dmic1_data";
+	                                drive-strength = <2>;
+	                                pull-down;
+	                                input-enable;
+	                        };
+	                };
+
+	                cdc_dmic01_clk_active: dmic01_clk_active {
+	                        mux {
+	                                pins = "gpio6";
+					function = "dmic1_clk";
+	                                drive-strength = <8>;
+	                                output-high;
+	                        };
+	                };
+
+	                cdc_dmic01_clk_sleep: dmic01_clk_sleep {
+	                        mux {
+	                                pins = "gpio6";
+					function = "dmic1_clk";
+	                                drive-strength = <2>;
+	                                bias-disable;
+	                                output-low;
+	                        };
+	                };
+		};
+
 		adsp: remoteproc@17300000 {
 			compatible = "qcom,sm8250-adsp-pas";
 			reg = <0 0x17300000 0 0x100>;
-- 
2.21.0

