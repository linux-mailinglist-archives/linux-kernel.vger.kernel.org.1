Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28792AFF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgKLFde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:33:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36022 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgKLBtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:49:49 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AC1ndXb058971;
        Wed, 11 Nov 2020 19:49:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605145779;
        bh=bia3k49as6I8p93U5wZIBsi1zltS0lnhC5Rl7qRFt+w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=K0nJerbld4yAOB/wZ81vRkpSptM65FmqKiOXyttz7OnOnWnGUyJw666/i5RevGqyh
         qg7FFk2JviNfvFIu20nAC38D5bstzyHgCWWXCMMlKYNe4GqlMbHbWWDJmmBCH4xMER
         nnBWFglutmCAvXhmLXx/nlaCfJpHy7o5/VT+CcVI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AC1ndNO095836
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 19:49:39 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 19:49:39 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 11 Nov 2020 19:49:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AC1ndrV120371;
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
Subject: [PATCH V2 4/5] arm64: dts: ti: k3-am654-base-board: Fix up un-necessary status set to "okay" for USB
Date:   Wed, 11 Nov 2020 19:49:28 -0600
Message-ID: <20201112014929.25227-5-nm@ti.com>
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

The default state of a device tree node is "okay". There is no specific
use of explicitly adding status = "okay" in the board dts.

Fixes: 7e7e7dd51d06 ("arm64: dts: ti: k3-am654-base-board: enable USB1")
Signed-off-by: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
---
Changes since v1:
- no change.

v1: https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-5-nm@ti.com/

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

