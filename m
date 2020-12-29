Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD42E743F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgL2VTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgL2VS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:18:58 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB39AC0617A0;
        Tue, 29 Dec 2020 13:17:48 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u19so13755956edx.2;
        Tue, 29 Dec 2020 13:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CykdsuJQmQKkcyjb49a1JcXvtyqlA5qLyewWUhGJatc=;
        b=Ohl4jfx2A5dpZwbMxVpRgu8m7894QhOi/n6CTAgjMm6OTHnOgXWJUkkiJuytlEAGyH
         Dgd/k1N/j3eKtB0tTFNZTXE+LF5KheppyzS+EjImz2YQpBNCGxxdT3Mn+Ucp0FmGOXPX
         9oNE4hp5d9rXkbevcaUClW93uVwcgSrOdoZxuAfwRVoybVpIdZM8VXvWQzcnEngWDmYV
         RtWdvHBfDt6T4MeOwm5jW2r5Wrnd/073S8Cbu20v7VcHI6qj371M09QsAxBDyGDR0pnC
         CLDNJDnuoHUAFbAC3eAL3JnvKvLQmKmbcenjXdslGA+UX6yazCo+lTnM83b45MTR/js/
         02ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CykdsuJQmQKkcyjb49a1JcXvtyqlA5qLyewWUhGJatc=;
        b=O2O16Ubxtcm8bY7X/Jq5bASmoy6nKpkwvJODzJXOwEtzSo01Hr1Ue+h9bycCCgVTNm
         11ox8KaNq5melH/1MIx3NpE8BJsB1EZJSeM0KFxoCFbiVdsgj5VkGClubWhLi2dSESjx
         5JSvUye/nl1u2krLJnZ4S5emPoqIskWJrSGZAka3fEirlIhdGwiazYS19ZiBX2dZ2x4P
         62PKtxu/FzRep6NEx9DS9g5/UHT3VA14SH1UXDav1WU92vgieL7xk7v7ECTP0GyiiV9w
         zGVr6B/+pWpH6XVtkxngPbgDYuMBYpms/M8kWbAK/9mm8yPl92/IUvBPq6ituc8d0XMG
         miVg==
X-Gm-Message-State: AOAM531nJ8j/vpZDUvZaog/Dd/q7txHdu2N9nfyNRKrEUoOJGqf2zhIs
        PEDzpNCKgXkMOSewJdMk6BQ=
X-Google-Smtp-Source: ABdhPJyOP1XT6qZjOJMPpM7fvNEOZHLtUYO59wQfCu/v917GtH9SA9vStTFc+4L6epFMk4FSjA0zQQ==
X-Received: by 2002:aa7:c886:: with SMTP id p6mr48059849eds.207.1609276667450;
        Tue, 29 Dec 2020 13:17:47 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:46 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/13] arm: dts: owl-s500-roseapplepi: Add uSD support
Date:   Tue, 29 Dec 2020 23:17:26 +0200
Message-Id: <47ee9695e89198ec2fbc4ab6188f1d0ad0424b2f.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uSD support for RoseapplePi SBC using a fixed regulator as a
temporary solution until PMIC support becomes available.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v3:
 - None

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
2.30.0

