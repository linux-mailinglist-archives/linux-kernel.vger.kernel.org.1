Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136732BA362
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgKTHew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:34:52 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40732 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgKTHev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:34:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AK7Ymk2083277;
        Fri, 20 Nov 2020 01:34:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605857688;
        bh=keWuZXmMWanYbVCT7h7x7bRuK4QQGCy9wcihJZJ4H8c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=d7+ZXiUDDm+ii7BY8oS0XSfQP22xCGWjwhyCD0KIkqkk/zHFb43jgPMQ8gaOYyDDP
         q6s9toDEYKrjyWBNwOaWoPV9M2HQ+g3PE3bidvPTmTu4t1UXWDwwKISgeJjFyf1wHv
         ms7u2UgokSyo3+REgwWgA3Rw/sp23751j9ro/8ZU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AK7Ymgi092729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 01:34:48 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 20
 Nov 2020 01:34:48 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 20 Nov 2020 01:34:48 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AK7YftX089749;
        Fri, 20 Nov 2020 01:34:46 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nsekhar@ti.com>, <vigneshr@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j7200-common-proc-board: Correct the name of io expander on main_i2c1
Date:   Fri, 20 Nov 2020 09:35:33 +0200
Message-ID: <20201120073533.24486-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120073533.24486-1-peter.ujfalusi@ti.com>
References: <20201120073533.24486-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J7200 main_i2c1 is connected to the i2c bus on the CPB marked as main_i2c3

The i2c1 devices on the CPB are _not_ connected to the SoC, they are not
usable with the J7200 SOM.

Correct the expander name from exp4 to exp3 and at the same time add the
line names as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 2721137d8943..7110ef3e4092 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -154,16 +154,26 @@ exp2: gpio@22 {
 	};
 };
 
+/*
+ * The j7200 CPB board is identical to the CPB used for J721E, the SOMs can be
+ * swapped on the CPB.
+ *
+ * main_i2c1 of J7200 is connected to the CPB i2c bus labeled as i2c3.
+ * The i2c1 of the CPB (as it is labeled) is not connected to j7200.
+ */
 &main_i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 
-	exp4: gpio@20 {
+	exp3: gpio@20 {
 		compatible = "ti,tca6408";
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-line-names = "CODEC_RSTz", "CODEC_SPARE1", "UB926_RESETn",
+				  "UB926_LOCK", "UB926_PWR_SW_CNTRL",
+				  "UB926_TUNER_RESET", "UB926_GPIO_SPARE", "";
 	};
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

