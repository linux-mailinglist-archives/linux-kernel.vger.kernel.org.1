Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96CE2C7D47
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgK3DXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:23:49 -0500
Received: from inva021.nxp.com ([92.121.34.21]:51456 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgK3DXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:23:44 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B4C2200715;
        Mon, 30 Nov 2020 04:22:58 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 58B2520071D;
        Mon, 30 Nov 2020 04:22:52 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8647640326;
        Mon, 30 Nov 2020 04:22:45 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [v3 04/11] arm64: dts: ls1046ardb: Add interrupt line for RTC node
Date:   Mon, 30 Nov 2020 11:30:48 +0800
Message-Id: <20201130033055.38462-4-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130033055.38462-1-biwen.li@oss.nxp.com>
References: <20201130033055.38462-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add interrupt line for RTC node, which is low level active.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
Change in v3:
	- none

Change in v2:
	- none

 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index d53ccc56bb63..60acdf0b689e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -3,6 +3,7 @@
  * Device Tree Include file for Freescale Layerscape-1046A family SoC.
  *
  * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2019-2020 NXP
  *
  * Mingkai Hu <mingkai.hu@nxp.com>
  */
@@ -74,6 +75,8 @@
 	rtc@51 {
 		compatible = "nxp,pcf2129";
 		reg = <0x51>;
+		/* IRQ_RTC_B -> IRQ05, active low */
+		interrupts-extended = <&extirq 5 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.17.1

