Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3892CBF12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbgLBOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388939AbgLBOIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:08:00 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15120C08E85F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:06:39 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id x16so4473910ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2JtlLp4w1Z1giGmdmjx5S9UgA6z7cseKVrEi8bWQG4=;
        b=OImXmOsA4pg0SUS/a/BG+be5IQ+DHkJQdC404Vt81CIJ9nxaGxv7B6PxS5goj81sjG
         F1WuhU/Gib+bajvJoA5cavcNou9wHv4HKAgWSEaLdCjniEcyT2WhrQPlAYFXxOBuH0ax
         OLoQiX7QRCm1l1QQqevgRFePsjBfD29qC7NjzM8p8YuH5sDSaHFA6PbHRvVLrYjOWQkM
         0z1Y9zxntwwUlaD7Umc+uv6AtOJY6RLDxPx4IYROLCmxWTtQcYHekg5PFBGUmJeVg2FI
         rFL91zcWi9rm/ryskzaK4oleo7lhWurD+2F6zAaDVmDlvkis8x8TxDvTe3Db3lQ5pkjN
         4DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=j2JtlLp4w1Z1giGmdmjx5S9UgA6z7cseKVrEi8bWQG4=;
        b=kYePuMC2zUwHhfWh2TuKH6AvWCq7Lf+0Laoiyjzm1BlZtLwOHOAe6kcRUjcCODOmPa
         SVC6mK1kcD6ycBTFQqH9Dxzy/+YgZ+JOpnzTHp7mx3guT7aL2d+IrNyXa+wpwIeOmt0V
         lcqLGfAJs76FTZVPqd+cB1xUdH8eJ3b9BQstb163iRlLq23UqIw+XqAcvYnFOSFC+e7J
         4FxTlG/4lTy8+bqQv6iU19I3iQ+OZYsZdS7G9SY52Xp6K6VDtdbe+IF5RnPAo6kVTC4R
         HuhQLeFfTLD3LRPhugkXsKEukbNjEFOeHPp9HrVu1E/Sey9GAKlFbrk6s4ENikJJWWt1
         Dc/Q==
X-Gm-Message-State: AOAM530QSFox7mlkMnST60ie5hal5wRQiuW2Njjze12o8/kRHlk3HAFG
        rH4QzTEZ9lSpO4XvvA7KlLL5y6+8Q1dp7cl0
X-Google-Smtp-Source: ABdhPJwdnxMGJt6ac+bc3IyHxOVRZJe6Ppipm16wStzecL3j8bl+7oMKGpohjUM1sV8aaWWWUyTmWw==
X-Received: by 2002:a17:906:1151:: with SMTP id i17mr1791190eja.250.1606917997323;
        Wed, 02 Dec 2020 06:06:37 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id y24sm27171edt.15.2020.12.02.06.06.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 06:06:36 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/12] arm64: dts: zynqmp: Add missing iommu IDs
