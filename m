Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA742B0CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKLSfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:35:48 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40434 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgKLSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:35:48 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACIZgma043391;
        Thu, 12 Nov 2020 12:35:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605206142;
        bh=q9ZmJG8FHCs/rSqVec1A9iyRSZ8ZTKcwj7L7mRCWahE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PaJFUX3hY8J2c1RhLAI7WJKNypSfPgjT1jIKG2fX3VoiLGjxz6VltoQo9XOq/c4A+
         fTwcr1NEBWRJWsgSI+7Z+T5C+6h46WW2+/jusTDYmqC/UPl9f4dJNU4lo78acm0yQo
         svfwlMww7p8lkArijrGNEcfxIjSGDdyWFoL3a4HQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACIZgbE068170
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 12:35:42 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 12:35:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 12:35:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACIZgcl042718;
        Thu, 12 Nov 2020 12:35:42 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 4/5] arm64: dts: ti: k3-am654-base-board: Fix up un-necessary status set to "okay" for USB
Date:   Thu, 12 Nov 2020 12:35:37 -0600
Message-ID: <20201112183538.6805-5-nm@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112183538.6805-1-nm@ti.com>
References: <20201112183538.6805-1-nm@ti.com>
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
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Roger Quadros <rogerq@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
---
Changes since V2:
- No change beyond picking up reviews.

v2: https://lore.kernel.org/linux-arm-kernel/20201112014929.25227-5-nm@ti.com/
v1: https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-5-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 0dec781982b1..c8c9aa98b561 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -356,14 +356,6 @@ &sdhci1 {
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

