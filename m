Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2CD2B69EC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgKQQUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:20:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50708 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgKQQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:20:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHGK16e106104;
        Tue, 17 Nov 2020 10:20:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605630001;
        bh=CRfJLmwRdnflO8lygGqJY8mmenaAvc3pCSqw/PILXs0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cF4Pl4xTjN6vADU6VZlx3WBKGWzueexwzhxfS8e6J8kccSi36QsiZCasiEk55YlB4
         Obfo6MGBM0HXWv1VGLZMK+Qj8c95rUAbUjFkseebJZJrYl+zw9z8w9LHY170aYsNCl
         lfsLkJzQdXmqbPoQ6MyTnmNVgvqaEQS+3zqrZj60=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHGK1fV099530
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 10:20:01 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 10:20:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 10:20:00 -0600
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHGJhwK032251;
        Tue, 17 Nov 2020 10:19:57 -0600
From:   Sekhar Nori <nsekhar@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio modules
Date:   Tue, 17 Nov 2020 21:49:42 +0530
Message-ID: <20201117161942.38754-5-nsekhar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117161942.38754-1-nsekhar@ti.com>
References: <20201117161942.38754-1-nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

There are 6 gpio instances inside SoC with 2 groups as show below:
	Group one: wkup_gpio0, wkup_gpio1
	Group two: main_gpio0, main_gpio2, main_gpio4, main_gpio6

Only one instance from each group can be used at a time. So use main_gpio0
and wkup_gpio0 in current linux context and disable the rest of the nodes.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 .../boot/dts/ti/k3-j7200-common-proc-board.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index ef03e7636b66..0bc4170225d5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -127,6 +127,22 @@
 	status = "disabled";
 };
 
+&main_gpio2 {
+	status = "disabled";
+};
+
+&main_gpio4 {
+	status = "disabled";
+};
+
+&main_gpio6 {
+	status = "disabled";
+};
+
+&wkup_gpio1 {
+	status = "disabled";
+};
+
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
-- 
2.17.1

