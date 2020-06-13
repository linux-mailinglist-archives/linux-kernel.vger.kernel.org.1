Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2764B1F8454
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 18:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgFMQoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 12:44:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51358 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgFMQoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:44:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05DGhtiw094259;
        Sat, 13 Jun 2020 11:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592066635;
        bh=bcIOWBCD+ochF/uUQZlJLY18qWtv6RQIJeaX/jm2CVo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V8pyPdFW2b2uVMUAH8u1KidLXHUFqguxHZsSENT3Kk9MuB4p2vxJ7LqYyRgqV0NBV
         PMQcka2MPGlOsHkLFeoXo3GYu1U6TXK7XlPvQz5ZDXU8y0bhOOfvc8lKKZ5m+Y9xCF
         /706kd4f/Tm83LcfMVuzwoPZR4EaCcKDNExZ9PvA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05DGhtEc109329;
        Sat, 13 Jun 2020 11:43:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 13
 Jun 2020 11:43:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 13 Jun 2020 11:43:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05DGhsws026664;
        Sat, 13 Jun 2020 11:43:54 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am65-wakeup: add k3 platforms chipid module node
Date:   Sat, 13 Jun 2020 19:43:45 +0300
Message-ID: <20200613164346.28852-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200613164346.28852-1-grygorii.strashko@ti.com>
References: <20200613164346.28852-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for the Texas Instruments K3 Multicore AM65x SoC platforms
chipid module.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 54a133fa1bf2..f7b9bc562e00 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -34,6 +34,11 @@
 		};
 	};
 
+	chipid@43000014 {
+		compatible = "ti,am654-chipid";
+		reg = <0x43000014 0x4>;
+	};
+
 	wkup_pmx0: pinmux@4301c000 {
 		compatible = "pinctrl-single";
 		reg = <0x4301c000 0x118>;
-- 
2.17.1

