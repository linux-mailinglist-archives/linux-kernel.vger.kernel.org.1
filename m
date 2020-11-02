Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B4C2A33B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgKBTLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:11:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57174 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:11:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2JBakt092489;
        Mon, 2 Nov 2020 13:11:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604344296;
        bh=izwgX9QWiArlHq7fWeBt+2soSOVhIA3TNekRdQeKsGM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O8+jEaKzy8LZRzunuKX+KJdD4VFJ5/MsbEUaGhmDTCLgezMTs+D0tfoOnO9zFagtR
         Q1QKKuxifSgCTjssCiYwEheS/o+v4VLEY2thorZTksNgJ3fpNJSNiCMzEcZSP7la8C
         AOGuRzDgiPQLM5SZXyD/LY3y8Ki4ShhuadgrNkvE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2JBZFp018834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 13:11:35 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 13:11:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 13:11:35 -0600
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2JBLoQ093265;
        Mon, 2 Nov 2020 13:11:32 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio modules
Date:   Tue, 3 Nov 2020 00:41:20 +0530
Message-ID: <20201102191120.20380-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102191120.20380-1-faiz_abbas@ti.com>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 6 gpio instances inside SoC with 2 groups as show below:
	Group one: wkup_gpio0, wkup_gpio1
	Group two: main_gpio0, main_gpio2, main_gpio4, main_gpio6

Only one instance from each group can be used at a time. So use main_gpio0
and wkup_gpio0 in current linux context and disable the rest of the nodes.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
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

