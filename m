Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70530285C68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgJGKGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgJGKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:06:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B6AC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 03:06:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n6so1159791wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpuXi1o+IHuZiacFej/j/1OCqU16SYrffISjS5U/rbM=;
        b=gfvZky3W42Kxh+9HkUaAtrNXp4gob+EqYqitVUDZcaqMRVKBGmau+dQ3d38uHLZ4A5
         6bS5ZdmRZY0lWU7NAqW/3gz2U9RKMbAOHvG6g4liOEYqxPKdD5qOl5A+Ghb1dXmB3WeS
         co24EDXZNUHuuGZssBYhbUMAyWub1m85HS5OD6mO6+bDeQ3Vp+EeT83VF/rStr10ZYUS
         Lfem46h9rDsTcbj8+ypF8PXuQKNI2Z9iH47Kjs/VLi2Y/tpPURKqN5UcidX9s5AWXkhM
         DHVSgBzQAiAqp3P84VxJiJhlSv07UmdWMCCgXr3licGpFc74ME9M8iHltrGFdKiWBKG1
         B2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpuXi1o+IHuZiacFej/j/1OCqU16SYrffISjS5U/rbM=;
        b=QhjtKlJPPRcFKGcsz6hAy94Y6mxKU0AxM9FMqtnn+lcqS0wXS5k/PnA1NFi4NyS5S7
         W51F6yCMTTENmrfJDHa0dNA41JDhEirjkVDR2c8R9e23GVB4MjWbrl0xm0s2HlWgbukb
         fbTapRYgSwv064rVelxiYPM6/qDfK/AT7W9X4ydFl8b1UbKmH6kQBpvXas8xQM4g5cTt
         27y31vo9VtQjm1N5WfE73WKsvm+RfW5gVbDRmCd8ZcrVMkXL839Pa4d3divniiuw1Y63
         n0J4aAHQO6DRNqnYcGoeRRh2a5WA/6BmsyJdolMlYkm5BJVvCoOWc/RMwPSbyR4F9dBy
         7n1Q==
X-Gm-Message-State: AOAM533jnl4dNegypKCWwi1Sp8MnvJU8kY30yRSPGMPzJGZCq/I8Iaq5
        os/N9RDyQ4Fo3x5bpYmHtDtzi1zI0zEFE91K
X-Google-Smtp-Source: ABdhPJwIULodMMl6cf11jyGyL9uHswHbpjpN9u0OXnZQDjaSkIf0Rlw+vRZlGgaIjMdczsaxMKPTNQ==
X-Received: by 2002:adf:80e4:: with SMTP id 91mr2618351wrl.223.1602065195284;
        Wed, 07 Oct 2020 03:06:35 -0700 (PDT)
Received: from bojack.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h16sm2214981wre.87.2020.10.07.03.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 03:06:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] arm64: dts: meson-axg: add PCIe nodes
Date:   Wed,  7 Oct 2020 12:06:30 +0200
Message-Id: <20201007100631.192348-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007100631.192348-1-narmstrong@baylibre.com>
References: <20201007100631.192348-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the nodes for the :
- AXG PCIe PHY, using the shared analog PCIe/MIPI DSI PHY
- 2x AXG PCIe controllers

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b27f6f4696da..44393d9c3981 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -172,6 +172,58 @@
 		#size-cells = <2>;
 		ranges;
 
+		pcieA: pcie@f9800000 {
+			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
+			reg = <0x0 0xf9800000 0x0 0x400000>,
+			      <0x0 0xff646000 0x0 0x2000>,
+			      <0x0 0xf9f00000 0x0 0x100000>;
+			reg-names = "elbi", "cfg", "config";
+			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
+			bus-range = <0x0 0xff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x82000000 0 0xf9c00000 0x0 0xf9c00000 0 0x00300000>;
+
+			clocks = <&clkc CLKID_USB>, <&clkc CLKID_PCIE_A>, <&clkc CLKID_PCIE_CML_EN0>;
+			clock-names = "general", "pclk", "port";
+			resets = <&reset RESET_PCIE_A>, <&reset RESET_PCIE_APB>;
+			reset-names = "port", "apb";
+			num-lanes = <1>;
+			phys = <&pcie_phy>;
+			phy-names = "pcie";
+			status = "disabled";
+		};
+
+		pcieB: pcie@fa000000 {
+			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
+			reg = <0x0 0xfa000000 0x0 0x400000>,
+			      <0x0 0xff648000 0x0 0x2000>,
+			      <0x0 0xfa400000 0x0 0x100000>;
+			reg-names = "elbi", "cfg", "config";
+			interrupts = <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
+			bus-range = <0x0 0xff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x82000000 0 0xfa500000 0x0 0xfa500000 0 0x00300000>;
+
+			clocks = <&clkc CLKID_USB>, <&clkc CLKID_PCIE_B>, <&clkc CLKID_PCIE_CML_EN1>;
+			clock-names = "general", "pclk", "port";
+			resets = <&reset RESET_PCIE_B>, <&reset RESET_PCIE_APB>;
+			reset-names = "port", "apb";
+			num-lanes = <1>;
+			phys = <&pcie_phy>;
+			phy-names = "pcie";
+			status = "disabled";
+		};
+
 		usb: usb@ffe09080 {
 			compatible = "amlogic,meson-axg-usb-ctrl";
 			reg = <0x0 0xffe09080 0x0 0x20>;
@@ -230,6 +282,15 @@
 			status = "disabled";
 		};
 
+		pcie_phy: phy@ff644000 {
+			compatible = "amlogic,axg-pcie-phy";
+			reg = <0x0 0xff644000 0x0 0x1c>;
+			resets = <&reset RESET_PCIE_PHY>;
+			phys = <&mipi_pcie_analog_dphy>;
+			phy-names = "analog";
+			#phy-cells = <0>;
+		};
+
 		pdm: audio-controller@ff632000 {
 			compatible = "amlogic,axg-pdm";
 			reg = <0x0 0xff632000 0x0 0x34>;
-- 
2.25.1

