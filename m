Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889C82C81CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgK3KIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:08:22 -0500
Received: from inva020.nxp.com ([92.121.34.13]:32946 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387432AbgK3KIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:08:17 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3288F1A15CE;
        Mon, 30 Nov 2020 11:07:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 532CF1A15F8;
        Mon, 30 Nov 2020 11:07:24 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D045040330;
        Mon, 30 Nov 2020 11:07:14 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [v4 10/11] arm64: dts: lx2160ardb: fix interrupt line for RTC node
Date:   Mon, 30 Nov 2020 18:15:14 +0800
Message-Id: <20201130101515.27431-10-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130101515.27431-1-biwen.li@oss.nxp.com>
References: <20201130101515.27431-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Fix interrupt line for RTC node on lx2160ardb

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v4:
	- none

Change in v3:
	- none

Change in v2:
	- none

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 54fe8cd3a711..f3bab76797fb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -2,7 +2,7 @@
 //
 // Device Tree file for LX2160ARDB
 //
-// Copyright 2018 NXP
+// Copyright 2018-2020 NXP
 
 /dts-v1/;
 
@@ -151,8 +151,8 @@
 	rtc@51 {
 		compatible = "nxp,pcf2129";
 		reg = <0x51>;
-		// IRQ10_B
-		interrupts = <0 150 0x4>;
+		/* IRQ_RTC_B -> IRQ08, active low */
+		interrupts-extended = <&extirq 8 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.17.1

