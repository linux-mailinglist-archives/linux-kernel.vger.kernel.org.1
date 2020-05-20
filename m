Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3041DA8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 06:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETEHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 00:07:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45900 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbgETEHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:07:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 55C131A0288;
        Wed, 20 May 2020 06:07:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE45D1A02A0;
        Wed, 20 May 2020 06:07:19 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E6E8840299;
        Wed, 20 May 2020 12:07:16 +0800 (SGT)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v3 2/2] arm64: dts: Add ds26522 node to dts to ls1043ardb
Date:   Wed, 20 May 2020 12:02:21 +0800
Message-Id: <20200520040221.10536-2-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520040221.10536-1-qiang.zhao@nxp.com>
References: <20200520040221.10536-1-qiang.zhao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

Add ds26522 node to fsl-ls1043a-rdb.dts

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
v3:
 - use "arm64: dts:" format for subject
 
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 44d9343..1cb265f 100644
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
 
 &duart0 {
-- 
2.7.4

