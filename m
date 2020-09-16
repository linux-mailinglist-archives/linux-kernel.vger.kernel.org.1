Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2226BF32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIPI05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:26:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34516 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgIPI0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:26:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ADF50200AA8;
        Wed, 16 Sep 2020 10:26:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DEB392011CD;
        Wed, 16 Sep 2020 10:26:47 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 35E554030E;
        Wed, 16 Sep 2020 10:26:43 +0200 (CEST)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biwen Li <biwen.li@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 3/5] arm: dts: ls1021a: fix that FlexTimer cannot wakeup system in deep sleep
Date:   Wed, 16 Sep 2020 16:18:29 +0800
Message-Id: <20200916081831.24747-3-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916081831.24747-1-ran.wang_1@nxp.com>
References: <20200916081831.24747-1-ran.wang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

The patch fixes a bug that FlexTimer cannot
wakeup system in deep sleep.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 827373e..089fe86 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -1007,6 +1007,7 @@
 			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x8>;
 			#fsl,rcpm-wakeup-cells = <2>;
+			fsl,ippdexpcr1-alt-addr = <&scfg 0x51c>;
 		};
 
 		ftm_alarm0: timer0@29d0000 {
-- 
2.7.4

