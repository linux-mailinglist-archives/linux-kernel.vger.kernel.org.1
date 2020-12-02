Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D672CC49C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbgLBSJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbgLBSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:09:25 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD10C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:07:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so10849448wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+Hx6pLobOGXXs8wOkryQ0MlQmOPmFt3/oj9+AjGRak=;
        b=orYhDey/HNLXhEUKG3mH9p6941gEfUTzV/eMnt8Zg86fsz5haRD/1ujt0qiOTVQFCn
         VFpsBnRhohyYjJtpjFfZ7ABZulP+e2xHOC/TgTuj7kuaJk1GLurt2Hf8h7HD0JN+YS8m
         VKYi5LEOxMISfwrmQl898ZV6CF3xu6KXKYFWZcBdACw2UFuoLLiTMFdDIKOQ6uTY0pju
         pyc2lnSaFBOPf621PPArjWNssG6mCkoQR0ViD92RDg6iNh2cHYkf7YP6o/uJ11JbbLfN
         owx1rbJ7nQNaU1+Q/m5CBg/pocOhzM++sv47jTl/nrxT98hfhDvHrlsIqw6BigSxd5o2
         xiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+Hx6pLobOGXXs8wOkryQ0MlQmOPmFt3/oj9+AjGRak=;
        b=PfNkikwq3+BqIVv/dKQuB4bEJvoqCMpQBkVhBPAH1iYuHlGLsnxhDE/Mg74KbiD2XZ
         aSyoUxTR0yMhk9opXoz/P46DJIIN9fFLA7lH44WhKc+rnd+KWZFA9+2Y9tkEW0sNtZUN
         CPeBbHqmrrQ4zIwn+PMirRwrnB2//XQEkEXvcEhGwsv6Flqy1gy+8WuCmXayESbEjBTQ
         4YOGQoJcwAd2Ry+JM6yEICXzOhyhNxGzcle8OhBGHDNPqy/goToq7iHN6PpXVer8agIu
         uAWtzCFEob+YqxLRCIJqeY7fRvA/myAU+L7OE97qmSYoY5tdvNuDMqzkwcU0XidFuBhY
         hxIw==
X-Gm-Message-State: AOAM531b0AXbR0Rerw8cLlfrh2BB/XvPUEr41F8JvUzL7YD099HbwRG2
        zU1itbFq37jlGM2NVXea43zr0g==
X-Google-Smtp-Source: ABdhPJy+/qQh2geEM6pGiEsN3COZIp9Vix8PdY/OkdfYpYeZPrcwAG6AWWTZB4BQXyGfn+vcEQvh5Q==
X-Received: by 2002:a1c:3902:: with SMTP id g2mr4311294wma.117.1606932476951;
        Wed, 02 Dec 2020 10:07:56 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id a18sm3004404wrr.20.2020.12.02.10.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:07:56 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm8250: add wsa and va codec macros
Date:   Wed,  2 Dec 2020 18:07:39 +0000
Message-Id: <20201202180741.16386-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201202180741.16386-1-srinivas.kandagatla@linaro.org>
References: <20201202180741.16386-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for WSA and VA codec macros along with WSA soundwire
controller required for getting audio on RB5.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 56 ++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index ce8ae776160d..d2ade3ab3389 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2691,6 +2691,62 @@
 	                };
 		};
 
+		wsamacro: codec@3240000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&wsa_swr_active>;
+
+			compatible = "qcom,sm8250-lpass-wsa-macro";
+			reg = <0 0x3240000 0 0x1000>;
+			clocks = <&audiocc LPASS_CDC_WSA_MCLK>,
+				<&audiocc LPASS_CDC_WSA_NPL>,
+				<&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&aoncc LPASS_CDC_VA_MCLK>,
+				<&vamacro>;
+
+			clock-names = "mclk", "npl", "macro", "dcodec", "va", "fsgen";
+
+			#clock-cells = <0>;
+			clock-frequency = <9600000>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+		};
+
+		swr0: soundwire-controller@3250000 {
+			reg = <0 0x3250000 0 0x2000>;
+			compatible = "qcom,soundwire-v1.5.1";
+			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&wsamacro>;
+			clock-names = "iface";
+
+			qcom,din-ports = <2>;
+			qcom,dout-ports = <6>;
+
+			qcom,ports-sinterval-low =	/bits/ 8 <0x07 0x1F 0x3F 0x07 0x1F 0x3F 0x0F 0x0F>;
+			qcom,ports-offset1 = 		/bits/ 8 <0x01 0x02 0x0C 0x06 0x12 0x0D 0x07 0x0A >;
+			qcom,ports-offset2 = 		/bits/ 8 <0xFF 0x00 0x1F 0xFF 0x00 0x1F 0x00 0x00>;
+			qcom,ports-block-pack-mode = 	/bits/ 8 <0x0 0x0 0x1 0x0 0x0 0x1 0x0 0x0>;
+
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		vamacro: codec@3370000 {
+			compatible = "qcom,sm8250-lpass-va-macro";
+			reg = <0 0x3370000 0 0x1000>;
+			clocks = <&aoncc LPASS_CDC_VA_MCLK>,
+				<&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+
+			clock-names = "mclk", "macro", "dcodec";
+
+			#clock-cells = <0>;
+			clock-frequency = <9600000>;
+			clock-output-names = "fsgen";
+			#sound-dai-cells = <1>;
+		};
+
 		adsp: remoteproc@17300000 {
 			compatible = "qcom,sm8250-adsp-pas";
 			reg = <0 0x17300000 0 0x100>;
-- 
2.21.0

