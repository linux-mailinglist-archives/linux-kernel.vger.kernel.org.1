Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383E7227973
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgGUH05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 03:26:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39980 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGUH05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:26:57 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E2AF2003E6;
        Tue, 21 Jul 2020 09:26:55 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 35A5C2003EF;
        Tue, 21 Jul 2020 09:26:53 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A3D534024E;
        Tue, 21 Jul 2020 15:08:13 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     shawnguo@kernel.org
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] ARM: dts: imx6qp-sabreauto: enable pcie
Date:   Tue, 21 Jul 2020 15:22:56 +0800
Message-Id: <1595316176-8533-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset-gpio property, and enable PCIe on iMX6QP SABREAUTO board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm/boot/dts/imx6qp-sabreauto.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qp-sabreauto.dts b/arch/arm/boot/dts/imx6qp-sabreauto.dts
index 639d9dd35377..2bb3bfb18ec3 100644
--- a/arch/arm/boot/dts/imx6qp-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6qp-sabreauto.dts
@@ -47,7 +47,8 @@
 };
 
 &pcie {
-	status = "disabled";
+	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
+	status = "okay";
 };
 
 &sata {
-- 
2.17.1

