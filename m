Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FB41CEAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgELCee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 22:34:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33354 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgELCed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:34:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 66B0D1A0E78;
        Tue, 12 May 2020 04:34:32 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 963721A0E75;
        Tue, 12 May 2020 04:34:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 11A5640293;
        Tue, 12 May 2020 10:34:22 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] ARM: dts: imx53: Add src node interrupt
Date:   Tue, 12 May 2020 10:25:07 +0800
Message-Id: <1589250307-29662-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589250307-29662-1-git-send-email-Anson.Huang@nxp.com>
References: <1589250307-29662-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt is a required property according to SRC binding, add
it for SRC node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx53.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 8536f59..0d06dbd 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -591,6 +591,7 @@
 			src: src@53fd0000 {
 				compatible = "fsl,imx53-src", "fsl,imx51-src";
 				reg = <0x53fd0000 0x4000>;
+				interrupts = <75>;
 				#reset-cells = <1>;
 			};
 
-- 
2.7.4

