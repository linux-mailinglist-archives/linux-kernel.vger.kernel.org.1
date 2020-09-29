Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2715627BF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgI2Ib1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:31:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53816 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2IbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:31:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 94E36201181;
        Tue, 29 Sep 2020 10:31:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3DACC20160F;
        Tue, 29 Sep 2020 10:31:19 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0F4744030E;
        Tue, 29 Sep 2020 10:31:14 +0200 (CEST)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v3 5/5] arm: dts: ls1021a: fix rcpm failed to claim resource
Date:   Tue, 29 Sep 2020 16:22:34 +0800
Message-Id: <20200929082234.36619-5-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929082234.36619-1-ran.wang_1@nxp.com>
References: <20200929082234.36619-1-ran.wang_1@nxp.com>
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
Change in v3:
 - None

Change in v2:
 - None

 arch/arm/boot/dts/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index cb95964..9e588ad 100644
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

