Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003FE2C9781
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 07:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgLAGWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 01:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLAGWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 01:22:22 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4015C0613CF;
        Mon, 30 Nov 2020 22:21:41 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so810167wrs.4;
        Mon, 30 Nov 2020 22:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B4+vAwQ0XCGKpTMOHLaGMHXIiumHxrp3xUNQ40+C1+8=;
        b=rXJKZ0qW5KrSEWabbe0E2m7shheeGE//k5UkLxCKEibmNwbb3xc2/iAp3VyX58+7/P
         QibHPg4Rhn/mQDnynGzpK6nPXS984H0gSIdB75Yht6kObRNXRmFrav4WPk7Rws2+J1FS
         z50xoyhegyr/gZVre+FVn898P1i3GnhQIGqNq3I4eUVPbAIObq5xocfqUFkbw2pDA+Vg
         kjjCYdoud/eT+Bibe+X3EriN1zWQjnwYjoggn9uRkKpHLgb/S8eZNXZDtxK5ZMo+zfvC
         +3nTGhXnVkOQvNqZc34EioGCAE0i39rO8Icpqr7eEeNcTXttvOZQ1mW1xnsNgmIBt098
         1wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B4+vAwQ0XCGKpTMOHLaGMHXIiumHxrp3xUNQ40+C1+8=;
        b=N0xM2lQQvQgsH5qO7JEE8Hl2K9CqgnJOT838Q7/9rMx6kFxJgzC50e1Xpc3TAaH2FX
         7nDdXL8v54zfhhjCJILpqMOWTO6Ccxgjf4bM3liQo3v7Uh9xTJq1U5S8OpTEwBJjgoRJ
         YRv2fFhXu8Pyv2FyZM0NHwsQYtzU4XE7YH0ZO4bjTJGCF8Z5cmNK0/9P3K+ChBXCJ5lH
         y7xGjn+Ds2ideuzthBRPzlEjYvTd2bMszgCDI7NRJS52kDDuRyVWTpnq5anow+lgLhCu
         6s67W5LCGv+3NDQTp9T2PvkV/tHm338HpVf+SWTgv8fG4h9cJoMP1vaEt1RpMBizJx58
         kv1Q==
X-Gm-Message-State: AOAM531RdSLMA2JAVhYK5a8baRLFkmw02xiMytpOqkvBiNkrSoKivS13
        Hyny2i4VV7sY9nhUSfYtOy4=
X-Google-Smtp-Source: ABdhPJxp4scGf9eqgOeK9SrGoge69GmJOdlImhNfFcszMuRmEiHWjISTjs6y6cynMoOYb+ygD6AxTw==
X-Received: by 2002:adf:9bd0:: with SMTP id e16mr1716956wrc.196.1606803700442;
        Mon, 30 Nov 2020 22:21:40 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 90sm1182182wra.95.2020.11.30.22.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 22:21:39 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add i2c3/rtc nodes and vrtc alias to GT-King/GT-King-Pro
Date:   Tue,  1 Dec 2020 06:21:35 +0000
Message-Id: <20201201062135.18241-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GT-King and GT-King-Pro boxes have an RTC chip and power cell, so enable it.

GTKING:~ # dmesg | grep rtc
[    5.237245] meson-vrtc ff8000a8.rtc: registered as rtc1
[    5.261869] rtc-hym8563 0-0051: registered as rtc0
[    5.265016] rtc-hym8563 0-0051: setting system clock to 2020-11-30T09:16:54 UTC (1606727814)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-g12b-gtking-pro.dts | 17 +++++++++++++++++
 .../boot/dts/amlogic/meson-g12b-gtking.dts     | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
index f0c56a16af3d..0e5c500fb78f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
@@ -14,6 +14,11 @@
 	compatible = "azw,gtking", "amlogic,g12b";
 	model = "Beelink GT-King Pro";
 
+	aliases {
+		rtc0 = &rtc;
+		rtc1 = &vrtc;
+	};
+
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		#address-cells = <1>;
@@ -112,6 +117,18 @@
 	status = "okay";
 };
 
+&i2c3 {
+	status = "okay";
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+
+	rtc: rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		wakeup-source;
+	};
+};
+
 &tdmif_b {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
index eeb7bc5539ef..10b87eb97b14 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
@@ -14,6 +14,11 @@
 	compatible = "azw,gtking", "amlogic,g12b";
 	model = "Beelink GT-King";
 
+	aliases {
+		rtc0 = &rtc;
+		rtc1 = &vrtc;
+	};
+
 	spdif_dit: audio-codec-1 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
@@ -122,6 +127,19 @@
 	status = "okay";
 };
 
+
+&i2c3 {
+	status = "okay";
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+
+	rtc: rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		wakeup-source;
+	};
+};
+
 &spdifout {
 	pinctrl-0 = <&spdif_out_h_pins>;
 	pinctrl-names = "default";
-- 
2.17.1

