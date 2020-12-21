Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2792DFF74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgLUSOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgLUSOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:14:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986DC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y23so11831484wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBG38fqf3nkMjryFRLlDYpQKv2p+mxjnCoJD3PtsF7E=;
        b=pyq3hcgB3dqgN6x6iV8m3tKTuu97ztx1JRM8yRKUY3g7PoBWX+j7RZznGGHPZL8YNq
         FtMPrxMV525KDwWzwG5uS2fGNchjwIg6tNEa9NEVGf8Y2es+GQJ3N7BwvjmjxGhmkM8c
         D/c1FKPsHfTNHbX3LS8dEZnOMp7cVxrwO8nbXMdpjub5Cj8w9JXHKf28pyjro59UywH7
         xKy3Qq6XIkXJVQKS84Vm6lBC3KM5YegQVuln3UYlWEMQ3pKfmAnSs0PFRwAMhjoRIgJ8
         sHsETo1+4kwmuU1jNdUlbCPY8H0RDOFH/JmrWUk8zcLgx993sOTlGMBRe7ICvf4rRgAg
         LuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBG38fqf3nkMjryFRLlDYpQKv2p+mxjnCoJD3PtsF7E=;
        b=Ez210sQyEzQeTCc1u4gEgY8+PKLdNYZkZkQ/JRZP0w4beFROb1UujrC63SX6mWlCby
         0A0rGJ+EtDQspS0eQpqYNRXbFwDa0sbhWWE1uDixcGwlvhX2mLnXqE2Gw7V4QyLuM+KJ
         ThesSGpQ6dJ8FHqxoE0VT9GfqJOHYd83D5ZuW8igBlGYysIxXpSlrtsaCh/fB9IxYQw8
         CVE0v7PrpoLXxj1msKqtE0XteKONp7K2MEeUEbftjXCRknPJVqKqnzMHShyAFPPVsDuU
         2hx7YGEXP4TvEE65al9tKhzN7E/g6N5G4e8o4m9yB5KqIJJAuG6io9dnJbDPWL2Js2Jm
         Ss6A==
X-Gm-Message-State: AOAM532pJWr37pgi/fOGeU6u0lBmCVPMhNcqEO7vfTRGDX0pwHVmtqkg
        /C/OzQgbYpkYVOWfP8fDrdg=
X-Google-Smtp-Source: ABdhPJwS7jYu0jsAngYbml49mXApBSnIpKpO60xi05KFbIF1ikmaTorH5qXetfn0BLYr0yTfuS8sqA==
X-Received: by 2002:a1c:1bcc:: with SMTP id b195mr18075018wmb.131.1608574418715;
        Mon, 21 Dec 2020 10:13:38 -0800 (PST)
Received: from localhost.localdomain (p200300f137019000428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3701:9000:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id m11sm23434936wmi.16.2020.12.21.10.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:13:38 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/5] ARM: dts: meson: move iio-hwmon for the SoC temperature to meson.dtsi
Date:   Mon, 21 Dec 2020 19:13:02 +0100
Message-Id: <20201221181306.904272-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
References: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC temperature can be retrieved from ADC channel 8 on all 32-bit
SoCs (Meson6, Meson8, Meson8b and Meson8m2). Move the iio-hwmon instance
to meson.dtsi instead of duplicating it in all board.dts.
If the temperature sensor calibration data is missing for a board then
iio-hwmon will simply not probe.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi              | 5 +++++
 arch/arm/boot/dts/meson8b-ec100.dts       | 5 -----
 arch/arm/boot/dts/meson8b-mxq.dts         | 5 -----
 arch/arm/boot/dts/meson8b-odroidc1.dts    | 5 -----
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 5 -----
 5 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 7649dd1e0b9e..5f074f7aa1a2 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -11,6 +11,11 @@ / {
 	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&saradc 8>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index ed06102a4014..8e48ccc6b634 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -70,11 +70,6 @@ gpio-poweroff {
 		timeout-ms = <20000>;
 	};
 
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&saradc 8>;
-	};
-
 	leds {
 		compatible = "gpio-leds";
 
diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
index 33037ef62d0a..f3937d55472d 100644
--- a/arch/arm/boot/dts/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
@@ -27,11 +27,6 @@ memory {
 		reg = <0x40000000 0x40000000>;
 	};
 
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&saradc 8>;
-	};
-
 	vcck: regulator-vcck {
 		compatible = "pwm-regulator";
 
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 5963566dbcc9..c440ef94e082 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -85,11 +85,6 @@ tf_io: gpio-regulator-tf_io {
 			  1800000 1>;
 	};
 
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&saradc 8>;
-	};
-
 	rtc32k_xtal: rtc32k-xtal-clk {
 		/* X3 in the schematics */
 		compatible = "fixed-clock";
diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index 8f4eb1ed4581..fa6d55f1cfb9 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -45,11 +45,6 @@ button-function {
 		};
 	};
 
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&saradc 8>;
-	};
-
 	vcc_3v3: regulator-vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC3V3";
-- 
2.29.2

