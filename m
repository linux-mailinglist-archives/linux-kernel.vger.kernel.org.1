Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3727017A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIRP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:58:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51090 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIRP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:58:36 -0400
X-Greylist: delayed 1183 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 11:58:36 EDT
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IFcrG6117108;
        Fri, 18 Sep 2020 10:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600443533;
        bh=+K5ks3WnxK8i2RS9vnGDI48YmMHkiKTH3vjbGyi7Z9Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qgiGk+FNkIX9EzmEpoaPy4g9Y/Mcx1mDLbZhvH5IrrAn2bUfnsfbJj38/b8Cz4jz2
         kt3wHwie0jsulkG4wdIZmaLeJzvksZYKKGG+8VHoQD2mAuIP+6t6H7+VNRLF/js1u6
         YvKPUaZsNQLZ93DI3ePWCehxJgruJcihjXdGCYus=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IFcrva017130
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 10:38:53 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 10:38:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 10:38:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IFcqNg014739;
        Fri, 18 Sep 2020 10:38:52 -0500
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
Subject: [PATCH v3 2/4] arm64: dts: ti: k3-j7200-main: add main navss cpts node
Date:   Fri, 18 Sep 2020 18:38:27 +0300
Message-ID: <20200918153829.14686-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918153829.14686-1-grygorii.strashko@ti.com>
References: <20200918153829.14686-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for Main NAVSS CPTS module.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index c5015df58cd4..31bd0c5ffb8b 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -129,6 +129,18 @@
 						<0x0c>; /* RX_UHCHAN */
 			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
 		};
+
+		cpts@310d0000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x0 0x310d0000 0x0 0x400>;
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

