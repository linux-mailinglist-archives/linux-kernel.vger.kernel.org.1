Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9912A2FE9B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbhAUMOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:14:11 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46882 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729877AbhAUK65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:58:57 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 356A71A0B25;
        Thu, 21 Jan 2021 11:58:10 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 84DFD1A00B7;
        Thu, 21 Jan 2021 11:58:07 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0B865402A9;
        Thu, 21 Jan 2021 11:58:04 +0100 (CET)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [Patch v2 3/3] arm64: dts: ls1028a: Enable flexcan support for LS1028A-RDB/QDS
Date:   Thu, 21 Jan 2021 16:27:39 +0530
Message-Id: <1611226659-30129-4-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611226659-30129-1-git-send-email-kuldeep.singh@nxp.com>
References: <1611226659-30129-1-git-send-email-kuldeep.singh@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS1028A-RDB/QDS provides support for flexcan. Add the properties.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index c0786b7..fbcba9c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -109,6 +109,14 @@
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
 &dspi0 {
 	bus-num = <0>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index c1d1ba4..41ae6e76 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -85,6 +85,22 @@
 	};
 };
 
+&can0 {
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
+
+&can1 {
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
+
 &esdhc {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
-- 
2.7.4

