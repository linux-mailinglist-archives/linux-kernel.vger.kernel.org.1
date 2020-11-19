Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85FB2B93A3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgKSNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:25:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46070 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgKSNZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:25:45 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJDPh4U072672;
        Thu, 19 Nov 2020 07:25:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605792343;
        bh=FSvO39LEJm4IuraeYVxmBRkvYiyoNTPzo6ZGCh2Q3N0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HKuSp9tzBrDFllRsLBWzA2gQSkdAr81NxZMDMLfwTq0rRYZ2luEmNRoMQxqD+KaO8
         Wj26baHIwG23jF9nDh5pQ5PpSZpap6e7oT+9kXqEIP/opR+/d8nndy+NSJS5JKWTzG
         xqHyH/Voc6Nu5MGBoL2JNqX9GzdGNdLWS6aOTqZM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJDPhfj130439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 07:25:43 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 07:25:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 07:25:42 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJDPZhg038667;
        Thu, 19 Nov 2020 07:25:40 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nsekhar@ti.com>, <vigneshr@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j7200-common-proc-board: Correct the name of io expander on main_i2c1
Date:   Thu, 19 Nov 2020 15:26:27 +0200
Message-ID: <20201119132627.8041-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119132627.8041-1-peter.ujfalusi@ti.com>
References: <20201119132627.8041-1-peter.ujfalusi@ti.com>
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
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 2721137d8943..83e043c65f81 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -159,11 +159,14 @@ &main_i2c1 {
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

