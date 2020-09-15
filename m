Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCCA26A442
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIOLix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:38:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34276 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIOLWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:22:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKoZb114714;
        Tue, 15 Sep 2020 06:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600168850;
        bh=Ox9JQ9lfIi6Br9DzqBenHYEJv6uad6xu9fA0mr6q0RY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Jhcb3soxyQPZj+kLnlX4H8cu2g2bZuNLan4n8l160n8OCe6Cptyv7zTDEwHxk03Ak
         Rrfr+x9cqMnXVG/SOmVx44PWO64i/PfU/LmjSLan6QbhvD1XlSnlZp8NzoxmUc23cr
         BVfcKt4/6vAbmitNyQkyX8JjwzrrNMZaK8M/635o=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKooN120706;
        Tue, 15 Sep 2020 06:20:50 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 06:20:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 06:20:49 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKdmC013285;
        Tue, 15 Sep 2020 06:20:47 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 3/6] arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
Date:   Tue, 15 Sep 2020 14:20:35 +0300
Message-ID: <20200915112038.30219-4-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915112038.30219-1-rogerq@ti.com>
References: <20200915112038.30219-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB controller can be connected to one of the 2 lanes
of SERDES0 using a MUX. Add a MUX controller node for that.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index d6d688efc32a..42f66b8dffa7 100644
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

