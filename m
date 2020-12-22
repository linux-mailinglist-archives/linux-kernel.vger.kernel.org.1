Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6922E0693
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgLVHHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:07:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54114 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgLVHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:07:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BM76GnR064352;
        Tue, 22 Dec 2020 01:06:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608620776;
        bh=JZPshwWVVHYyyVCfjW7JfaXlQvyXib/1joMtQSq41ig=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iH6ItnEwqY88nkpJfjx63ytcaVeKH3yULaQAu4qdx5u6qM6ChypZ4mlOWkUow/+n6
         TeQfYOqjeLw/xfe550wm7D41ZTeryAXTQZ54P396Fwq5PhJLoIAUQtlrOq7ygTS2vB
         lhWmm1ERaQ38+ztnRRkYmnadRLQXzsgYr3E44qPA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BM76GLf033092
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 01:06:16 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 01:06:15 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 01:06:15 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75N7N050344;
        Tue, 22 Dec 2020 01:06:13 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 14/14] arm64: dts: ti: k3-j721e-common-proc-board: Re-name "link" name as "phy"
Date:   Tue, 22 Dec 2020 12:35:20 +0530
Message-ID: <20201222070520.28132-15-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222070520.28132-1-kishon@ti.com>
References: <20201222070520.28132-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 66db854b1f62d ("arm64: dts: ti: k3-j721e-common-proc-board:
Configure the PCIe instances") and
commit 02c35dca2b488 ("arm64: dts: ti: k3-j721e: Enable Super-Speed
support for USB0") added PHY DT nodes with node name as "link"
However nodes with #phy-cells should be named 'phy' as discussed in [1].
Re-name subnodes of serdes in J721E to 'phy'.

[1] -> http://lore.kernel.org/r/20200909203631.GA3026331@bogus
Fixes: 66db854b1f62d ("arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe instances")
Fixes: 02c35dca2b488 ("arm64: dts: ti: k3-j721e: Enable Super-Speed support for USB0")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 788126daf91c..13ae0d89caf2 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -358,7 +358,7 @@
 };
 
 &serdes3 {
-	serdes3_usb_link: link@0 {
+	serdes3_usb_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
@@ -685,7 +685,7 @@
 };
 
 &serdes0 {
-	serdes0_pcie_link: link@0 {
+	serdes0_pcie_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
@@ -695,7 +695,7 @@
 };
 
 &serdes1 {
-	serdes1_pcie_link: link@0 {
+	serdes1_pcie_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
@@ -705,7 +705,7 @@
 };
 
 &serdes2 {
-	serdes2_pcie_link: link@0 {
+	serdes2_pcie_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
-- 
2.17.1

