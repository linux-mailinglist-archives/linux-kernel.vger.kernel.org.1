Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9292E275C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgIWPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:55:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44696 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgIWPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:55:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NFtc2i041021;
        Wed, 23 Sep 2020 10:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600876538;
        bh=EDhBgYHrdBd7OfBBGP8hWPI28Py5zzfWjhPX7hHVzyI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ve/tVrQGXyTC4SJ5ur0/ctA1cuNnWXKM2E0zuXsXzFSKjJ08xb2+KcHlxNxu+bjg3
         IW+y+c9saKKTRI6FfP968sB/+KO3B8zsMwU9X7KdpS4pjDE3HkSgpY/hEujxdVYyUX
         VFj4GfBoL/0vlVWHa2MysL+AKIkxduWX/OhX8jV0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NFtc61014934
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 10:55:38 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 10:55:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 10:55:38 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NFtT8t074561;
        Wed, 23 Sep 2020 10:55:35 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j7200-common-proc-board: Add I2C IO expanders
Date:   Wed, 23 Sep 2020 21:24:00 +0530
Message-ID: <20200923155400.13757-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923155400.13757-1-vigneshr@ti.com>
References: <20200923155400.13757-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for I2C GPIO expanders on main_i2c0 and main_i2c1 and
also add the pinmux corresponding to these I2C instances.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index e27069317c4e..26ad2e46009e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -14,6 +14,22 @@ chosen {
 	};
 };
 
+&main_pmx0 {
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
+			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
+			J721E_IOPAD(0xe0, PIN_INPUT_PULLUP, 3) /* (T3) EXT_REFCLK1.I2C1_SDA */
+		>;
+	};
+};
+
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
 	status = "disabled";
@@ -62,3 +78,36 @@ &main_uart9 {
 	/* UART not brought out */
 	status = "disabled";
 };
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	exp1: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	exp2: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <400000>;
+
+	exp4: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
-- 
2.28.0

