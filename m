Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D171129F5E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgJ2UKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:10:12 -0400
Received: from mailoutvs5.siol.net ([185.57.226.196]:41995 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbgJ2UKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:10:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 5D2DE528C64;
        Thu, 29 Oct 2020 21:10:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zEaBtmw8iYhp; Thu, 29 Oct 2020 21:10:09 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 10BCD528C81;
        Thu, 29 Oct 2020 21:10:09 +0100 (CET)
Received: from kista.localdomain (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 153F6528C64;
        Thu, 29 Oct 2020 21:10:08 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH] arm64: dts: allwinner: h6: PineH64 model B: Add wifi
Date:   Thu, 29 Oct 2020 21:15:37 +0100
Message-Id: <20201029201537.598182-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PineH64 model B contains RTL8723CS wifi+bt combo module.

Since bluetooth support is not yet squared away, only wifi is enabled
for now.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../dts/allwinner/sun50i-h6-pine-h64-model-b.dts   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts=
 b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
index f4c8966a6497..3f42b8b29b0f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
@@ -10,6 +10,12 @@ / {
 	compatible =3D "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
=20
 	/delete-node/ reg_gmac_3v3;
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible =3D "mmc-pwrseq-simple";
+		reset-gpios =3D <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
+		post-power-on-delay-ms =3D <200>;
+	};
 };
=20
 &hdmi_connector {
@@ -19,3 +25,11 @@ &hdmi_connector {
 &emac {
 	phy-supply =3D <&reg_aldo2>;
 };
+
+&mmc1 {
+	vmmc-supply =3D <&reg_cldo3>;
+	mmc-pwrseq =3D <&wifi_pwrseq>;
+	bus-width =3D <4>;
+	non-removable;
+	status =3D "okay";
+};
--=20
2.29.1

