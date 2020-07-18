Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1244A224DEC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 22:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGRUun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 16:50:43 -0400
Received: from v6.sk ([167.172.42.174]:37514 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgGRUul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:50:41 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 1F52560D2C;
        Sat, 18 Jul 2020 20:50:40 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 02/13] ARM: dts: mmp2-olpc-xo-1-75: Delete #address-cells from ssp3
Date:   Sat, 18 Jul 2020 22:50:08 +0200
Message-Id: <20200718205019.184927-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718205019.184927-1-lkundrak@v3.sk>
References: <20200718205019.184927-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the XO-1.75, this node represents a bus interface that operates in slave
mode and thus is only able to accommodate a single subnode; no address
cells are necessary.

The Documentation/devicetree/bindings/spi/spi-controller.yaml binding
prefers that we drop the property instead of setting it to zero.

This fixes a DT validation error:

  arch/arm/boot/dts/mmp2-olpc-xo-1-75.dt.yaml: spi@d4037000:
      { ... } is valid under each of {'required': ['spi-slave']},
                                     {'required': ['#address-cells']}

We also need to drop #size-cells:

  arch/arm/boot/dts/mmp2-olpc-xo-1-75.dt.yaml: spi@d4037000:
      '#address-cells' is a dependency of '#size-cells'

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
index 02f4005a654b9..392f546f7915b 100644
--- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
+++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
@@ -221,7 +221,8 @@ accelerometer@1d {
 };
 
 &ssp3 {
-	#address-cells = <0>;
+	/delete-property/ #address-cells;
+	/delete-property/ #size-cells;
 	spi-slave;
 	status = "okay";
 	ready-gpio = <&gpio 125 GPIO_ACTIVE_HIGH>;
-- 
2.26.2

