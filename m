Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63F2B9EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgKSX4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgKSX4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:38 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972D0C0613CF;
        Thu, 19 Nov 2020 15:56:38 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id i19so10384472ejx.9;
        Thu, 19 Nov 2020 15:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qO93vAGuITSebLhoJ1hpwjQmgCXudOAkh2U6z4dlaEM=;
        b=Ok31bZxZGVHmgQxPtvqLKDgAbESWqR6TkAcjj0CCABPgalzGMuYw1a9AS7ax+5kmak
         mwY4ri8PmJr7A6gqDrxBJpSdG3uR2YIUq0b4rlXC/6W1LRog803Wi4LlNAsZmxT4zrwd
         idJyS8jWov8wJat0Vd4rX0qd0Eq4ffm3I9SUvThFFdwMhSf6Cm84o5LU+qW2V7EDZn/+
         FGJEBZHCJsU5X6Mcm4kJTUy1cXGaHHmiaQr2wgHToEjB8FTcQ+WD3ptGiddO7XbBXvj5
         wYtpfyAmyfLVfjhvF44uKY4a6oaCPEQG74R6Dmmf1eRQMy7jjnQNHQNajc5u6Gz3n8PJ
         TvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qO93vAGuITSebLhoJ1hpwjQmgCXudOAkh2U6z4dlaEM=;
        b=N66H3yh+4a5NBDF/7zp66O20qgyyrS1ipd/QECECn7CPLHE/nfC3ZyYd15ooPWO9ad
         4wUXFygDpw4J8aM17IQITILv/e+WpA1sCHiSpDV0n3za2stiMSgDSxn7t1V4q8miyGDY
         E23QOUrKPt4C0j1cZoFs3ZvU2s1iE/n7JZVeY9U+maXFYwAd8iyxJ7YXJBwcoiwBEvbg
         E/mJXl6+S24QbVT/+N3bKNYlN8h/T7E3sQl2Zjr0eeIhNlJP20gVBPUKIxFn05qThjcM
         li7X9K8te+vl8A98F5AFcvujLyEn/rVtj1oHhMjo7FmWUubmpAqtJB5yZMOmPAnrfCzp
         maZg==
X-Gm-Message-State: AOAM530Kjs5wCHSTUaaLsbs3c65LRKm8lU5J0cPdlpIz9E9A0fN4Q13q
        2W/sP1gw7uCNjN+O5DDcF8bjJF1CfV98NA==
X-Google-Smtp-Source: ABdhPJy3Z6o3YiBs+6Lolp+IvVcJ1y4/+1SQ2G+ojjITQePGqiiNV2kGlTsYNU5ih684IWcI36A14Q==
X-Received: by 2002:a17:906:f1d8:: with SMTP id gx24mr29842741ejb.73.1605830197323;
        Thu, 19 Nov 2020 15:56:37 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:36 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/18] arm: dts: owl-s500-roseapplepi: Add uSD support
Date:   Fri, 20 Nov 2020 01:56:10 +0200
Message-Id: <cf62e297a18518d54dd887a0bc531b18a50da5c5.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uSD support for RoseapplePi SBC using a fixed regulator as a
temporary solution until PMIC support becomes available.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index 800edf5d2d12..fe9ae3619422 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -14,6 +14,7 @@ / {
 	model = "Roseapple Pi";
 
 	aliases {
+		mmc0 = &mmc0;
 		serial2 = &uart2;
 	};
 
@@ -25,6 +26,55 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000>; /* 2GB */
 	};
+
+	/* Fixed regulator used in the absence of PMIC */
+	sd_vcc: sd-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+		regulator-always-on;
+	};
+};
+
+&pinctrl {
+	mmc0_pins: mmc0-pins {
+		pinmux {
+			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
+				 "sd0_cmd_mfp", "sd0_clk_mfp";
+			function = "sd0";
+		};
+
+		drv-pinconf {
+			groups = "sd0_d0_d3_drv", "sd0_cmd_drv", "sd0_clk_drv";
+			drive-strength = <8>;
+		};
+
+		bias0-pinconf {
+			pins = "sd0_d0", "sd0_d1", "sd0_d2",
+			       "sd0_d3", "sd0_cmd";
+			bias-pull-up;
+		};
+
+		bias1-pinconf {
+			pins = "sd0_clk";
+			bias-pull-down;
+		};
+	};
+};
+
+/* uSD */
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	no-sdio;
+	no-mmc;
+	no-1-8-v;
+	cd-gpios = <&pinctrl 117 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	vmmc-supply = <&sd_vcc>;
+	vqmmc-supply = <&sd_vcc>;
 };
 
 &twd_timer {
-- 
2.29.2

