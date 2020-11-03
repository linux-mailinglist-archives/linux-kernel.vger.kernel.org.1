Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AC42A4F0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgKCSiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgKCSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:38:43 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531BC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 10:38:43 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u2so3038389pls.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/y2i5E0lLOisb13IRdBzP56Bd8XoXxDrEf0WMq0vvrM=;
        b=Z5C3WaI6MFFHbzFSQfNv4RpPgpT4fxVtmM1vLkg3tT63xjg/2Z3SxO7aHJBGbfGjuO
         OAcDNt9Su0qU/kmEARDZIX74Bep4NpHiMz5App4uIOj82Ju2Fb+zgNZQr7jI2HRvxj3K
         xRkYUoX53mRTNDt6+nNdWLxfKyXHXc3103BZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/y2i5E0lLOisb13IRdBzP56Bd8XoXxDrEf0WMq0vvrM=;
        b=O9GdzV6DuzMrkt4FM45fcMLUf+xAMs5607JC60Z9WKxJluzGvoY9clTLcOQeGaYd1r
         XCKUcK2Wpuso13HiYqlvV41uYt+XBcso0aW3I1WkPkpn5C1lgGCoRx2InjgsfWKRIYZ0
         FwrY1oZ3dPwXbjv/V+omRVpQamDMLvBr5HqqnsdKu8jn6TxwsPmDE83IUn9GKE/4wFnh
         /8H2JTWE4gJUADRnOYRKqVhYZad7HjlWBKKN37M/cOFEzKNmjBH7dXGIunyuJz/8aKx+
         MnWzys3K1wFnqB+H0CoV+wbU4f1+Mxllhtp8uake05pP3TH5nZ7CXEZAH+yNZEDxRyv1
         eFZQ==
X-Gm-Message-State: AOAM532vus7Q8UlhP7w4GWhWOKrfis20sSfUlWmqYEFBTkuEa1oQmo8Y
        mMbWDShsfOmvZ1tVM4QYY+B6NA==
X-Google-Smtp-Source: ABdhPJwCj82luwLwEimPMxozKH8htGeXlq/o5RCPdsw22t1ZiOvgfbjAmqlypZ8iTdEH/E4YYvgaHQ==
X-Received: by 2002:a17:902:c3c9:b029:d6:7e88:cfa9 with SMTP id j9-20020a170902c3c9b02900d67e88cfa9mr25410888plj.64.1604428723296;
        Tue, 03 Nov 2020 10:38:43 -0800 (PST)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id 16sm4399353pjf.36.2020.11.03.10.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 10:38:42 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7180-trogdor: Make pp3300_a the default supply for pp3300_hub
Date:   Tue,  3 Nov 2020 10:38:33 -0800
Message-Id: <20201103103749.1.I0ed4abdd2b2916fbedf76be254bc3457fb8b9655@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trogdor design has two options for supplying the pp3300_hub power rail,
it can be supplied by pp3300_l7c or pp3300_a. Initially pp3300_l7c was
used, newer revisions (will) use pp3300_a as supply.

Add a DT node for the pp3300_a path which includes a power switch that is
controlled by a GPIO. Make this path the default and keep trogdor rev1,
lazor rev0 and rev1 on pp3300_l7c.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts |  4 +++
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts |  4 +++
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |  4 +++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 30 ++++++++++++++++++-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
index ae4c23a4fe65..08bf30b761fc 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
@@ -22,3 +22,7 @@ &sn65dsi86_out {
 	 */
 	lane-polarities = <1 0>;
 };
+
+&usb_hub {
+	vdd-supply = <&pp3300_hub_7c>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
index 3151ae31c1cc..9f7a44d78a1a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
@@ -13,3 +13,7 @@ / {
 	model = "Google Lazor (rev1+)";
 	compatible = "google,lazor", "qcom,sc7180";
 };
+
+&usb_hub {
+	 vdd-supply = <&pp3300_hub_7c>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index 0a281c24841c..e1840fe07cd0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -62,6 +62,10 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&usb_hub {
+	 vdd-supply = <&pp3300_hub_7c>;
+};
+
 /* PINCTRL - board-specific pinctrl */
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index bf875589d364..2d64e75a2d6d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -174,6 +174,21 @@ pp3300_fp_tp: pp3300-fp-tp-regulator {
 		vin-supply = <&pp3300_a>;
 	};
 
+	pp3300_hub: pp3300-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_hub";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 84 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&en_pp3300_hub>;
+
+		vin-supply = <&pp3300_a>;
+	};
+
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
 
 	backlight: backlight {
@@ -469,7 +484,7 @@ ppvar_l6c: ldo6 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
-		pp3300_hub:
+		pp3300_hub_7c:
 		pp3300_l7c: ldo7 {
 			regulator-min-microvolt = <3304000>;
 			regulator-max-microvolt = <3304000>;
@@ -1151,6 +1166,19 @@ pinconf {
 		};
 	};
 
+	en_pp3300_hub: en-pp3300-hub {
+		pinmux {
+			pins = "gpio84";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio84";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	en_pp3300_dx_edp: en-pp3300-dx-edp {
 		pinmux {
 			pins = "gpio30";
-- 
2.29.1.341.ge80a0c044ae-goog

