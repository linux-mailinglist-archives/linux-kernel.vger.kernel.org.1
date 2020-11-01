Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6E2A1C8D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 08:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgKAHUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 02:20:42 -0500
Received: from mailoutvs22.siol.net ([185.57.226.213]:55588 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgKAHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 02:20:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 22F3C525A75;
        Sun,  1 Nov 2020 08:20:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VznvH_Pv3pk1; Sun,  1 Nov 2020 08:20:38 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id CDB69527B3B;
        Sun,  1 Nov 2020 08:20:38 +0100 (CET)
Received: from kista.localdomain (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 2BDA2525A75;
        Sun,  1 Nov 2020 08:20:38 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH] arm64: dts: allwinner: h6: orangepi-one-plus: Fix ethernet
Date:   Sun,  1 Nov 2020 08:26:09 +0100
Message-Id: <20201101072609.1681891-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RX/TX delay on OrangePi One Plus board is set on PHY. Reflect that in
ethernet node.

Fixes: 7ee32a17e0d6 ("arm64: dts: allwinner: h6: orangepi-one-plus: Enabl=
e ethernet")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index fceb298bfd53..29a081e72a9b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -27,7 +27,7 @@ reg_gmac_3v3: gmac-3v3 {
 &emac {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&ext_rgmii_pins>;
-	phy-mode =3D "rgmii";
+	phy-mode =3D "rgmii-id";
 	phy-handle =3D <&ext_rgmii_phy>;
 	phy-supply =3D <&reg_gmac_3v3>;
 	allwinner,rx-delay-ps =3D <200>;
--=20
2.29.2

