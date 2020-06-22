Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DCF203203
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 10:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgFVIXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 04:23:48 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48086 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgFVIXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:23:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DB5CB1A0B48;
        Mon, 22 Jun 2020 10:23:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 800D11A0B34;
        Mon, 22 Jun 2020 10:23:41 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 32B31402CA;
        Mon, 22 Jun 2020 16:23:38 +0800 (SGT)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 2/2] arm64: dts: lx2160a: add DT node for all DSPI controller
Date:   Mon, 22 Jun 2020 16:17:52 +0800
Message-Id: <20200622081752.481-2-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622081752.481-1-qiang.zhao@nxp.com>
References: <20200622081752.481-1-qiang.zhao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanhua Han <chuanhua.han@nxp.com>

Add device tree node for first flash (CS0) connected
to all dspi controller.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 3b88e1e..2d1fe6c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -35,6 +35,42 @@
 	status = "okay";
 };
 
+&dspi0 {
+	status = "okay";
+
+	dflash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&dspi1 {
+	status = "okay";
+
+	dflash1: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&dspi2 {
+	status = "okay";
+
+	dflash2: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
 &esdhc0 {
 	status = "okay";
 };
-- 
2.7.4

