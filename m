Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECFB26D42A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIQHFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgIQHAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:00:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA82C061353
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:00:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so797371wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+DywmJboSNUNdQ2uZXss10ZspnBgEtSObT6BaOsYuU=;
        b=lW/beOL3XA50ods5obfOlL1dVy/tZBu/kxr17RwS+DsUR2pKeIq9zso0GGCWkx9NQ2
         fSI2bLvOyM/STfJjZub70ytbqqVRlUveC73rzwBk9bP7DWkVGH1C6utZmbmbgowqVWHB
         jrnAn5Hvj5TetikiiBPLMvL3WJEs9BijPJveO5LjfTFqYFagIzYRipupJFYzWPjEO8EI
         djSpZc3OrzRY3KTHLwYhgvO7M6DsqzMh/hIMuFAH1R4jjWomJ9qF3kaQozA+DY8vQcQ5
         r4vfqZk19knZ/sPSD525pqW9tzMhw+5V0v0VhIL37p0NIGCV+NyNP3R87hrR2o7R5Cdk
         TXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+DywmJboSNUNdQ2uZXss10ZspnBgEtSObT6BaOsYuU=;
        b=ND8AYVFtqpbeFhEB2p4CIn1NCZt78Zfb2EPicAmZZI3lYM882vPi1CEpJY/qBjc7kh
         Rj5BT4ebhLRbTT9W9ippHN8DtTLFdCpHBx0mGSot/lzB9jGtpeExYRVNZ+sq4zzqb6P2
         8GG8CJKQVmOu07RjX7HarDJ88FcH5vJQ1cykrv9KvUCblEVuTKi0TJ5Vy5sZdPz+nyLu
         SDUWJIjBg0y744xO8E+mMqzvFSPSkHHFkpnB9SZt2ci671MoIsMG8H7Mk89wdxz3PVqQ
         hFN+QxpFQYzq+XDUOoB4clBKguhLgqz8sO3mVSePIjZH8mffBdXORhjWTbsCTCZTbgwd
         TaHw==
X-Gm-Message-State: AOAM530Z+ZcfWUadKcA3C0gUe4j0PmAMEZ56zr5DFO3ElK/w2Lb3+YgY
        IQh9OO3WH3SWsqkm92wefwXi5Q==
X-Google-Smtp-Source: ABdhPJwECOk8wlkQy6PMVw8pFFC5HSF/3EfVuOGPHmRJS9Hqhvn+vAyLeHVIlckru2yuDvcc8cBcsw==
X-Received: by 2002:a5d:414b:: with SMTP id c11mr29380507wrq.181.1600326004238;
        Thu, 17 Sep 2020 00:00:04 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14sm35709055wrh.14.2020.09.17.00.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:00:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/5] arm64: dts: meson-axg: add USB nodes
Date:   Thu, 17 Sep 2020 08:59:48 +0200
Message-Id: <20200917065949.3476-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200917065949.3476-1-narmstrong@baylibre.com>
References: <20200917065949.3476-1-narmstrong@baylibre.com>
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
index 9ae6db16b8e6..d047779a3dc3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -171,6 +171,46 @@
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
@@ -1734,6 +1774,16 @@
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
2.22.0

