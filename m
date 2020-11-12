Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC50D2AFF08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgKLFdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:33:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57356 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgKLBtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:49:53 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AC1nddO087198;
        Wed, 11 Nov 2020 19:49:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605145779;
        bh=kzZUD0v8POHeVdqHJO6ZQf/TtjgIfWTQcVpUSFpITao=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MqJf54BL8GtbBOE4aU+eGiQq4vr5aotY3l5cpMwYhmQwhyf2EFC+CD/sJt9Ni9Qvy
         FMyuMMtIJmqw9WihIJBJHQNEu2ySAp+Wq7y579vkENyun+MIyYl9hLHND0cuvHRr3R
         HO4YDeQrXubM6i2K5RXlRm6vaLsYG7luTgw619+Y=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AC1ndfP033101
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 19:49:39 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 19:49:39 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 11 Nov 2020 19:49:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AC1ndbi114800;
        Wed, 11 Nov 2020 19:49:39 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 5/5] arm64: dts: ti: am65/j721e/j7200: Mark firmware used uart as "reserved"
Date:   Wed, 11 Nov 2020 19:49:29 -0600
Message-ID: <20201112014929.25227-6-nm@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112014929.25227-1-nm@ti.com>
References: <20201112014929.25227-1-nm@ti.com>
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
---
- New patch introduced with V2 based on feedback on v1

 arch/arm64/boot/dts/ti/k3-am654-base-board.dts        | 2 +-
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 744efcbb4f7f..b5dba13556f8 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -211,7 +211,7 @@ AM65X_IOPAD(0x0010, PIN_INPUT, 0) /* (D21) ECAP0_IN_APWM_OUT */
 
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
-	status = "disabled";
+	status = "reserved";
 };
 
 &main_uart0 {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index ef03e7636b66..1d08434229c7 100644
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

