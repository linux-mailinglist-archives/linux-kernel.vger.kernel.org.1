Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D6D2C8A30
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgK3RAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgK3RAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:00:07 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8CEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:59:26 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id f11so14876695oij.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3AKqtsetF/3bygtwtqV3okW03J10w7MYPRsa4Q8rRqs=;
        b=M8OJrSKFLTX0WFm05MzcEUaLJXf0dqYh6EuXVIKrwU+drTaNU20rM9i5l4y2sSL8U9
         bPBnkk6rnUQsXlPpmRcrdPJTcCxN4Rk4oICZ1AXuXzq/NWI1ck/Z2l4+Cqkoeygmzhrb
         xXs3Xgk2N7dKP63D3/BFT1CZI4b/as0hgskh82Y39mdMxlzWyjihvdEdkrToE0VNmlM9
         q/n/uwfc7sqZJ4YumXBcqN6+EQFFSKRZEFUXw/yQQzy1t1J7OSSdDXbW2Zuy1bhfJpu9
         fdsSyPzrEu85b7QYrpMvnNdL+1KY/12wIJnbogjEWR3DW/wbYNSr/IDDTP123EwrCG10
         gOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3AKqtsetF/3bygtwtqV3okW03J10w7MYPRsa4Q8rRqs=;
        b=N7Yc3G/piG4REljhky3Q+3vpwjWOsvN6QEl07UXNSLj8C03so/AzqN1m5VTSF+Xyhj
         iPj6if0KHmetxCPUr0CYv9/SETbQCUR7L0rdiLIodkLMa3u/+5sDV+Zne3gkXbJm6ZhM
         H67l0maS+qrIH9XVbCzjHJN7MlT24+/TQLRMQmUnCnFUr5ue57AMakGnbNJwt2Fq5KK7
         ZGD+emTFShD/1ol4jXLUnZtw/jpyrKCDDsmZNvlZjGq85RwhVGMWw7i2CL12ALq0tsAN
         7cYAnZuGh5fZah1uXXR0wSpo1fY0hSDxFNM7NHuzs8uHfvAionzI9Uky3NZwSy6LpC4c
         5s6g==
X-Gm-Message-State: AOAM531gH3WrlPkjUEjx3VoNPUwmTWG6yryl8hFej/YyoaE/GS3J3BeE
        EbU2OUe9NTF8rqAWhfyP9UPD3b1uK0OA8A==
X-Google-Smtp-Source: ABdhPJyqdkYHTQphFE5XYHsJ7PiuNzw/fBfr3seAF2MUeljr5LZgUiqKO0VeNttycKzKmnnfAvnXyg==
X-Received: by 2002:a54:4f95:: with SMTP id g21mr15365047oiy.61.1606755565905;
        Mon, 30 Nov 2020 08:59:25 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n63sm10018180oih.39.2020.11.30.08.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:59:25 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: c630: Polish i2c-hid devices
Date:   Mon, 30 Nov 2020 10:59:24 -0600
Message-Id: <20201130165924.319708-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The numbering of the i2c busses differs from ACPI and a number of typos
was made in the original patch. Further more the irq flags for the
various resources was not correct and i2c3 only has one of the two
client devices active in any one device.

Also label the various devices, for easier comparison with the ACPI
tables.

Fixes: 44acee207844 ("arm64: dts: qcom: Add Lenovo Yoga C630")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 047ac9c16874..399aef2a0951 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -264,23 +264,28 @@ &i2c3 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	hid@15 {
+	tsel: hid@15 {
 		compatible = "hid-over-i2c";
 		reg = <0x15>;
 		hid-descr-addr = <0x1>;
 
-		interrupts-extended = <&tlmm 37 IRQ_TYPE_EDGE_RISING>;
+		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c3_hid_active>;
 	};
 
-	hid@2c {
+	tsc2: hid@2c {
 		compatible = "hid-over-i2c";
 		reg = <0x2c>;
 		hid-descr-addr = <0x20>;
 
-		interrupts-extended = <&tlmm 37 IRQ_TYPE_EDGE_RISING>;
+		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_HIGH>;
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_hid_active>;
+		pinctrl-0 = <&i2c3_hid_active>;
+
+		status = "disabled";
 	};
 };
 
@@ -288,15 +293,15 @@ &i2c5 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	hid@10 {
+	tsc1: hid@10 {
 		compatible = "hid-over-i2c";
 		reg = <0x10>;
 		hid-descr-addr = <0x1>;
 
-		interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&tlmm 125 IRQ_TYPE_LEVEL_LOW>;
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&i2c6_hid_active>;
+		pinctrl-0 = <&i2c5_hid_active>;
 	};
 };
 
@@ -304,7 +309,7 @@ &i2c11 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	hid@5c {
+	ecsh: hid@5c {
 		compatible = "hid-over-i2c";
 		reg = <0x5c>;
 		hid-descr-addr = <0x1>;
@@ -312,7 +317,7 @@ hid@5c {
 		interrupts-extended = <&tlmm 92 IRQ_TYPE_LEVEL_LOW>;
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&i2c12_hid_active>;
+		pinctrl-0 = <&i2c11_hid_active>;
 	};
 };
 
@@ -426,7 +431,7 @@ codec {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	i2c2_hid_active: i2c2-hid-active {
+	i2c3_hid_active: i2c2-hid-active {
 		pins = <37>;
 		function = "gpio";
 
@@ -435,7 +440,7 @@ i2c2_hid_active: i2c2-hid-active {
 		drive-strength = <2>;
 	};
 
-	i2c6_hid_active: i2c6-hid-active {
+	i2c5_hid_active: i2c5-hid-active {
 		pins = <125>;
 		function = "gpio";
 
@@ -444,7 +449,7 @@ i2c6_hid_active: i2c6-hid-active {
 		drive-strength = <2>;
 	};
 
-	i2c12_hid_active: i2c12-hid-active {
+	i2c11_hid_active: i2c11-hid-active {
 		pins = <92>;
 		function = "gpio";
 
-- 
2.29.2

