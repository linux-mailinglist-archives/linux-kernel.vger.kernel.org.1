Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4256820322E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 10:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgFVIhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 04:37:02 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50470 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFVIhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:37:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A172D1A0A5D;
        Mon, 22 Jun 2020 10:36:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E1BF41A0420;
        Mon, 22 Jun 2020 10:36:56 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2914A4029F;
        Mon, 22 Jun 2020 16:36:53 +0800 (SGT)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, qiang.zhao@nxp.com,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: [RESEND PATCH 1/2] arm64: dts: lx2160a: add dspi controller DT nodes
Date:   Mon, 22 Jun 2020 16:31:08 +0800
Message-Id: <20200622083109.3441-1-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanhua Han <chuanhua.han@nxp.com>

Add the dspi support on lx2160

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index abaeb58..f56172f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -777,6 +777,45 @@
 			status = "disabled";
 		};
 
+		dspi0: spi@2100000 {
+			compatible = "fsl,lx2160a-dspi", "fsl,ls2085a-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 7>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <0>;
+			status = "disabled";
+		};
+
+		dspi1: spi@2110000 {
+			compatible = "fsl,lx2160a-dspi", "fsl,ls2085a-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2110000 0x0 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 7>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <1>;
+			status = "disabled";
+		};
+
+		dspi2: spi@2120000 {
+			compatible = "fsl,lx2160a-dspi", "fsl,ls2085a-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2120000 0x0 0x10000>;
+			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 7>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <2>;
+			status = "disabled";
+		};
+
 		esdhc0: esdhc@2140000 {
 			compatible = "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
-- 
2.7.4

