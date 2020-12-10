Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EEF2D5B47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbgLJNJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:09:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39664 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgLJNI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:08:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BAD83CS060378;
        Thu, 10 Dec 2020 07:08:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607605683;
        bh=jGh02B5M1rvfYl69hvxasPDk9iriEgMEUYJWXaLhXmQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PDNtYN1wcAjHtZQhWHl0rG2EmiXeqM2SLHyrQSm5Briva2uZ0Ea3v5GSNR9uNPoBw
         7f0VSO5RnQtsBCploLTAHvmQ2GEgWB9r8F0TZUyTtHoBbGyTl0GCb9GTQlDjYsMiRS
         h3+HnZezuMLDOglnZRXEGTHWvBMUE0M12LGX72zU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BAD82JL043236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 07:08:03 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Dec 2020 07:08:02 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Dec 2020 07:08:02 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BAD7rag098988;
        Thu, 10 Dec 2020 07:07:59 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] arm64: dts: ti: k3-j721e-main: Fix supported max outbound regions
Date:   Thu, 10 Dec 2020 18:37:42 +0530
Message-ID: <20201210130747.25436-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210130747.25436-1-kishon@ti.com>
References: <20201210130747.25436-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence IP in J721E supports a maximum of 32 outbound regions. However
commit 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device
tree nodes") incorrectly added this as 16 outbound regions. Now that
"cdns,max-outbound-regions" is an optional property with default value
as 32, remove "cdns,max-outbound-regions" from endpoint DT node.

Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index b32df591c766..1c11da612c67 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -651,7 +651,6 @@
 		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 239 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
@@ -700,7 +699,6 @@
 		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 240 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
@@ -749,7 +747,6 @@
 		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 241 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
@@ -798,7 +795,6 @@
 		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 242 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
-- 
2.17.1

