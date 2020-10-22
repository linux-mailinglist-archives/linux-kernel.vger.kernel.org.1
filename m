Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8732829665F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 23:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372154AbgJVVHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 17:07:41 -0400
Received: from mailoutvs19.siol.net ([185.57.226.210]:45593 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2897417AbgJVVHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:07:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id C5EAC528DCB;
        Thu, 22 Oct 2020 23:07:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wCk7ODnrwXeu; Thu, 22 Oct 2020 23:07:37 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 83103528785;
        Thu, 22 Oct 2020 23:07:37 +0200 (CEST)
Received: from kista.localdomain (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 39ABA528DCB;
        Thu, 22 Oct 2020 23:07:37 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH] arm64: dts: allwinner: a64: Pine64 Plus: Fix ethernet node
Date:   Thu, 22 Oct 2020 23:13:01 +0200
Message-Id: <20201022211301.3548422-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to board schematic, PHY provides both, RX and TX delays.
However, according to "fix" Realtek provided for this board, only TX
delay should be provided by PHY.
Tests show that both variants work but TX only PHY delay works
slightly better.

Update ethernet node to reflect the fact that PHY provides TX delay.

Fixes: 94f442886711 ("arm64: dts: allwinner: A64: Restore EMAC changes")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts b/a=
rch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
index b26181cf9095..b54099b654c8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
@@ -13,7 +13,7 @@ / {
 &emac {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&rgmii_pins>;
-	phy-mode =3D "rgmii";
+	phy-mode =3D "rgmii-txid";
 	phy-handle =3D <&ext_rgmii_phy>;
 	status =3D "okay";
 };
--=20
2.29.0