Date:   Wed,  2 Dec 2020 15:06:10 +0100
Message-Id: <bcd8f9223b568d1f027bc94cb6a9809640cb8949.1606917949.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606917949.git.michal.simek@xilinx.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing iommu IDs to all IPs which have IDs assigned.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 704696811116..14a2e69cf98b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -270,6 +270,8 @@ fpd_dma_chan1: dma@fd500000 {
 			interrupts = <0 124 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x14e8>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -281,6 +283,8 @@ fpd_dma_chan2: dma@fd510000 {
 			interrupts = <0 125 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x14e9>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -292,6 +296,8 @@ fpd_dma_chan3: dma@fd520000 {
 			interrupts = <0 126 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x14ea>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -303,6 +309,8 @@ fpd_dma_chan4: dma@fd530000 {
 			interrupts = <0 127 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x14eb>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -314,6 +322,8 @@ fpd_dma_chan5: dma@fd540000 {
 			interrupts = <0 128 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x14ec>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -325,6 +335,8 @@ fpd_dma_chan6: dma@fd550000 {
 			interrupts = <0 129 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x14ed>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -336,6 +348,8 @@ fpd_dma_chan7: dma@fd560000 {
 			interrupts = <0 130 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x14ee>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -347,6 +361,8 @@ fpd_dma_chan8: dma@fd570000 {
 			interrupts = <0 131 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x14ef>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -374,6 +390,8 @@ lpd_dma_chan1: dma@ffa80000 {
 			interrupts = <0 77 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x868>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -385,6 +403,8 @@ lpd_dma_chan2: dma@ffa90000 {
 			interrupts = <0 78 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x869>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -396,6 +416,8 @@ lpd_dma_chan3: dma@ffaa0000 {
 			interrupts = <0 79 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86a>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -407,6 +429,8 @@ lpd_dma_chan4: dma@ffab0000 {
 			interrupts = <0 80 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86b>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -418,6 +442,8 @@ lpd_dma_chan5: dma@ffac0000 {
 			interrupts = <0 81 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86c>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -429,6 +455,8 @@ lpd_dma_chan6: dma@ffad0000 {
 			interrupts = <0 82 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86d>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -440,6 +468,8 @@ lpd_dma_chan7: dma@ffae0000 {
 			interrupts = <0 83 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86e>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -451,6 +481,8 @@ lpd_dma_chan8: dma@ffaf0000 {
 			interrupts = <0 84 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86f>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -470,6 +502,8 @@ nand0: nand-controller@ff100000 {
 			interrupts = <0 14 4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x872>;
 			power-domains = <&zynqmp_firmware PD_NAND>;
 		};
 
@@ -482,6 +516,8 @@ gem0: ethernet@ff0b0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x874>;
 			power-domains = <&zynqmp_firmware PD_ETH_0>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM0>;
 			reset-names = "gem0_rst";
@@ -496,6 +532,8 @@ gem1: ethernet@ff0c0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x875>;
 			power-domains = <&zynqmp_firmware PD_ETH_1>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM1>;
 			reset-names = "gem1_rst";
@@ -510,6 +548,8 @@ gem2: ethernet@ff0d0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x876>;
 			power-domains = <&zynqmp_firmware PD_ETH_2>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM2>;
 			reset-names = "gem2_rst";
@@ -524,6 +564,8 @@ gem3: ethernet@ff0e0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x877>;
 			power-domains = <&zynqmp_firmware PD_ETH_3>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM3>;
 			reset-names = "gem3_rst";
@@ -618,6 +660,8 @@ qspi: spi@ff0f0000 {
 			      <0x0 0xc0000000 0x0 0x8000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x873>;
 			power-domains = <&zynqmp_firmware PD_QSPI>;
 		};
 
@@ -647,6 +691,9 @@ sata: ahci@fd0c0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 133 4>;
 			power-domains = <&zynqmp_firmware PD_SATA>;
+			#stream-id-cells = <4>;
+			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
+				 <&smmu 0x4c2>, <&smmu 0x4c3>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
 			reset-names = "sata_rst";
 		};
@@ -658,6 +705,8 @@ sdhci0: mmc@ff160000 {
 			interrupts = <0 48 4>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x870>;
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd0", "clk_in_sd0";
 			power-domains = <&zynqmp_firmware PD_SD_0>;
@@ -670,6 +719,8 @@ sdhci1: mmc@ff170000 {
 			interrupts = <0 49 4>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x871>;
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd1", "clk_in_sd1";
 			power-domains = <&zynqmp_firmware PD_SD_1>;
@@ -678,6 +729,7 @@ sdhci1: mmc@ff170000 {
 		smmu: iommu@fd800000 {
 			compatible = "arm,mmu-500";
 			reg = <0x0 0xfd800000 0x0 0x20000>;
+			#iommu-cells = <1>;
 			status = "disabled";
 			#global-interrupts = <1>;
 			interrupt-parent = <&gic>;
-- 
2.29.2

