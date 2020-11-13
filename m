Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9530B2B266E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKMVTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:19:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42148 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgKMVSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:18:55 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADLISpL082670;
        Fri, 13 Nov 2020 15:18:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605302308;
        bh=pCkJXKQ+ssBuHTanlMFM4pLYF97yGl387KgBtB4KXbE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J3FAVB4JY9UYGjm85ZmcXggLljORwnt6KSY82wi38n1fQ2v/SgzUhD+uipYfmYOto
         rZMOme6sNaWfxlRW0GLZ7bF237+6ck3Hhcv/2A8wc5PCzQvxf/RTsD9hAoPmt1kH88
         6b2jGMaifJTmv10on5zhe/9p/pj94gWJKUwXt6bo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADLISTO061366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 15:18:28 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 15:18:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 15:18:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADLIRi6099425;
        Fri, 13 Nov 2020 15:18:27 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 3/5] arm64: dts: ti: am65/j721e: Fix up un-necessary status set to "okay" for crypto
Date:   Fri, 13 Nov 2020 15:18:24 -0600
Message-ID: <20201113211826.13087-4-nm@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113211826.13087-1-nm@ti.com>
References: <20201113211826.13087-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default state of a device tree node is "okay". There is no specific
use of explicitly adding status = "okay" in the SoC dtsi.

Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Tero Kristo <t-kristo@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
---
Change in v4: Dropped Fixes

V3: https://lore.kernel.org/linux-arm-kernel/20201112183538.6805-4-nm@ti.com/
V2: https://lore.kernel.org/linux-arm-kernel/20201112014929.25227-4-nm@ti.com/
V1: https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-4-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 1 -
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index c842b9803f2d..116818912ba2 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -119,7 +119,6 @@ crypto: crypto@4e00000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x0 0x04e00000 0x00 0x04e00000 0x0 0x30000>;
-		status = "okay";
 
 		dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
 				<&main_udmap 0x4001>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 137966c6be1f..19e602afdb05 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -345,8 +345,6 @@ main_crypto: crypto@4e00000 {
 		#size-cells = <2>;
 		ranges = <0x0 0x04e00000 0x00 0x04e00000 0x0 0x30000>;
 
-		status = "okay";
-
 		dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
 				<&main_udmap 0x4001>;
 		dma-names = "tx", "rx1", "rx2";
-- 
2.29.2

