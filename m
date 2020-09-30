Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B37527E862
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgI3MUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:20:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59068 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbgI3MUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:20:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKhpN128563;
        Wed, 30 Sep 2020 07:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601468443;
        bh=RJ19G6aZ1J8b4aOVnV8VNDjjq+m87iMxPkpaqH3M05k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=y6l8U8Ehszc4758jQGhp2WMketzPr6RbNYidkZ5HSy9gJ9Oyv3ZToj1QUS987q0ft
         bYBlKSqpD9E8gvtRQwjMR23fisH8YOckIWCETYGxk52EX5X5+RAp4NCTXP7QG/uFC5
         AMsdDbexluw2gCGzy9xDAfYSiKB9V6Pp/eozy0WQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKhC3120958;
        Wed, 30 Sep 2020 07:20:43 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 07:20:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 07:20:42 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKXr5049132;
        Wed, 30 Sep 2020 07:20:40 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <nm@ti.com>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 3/6] arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
Date:   Wed, 30 Sep 2020 15:20:29 +0300
Message-ID: <20200930122032.23481-4-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930122032.23481-1-rogerq@ti.com>
References: <20200930122032.23481-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB controller can be connected to one of the 2 lanes
of SERDES0 using a MUX. Add a MUX controller node for that.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 8997276158ca..c638c3d8c0f2 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -31,6 +31,12 @@
 			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
 					<0x4088 0x3>, <0x408c 0x3>; /* SERDES0 lane2/3 select */
 		};
+
+		usb_serdes_mux: mux-controller@4000 {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4000 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

