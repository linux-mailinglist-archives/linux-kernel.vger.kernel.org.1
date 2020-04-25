Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5AA1B8683
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgDYMib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 08:38:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58456 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgDYMib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 08:38:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B23D1A07FC;
        Sat, 25 Apr 2020 14:38:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 47A8B1A07F7;
        Sat, 25 Apr 2020 14:38:24 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EAD19402BB;
        Sat, 25 Apr 2020 20:38:17 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        horia.geanta@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] arm64: dts: imx8mn: Update VDD_ARM 1.2GHz setpoint voltage
Date:   Sat, 25 Apr 2020 20:29:50 +0800
Message-Id: <1587817790-21698-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest datasheet Rev. 0.1, 03/2020 removes below constrain:

"If VDD_SOC/GPU/DDR = 0.95V, then VDD_ARM must be >= 0.95V."

So, for 1.2GHz setpoint VDD_ARM can use its typical voltage
directly.

The datasheet can be downloaded from below link:
https://www.nxp.com/docs/en/data-sheet/IMX8MNCEC.pdf

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index fa78f01..de6e2cf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -121,7 +121,7 @@
 
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <950000>;
+			opp-microvolt = <850000>;
 			opp-supported-hw = <0xb00>, <0x7>;
 			clock-latency-ns = <150000>;
 			opp-suspend;
-- 
2.7.4

