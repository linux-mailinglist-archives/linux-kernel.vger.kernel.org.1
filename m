Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA3B2B69E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgKQQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:20:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46902 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgKQQUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:20:01 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHGJort008011;
        Tue, 17 Nov 2020 10:19:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605629990;
        bh=fOcGPq25kCNFtsMe/61ChnGUekQJo9px2A8HMNw0tXs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VlBA8xDU38k1OmY54F+lhoUf4oYPVObnEE3g08c4aoXKdIOjSzupdLN3XwCNsMKAh
         iYq9IgZLB02ey+C9mxHv3EfBtS7Y7M4tkl4KFWQH8GXrNtZbtXdDiHdR2bBXtu4Ag+
         3m/l9GfrgPgBqNora/OQNNEaiQ/5+k9cDwW/7IRI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHGJoZU099417
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 10:19:50 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 10:19:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 10:19:50 -0600
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHGJhwH032251;
        Tue, 17 Nov 2020 10:19:47 -0600
From:   Sekhar Nori <nsekhar@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 1/4] arm64: dts: ti: k3: squelch warning about lack of #interrupt-cells
Date:   Tue, 17 Nov 2020 21:49:39 +0530
Message-ID: <20201117161942.38754-2-nsekhar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117161942.38754-1-nsekhar@ti.com>
References: <20201117161942.38754-1-nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are couple of places where INTA interrupt controller
lacks #interrupt-cells property. This leads to warnings of
the type:

arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:147.51-156.5: Warning (interrupt_provider): /bus@100000/main-navss/interrupt-controller@33d00000: Missing #interrupt-cells in interrupt provider

When building TI device-tree files with W=2 warning level.
Fix these.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 3eeb6e9876db..aa8725db0187 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -473,6 +473,7 @@
 			interrupt-controller;
 			interrupt-parent = <&intr_main_navss>;
 			msi-controller;
+			#interrupt-cells = <0>;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <179>;
 			ti,interrupt-ranges = <0 0 256>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index e2a96b2c423c..ffedd9531362 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -148,6 +148,7 @@
 			interrupt-controller;
 			interrupt-parent = <&main_navss_intr>;
 			msi-controller;
+			#interrupt-cells = <0>;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <209>;
 			ti,interrupt-ranges = <0 0 256>;
-- 
2.17.1

