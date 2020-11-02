Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B562A2558
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgKBHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:36:50 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42502 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbgKBHgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:36:48 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9388B2013A0;
        Mon,  2 Nov 2020 08:36:46 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 923152013D3;
        Mon,  2 Nov 2020 08:36:43 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6AE7E402DA;
        Mon,  2 Nov 2020 08:36:39 +0100 (CET)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v4 3/3] arm: dts: ls1021a: fix rcpm failed to claim resource
Date:   Mon,  2 Nov 2020 15:26:52 +0800
Message-Id: <20201102072652.34893-3-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102072652.34893-1-ran.wang_1@nxp.com>
References: <20201102072652.34893-1-ran.wang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The range of dcfg reg is wrong, which overlap with other device,
such as rcpm. This issue causing rcpm driver failed to claim
reg resource when calling devm_ioremap_resource().

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
Change in v4:
 - None

Change in v3:
 - None

Change in v2:
 - None

 arch/arm/boot/dts/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index e12809d6..16744f64 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -173,7 +173,7 @@
 
 		dcfg: dcfg@1ee0000 {
 			compatible = "fsl,ls1021a-dcfg", "syscon";
-			reg = <0x0 0x1ee0000 0x0 0x10000>;
+			reg = <0x0 0x1ee0000 0x0 0x1000>;
 			big-endian;
 		};
 
-- 
2.7.4

