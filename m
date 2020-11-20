Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40E02BAF02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgKTPcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgKTPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:32:41 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214ABC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:32:40 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so10493342wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sy+npf4qPF0hQlWQGZkG29ESoHVhDUO9bSuS4H9zF4M=;
        b=HXBYOzbhhXmSyjWEDFN61kOL4DFh60eZtEvpShrq/4pUHXnoVh0sBP7EM2X4RVtdvc
         aMNY7gKfuBz84ig/MTRHz1D7IWrH3f8aUqMS1DQIdODMpztoaNSA/KUvqJu91SX7KZmK
         VgHmgzGCb0o4TZzhbHeQxPd76RWm+4L26FlJQqZ25E54//EpDOYshiVpI57VU8Lr46zy
         sWoRpqThp8YrbCAvl8RUI2TPf+dvC8irVUtdG3w4Bx9RgeTtxdMZxNfHYU0s+o2lb8eG
         6sJbCWTyIKDaAhW5rUzxJ2/f3dB7MOw0VjMETcE1QOXhSEUhgcM6Tesm+Lrrmk/uPnY/
         2ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sy+npf4qPF0hQlWQGZkG29ESoHVhDUO9bSuS4H9zF4M=;
        b=YIK7YuAVCNIiSvzvCMF9iOQ0V3Pzz2PSH8zEnZo5G6N/Y6HeB4H5TVVwimHhU1ypqd
         hUStr3VK/zzQtTjG3Nlk8Q4+BrzuFAewgt/urfAp86OSN1SkdnSV1sorVBpQN9/4Eh3q
         i0swy4U0IIZFlG3omUX4sVE+HPFhVYfS/BTEbxQj9+aE9Syq2wzzIGjyDUXfrV7SFf+m
         AdTfMej1CPOTiX2s46qoUHwS3rEUSbPOLtGqkDVI7p5xYdNSFh7qvjtJyEHIlJZKmyJg
         Zw2X05B1U3IVOavjfC7anRqcajgKaifgDzWZNrp8iAzSXuilGhijIfYKvUNcIyRZRlbl
         MeiA==
X-Gm-Message-State: AOAM533ThdA0b1qvMiqs164AQyqBS3MMurxeIC1CHGvjkfPgGx/+vt8Q
        ZuVPuEu4i6YhLI9HCmZisk6FtQ==
X-Google-Smtp-Source: ABdhPJyz6mra4I7tNvn0ImxS7+5dhfVI4AZGFHDt2MjVCkmcYSSSvvgsYSbh60Ckrcus6kS0DPgiAg==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr16575614wrw.200.1605886358656;
        Fri, 20 Nov 2020 07:32:38 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id i16sm5398180wru.92.2020.11.20.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:32:37 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/4] arm64: dts: meson-axg: add PCIe nodes
Date:   Fri, 20 Nov 2020 16:32:28 +0100
Message-Id: <20201120153229.3920123-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120153229.3920123-1-narmstrong@baylibre.com>
References: <20201120153229.3920123-1-narmstrong@baylibre.com>
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
index 0c4f0cf076ab..b5a06210c49a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -172,6 +172,58 @@ soc {
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
@@ -232,6 +284,15 @@ ethmac: ethernet@ff3f0000 {
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

