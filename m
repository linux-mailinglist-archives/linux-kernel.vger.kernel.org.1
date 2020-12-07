Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7392D0C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgLGItA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:49:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9109 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgLGIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:48:59 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqH4n62CGzLwd9;
        Mon,  7 Dec 2020 16:47:37 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 16:48:07 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        "Arnd Bergmann" <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] ARM: dts: mmp2-olpc-xo-1-75: clear the warnings when make dtbs
Date:   Mon, 7 Dec 2020 16:47:52 +0800
Message-ID: <20201207084752.1665-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201207084752.1665-1-thunder.leizhen@huawei.com>
References: <20201207084752.1665-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check_spi_bus_bridge() in scripts/dtc/checks.c requires that the node
have "spi-slave" property must with "#address-cells = <0>" and
"#size-cells = <0>". But currently both "#address-cells" and "#size-cells"
properties are deleted, the corresponding default values are 2 and 1. As a
result, the check fails and below warnings is displayed.

arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): \
/soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): \
/soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): \
Failed prerequisite 'spi_bus_bridge'

Because the value of "#size-cells" is already defined as zero in the node
"ssp3: spi@d4037000" in arch/arm/boot/dts/mmp2.dtsi. So we only need to
explicitly add "#address-cells = <0>" and keep "#size-cells" no change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
index adde62d6fce73b9..82da44dacba7172 100644
--- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
+++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
@@ -224,7 +224,7 @@
 
 &ssp3 {
 	/delete-property/ #address-cells;
-	/delete-property/ #size-cells;
+	#address-cells = <0>;
 	spi-slave;
 	status = "okay";
 	ready-gpios = <&gpio 125 GPIO_ACTIVE_HIGH>;
-- 
1.8.3


