Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1B62FEACE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbhAUKfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbhAUK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:29:19 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E30C0617A4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a10so1836178ejg.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QWjpDInuuW7WdHEsJw7GmtWphcGhTtqH0rl1+ezDRRA=;
        b=Fa2aEo1dDVUyyBih+HsrZf8m/BDo6GYsmCJS1nyAoRpsuVRGDqm9GvMAV/c6G1f4iO
         ObwGCS4vkSvRF7lyeiz1p1HQ82G72voWYpUJdQsLx6nUGa0eLKm0VSZJDbNyiHuTva2v
         loSZsg/PaMJHYRu9yW4VLjaOD7Mu8wBR0Fd86sX8mCHLyeIeoim5Zck5bXCwqXUU7YwH
         4whk28VSnltU+tgKN9co1SKMyAafIdPQyhUEYSmkEmuVlGuq8t2QxKCbMetN+wNMl02G
         paqkIXOaByTS7ztCBsKPoqv3RGQm09Fxr2FJnocPzUrUM/ovotHw5XGM7cEhwqQKrIoM
         l/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QWjpDInuuW7WdHEsJw7GmtWphcGhTtqH0rl1+ezDRRA=;
        b=hVMZ5dg1iac1GIOpgYQXMJXPrVGDzc2PME/RM8MtY7B0ppuBntlKn8BSs4eBYnUkmq
         bOGslR5IpSdNoDRIeYidcOLIzveUHulxn1fBkhV3bjR1S/kssF5rsrIBvfB8vu9QvqiJ
         tC7rbv+fzXp6xQAUl/ReHL9v2RVdOhzAM1IKPG6+PQN0YIFdrRmIzadTbuoSMEbxAKYG
         u2VoCgRYXaO+t3bE27FdanZXkCPePROiJDg7yZVnCfeIaT3Y/hiNahmQyBRQM31Ngg8t
         EWU0p/bMsGDwfXlGnrpXKicHb3gM7XezlUv0A9eyHc6Ygu/Jdgrn0H+D6McsQV+M2nGM
         KAkw==
X-Gm-Message-State: AOAM531LPThN/0pys0I4fg3fyY8ro7CkQdP3TRgYhPxBbPia/pz/KfUE
        74+9CChwrDkbVhIMCyllI1lzw1f7QCSKIVcO
X-Google-Smtp-Source: ABdhPJzmfB7Kx1FATqc7DvycUSKj5LxVldn75heuIJdNnqddqsZo/92aJYQJA6DnzBIEu/Qo+DUbVw==
X-Received: by 2002:a17:906:853:: with SMTP id f19mr8406945ejd.259.1611224844569;
        Thu, 21 Jan 2021 02:27:24 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w14sm2042791ejz.68.2021.01.21.02.27.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:27:24 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 11/12] arm64: dts: zynqmp: Add missing iommu IDs
Date:   Thu, 21 Jan 2021 11:26:59 +0100
Message-Id: <78afdafdc60c3182318894f2808f7f337a798278.1611224800.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing iommu IDs to all IPs which have IDs assigned.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 467f92c2044b..66d53521ec58 100644
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
 
@@ -375,6 +391,8 @@ lpd_dma_chan1: dma@ffa80000 {
 			interrupts = <0 77 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x868>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -386,6 +404,8 @@ lpd_dma_chan2: dma@ffa90000 {
 			interrupts = <0 78 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x869>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -397,6 +417,8 @@ lpd_dma_chan3: dma@ffaa0000 {
 			interrupts = <0 79 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86a>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -408,6 +430,8 @@ lpd_dma_chan4: dma@ffab0000 {
 			interrupts = <0 80 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86b>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -419,6 +443,8 @@ lpd_dma_chan5: dma@ffac0000 {
 			interrupts = <0 81 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86c>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -430,6 +456,8 @@ lpd_dma_chan6: dma@ffad0000 {
 			interrupts = <0 82 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86d>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -441,6 +469,8 @@ lpd_dma_chan7: dma@ffae0000 {
 			interrupts = <0 83 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86e>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -452,6 +482,8 @@ lpd_dma_chan8: dma@ffaf0000 {
 			interrupts = <0 84 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x86f>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -471,6 +503,8 @@ nand0: nand-controller@ff100000 {
 			interrupts = <0 14 4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x872>;
 			power-domains = <&zynqmp_firmware PD_NAND>;
 		};
 
@@ -483,6 +517,8 @@ gem0: ethernet@ff0b0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x874>;
 			power-domains = <&zynqmp_firmware PD_ETH_0>;
 		};
 
@@ -495,6 +531,8 @@ gem1: ethernet@ff0c0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x875>;
 			power-domains = <&zynqmp_firmware PD_ETH_1>;
 		};
 
@@ -507,6 +545,8 @@ gem2: ethernet@ff0d0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x876>;
 			power-domains = <&zynqmp_firmware PD_ETH_2>;
 		};
 
@@ -519,6 +559,8 @@ gem3: ethernet@ff0e0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x877>;
 			power-domains = <&zynqmp_firmware PD_ETH_3>;
 		};
 
@@ -606,6 +648,8 @@ qspi: spi@ff0f0000 {
 			      <0x0 0xc0000000 0x0 0x8000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x873>;
 			power-domains = <&zynqmp_firmware PD_QSPI>;
 		};
 
@@ -635,6 +679,9 @@ sata: ahci@fd0c0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 133 4>;
 			power-domains = <&zynqmp_firmware PD_SATA>;
+			#stream-id-cells = <4>;
+			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
+				 <&smmu 0x4c2>, <&smmu 0x4c3>;
 		};
 
 		sdhci0: mmc@ff160000 {
@@ -644,6 +691,8 @@ sdhci0: mmc@ff160000 {
 			interrupts = <0 48 4>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x870>;
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd0", "clk_in_sd0";
 			power-domains = <&zynqmp_firmware PD_SD_0>;
@@ -656,6 +705,8 @@ sdhci1: mmc@ff170000 {
 			interrupts = <0 49 4>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x871>;
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd1", "clk_in_sd1";
 			power-domains = <&zynqmp_firmware PD_SD_1>;
@@ -664,6 +715,7 @@ sdhci1: mmc@ff170000 {
 		smmu: iommu@fd800000 {
 			compatible = "arm,mmu-500";
 			reg = <0x0 0xfd800000 0x0 0x20000>;
+			#iommu-cells = <1>;
 			status = "disabled";
 			#global-interrupts = <1>;
 			interrupt-parent = <&gic>;
-- 
2.30.0

