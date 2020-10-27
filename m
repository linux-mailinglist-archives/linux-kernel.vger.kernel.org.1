Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883729A3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 05:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505495AbgJ0Ez6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 00:55:58 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59576 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502093AbgJ0Ezx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 00:55:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 07EF6200CA8;
        Tue, 27 Oct 2020 05:55:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 38E12200C86;
        Tue, 27 Oct 2020 05:55:46 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 78C4940314;
        Tue, 27 Oct 2020 05:55:33 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [v2 06/11] arm64: dts: ls1088ardb: fix interrupt line for RTC node
Date:   Tue, 27 Oct 2020 12:46:14 +0800
Message-Id: <20201027044619.41879-6-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027044619.41879-1-biwen.li@oss.nxp.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Fix interrupt line for RTC node on ls1088ardb

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
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

