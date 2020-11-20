Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE91C2BAF00
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgKTPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgKTPch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:32:37 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139D9C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:32:36 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id j7so10474173wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qECUmJ7i37OI126KT2ZCqYFNHb2XPZlIEHKmEDXRy0k=;
        b=eAiZZPHayWxA496THQg2NO4o3xrHZFbzfQv0s0bsYfyepKbenM+hPIcFj7YUU7udiF
         wztzGdNlShDPVvAHia9mKF3ec9ZWCfyf2Cdyq3jCgnOws0ln5bpjxBVksTWWyXwzR0Kj
         xEwQSFz3GzaS4AWdUO6z5zIotRqdGJnvO7cF8rWUffE6XYxuc0GLTY+ACllpCweNSPKu
         CJAKWcf1MtnuvukpwXPuColV2M0V4pjvSoqEKN3OUpqgRIz0w4jLmunLrZSCQIVKcPwX
         2vH4i6IDY5Vp31fefRrpmO2UlKOFgucp1OtbhyqrA33BOweMAp7uCKIIbdTHfZc+MveY
         ZudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qECUmJ7i37OI126KT2ZCqYFNHb2XPZlIEHKmEDXRy0k=;
        b=P5CwVmXjY1pMUE1A85EcCQBjYBLduMpfnLlVIJsCrmhFVneo6LPyHkf2DyV36hhtYz
         r1fd0TD9Z7EDUErSbLTS5ktf3zIVCfyyPPBYtpYvmpqyn85KZ7yv7i6RAz84/iHr5GVQ
         27+UcXnogNTY4TJqCYsKb0FZjYZPlMdiixDh5Wa1yghN2nJLPAAX67tTCJZTuHVw72Qe
         vSEwrNKuauW6UIPb5Uf93vQAKd5JXnNt8FI2cgae6GtY4TeI4NAFUNEgqhmohKfkwE6Q
         /ZIW5KZZpADDqNX5sT6pX+cWYsefPrDHbA8nqEC536SCoi6tmuExvkZ1Dr3hBpBgHzVp
         SN9Q==
X-Gm-Message-State: AOAM531n97xbHgw0LLDXQgvaghgWn8Kus8HaLI655iAUXGuyVUgeYQjC
        mHnCa39BEtjeIqGKbBB9wMIAhg==
X-Google-Smtp-Source: ABdhPJyhYc/oVgaBEiYn8vj3ptWCf6cMyzmrnejPst3ogZ35ww5mclSng4q5wzZIM0qZL2cPPNB/Yw==
X-Received: by 2002:a05:6000:89:: with SMTP id m9mr16796731wrx.412.1605886354671;
        Fri, 20 Nov 2020 07:32:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id i16sm5398180wru.92.2020.11.20.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:32:33 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/4] arm64: dts: meson-axg: add USB nodes
Date:   Fri, 20 Nov 2020 16:32:26 +0100
Message-Id: <20201120153229.3920123-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120153229.3920123-1-narmstrong@baylibre.com>
References: <20201120153229.3920123-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the USB Glue node, with the USB2 & USB3 controllers along the single
USB2 PHY node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index d811708f8f67..0c4f0cf076ab 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -172,6 +172,46 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		usb: usb@ffe09080 {
+			compatible = "amlogic,meson-axg-usb-ctrl";
+			reg = <0x0 0xffe09080 0x0 0x20>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB1_DDR_BRIDGE>;
+			clock-names = "usb_ctrl", "ddr";
+			resets = <&reset RESET_USB_OTG>;
+
+			dr_mode = "otg";
+
+			phys = <&usb2_phy1>;
+			phy-names = "usb2-phy1";
+
+			dwc2: usb@ff400000 {
+				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
+				reg = <0x0 0xff400000 0x0 0x40000>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_USB1>;
+				clock-names = "otg";
+				phys = <&usb2_phy1>;
+				dr_mode = "peripheral";
+				g-rx-fifo-size = <192>;
+				g-np-tx-fifo-size = <128>;
+				g-tx-fifo-size = <128 128 16 16 16>;
+			};
+
+			dwc3: usb@ff500000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff500000 0x0 0x100000>;
+				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				maximum-speed = "high-speed";
+				snps,dis_u2_susphy_quirk;
+			};
+		};
+
 		ethmac: ethernet@ff3f0000 {
 			compatible = "amlogic,meson-axg-dwmac",
 				     "snps,dwmac-3.70a",
@@ -1795,6 +1835,16 @@ sd_emmc_c: mmc@7000 {
 				clock-names = "core", "clkin0", "clkin1";
 				resets = <&reset RESET_SD_EMMC_C>;
 			};
+
+			usb2_phy1: phy@9020 {
+				compatible = "amlogic,meson-gxl-usb2-phy";
+				#phy-cells = <0>;
+				reg = <0x0 0x9020 0x0 0x20>;
+				clocks = <&clkc CLKID_USB>;
+				clock-names = "phy";
+				resets = <&reset RESET_USB_OTG>;
+				reset-names = "phy";
+			};
 		};
 
 		sram: sram@fffc0000 {
-- 
2.25.1

