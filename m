Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0D2AFE12
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgKLFd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:33:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36016 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgKLBtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:49:47 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AC1ndeP058967;
        Wed, 11 Nov 2020 19:49:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605145779;
        bh=W4cEziqqqu/ftLy2y5gFR2ad+GWOlgwJMtLiIlJr/mg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hRnxJ4iH9bioXh9YWUbR6pIo/yyKr4/9Thbza6Wxmo1TLBLdSp/M5gmM2VgDw8plw
         UJlm16LIb3HbjPWKq1OThH5xhGzNxoAzEOsdNnJEsas9hMXhmWfsmUxoCNgc4nr5eT
         q/L7qufN9/f2abB31xYkOX8II1gQVHCBIHUUia44=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AC1ndqX130267
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 19:49:39 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 19:49:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 11 Nov 2020 19:49:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AC1ncTO028665;
        Wed, 11 Nov 2020 19:49:39 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 3/5] arm64: dts: ti: am65/j721e: Fix up un-necessary status set to "okay" for crypto
Date:   Wed, 11 Nov 2020 19:49:27 -0600
Message-ID: <20201112014929.25227-4-nm@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112014929.25227-1-nm@ti.com>
References: <20201112014929.25227-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default state of a device tree node is "okay". There is no specific
use of explicitly adding status = "okay" in the SoC dtsi.

Fixes: 8ebcaaae8017 ("arm64: dts: ti: k3-j721e-main: Add crypto accelerator node")
Fixes: b366b2409c97 ("arm64: dts: ti: k3-am6: Add crypto accelarator node")
Signed-off-by: Nishanth Menon <nm@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
---
Changes since V1:
- No change.

V1: https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-4-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 1 -
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 21e50021dd83..2bd66a9e4b1d 100644
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
index b54332d6fdc5..9747c387385b 100644
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

