Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9B29A3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 05:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505545AbgJ0E4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 00:56:25 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59620 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505439AbgJ0Ezy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 00:55:54 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FC08200C7C;
        Tue, 27 Oct 2020 05:55:53 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 441122012A8;
        Tue, 27 Oct 2020 05:55:47 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 56F8840319;
        Tue, 27 Oct 2020 05:55:36 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [v2 08/11] arm64: dts: ls208xa-rdb: add interrupt line for RTC node
Date:   Tue, 27 Oct 2020 12:46:16 +0800
Message-Id: <20201027044619.41879-8-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027044619.41879-1-biwen.li@oss.nxp.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add interrupt line for RTC node on ls208xa-rdb

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
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

