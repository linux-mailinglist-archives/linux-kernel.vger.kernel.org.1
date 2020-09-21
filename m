Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB32728D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgIUOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:48:12 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52050 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgIUOsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:48:07 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 10:48:04 EDT
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08LEe0cm011193;
        Mon, 21 Sep 2020 09:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600699200;
        bh=80QVkPZJsQFSWAzeZHGO8haEv3COPTYc4kG+gj4eLus=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=k0O/wG1Dd663HNo3vt2LYkVsYiMBxxnTqXaotxtj8lCf9gl2VecjLVCv2KTnS9j8H
         BapDcHeIM813MLwi7ND4q62P5DQhWfPYCmlsKVdIa6Lx/1Zu/EDbqjHZj3unBVmeib
         ubQM5OfGHJRlaPrVfeF7kFafmo6ofqNZSJ2K2QSY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08LEe04u009683
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 09:40:00 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 21
 Sep 2020 09:39:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 21 Sep 2020 09:39:59 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LEdivq065452;
        Mon, 21 Sep 2020 09:39:57 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <peda@axentia.se>, <nm@ti.com>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 5/6] arm64: dts: ti: k3-j7200-common-proc-board: Configure the SERDES lane function
Date:   Mon, 21 Sep 2020 17:39:40 +0300
Message-ID: <20200921143941.13905-6-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921143941.13905-1-rogerq@ti.com>
References: <20200921143941.13905-1-rogerq@ti.com>
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
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 8e534ef8a3f5..6ab9d5d33a72 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "k3-j7200-som-p0.dtsi"
+#include <dt-bindings/mux/ti-serdes.h>
 
 / {
 	chosen {
@@ -139,3 +140,8 @@
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

