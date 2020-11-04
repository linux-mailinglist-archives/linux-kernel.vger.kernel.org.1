Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68302A6527
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgKDN3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:29:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55150 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729794AbgKDN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:29:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A4DTAse023869;
        Wed, 4 Nov 2020 07:29:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604496550;
        bh=y3F0mMpTS94GzADfCO1F6dKsbjUP2ytKdFaTXQxi3lU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ckOZuYCHUFZzHMs6rF9YqEh1Dsj/P1vQc09fCS/GggrZQj2Jq6TmCRRJgkA7iiOHy
         v9Xe7+UhPIGQ9Lmmjln+4P+stDrcAy0saVzUYH+3ob74V3o4K0tZ4twWPuRq25Mc4s
         ReB+RO3LPYZFw9U9nZozF0eLGm6b6V5ezKsa2Yfw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A4DTAKS095645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Nov 2020 07:29:10 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 4 Nov
 2020 07:29:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 4 Nov 2020 07:29:09 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A4DT3nF024388;
        Wed, 4 Nov 2020 07:29:07 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721e-main: Fix PCIe maximum outbound regions
Date:   Wed, 4 Nov 2020 18:59:01 +0530
Message-ID: <20201104132902.20377-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104132902.20377-1-kishon@ti.com>
References: <20201104132902.20377-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe controller in J721E supports a maximum of 32 outbound regions.
commit 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree
nodes") incorrectly added maximum number of outbound regions to 16. Fix
it here.

Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index e2a96b2c423c..61b533130ed1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -652,7 +652,7 @@
 		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 239 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
+		cdns,max-outbound-regions = <32>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
@@ -701,7 +701,7 @@
 		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 240 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
+		cdns,max-outbound-regions = <32>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
@@ -750,7 +750,7 @@
 		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 241 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
+		cdns,max-outbound-regions = <32>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
@@ -799,7 +799,7 @@
 		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 242 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
+		cdns,max-outbound-regions = <32>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
-- 
2.17.1

