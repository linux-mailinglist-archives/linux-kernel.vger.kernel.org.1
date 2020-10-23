Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581642977CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbgJWTnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:43:39 -0400
Received: from mailoutvs27.siol.net ([185.57.226.218]:45136 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754479AbgJWTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:43:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 126DA528120;
        Fri, 23 Oct 2020 21:43:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rEXZf2IX2IaY; Fri, 23 Oct 2020 21:43:35 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C4F7052818E;
        Fri, 23 Oct 2020 21:43:35 +0200 (CEST)
Received: from kista.localdomain (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 52CA9528176;
        Fri, 23 Oct 2020 21:43:35 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH] arm64: dts: allwinner: h6: Pine H64: Fix ethernet node
Date:   Fri, 23 Oct 2020 21:49:02 +0200
Message-Id: <20201023194902.368239-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ethernet PHY provides RX and TX delay on both models, A and B. Although
schematic for model A suggests only TX delay, network never worked with
such configuration.

Fix ethernet node to reflect PHY delays.

Fixes: 729e1ffcf47e ("arm64: allwinner: h6: add support for the Ethernet =
on Pine H64")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index af85b2074867..961732c52aa0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -100,7 +100,7 @@ &ehci3 {
 &emac {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&ext_rgmii_pins>;
-	phy-mode =3D "rgmii";
+	phy-mode =3D "rgmii-id";
 	phy-handle =3D <&ext_rgmii_phy>;
 	phy-supply =3D <&reg_gmac_3v3>;
 	allwinner,rx-delay-ps =3D <200>;
--=20
2.29.0

