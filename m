Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66FE2FE064
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbhAUEIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:08:40 -0500
Received: from mail.v3.sk ([167.172.186.51]:43718 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727442AbhAUD74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:59:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BE354E0AA6;
        Thu, 21 Jan 2021 03:37:45 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QeRj4b-AuJuy; Thu, 21 Jan 2021 03:37:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7E511E0AAC;
        Thu, 21 Jan 2021 03:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id f7eoDp1UMAtZ; Thu, 21 Jan 2021 03:37:45 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 46A02E0AA9;
        Thu, 21 Jan 2021 03:37:45 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 11/12] ARM: dts: mmp3-dell-ariel: Replace SSP2 with spi-gpio
Date:   Thu, 21 Jan 2021 04:41:29 +0100
Message-Id: <20210121034130.1381872-12-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121034130.1381872-1-lkundrak@v3.sk>
References: <20210121034130.1381872-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware leaves the pins in GPIO mode. Until we have a proper pinmux
driver hooked on we just need to bitbang SPI. No big deal, this is just
used for the power button and performance is not important.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3-dell-ariel.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp3-dell-ariel.dts b/arch/arm/boot/dts/mm=
p3-dell-ariel.dts
index c4a6bd876d849..fe6df364a9eb6 100644
--- a/arch/arm/boot/dts/mmp3-dell-ariel.dts
+++ b/arch/arm/boot/dts/mmp3-dell-ariel.dts
@@ -30,6 +30,17 @@ memory@0 {
 		reg =3D <0x0 0x80000000>;
 		device_type =3D "memory";
 	};
+
+	ec_input_spi: spi {
+		compatible =3D "spi-gpio";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		num-chipselects =3D <0>;
+		sck-gpios =3D <&gpio 55 GPIO_ACTIVE_HIGH>;
+		miso-gpios =3D <&gpio 57 GPIO_ACTIVE_HIGH>;
+		mosi-gpios =3D <&gpio 58 GPIO_ACTIVE_HIGH>;
+	};
 };
=20
 &uart3 {
@@ -118,7 +129,7 @@ firmware-flash@0 {
 	};
 };
=20
-&ssp2 {
+&ec_input_spi {
 	status =3D "okay";
 	cs-gpios =3D <&gpio 56 GPIO_ACTIVE_LOW>;
=20
--=20
2.29.2

