Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5677E1CEADB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 04:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgELCef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 22:34:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60578 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbgELCee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:34:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 76467200E51;
        Tue, 12 May 2020 04:34:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A68B5200E53;
        Tue, 12 May 2020 04:34:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 85D2B402B7;
        Tue, 12 May 2020 10:34:21 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] ARM: dts: imx51: Add src node interrupt
Date:   Tue, 12 May 2020 10:25:06 +0800
Message-Id: <1589250307-29662-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt is a required property according to SRC binding, add
it for SRC node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx51.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 92fbb90..3f1e913 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -442,6 +442,7 @@
 			src: src@73fd0000 {
 				compatible = "fsl,imx51-src";
 				reg = <0x73fd0000 0x4000>;
+				interrupts = <75>;
 				#reset-cells = <1>;
 			};
 
-- 
2.7.4

