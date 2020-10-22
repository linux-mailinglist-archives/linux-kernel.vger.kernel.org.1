Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDA9295AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508737AbgJVIxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:53:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34336 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509805AbgJVIxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:53:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DFEC1A0F01;
        Thu, 22 Oct 2020 10:53:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F08D1A0EAE;
        Thu, 22 Oct 2020 10:53:34 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 11537402F2;
        Thu, 22 Oct 2020 10:53:26 +0200 (CEST)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 10/11] arm64: dts: lx2160ardb: fix interrupt line for RTC node
Date:   Thu, 22 Oct 2020 16:44:09 +0800
Message-Id: <20201022084410.28249-10-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022084410.28249-1-biwen.li@oss.nxp.com>
References: <20201022084410.28249-1-biwen.li@oss.nxp.com>
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
index 22d0308eb13b..05f977974d11 100644
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

