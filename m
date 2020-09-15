Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6021326A435
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgIOLeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:34:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46666 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgIOLWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:22:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKtS6121436;
        Tue, 15 Sep 2020 06:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600168855;
        bh=yE6RpXYHDyZjsrmmJuZhV/96rFSzlppfJV7S6myB8Ak=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zLCwTHyqjs2+O5VYwR6t0O0D5v52sAVPwUd3hNcjXYt830q4q+j+WXpWhUC/GFrIy
         tX9AlHwwXoCUXNzTzTMdrdH+BOHyaJB/Ur3eNcEctq6E1edApRVYM8VhX0gKFDPjgR
         uV9FtSOD+O3PUbCjtU9KNByaY79WfXk5/bghDl5w=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FBKtqg051099
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 06:20:55 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 06:20:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 06:20:54 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKdmE013285;
        Tue, 15 Sep 2020 06:20:52 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 5/6] arm64: dts: ti: k3-j7200-common-proc-board: Configure the SERDES lane function
Date:   Tue, 15 Sep 2020 14:20:37 +0300
Message-ID: <20200915112038.30219-6-rogerq@ti.com>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

First two lanes of SERDES is connected to PCIe, third lane is
connected to QSGMII and the last lane is connected to USB. However,
Cadence torrent SERDES doesn't support more than 2 protocols
at the same time. Configure it only for PCIe and QSGMII.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 8e534ef8a3f5..0ecaba600704 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "k3-j7200-som-p0.dtsi"
+#include <dt-bindings/mux/mux-j7200-wiz.h>
 
 / {
 	chosen {
@@ -139,3 +140,8 @@
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
+
+&serdes_ln_ctrl {
+	idle-states = <SERDES0_LANE0_PCIE1_LANE0>, <SERDES0_LANE1_PCIE1_LANE1>,
+		      <SERDES0_LANE2_QSGMII_LANE1>, <SERDES0_LANE3_IP4_UNUSED>;
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

