Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD5B298817
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771344AbgJZILo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:11:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55530 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771277AbgJZIK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:10:59 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 32DB6200939;
        Mon, 26 Oct 2020 09:10:58 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B64C02010A9;
        Mon, 26 Oct 2020 09:10:52 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8902C402B1;
        Mon, 26 Oct 2020 09:10:45 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [RESEND 10/11] arm64: dts: lx2160ardb: fix interrupt line for RTC node
Date:   Mon, 26 Oct 2020 16:01:26 +0800
Message-Id: <20201026080127.40499-10-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026080127.40499-1-biwen.li@oss.nxp.com>
References: <20201026080127.40499-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Fix interrupt line for RTC node on lx2160ardb

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
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

