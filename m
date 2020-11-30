Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC72C81C4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbgK3KIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:08:16 -0500
Received: from inva021.nxp.com ([92.121.34.21]:51966 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgK3KIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:08:15 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C34D200761;
        Mon, 30 Nov 2020 11:07:28 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BB493200734;
        Mon, 30 Nov 2020 11:07:22 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 087F340323;
        Mon, 30 Nov 2020 11:07:08 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [v4 06/11] arm64: dts: ls1088ardb: fix interrupt line for RTC node
Date:   Mon, 30 Nov 2020 18:15:10 +0800
Message-Id: <20201130101515.27431-6-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130101515.27431-1-biwen.li@oss.nxp.com>
References: <20201130101515.27431-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Fix interrupt line for RTC node on ls1088ardb

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v4:
	- none

Change in v3:
	- none

Change in v2:
	- none

 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 5633e59febc3..89c40d3f9a50 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree file for NXP LS1088A RDB Board.
  *
- * Copyright 2017 NXP
+ * Copyright 2017-2020 NXP
  *
  * Harninder Rai <harninder.rai@nxp.com>
  *
@@ -51,8 +51,8 @@
 			rtc@51 {
 				compatible = "nxp,pcf2129";
 				reg = <0x51>;
-				/* IRQ10_B */
-				interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+				/* IRQ_RTC_B -> IRQ0_B(CPLD) -> IRQ00(CPU), active low */
+				interrupts-extended = <&extirq 0 IRQ_TYPE_LEVEL_LOW>;
 			};
 		};
 	};
-- 
2.17.1

