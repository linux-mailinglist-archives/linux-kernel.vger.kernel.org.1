Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A930B2FE060
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbhAUEG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:06:57 -0500
Received: from mail.v3.sk ([167.172.186.51]:43698 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727297AbhAUD6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:58:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C5A18E0AAB;
        Thu, 21 Jan 2021 03:37:44 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JQ8ncpXoGQjv; Thu, 21 Jan 2021 03:37:44 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 81207E0AA6;
        Thu, 21 Jan 2021 03:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wNyiNZfv35AC; Thu, 21 Jan 2021 03:37:44 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4ED8EE0AA9;
        Thu, 21 Jan 2021 03:37:44 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 09/12] ARM: dts: mmp3-dell-ariel: Add the embedded controller
Date:   Thu, 21 Jan 2021 04:41:27 +0100
Message-Id: <20210121034130.1381872-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121034130.1381872-1-lkundrak@v3.sk>
References: <20210121034130.1381872-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device node for the computer's embedded controller, responsible
for controlling the LEDs and system power.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3-dell-ariel.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/mmp3-dell-ariel.dts b/arch/arm/boot/dts/mm=
p3-dell-ariel.dts
index 53714cb0d171e..565cd0fadf3d3 100644
--- a/arch/arm/boot/dts/mmp3-dell-ariel.dts
+++ b/arch/arm/boot/dts/mmp3-dell-ariel.dts
@@ -95,6 +95,15 @@ &twsi3 {
=20
 &twsi4 {
 	status =3D "okay";
+
+	embedded-controller@58 {
+		compatible =3D "dell,wyse-ariel-ec", "ene,kb3930";
+		reg =3D <0x58>;
+		system-power-controller;
+
+		off-gpios =3D <&gpio 126 GPIO_ACTIVE_HIGH>,
+			    <&gpio 127 GPIO_ACTIVE_HIGH>;
+	};
 };
=20
 &ssp1 {
--=20
2.29.2

