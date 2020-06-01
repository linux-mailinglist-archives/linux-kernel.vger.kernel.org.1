Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217C01E9FC8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 10:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFAIEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 04:04:53 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40656 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgFAIEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:04:52 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C4C84200689;
        Mon,  1 Jun 2020 10:04:50 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F1FE9200683;
        Mon,  1 Jun 2020 10:04:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4A8E140280;
        Mon,  1 Jun 2020 16:04:42 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx6qdl: Remove invalid interrupt for GPC node
Date:   Mon,  1 Jun 2020 15:54:29 +0800
Message-Id: <1590998069-28212-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In latest i.MX6Q RM Rev.6, 05/2020, #90 SPI interrupt is reserved,
so remove it from GPC node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b047403..deb09df 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -871,8 +871,7 @@
 				reg = <0x020dc000 0x4000>;
 				interrupt-controller;
 				#interrupt-cells = <3>;
-				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 90 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&intc>;
 				clocks = <&clks IMX6QDL_CLK_IPG>;
 				clock-names = "ipg";
-- 
2.7.4

