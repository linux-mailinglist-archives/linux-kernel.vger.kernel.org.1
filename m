Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC742B266B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgKMVTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:19:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42150 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgKMVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:18:56 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADLISQW082680;
        Fri, 13 Nov 2020 15:18:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605302308;
        bh=SeVTYct2l/NC7+kT3kwVLit2qpDjkJYaP5bfoGiv7HA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FeMWQSjmxx+c5mOSeFRWSvcxdAJlEyjR4FYO3Mc4BcCqaNTUba/zw2U1iBWCqjN5z
         YX4AapDcvMZYj4zAZP0x45vIhDM0kRY4q3nkK7avaWmHUP2SlFOIBBh7CTDp+PXolg
         YSw8d/uDKPsk9KMjJy1PwZAOvQnpLAvaYgHqDIAY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADLISqL061381
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 15:18:28 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 15:18:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 15:18:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADLIRes092288;
        Fri, 13 Nov 2020 15:18:27 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH V4 5/5] arm64: dts: ti: am65/j721e/j7200: Mark firmware used uart as "reserved"
Date:   Fri, 13 Nov 2020 15:18:26 -0600
Message-ID: <20201113211826.13087-6-nm@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113211826.13087-1-nm@ti.com>
References: <20201113211826.13087-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the device tree standards that states to set the
status="reserved" if an device is operational, but used by a non-linux
firmware in the system.

Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Vignesh Raghavendra <vigneshr@ti.com>
---
v4: no change

v3: https://lore.kernel.org/linux-arm-kernel/20201112183538.6805-6-nm@ti.com/
V2: https://lore.kernel.org/linux-arm-kernel/20201112014929.25227-6-nm@ti.com/
V1: didnot exist

 arch/arm64/boot/dts/ti/k3-am654-base-board.dts        | 2 +-
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index c8c9aa98b561..fe3043943906 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -242,7 +242,7 @@ AM65X_IOPAD(0x0010, PIN_INPUT, 0) /* (D21) ECAP0_IN_APWM_OUT */
 
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
-	status = "disabled";
+	status = "reserved";
 };
 
 &main_uart0 {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 7d2ff1c3b50f..96fa26365248 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -79,7 +79,7 @@ J721E_IOPAD(0x120, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
 
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
-	status = "disabled";
+	status = "reserved";
 };
 
 &main_uart0 {
@@ -89,7 +89,7 @@ &main_uart0 {
 
 &main_uart2 {
 	/* MAIN UART 2 is used by R5F firmware */
-	status = "disabled";
+	status = "reserved";
 };
 
 &main_uart3 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 9416528caa8a..5754892f8501 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -221,7 +221,7 @@ J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_MDIO0_MDIO */
 
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
-	status = "disabled";
+	status = "reserved";
 };
 
 &main_uart0 {
-- 
2.29.2

