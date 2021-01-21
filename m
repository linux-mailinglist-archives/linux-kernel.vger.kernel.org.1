Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FAB2FE0AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbhAUE2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:28:52 -0500
Received: from mail.v3.sk ([167.172.186.51]:43922 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbhAUEUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:20:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 82B7EE0738;
        Thu, 21 Jan 2021 03:37:46 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rqpuAFeEUP4K; Thu, 21 Jan 2021 03:37:46 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1F68CE0AA9;
        Thu, 21 Jan 2021 03:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YoQcdNrIrArX; Thu, 21 Jan 2021 03:37:45 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D76FCE0738;
        Thu, 21 Jan 2021 03:37:45 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 12/12] ARM: dts: mmp3: Fix the CCIC interrupts
Date:   Thu, 21 Jan 2021 04:41:30 +0100
Message-Id: <20210121034130.1381872-13-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121034130.1381872-1-lkundrak@v3.sk>
References: <20210121034130.1381872-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A copy & paste oversight from MMP2; camera interrupts are handled
via a multiplexer on MMP3.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index 9f2b059f0900b..a4fb9203ec1fb 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -293,7 +293,8 @@ mmc5: mmc@d4217000 {
 			camera0: camera@d420a000 {
 				compatible =3D "marvell,mmp2-ccic";
 				reg =3D <0xd420a000 0x800>;
-				interrupts =3D <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts =3D <1>;
+				interrupt-parent =3D <&ci_mux>;
 				clocks =3D <&soc_clocks MMP2_CLK_CCIC0>;
 				clock-names =3D "axi";
 				power-domains =3D <&soc_clocks MMP3_POWER_DOMAIN_CAMERA>;
@@ -305,7 +306,8 @@ camera0: camera@d420a000 {
 			camera1: camera@d420a800 {
 				compatible =3D "marvell,mmp2-ccic";
 				reg =3D <0xd420a800 0x800>;
-				interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts =3D <2>;
+				interrupt-parent =3D <&ci_mux>;
 				clocks =3D <&soc_clocks MMP2_CLK_CCIC1>;
 				clock-names =3D "axi";
 				power-domains =3D <&soc_clocks MMP3_POWER_DOMAIN_CAMERA>;
--=20
2.29.2

