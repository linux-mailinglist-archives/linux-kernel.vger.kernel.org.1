Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E04276398
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgIWWJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:09:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33566 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:09:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NM9u5n114108;
        Wed, 23 Sep 2020 17:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600898996;
        bh=1ppdp6+3tSkgxYc1+QL11jWvTtdem1obLVdzKtxKdoI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=H4VCn7EOt6jjGQhde0H4oPGeMou339FaZRhm0XTWA5O19QVUs2163EbsDElkZNwVo
         hbORJ1/y1csQb/uQlOxjXuEFIeqbl8HI04sa98RPV50+eZcolAAOzBf3uVl7H1DETM
         g5ogtt3CXrsMrDPnZ84TqpMsGLPF9gQrDPINvKsE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NM9uea049682
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 17:09:56 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 17:09:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 17:09:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NM9t2i045341;
        Wed, 23 Sep 2020 17:09:55 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v4 2/4] arm64: dts: ti: k3-j7200-main: add main navss cpts node
Date:   Thu, 24 Sep 2020 01:09:36 +0300
Message-ID: <20200923220938.30788-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923220938.30788-1-grygorii.strashko@ti.com>
References: <20200923220938.30788-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for Main NAVSS CPTS module.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index a44c3388c1a8..c2a986affb0e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -129,6 +129,18 @@
 						<0x0c>; /* RX_UHCHAN */
 			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
 		};
+
+		cpts@310d0000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x00 0x310d0000 0x00 0x400>;
+			reg-names = "cpts";
+			clocks = <&k3_clks 201 1>;
+			clock-names = "cpts";
+			interrupts-extended = <&main_navss_intr 391>;
+			interrupt-names = "cpts";
+			ti,cpts-periodic-outputs = <6>;
+			ti,cpts-ext-ts-inputs = <8>;
+		};
 	};
 
 	main_pmx0: pinctrl@11c000 {
-- 
2.17.1

