Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A858A203207
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 10:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgFVIZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 04:25:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47880 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgFVIZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:25:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5950F200903;
        Mon, 22 Jun 2020 10:25:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F07332008F6;
        Mon, 22 Jun 2020 10:25:04 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8F729402CA;
        Mon, 22 Jun 2020 16:25:01 +0800 (SGT)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH] arm64: dts: ls1028a: Add DSPI nodes
Date:   Mon, 22 Jun 2020 16:19:20 +0800
Message-Id: <20200622081920.22269-1-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add the DSPI nodes for ls1028a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 85 +++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index dd69c5b..e4f00c2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -107,6 +107,91 @@
 	};
 };
 
+&dspi0 {
+	bus-num = <0>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <1>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash@2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <2>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
+&dspi1 {
+	bus-num = <1>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <1>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash@2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <2>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
+&dspi2 {
+	bus-num = <2>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
 &duart0 {
 	status = "okay";
 };
-- 
2.7.4

