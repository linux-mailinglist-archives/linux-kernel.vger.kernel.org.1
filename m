Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2632A70BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgKDWoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:44:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35472 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgKDWoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:44:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A4Mi3Ke123278;
        Wed, 4 Nov 2020 16:44:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604529843;
        bh=vm0SmAIBDv/JlPGpGIwp92DW3Tea209tPYxdOes6hak=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UwFfyLBnmAUFZUPYD9HqUcBurYKeBmsc7tHlGZ4wRfHCdyJ6HzwNqPTdjfBtqw8yj
         j8FrSETFnbP1W0l3926R5u9eQekLj54q7LfCvAqxRe+VmdKi2iiH5+m2QXj79kQqY0
         M91XNIL5CM+DFUW6dghLxrjm9gUM8o/Z4lt+T+zI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A4Mi2Xf056145
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Nov 2020 16:44:02 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 4 Nov
 2020 16:44:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 4 Nov 2020 16:44:02 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A4Mi1hS124737;
        Wed, 4 Nov 2020 16:44:01 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-am654-base-board: Fix up un-necessary status set to "okay" for USB
Date:   Wed, 4 Nov 2020 16:43:56 -0600
Message-ID: <20201104224356.18040-5-nm@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104224356.18040-1-nm@ti.com>
References: <20201104224356.18040-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default state of a device tree node is "okay". There is no specific
use of explicitly adding status = "okay" in the board dts.

Fixes: 7e7e7dd51d06 ("arm64: dts: ti: k3-am654-base-board: enable USB1")
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 199c4d4e7539..744efcbb4f7f 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -325,14 +325,6 @@ &sdhci1 {
 	disable-wp;
 };
 
-&dwc3_1 {
-	status = "okay";
-};
-
-&usb1_phy {
-	status = "okay";
-};
-
 &usb1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins_default>;
-- 
2.29.2

