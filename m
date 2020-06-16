Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C431FBDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgFPSXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 14:23:55 -0400
Received: from v6.sk ([167.172.42.174]:47578 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgFPSXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:23:55 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 10A3261627;
        Tue, 16 Jun 2020 18:23:53 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 01/13] ARM: dts: mmp2-olpc-xo-1-75: Fix camera I2C node validation
Date:   Tue, 16 Jun 2020 20:23:29 +0200
Message-Id: <20200616182341.944473-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616182341.944473-1-lkundrak@v3.sk>
References: <20200616182341.944473-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  mmp2-olpc-xo-1-75.dt.yaml: camera_i2c: $nodename:0:
      'camera_i2c' does not match '^i2c(@.*)?'
  mmp2-olpc-xo-1-75.dt.yaml: camera_i2c: 'sda-gpios' is a required property
  mmp2-olpc-xo-1-75.dt.yaml: camera_i2c: 'scl-gpios' is a required property

The "gpios" property actually was documented as deprecated, but got dropped
in commit 0175ce4a58d6 ("dt-bindings: i2c: Convert i2c-gpio binding to
json-schema"). It's probably best kept forgotten though.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
index 6cfa0d4a18845..02f4005a654b9 100644
--- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
+++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
@@ -77,10 +77,10 @@ headphone_insert {
 		};
 	};
 
-	camera_i2c {
+	i2c {
 		compatible = "i2c-gpio";
-		gpios = <&gpio 109 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>,
-			<&gpio 108 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		sda-gpios = <&gpio 109 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio 108 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-gpio,timeout-ms = <1000>;
-- 
2.26.2

