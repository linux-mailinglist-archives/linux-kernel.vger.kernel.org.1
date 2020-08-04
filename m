Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4838C23C14F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 23:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHDVSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 17:18:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42716 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgHDVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:18:07 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 074LI0Xg079064;
        Tue, 4 Aug 2020 16:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596575880;
        bh=G7GCYMIKfue/A5ZDgs9tAJHdVeUEdZoF+fa0oTfoEn0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xUN4x37c6A/wmVZ0nUO4QNvhNyCDmZhwkA0dr0LaVSLbtfzmcAmis+62b+/5TrJfn
         9J66tleiiYqLe9bOTuljgzWm9ck06PESvqDibiLYYadQ+rvyhniA2SJk986aN+M/OB
         1HPyO9V4QQo4dGBGDWDN0TCv7mo92i4d7aCBct94=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 074LI0ZP059403;
        Tue, 4 Aug 2020 16:18:00 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 4 Aug
 2020 16:18:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 4 Aug 2020 16:18:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 074LHxA7020492;
        Tue, 4 Aug 2020 16:17:59 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next 3/3] arm64: dts: ti: k3-am65: ringacc: drop ti,dma-ring-reset-quirk
Date:   Wed, 5 Aug 2020 00:17:32 +0300
Message-ID: <20200804211732.2861-4-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804211732.2861-1-grygorii.strashko@ti.com>
References: <20200804211732.2861-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove obsolete "ti,dma-ring-reset-quirk" Ringacc DT property.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 -
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 9edfae5944f7..efbe94b6d418 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -590,7 +590,6 @@
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <818>;
 			ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
-			ti,dma-ring-reset-quirk;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <187>;
 			msi-parent = <&inta_main_udmass>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 8c1abcfe0860..f559bb6febdb 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -135,7 +135,6 @@
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
-			ti,dma-ring-reset-quirk;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <195>;
 			msi-parent = <&inta_main_udmass>;
-- 
2.17.1

