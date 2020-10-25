Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE3D2980C1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 09:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768220AbgJYIOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 04:14:33 -0400
Received: from mailoutvs31.siol.net ([185.57.226.222]:46806 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732232AbgJYIO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 04:14:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3296D529E39;
        Sun, 25 Oct 2020 09:14:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aIRB7Go1sYw4; Sun, 25 Oct 2020 09:14:22 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E682152A0BE;
        Sun, 25 Oct 2020 09:14:21 +0100 (CET)
Received: from kista.localdomain (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A68F0529E39;
        Sun, 25 Oct 2020 09:14:21 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH] ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix ethernet node
Date:   Sun, 25 Oct 2020 09:19:49 +0100
Message-Id: <20201025081949.783443-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ethernet PHY on BananaPi M2 Ultra provides RX and TX delays. Fix
ethernet node to reflect that fact.

Fixes: c36fd5a48bd2 ("ARM: dts: sun8i: r40: bananapi-m2-ultra: Enable GMA=
C ethernet controller")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm=
/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 2fc62ef0cb3e..a6a1087a0c9b 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -129,7 +129,7 @@ &gmac {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&gmac_rgmii_pins>;
 	phy-handle =3D <&phy1>;
-	phy-mode =3D "rgmii";
+	phy-mode =3D "rgmii-id";
 	phy-supply =3D <&reg_dc1sw>;
 	status =3D "okay";
 };
--=20
2.29.1

