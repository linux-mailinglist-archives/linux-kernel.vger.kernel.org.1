Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400132EAE0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbhAEPQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:16:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40016 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAEPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:16:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 105FEW8i012808;
        Tue, 5 Jan 2021 09:14:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609859672;
        bh=jEkh70lgQQiul1cZEJwraNm1tV2d5H5lh02w9ERRWbs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dzA2i6GeZ16mU/09MxoUx+/L5yqggf+fmCQLAv3gFdCVcn5gOnb5hGzbmNciEAy4S
         PssAT4o1f121I9DS4U4Uk24tFh0gWPg1LuMKj9uba/XxRd42UVsgTNMZb/T+uIQBUs
         56F+hijirZQrfJXLi8ZwUt7w1NHO784ljf2glsM0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 105FEWal035998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jan 2021 09:14:32 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 5 Jan
 2021 09:14:31 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 5 Jan 2021 09:14:31 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 105FEPOD005961;
        Tue, 5 Jan 2021 09:14:29 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/6] arm64: dts: ti: k3-j721e-main: Fix supported max outbound regions
Date:   Tue, 5 Jan 2021 20:44:16 +0530
Message-ID: <20210105151421.23237-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105151421.23237-1-kishon@ti.com>
References: <20210105151421.23237-1-kishon@ti.com>
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
(Since this doesn't impact existing functionality, it need not be
backported to older kernels).

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

