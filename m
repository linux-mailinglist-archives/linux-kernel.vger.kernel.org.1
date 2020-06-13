Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C051F8452
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 18:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgFMQoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 12:44:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58236 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgFMQoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:44:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05DGi2xY095320;
        Sat, 13 Jun 2020 11:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592066642;
        bh=Kq9RmWG9zoUDdSoYUNDsFx1fgCZs2wx3Q+U+B2lGhGo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rhe/LGv2Bs1MRQszFincmAPkufiOE3Ek3rDO0NbsWeZGJD5lqa09fQevdxTfwDUNi
         hcxJv8FadFEvr62AZgn6Clm6xAKVXUj3SI1b0nacwgXtsW4mfBCDzZ/JCeUYkLzC0G
         wX3jnVJ+OWLPsVC8VxU5gnmy9B58z6mP3pcI1sug=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05DGi1LZ037833
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 Jun 2020 11:44:02 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 13
 Jun 2020 11:44:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 13 Jun 2020 11:44:01 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05DGi0jX074501;
        Sat, 13 Jun 2020 11:44:01 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j721e-mcu-wakeup: add k3 platforms chipid module node
Date:   Sat, 13 Jun 2020 19:43:46 +0300
Message-ID: <20200613164346.28852-3-grygorii.strashko@ti.com>
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

Add DT node for the Texas Instruments K3 Multicore J721E SoC platforms
chipid module.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index dc31bd0434cb..e468cc1f8e4d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -48,6 +48,11 @@
 		};
 	};
 
+	chipid@43000014 {
+		compatible = "ti,am654-chipid";
+		reg = <0x0 0x43000014 0x0 0x4>;
+	};
+
 	wkup_pmx0: pinmux@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-- 
2.17.1

