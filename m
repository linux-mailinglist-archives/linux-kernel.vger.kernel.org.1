Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38B927BA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgI2BjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:39:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47682 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgI2BjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:39:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D6F1F200E74;
        Tue, 29 Sep 2020 03:38:58 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80C6D200EAD;
        Tue, 29 Sep 2020 03:38:55 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 060764030D;
        Tue, 29 Sep 2020 03:38:50 +0200 (CEST)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biwen Li <biwen.li@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2] arm64: dts: fix endianness issue of rcpm
Date:   Tue, 29 Sep 2020 09:30:21 +0800
Message-Id: <20200929013021.46395-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add little-endian property to RCPM node (for ls1028a,ls1088a,ls208xa),
otherwise RCPM driver will program hardware with incorrect setting,
causing system (such as LS1028ARDB) failed to be waked by wakeup source.

Fixes: 791c88ca5713 (“arm64: dts: ls1028a: Add ftm_alarm0 DT node”)
Fixes: f4fe3a8665495 (“arm64: dts: layerscape: add ftm_alarm0 node”)
Signed-off-by: Biwen Li <biwen.li@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
Change in v2:
 - Update commit message with more details
 - Add Fixes and Singed-off tags

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 0efeb8f..651bfe1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1012,6 +1012,7 @@
 			compatible = "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x1c>;
 			#fsl,rcpm-wakeup-cells = <7>;
+			little-endian;
 		};
 
 		ftm_alarm0: timer@2800000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 169f474..2ef812d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -787,6 +787,7 @@
 			compatible = "fsl,ls1088a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x18>;
 			#fsl,rcpm-wakeup-cells = <6>;
+			little-endian;
 		};
 
 		ftm_alarm0: timer@2800000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 41102da..141b3d2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -769,6 +769,7 @@
 			compatible = "fsl,ls208xa-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x18>;
 			#fsl,rcpm-wakeup-cells = <6>;
+			little-endian;
 		};
 
 		ftm_alarm0: timer@2800000 {
-- 
2.7.4

