Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2527D0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbgI2OQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:16:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14777 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728514AbgI2OPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:15:33 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6E1C72BDB9FDB8E4435E;
        Tue, 29 Sep 2020 22:15:19 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 22:15:12 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 02/17] dt-bindings: arm: hisilicon: delete the descriptions of HiP05/HiP06 controllers
Date:   Tue, 29 Sep 2020 22:14:39 +0800
Message-ID: <20200929141454.2312-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200929141454.2312-1-thunder.leizhen@huawei.com>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible strings of Hi6220 SRAM controller, HiP05/HiP06 PCIe-SAS
subsystem controller, HiP05/HiP06 PERI subsystem controller and
HiP05/HiP06 DSA subsystem controller is in syscon.yaml now.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 68 ----------------------
 1 file changed, 68 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index a97f643e7d1c760..54f423d87a80a6a 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -186,24 +186,6 @@ Example:
 		#clock-cells = <1>;
 	};
 
-
-Hisilicon Hi6220 SRAM controller
-
-Required properties:
-- compatible : "hisilicon,hi6220-sramctrl", "syscon"
-- reg : Register address and size
-
-Hisilicon's SoCs use sram for multiple purpose; on Hi6220 there have several
-SRAM banks for power management, modem, security, etc. Further, use "syscon"
-managing the common sram which can be shared by multiple modules.
-
-Example:
-	/*for Hi6220*/
-	sram: sram@fff80000 {
-		compatible = "hisilicon,hi6220-sramctrl", "syscon";
-		reg = <0x0 0xfff80000 0x0 0x12000>;
-	};
-
 -----------------------------------------------------------------------
 Hisilicon HiP01 system controller
 
@@ -226,56 +208,6 @@ Example:
 	};
 
 -----------------------------------------------------------------------
-Hisilicon HiP05/HiP06 PCIe-SAS sub system controller
-
-Required properties:
-- compatible : "hisilicon,pcie-sas-subctrl", "syscon";
-- reg : Register address and size
-
-The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
-HiP05 or HiP06 Soc to implement some basic configurations.
-
-Example:
-	/* for HiP05 PCIe-SAS sub system */
-	pcie_sas: system_controller@b0000000 {
-		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
-		reg = <0xb0000000 0x10000>;
-	};
-
-Hisilicon HiP05/HiP06 PERI sub system controller
-
-Required properties:
-- compatible : "hisilicon,peri-subctrl", "syscon";
-- reg : Register address and size
-
-The PERI sub system controller is shared by peripheral controllers in
-HiP05 or HiP06 Soc to implement some basic configurations. The peripheral
-controllers include mdio, ddr, iic, uart, timer and so on.
-
-Example:
-	/* for HiP05 sub peri system */
-	peri_c_subctrl: syscon@80000000 {
-		compatible = "hisilicon,peri-subctrl", "syscon";
-		reg = <0x0 0x80000000 0x0 0x10000>;
-	};
-
-Hisilicon HiP05/HiP06 DSA sub system controller
-
-Required properties:
-- compatible : "hisilicon,dsa-subctrl", "syscon";
-- reg : Register address and size
-
-The DSA sub system controller is shared by peripheral controllers in
-HiP05 or HiP06 Soc to implement some basic configurations.
-
-Example:
-	/* for HiP05 dsa sub system */
-	pcie_sas: system_controller@a0000000 {
-		compatible = "hisilicon,dsa-subctrl", "syscon";
-		reg = <0xa0000000 0x10000>;
-	};
-
------------------------------------------------------------------------
 Hisilicon CPU controller
 
 Required properties:
-- 
1.8.3


