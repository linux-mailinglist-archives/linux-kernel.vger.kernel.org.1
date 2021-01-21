Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81712FE06C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbhAUEIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:08:49 -0500
Received: from mail.v3.sk ([167.172.186.51]:43652 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732063AbhAUD4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:56:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 06C37E0AA7;
        Thu, 21 Jan 2021 03:37:44 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cvsnP83ra3B4; Thu, 21 Jan 2021 03:37:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id ABD25E0AA6;
        Thu, 21 Jan 2021 03:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U_8s97sQJy5Q; Thu, 21 Jan 2021 03:37:43 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 754ACE0AAA;
        Thu, 21 Jan 2021 03:37:43 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 08/12] ARM: dts: mmp2-olpc-xo-1-75: Use symbolic names for audio clocks
Date:   Thu, 21 Jan 2021 04:41:26 +0100
Message-Id: <20210121034130.1381872-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121034130.1381872-1-lkundrak@v3.sk>
References: <20210121034130.1381872-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are slighly easier to read.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/=
mmp2-olpc-xo-1-75.dts
index 0f8b5ad48deed..55ea87870af3e 100644
--- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
+++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
@@ -2,7 +2,7 @@
 /*
  * OLPC XO 1.75 Laptop.
  *
- * Copyright (C) 2018,2019 Lubomir Rintel <lkundrak@v3.sk>
+ * Copyright (C) 2018,2019,2020 Lubomir Rintel <lkundrak@v3.sk>
  */
=20
 /dts-v1/;
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/marvell,mmp2-audio.h>
=20
 / {
 	model =3D "OLPC XO-1.75";
@@ -194,7 +195,7 @@ audio-codec@1a {
 		port {
 			rt5631_0: endpoint {
 				mclk-fs =3D <256>;
-				clocks =3D <&audio_clk 0>;
+				clocks =3D <&audio_clk MMP2_CLK_AUDIO_SYSCLK>;
 				remote-endpoint =3D <&sspa0_0>;
 			};
 		};
--=20
2.29.2

