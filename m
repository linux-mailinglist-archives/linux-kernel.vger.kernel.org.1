Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2572CA748
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391913AbgLAPiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391905AbgLAPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:38:54 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D9C061A53
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:37:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so3269912wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vXiT5FpPdzP+F5sPQwMF6j9EVgTdZPYADmNV8Tr/zQ=;
        b=TbVdQfZdGXdVxc/qIYtd7/2RnLmbhk9iHaPbVGxFpQrpBDSS/iC/zhk0Mpty5j2yvd
         MMejl3MDG9f106+i9JnkxzHN38reC3FB6VXryJ2wlyRDzUO5GjqtVJoFLuXNu34ISPU0
         ViPvsutDNP180YEf8K195Sb1Pjbz1nCCKGjKEvwru2GmOyhrOy03li0QpF2cVn6J8GwV
         orv5Gme+c3L862r4n05I0S/iTEwgG7tTdurW4841H4DihC3tch67vtZH/t1QQuuXmy8r
         jRM7Ac0fTReQi/OmH/sTr01B1qkhCwjQU9fDW3/nlIYyA74wSEQCej/TTYryuPdEGMPH
         AqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vXiT5FpPdzP+F5sPQwMF6j9EVgTdZPYADmNV8Tr/zQ=;
        b=iOtG9eQWDwR6vw6IuURutNQR03zucFD/fxrF+QikUF1rW9/nr0sxD7x4oaQyhcSV/t
         622djVhQPjfyIbzaeDMkMpUAG80T1gBUfn/oc0ritMnHf+P5ERyF9QHjElpofzT8rxKw
         9k40j5tep3em0tXeCM3bpadRSZ3nXi6uXeJyhdI8tx07IJ5M/Jt1wElxTE8zGO4SoQWy
         8a3xRFzi6XjzygEkYjSVgNIgQnkgtuJZoEwq4jZsUWD7h3JsUGpCf/Y0yCC26gdsEYfB
         IzeeagBgoS4UFnjnty7Ax1hIo/cs5Si+bLpIvNM0VBUBPWbG+Wy1wfHLxq0fZUMKJhUE
         RA0w==
X-Gm-Message-State: AOAM5323N9qvYzDTGR2r2TfP94f1shbOoT7FL80aPyKMTOqxj99vFOUZ
        q6F4gowLDfPtIEdCStKbTh4+2Q==
X-Google-Smtp-Source: ABdhPJwpSRyY1JngpXYaiQ/Pmaldz9WrCP/ULRroZLPPi+CRiFFopPSDfB0moPEm6/LpXN/QTbiTlA==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr4445405wru.8.1606837048122;
        Tue, 01 Dec 2020 07:37:28 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y7sm302171wmb.37.2020.12.01.07.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 07:37:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/6] arm64: dts: qcom: sm8250: add mi2s pinconfs
Date:   Tue,  1 Dec 2020 15:37:05 +0000
Message-Id: <20201201153706.13450-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201201153706.13450-1-srinivas.kandagatla@linaro.org>
References: <20201201153706.13450-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add primary and tertinary mi2s pinconfs required to get I2S audio.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 98 ++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 19dd7460e586..a87940e157be 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1561,6 +1561,9 @@
 			};
 		};
 
+		sound: sound {
+		};
+
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sm8250-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
@@ -1884,6 +1887,60 @@
 			gpio-ranges = <&tlmm 0 0 180>;
 			wakeup-parent = <&pdc>;
 
+			pri_mi2s_sck_active: pri-mi2s-sck-active {
+				mux {
+					pins = "gpio138";
+					function = "mi2s0_sck";
+				};
+
+				config {
+					pins = "gpio138";
+					drive-strength = <8>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			pri_mi2s_ws_active: pri-mi2s-ws-active {
+				mux {
+					pins = "gpio141";
+					function = "mi2s0_ws";
+				};
+
+				config {
+					pins = "gpio141";
+					drive-strength = <8>;
+					output-high;
+				};
+			};
+
+			pri_mi2s_sd0_active: pri-mi2s-sd0-active {
+				mux {
+					pins = "gpio139";
+					function = "mi2s0_data0";
+				};
+
+				config {
+					pins = "gpio139";
+					drive-strength = <8>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			pri_mi2s_sd1_active: pri-mi2s-sd1-active {
+				mux {
+					pins = "gpio140";
+					function = "mi2s0_data1";
+				};
+
+				config {
+					pins = "gpio140";
+					drive-strength = <8>;
+					output-high;
+				};
+			};
+
 			qup_i2c0_default: qup-i2c0-default {
 				mux {
 					pins = "gpio28", "gpio29";
@@ -2480,6 +2537,47 @@
 					function = "qup18";
 				};
 			};
+
+			tert_mi2s_sck_active: tert-mi2s-sck-active {
+				mux {
+					pins = "gpio133";
+					function = "mi2s2_sck";
+				};
+
+				config {
+					pins = "gpio133";
+					drive-strength = <8>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			tert_mi2s_sd0_active: tert-mi2s-sd0-active {
+				mux {
+					pins = "gpio134";
+					function = "mi2s2_data0";
+				};
+
+				config {
+					pins = "gpio134";
+					drive-strength = <8>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			tert_mi2s_ws_active: tert-mi2s-ws-active {
+				mux {
+					pins = "gpio135";
+					function = "mi2s2_ws";
+				};
+
+				config {
+					pins = "gpio135";
+					drive-strength = <8>;
+					output-high;
+				};
+			};
 		};
 
 		apps_smmu: iommu@15000000 {
-- 
2.21.0

