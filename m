Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2385227E868
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgI3MU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:20:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59082 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbgI3MUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:20:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKlOL128603;
        Wed, 30 Sep 2020 07:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601468447;
        bh=AvEmbdVbHpW82BxDz90KTPiGi9l7lZVqWLBVhXFIhHI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WISUFaBMcKNFnFytiVjP+6zVD9Q6mep3sM6yvV6WTx+AWqKLrGCyECeglSwOBCc0O
         4pfk5KchmLwDVsHhqGvzqOgSj6IQYuMcHTaIW8qT6lyIcpmQc4VPiDLaAJ6uFAgAHT
         yEffh82XI27uWzPcAcUO1bTCnVbmuG8aVUUZS960=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UCKlYk064247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 07:20:47 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 07:20:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 07:20:47 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKXr7049132;
        Wed, 30 Sep 2020 07:20:45 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <nm@ti.com>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 5/6] arm64: dts: ti: k3-j7200-common-proc-board: Configure the SERDES lane function
Date:   Wed, 30 Sep 2020 15:20:31 +0300
Message-ID: <20200930122032.23481-6-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930122032.23481-1-rogerq@ti.com>
References: <20200930122032.23481-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

First two lanes of SERDES is connected to PCIe, third lane is
connected to QSGMII and the last lane is connected to USB. However,
Cadence torrent SERDES doesn't support more than 2 protocols
at the same time. Configure it only for PCIe and QSGMII.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 1541311cecb4..ddbc2163e698 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -7,6 +7,7 @@
 
 #include "k3-j7200-som-p0.dtsi"
 #include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/mux/ti-serdes.h>
 
 / {
 	chosen {
@@ -185,3 +186,8 @@
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
+
+&serdes_ln_ctrl {
+	idle-states = <J7200_SERDES0_LANE0_PCIE1_LANE0>, <J7200_SERDES0_LANE1_PCIE1_LANE1>,
+		      <J7200_SERDES0_LANE2_QSGMII_LANE1>, <J7200_SERDES0_LANE3_IP4_UNUSED>;
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

