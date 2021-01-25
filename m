Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF683027D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbhAYQa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:30:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40118 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbhAYQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:27:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10PGPmUH090421;
        Mon, 25 Jan 2021 10:25:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611591948;
        bh=w3PJZmqxxaVKfmdUeB/QsuwKCTlYxK6K5krP0sgaD9c=;
        h=From:To:CC:Subject:Date;
        b=Wpf7ad+uywWwqIyFsWVORyAzRBogPSeBsLbijXgnzupIL10OJHX9MEaDKOIoVFFfb
         nHb1Ks6SEToYejDXQzxQ2ahnq3f0r3Y+VnzlqaDFSjgcrpNqRcLGzstzas9VKtTuiM
         octFy8LVz0uL10w37aEh9lwWeVtIDZsB4WPtLoS4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10PGPmRB111646
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jan 2021 10:25:48 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 25
 Jan 2021 10:25:48 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 25 Jan 2021 10:25:48 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10PGPhsM064422;
        Mon, 25 Jan 2021 10:25:44 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-j7200-main: Add support for higher speed modes in MMCSD subsystems
Date:   Mon, 25 Jan 2021 21:55:32 +0530
Message-ID: <20210125162532.30845-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following speed modes are now supported in J7200 SoC,
- HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
- UHS-I speed modes in MMCSD1 subsystem [1].

Set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1 device
tree nodes.

[1] - section 12.3.6.1.1 MMCSD Features, in
      https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

performance test logs using EXT4 filesystem for eMMC HS400 speed mode,
https://pastebin.ubuntu.com/p/JnPs8DxV58/

performance test logs using EXT4 filesystem for SD SDR104 speed mode,
https://pastebin.ubuntu.com/p/KPGzBz8YwC/

Changes since v1:
- Squashed the two patches into one
- added performance logs for the above mentioned speed modes

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 4cc2e9094d0e..4b3d0b5739e8 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -517,6 +517,8 @@
 		ti,trm-icp = <0x8>;
 		bus-width = <8>;
 		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		mmc-hs400-1_8v;
 		dma-coherent;
 	};
 
@@ -534,7 +536,6 @@
 		ti,otap-del-sel-sdr50 = <0xc>;
 		ti,otap-del-sel-sdr104 = <0x5>;
 		ti,otap-del-sel-ddr50 = <0xc>;
-		no-1-8-v;
 		dma-coherent;
 	};
 
-- 
2.17.1

