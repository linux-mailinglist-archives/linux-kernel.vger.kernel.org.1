Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5CA2C7D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgK3DXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:23:51 -0500
Received: from inva020.nxp.com ([92.121.34.13]:33782 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgK3DXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:23:51 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5177F1A088D;
        Mon, 30 Nov 2020 04:23:04 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 823BD1A0873;
        Mon, 30 Nov 2020 04:22:58 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5207040330;
        Mon, 30 Nov 2020 04:22:51 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [v3 08/11] arm64: dts: ls208xa-rdb: add interrupt line for RTC node
Date:   Mon, 30 Nov 2020 11:30:52 +0800
Message-Id: <20201130033055.38462-8-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130033055.38462-1-biwen.li@oss.nxp.com>
References: <20201130033055.38462-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add interrupt line for RTC node on ls208xa-rdb

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v3:
	- none

Change in v2:
	- none

 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index d0d670227ae2..4b71c4fcb35f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -3,7 +3,7 @@
  * Device Tree file for Freescale LS2080A RDB Board.
  *
  * Copyright 2016 Freescale Semiconductor, Inc.
- * Copyright 2017 NXP
+ * Copyright 2017-2020 NXP
  *
  * Abhimanyu Saini <abhimanyu.saini@nxp.com>
  *
@@ -56,6 +56,8 @@
 			rtc@68 {
 				compatible = "dallas,ds3232";
 				reg = <0x68>;
+				/* IRQ_RTC_B -> IRQ06, active low */
+				interrupts-extended = <&extirq 6 IRQ_TYPE_LEVEL_LOW>;
 			};
 		};
 
-- 
2.17.1

