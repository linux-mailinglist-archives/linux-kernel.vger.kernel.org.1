Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5BC2E94BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhADMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:23:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52872 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:23:38 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104CMtmX092756;
        Mon, 4 Jan 2021 06:22:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609762975;
        bh=v8DeDg+aSnj9XDWh6SjoEmvU220d2QLKrD8S48HIXT4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=haLnkUev2i6EyWZdrmJ4QYp5wPMZ/a3RgM0V33t8LXTHECRyNnIyM3Te6aMNEv34R
         8JIKUt2qvt6lM6wgJ8qR5Nqvx6qC73DsjxWt4ftElZdJ/qfbmTO/Y6mM/Js2XD+XQb
         fQ8RI2k7wektGimc49sKJq3fyT7pceIdtEkJDVjI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104CMt9P068645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 06:22:55 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 06:22:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 06:22:54 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104CMZhS002211;
        Mon, 4 Jan 2021 06:22:52 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/6] arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe
Date:   Mon, 4 Jan 2021 17:52:32 +0530
Message-ID: <20210104122232.24071-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210104122232.24071-1-kishon@ti.com>
References: <20210104122232.24071-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x2 lane PCIe slot in the common processor board is enabled and connected to
j7200 SOM. Add PCIe DT node in common processor board to reflect the
same.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../boot/dts/ti/k3-j7200-common-proc-board.dts    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index def98f563336..4a7182abccf5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "k3-j7200-som-p0.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
@@ -241,3 +242,17 @@
 		resets = <&serdes_wiz0 3>;
 	};
 };
+
+&pcie1_rc {
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
+};
+
+&pcie1_ep {
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
+	status = "disabled";
+};
-- 
2.17.1

