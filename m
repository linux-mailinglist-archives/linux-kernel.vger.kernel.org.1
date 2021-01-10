Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B98C2F09CC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 22:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbhAJVQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 16:16:55 -0500
Received: from mailoutvs35.siol.net ([185.57.226.226]:46142 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726432AbhAJVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 16:16:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 90C3C521798;
        Sun, 10 Jan 2021 22:16:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Pcl9tw4YCoIO; Sun, 10 Jan 2021 22:16:12 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 507F05218D9;
        Sun, 10 Jan 2021 22:16:12 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 0A881521798;
        Sun, 10 Jan 2021 22:16:11 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH] arm64: dts: allwinner: h6: PineH64 model B: Add bluetooth
Date:   Sun, 10 Jan 2021 22:16:06 +0100
Message-Id: <20210110211606.3733056-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PineH64 model B has wifi+bt combo module. Wifi is already supported, so
lets add also bluetooth node.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../dts/allwinner/sun50i-h6-pine-h64-model-b.dts  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts=
 b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
index 7fea1e4e2d49..645bd8761eb5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
@@ -34,3 +34,18 @@ &mmc1 {
 	non-removable;
 	status =3D "okay";
 };
+
+&uart1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status =3D "okay";
+
+	bluetooth {
+		compatible =3D "realtek,rtl8723bs-bt";
+		device-wakeup-gpios =3D <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
+		host-wakeup-gpios =3D <&r_pio 1 1 GPIO_ACTIVE_HIGH>; /* PM1 */
+		enable-gpios =3D <&r_pio 1 4 GPIO_ACTIVE_HIGH>; /* PM4 */
+		max-speed =3D <1500000>;
+	};
+};
--=20
2.30.0

