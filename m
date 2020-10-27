Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374E129A3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 05:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505473AbgJ0Ezr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 00:55:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:32956 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505449AbgJ0Ezp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 00:55:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 86A981A12DC;
        Tue, 27 Oct 2020 05:55:43 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA2691A0020;
        Tue, 27 Oct 2020 05:55:37 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9A65440309;
        Tue, 27 Oct 2020 05:55:30 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [v2 04/11] arm64: dts: ls1046ardb: Add interrupt line for RTC node
Date:   Tue, 27 Oct 2020 12:46:12 +0800
Message-Id: <20201027044619.41879-4-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027044619.41879-1-biwen.li@oss.nxp.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add interrupt line for RTC node, which is low level active.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
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

