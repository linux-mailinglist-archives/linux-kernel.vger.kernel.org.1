Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD5F1BD73E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgD2IZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 04:25:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49962 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgD2IZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:25:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DF2A200049;
        Wed, 29 Apr 2020 10:25:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 41826200311;
        Wed, 29 Apr 2020 10:25:23 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E0EA3402B4;
        Wed, 29 Apr 2020 16:25:19 +0800 (SGT)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [patch v2 2/2] ls1043ardb: add ds26522 node to dts
Date:   Wed, 29 Apr 2020 16:20:52 +0800
Message-Id: <20200429082052.18519-2-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429082052.18519-1-qiang.zhao@nxp.com>
References: <20200429082052.18519-1-qiang.zhao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

add ds26522 node to fsl-ls1043a-rdb.dts

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 96e87ba..b60c742 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -94,6 +94,22 @@
 		reg = <0>;
 		spi-max-frequency = <1000000>; /* input clock */
 	};
+
+	slic@2 {
+		compatible = "maxim,ds26522";
+		reg = <2>;
+		spi-max-frequency = <2000000>;
+		fsl,spi-cs-sck-delay = <100>;
+		fsl,spi-sck-cs-delay = <50>;
+	};
+
+	slic@3 {
+		compatible = "maxim,ds26522";
+		reg = <3>;
+		spi-max-frequency = <2000000>;
+		fsl,spi-cs-sck-delay = <100>;
+		fsl,spi-sck-cs-delay = <50>;
+	};
 };
 
 &uqe {
-- 
2.9.5

