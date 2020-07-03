Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9921364E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 10:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgGCIWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 04:22:10 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60516 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgGCIWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:22:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 05127200BFF;
        Fri,  3 Jul 2020 10:22:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C006200BF2;
        Fri,  3 Jul 2020 10:22:06 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 25B5D40296;
        Fri,  3 Jul 2020 16:22:03 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     shawnguo@kernel.org
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] ARM: dts: imx6qp-sabreauto: enable sata on imx6qp sabreauto board
Date:   Fri,  3 Jul 2020 16:18:56 +0800
Message-Id: <1593764337-8267-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SATA on iMX6QP SABREAUTO board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm/boot/dts/imx6qp-sabreauto.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp-sabreauto.dts b/arch/arm/boot/dts/imx6qp-sabreauto.dts
index d4caeeb0af70..639d9dd35377 100644
--- a/arch/arm/boot/dts/imx6qp-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6qp-sabreauto.dts
@@ -50,6 +50,10 @@
 	status = "disabled";
 };
 
+&sata {
+	status = "okay";
+};
+
 &vgen3_reg {
 	regulator-always-on;
 };
-- 
2.17.1

