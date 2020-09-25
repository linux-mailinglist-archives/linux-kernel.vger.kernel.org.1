Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C20027950E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgIYXsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:48:15 -0400
Received: from mail.v3.sk ([167.172.186.51]:37902 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729629AbgIYXsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:48:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 30B1BDFAA1;
        Fri, 25 Sep 2020 23:46:32 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9Bo6cczJWBk4; Fri, 25 Sep 2020 23:46:31 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 55761DFA9E;
        Fri, 25 Sep 2020 23:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1B47My6PVQgS; Fri, 25 Sep 2020 23:46:31 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 20D54DFAA2;
        Fri, 25 Sep 2020 23:46:31 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/2] ARM: dts: mmp3: Add power domain for the camera
Date:   Sat, 26 Sep 2020 01:48:04 +0200
Message-Id: <20200925234805.228251-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925234805.228251-1-lkundrak@v3.sk>
References: <20200925234805.228251-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The camera interfaces on MMP3 are on a separate power island that needs
to be turned on for them to operate and, ideally, turned off when the
cameras are not in use.

This hooks the power island with the camera interfaces in the device
tree.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index cc4efd0efabd2..4ae630d37d094 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -296,6 +296,7 @@ camera0: camera@d420a000 {
 				interrupts =3D <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks =3D <&soc_clocks MMP2_CLK_CCIC0>;
 				clock-names =3D "axi";
+				power-domains =3D <&soc_clocks MMP3_POWER_DOMAIN_CAMERA>;
 				#clock-cells =3D <0>;
 				clock-output-names =3D "mclk";
 				status =3D "disabled";
@@ -307,6 +308,7 @@ camera1: camera@d420a800 {
 				interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 				clocks =3D <&soc_clocks MMP2_CLK_CCIC1>;
 				clock-names =3D "axi";
+				power-domains =3D <&soc_clocks MMP3_POWER_DOMAIN_CAMERA>;
 				#clock-cells =3D <0>;
 				clock-output-names =3D "mclk";
 				status =3D "disabled";
--=20
2.26.2

