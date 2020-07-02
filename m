Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637F9212452
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgGBNNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 09:13:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38938 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgGBNNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:13:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 062DDUlP028111;
        Thu, 2 Jul 2020 08:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593695610;
        bh=WDMC1z6jzpUNYiGQWlUKYjUaAdNa/terAf9fLOG3fwk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TgRrVioXFdYzjUAP7HJIPnIJKbBcZ+s7oODDML8tchNxsOgEAC9gmCpsh+6U0Ag5h
         24mS8rMtnOnr/lze6dHCXDvGGi0LZQLXS9ABEZPV/2m5te0E8ujhZLcHttsvR55f+A
         /C50wji4Iith8l//qcwODFLbSAlIlhQNBBRZLpHw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 062DDUG1108058
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Jul 2020 08:13:30 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 2 Jul
 2020 08:13:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 2 Jul 2020 08:13:29 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 062DDOaq130577;
        Thu, 2 Jul 2020 08:13:27 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721e-common-proc-board: Remove duplicated main_i2c1_exp4_pins_default
Date:   Thu, 2 Jul 2020 16:14:23 +0300
Message-ID: <20200702131424.21241-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702131424.21241-1-peter.ujfalusi@ti.com>
References: <20200702131424.21241-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two pimux entry is present with the same name, remove one of them.

Fixes: cb27354b38f3 ("arm64: dts: ti: k3-j721e: Add DT nodes for few peripherials")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 6df823aaa37c..1f1fee85acca 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -102,12 +102,6 @@ J721E_IOPAD(0x1d0, PIN_INPUT_PULLUP, 2) /* (AA3) SPI0_D1.I2C6_SCL */
 			J721E_IOPAD(0x1e4, PIN_INPUT_PULLUP, 2) /* (Y2) SPI1_D1.I2C6_SDA */
 		>;
 	};
-
-	main_i2c1_exp4_pins_default: main-i2c1-exp4-pins-default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x230, PIN_INPUT, 7) /* (U2) ECAP0_IN_APWM_OUT.GPIO1_11 */
-		 >;
-	};
 };
 
 &wkup_pmx0 {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

