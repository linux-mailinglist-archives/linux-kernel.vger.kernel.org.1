Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02932734E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgIUV1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUV1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:27:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD09C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:27:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b17so427996pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1cNEjI6vBx/2IctQdWYH5QeAX4vlIgnDCfCgcDi02w=;
        b=JFmv4fjBxgHItcElNgO81uhGX9JDXLxYcOtAFUqgF/CBvQwuaskLCZe5z9XC3aLN34
         vdJp7rZ6IWxShkH3S9fZUSN/D242B7qNyhIeDt8objn+tHVwqXrQc/seCzU43NmN+Yct
         M/LzIgsHf9dqeM8Eddj5KXwVvXBYpHK2J11c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1cNEjI6vBx/2IctQdWYH5QeAX4vlIgnDCfCgcDi02w=;
        b=bAXO99tmoZNd3KI0+Eodtc9jbVrSxI5mYYgeyeWn+JGNfsTQMu1NjQ0i668wORninQ
         omzYVkAnm1rDMkakXs1X52lsOI0h+ypnKfANrlZ3hMkT0ZHFH2XvadV5CUuhD1otbnfj
         bswlLByX1E9193vwzL4SV+5A55RqAOV/4AlYBYgJ/Nl+kT8YT+fOhOjT6dD0Ux45igPr
         IeM7b7RxXGKfUlFRLPfaXPGKCQndV74ltf1UuhySnZpl3uzE1aILURJQJSMFbc/pt5f2
         8qlw6M9qX8uCboHDSeKFx5xzFKEp/1FKP/bap8kzpRoBg7vwON6Z7/4AUX1SZcB/tvUe
         NcmQ==
X-Gm-Message-State: AOAM530ec5Cyv5mS4Mf2tFVPzb2ANR0Ad3VlUmbXDP/IaDsA4UO77Los
        KJf9RIl2RC/5MTTdbcnCxst99w==
X-Google-Smtp-Source: ABdhPJygVUS93ltppQU3sEhBy7eUmdK/1uIv2ae9txtkZMaHd0H34MWHcmmyJGtdxdG+eXx9rRT1YA==
X-Received: by 2002:a17:90b:8a:: with SMTP id bb10mr1108424pjb.108.1600723663802;
        Mon, 21 Sep 2020 14:27:43 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id x62sm3865659pfx.20.2020.09.21.14.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 14:27:43 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, akashast@codeaurora.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: qcom: Switch sc7180-trogdor to control SPI CS via GPIO
Date:   Mon, 21 Sep 2020 14:27:17 -0700
Message-Id: <20200921142655.v3.2.I3c57d8b6d83d5bdad73a413eea1e249a98d11973@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200921142655.v3.1.I997a428f58ef9d48b37a27a028360f34e66c00ec@changeid>
References: <20200921142655.v3.1.I997a428f58ef9d48b37a27a028360f34e66c00ec@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As talked about in the patch ("arm64: dts: qcom: sc7180: Provide
pinconf for SPI to use GPIO for CS"), on some boards it makes much
more sense (and is much more efficient) to think of the SPI Chip
Select as a GPIO.  Trogdor is one such board where the SPI parts don't
run in GSI mode and we do a lot of SPI traffic.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index bf875589d364..0759896a0df5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -776,7 +776,20 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 69 GPIO_ACTIVE_LOW>;
 };
 
+&spi0 {
+	pinctrl-0 = <&qup_spi0_cs_gpio>;
+	cs-gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
+};
+
+&spi6 {
+	pinctrl-0 = <&qup_spi6_cs_gpio>;
+	cs-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
+};
+
 ap_spi_fp: &spi10 {
+	pinctrl-0 = <&qup_spi10_cs_gpio>;
+	cs-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+
 	cros_ec_fp: ec@0 {
 		compatible = "google,cros-ec-spi";
 		reg = <0>;
@@ -937,7 +950,7 @@ pinconf {
 	};
 };
 
-&qup_spi0_default {
+&qup_spi0_cs_gpio {
 	pinconf {
 		pins = "gpio34", "gpio35", "gpio36", "gpio37";
 		drive-strength = <2>;
@@ -945,7 +958,7 @@ pinconf {
 	};
 };
 
-&qup_spi6_default {
+&qup_spi6_cs_gpio {
 	pinconf {
 		pins = "gpio59", "gpio60", "gpio61", "gpio62";
 		drive-strength = <2>;
@@ -953,7 +966,7 @@ pinconf {
 	};
 };
 
-&qup_spi10_default {
+&qup_spi10_cs_gpio {
 	pinconf {
 		pins = "gpio86", "gpio87", "gpio88", "gpio89";
 		drive-strength = <2>;
-- 
2.28.0.681.g6f77f65b4e-goog

