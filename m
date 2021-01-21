Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC12FE0E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbhAUEkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:40:55 -0500
Received: from mail.v3.sk ([167.172.186.51]:43646 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732044AbhAUDzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:55:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8290FE0AAE;
        Thu, 21 Jan 2021 03:37:45 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LcSkUZQy2OKO; Thu, 21 Jan 2021 03:37:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 025ECE0AA6;
        Thu, 21 Jan 2021 03:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pXgSsFwuFnmt; Thu, 21 Jan 2021 03:37:44 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C10F2E0AA9;
        Thu, 21 Jan 2021 03:37:44 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 10/12] ARM: dts: mmp3-dell-ariel: Add the power button node
Date:   Thu, 21 Jan 2021 04:41:28 +0100
Message-Id: <20210121034130.1381872-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121034130.1381872-1-lkundrak@v3.sk>
References: <20210121034130.1381872-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the power button attached to the Embedded Controlle=
r
on a Dell Wyse 3020 "Ariel" board.

However, while the EC itself is controlled via I2C, the input capability
for the power button acts as a separate device attached to the SPI, hence
it has a separate device node.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3-dell-ariel.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp3-dell-ariel.dts b/arch/arm/boot/dts/mm=
p3-dell-ariel.dts
index 565cd0fadf3d3..c4a6bd876d849 100644
--- a/arch/arm/boot/dts/mmp3-dell-ariel.dts
+++ b/arch/arm/boot/dts/mmp3-dell-ariel.dts
@@ -119,8 +119,16 @@ firmware-flash@0 {
 };
=20
 &ssp2 {
-	cs-gpios =3D <&gpio 56 GPIO_ACTIVE_LOW>;
 	status =3D "okay";
+	cs-gpios =3D <&gpio 56 GPIO_ACTIVE_LOW>;
+
+	power-button@0 {
+		reg =3D <0>;
+		interrupt-parent =3D <&gpio>;
+		interrupts =3D <60 IRQ_TYPE_EDGE_RISING>;
+		compatible =3D "dell,wyse-ariel-ec-input", "ene,kb3930-input";
+		spi-max-frequency =3D <33000000>;
+	};
 };
=20
 &gpu_2d {
--=20
2.29.2

