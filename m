Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B022167B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 09:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgGGHq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 03:46:58 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51980 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgGGHq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:46:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 13D731A09D1;
        Tue,  7 Jul 2020 09:46:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D8C561A09EC;
        Tue,  7 Jul 2020 09:46:52 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 84100402C8;
        Tue,  7 Jul 2020 15:46:48 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] arm64: dts: ls1043a: update USB nodes status to match board config
Date:   Tue,  7 Jul 2020 15:40:31 +0800
Message-Id: <20200707074031.13943-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ls1043a-rdb and ls1043a-qds board’s default HW config (such as
pin mux selection) would not enable some USB controllers’
data path, which causing over-current detected on those
controllers. This will hit the case of ‘xhci driver prevent bus suspend
if a root hub port detected over-current condition’, causing system
failed to be suspended. So disable them in device tree to resolve this
issue.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi    | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 1aac81d..fea167d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -148,4 +148,8 @@
 	};
 };
 
+&usb0 {
+	status = "okay";
+};
+
 #include "fsl-ls1043-post.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index bfa9d95..3516af4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -209,3 +209,11 @@
 		fsl,tdm-interface;
 	};
 };
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 3b641bd..c6d8dcb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -677,6 +677,7 @@
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			status = "disabled";
 		};
 
 		usb1: usb3@3000000 {
@@ -687,6 +688,7 @@
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			status = "disabled";
 		};
 
 		usb2: usb3@3100000 {
@@ -697,6 +699,7 @@
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			status = "disabled";
 		};
 
 		sata: sata@3200000 {
-- 
2.7.4

