Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015182D0C0B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgLGItA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:49:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9108 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgLGIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:48:59 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqH4n6GR9zLyDk;
        Mon,  7 Dec 2020 16:47:37 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 16:48:06 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        "Arnd Bergmann" <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] ARM: dts: mmp2-olpc-xo-1-75: clear the warnings when make dtbs
Date:   Mon, 7 Dec 2020 16:47:51 +0800
Message-ID: <20201207084752.1665-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 --> v2:
Update the patch description and subject.

I'm going to describe the detailed analysis here, because I don't want the
patch description to be too long.

0) make ARCH=arm CROSS_COMPILE=arm-linux-gnu- dtbs -j24 2>err.txt
   vim err.txt
arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'

1) mmp2.dtsi is included by mmp2-olpc-xo-1-75.dts, and the content of ssp3
node is:

arch/arm/boot/dts/mmp2.dtsi:472
ssp3: spi@d4037000 {
	compatible = "marvell,mmp2-ssp";
	reg = <0xd4037000 0x1000>;
	clocks = <&soc_clocks MMP2_CLK_SSP2>;
	interrupts = <20>;
	#address-cells = <1>;
	#size-cells = <0>;                        <-------- #size-cells = <0>
	status = "disabled";
};

arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225
&ssp3 {
        /delete-property/ #address-cells;         <-------- #address-cells is deleted here
        /delete-property/ #size-cells;            <-------- #size-cells is deleted here
        spi-slave;
        status = "okay";
        ready-gpios = <&gpio 125 GPIO_ACTIVE_HIGH>;

        slave {
                compatible = "olpc,xo1.75-ec";
                spi-cpha;
                cmd-gpios = <&gpio 155 GPIO_ACTIVE_HIGH>;
        };
};

2) scripts/dtc/checks.c: check_spi_bus_bridge() requires that the values of both
#address-cells and #size-cells must be zero, when the node have "spi-slave" property.
	if (get_property(node, "spi-slave"))
                spi_addr_cells = 0;
        if (node_addr_cells(node) != spi_addr_cells)
                FAIL(c, dti, node, "incorrect #address-cells for SPI bus");
        if (node_size_cells(node) != 0)
                FAIL(c, dti, node, "incorrect #size-cells for SPI bus");

3) But both #address-cells and #size-cells properties are deleted. So the return value
of node_addr_cells(node) is 2, and the return value of node_size_cells(node) is 1.
#define node_addr_cells(n) \
        (((n)->addr_cells == -1) ? 2 : (n)->addr_cells)
#define node_size_cells(n) \
        (((n)->size_cells == -1) ? 1 : (n)->size_cells)

4) The checks in 2) failed, so the above 0) warnings is displayed.



v1:
Patch 5/6.
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2341407.html

Zhen Lei (1):
  ARM: dts: mmp2-olpc-xo-1-75: clear the warnings when make dtbs

 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.3


