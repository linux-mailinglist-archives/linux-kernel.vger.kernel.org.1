Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDBE2964E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369779AbgJVSxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:53:21 -0400
Received: from mailoutvs46.siol.net ([185.57.226.237]:56871 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S368261AbgJVSxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:53:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A66DD528530;
        Thu, 22 Oct 2020 20:53:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ivWpOrxbe1hZ; Thu, 22 Oct 2020 20:53:17 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 5ADFE528565;
        Thu, 22 Oct 2020 20:53:17 +0200 (CEST)
Received: from kista.localdomain (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A9CFB528530;
        Thu, 22 Oct 2020 20:53:15 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH] arm64: dts: allwinner: a64: OrangePi Win: Fix ethernet node
Date:   Thu, 22 Oct 2020 20:58:39 +0200
Message-Id: <20201022185839.2779245-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RX/TX delay on OrangePi Win board is set on PHY. Reflect that in
ethernet node.

Fixes: 93d6a27cfcc0 ("arm64: dts: allwinner: a64: Orange Pi Win: Add Ethe=
rnet node")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index d894ec5fa8a1..70e31743f0ba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -120,7 +120,7 @@ &ehci1 {
 &emac {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&rgmii_pins>;
-	phy-mode =3D "rgmii";
+	phy-mode =3D "rgmii-id";
 	phy-handle =3D <&ext_rgmii_phy>;
 	phy-supply =3D <&reg_gmac_3v3>;
 	status =3D "okay";
--=20
2.29.0

