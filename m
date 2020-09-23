Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98563275D79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIWQcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:32:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58882 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:32:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NGW3TR062919;
        Wed, 23 Sep 2020 11:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600878723;
        bh=FaPOHCZ660d3W7GeeWfOLvfIqGvvaoUZniUzdCIKfpQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fscOXTYUx2/UXQnVgi3ZkPaP4CH8yI8IpOD4VUHmFrulexZFfpDNNC9M3F/E3Ms2j
         oSSt7rIIxImt6KoBECCWs5kC5YSl14QORM3lC6cm5zEf7ZTYzHnsm6OQ/uBF2qZ779
         GxTlz2Qqi2PoQlHmZ8jz14yfSCicks7dsA7u5EE0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NGW2fg079903;
        Wed, 23 Sep 2020 11:32:02 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 11:32:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 11:32:02 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NGVudf099701;
        Wed, 23 Sep 2020 11:32:00 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j7200-mcu-wakeup: Add HyperBus node
Date:   Wed, 23 Sep 2020 22:01:49 +0530
Message-ID: <20200923163150.16973-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923163150.16973-1-vigneshr@ti.com>
References: <20200923163150.16973-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J7200 has a Flash SubSystem that has one OSPI and one HyperBus.. Add
DT nodes for HyperBus controller for now.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index a43385d8feca..ab22b02c0da5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -125,4 +125,31 @@ wkup_i2c0: i2c@42120000 {
 		clocks = <&k3_clks 197 1>;
 		power-domains = <&k3_pds 197 TI_SCI_PD_SHARED>;
 	};
+
+	fss: syscon@47000000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x00 0x47000000 0x00 0x100>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hbmc_mux: hbmc-mux {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4 0x2>; /* HBMC select */
+		};
+
+		hbmc: hyperbus@47034000 {
+			compatible = "ti,am654-hbmc";
+			reg = <0x00 0x47034000 0x00 0x100>,
+				<0x05 0x00000000 0x01 0x0000000>;
+			power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+			clocks = <&k3_clks 102 0>;
+			assigned-clocks = <&k3_clks 102 5>;
+			assigned-clock-rates = <333333333>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			mux-controls = <&hbmc_mux 0>;
+		};
+	};
 };
-- 
2.28.0

