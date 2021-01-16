Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870AB2F8D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 11:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbhAPKxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 05:53:17 -0500
Received: from mailoutvs45.siol.net ([185.57.226.236]:43746 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbhAPKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 05:53:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 116895209BC;
        Sat, 16 Jan 2021 11:52:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uUWNsPg60bF0; Sat, 16 Jan 2021 11:52:33 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C8719520C4D;
        Sat, 16 Jan 2021 11:52:33 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 473435209BC;
        Sat, 16 Jan 2021 11:52:33 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH] ARM: dts: sunxi: bananapi-m2-plus: Increase BT UART speed
Date:   Sat, 16 Jan 2021 11:52:28 +0100
Message-Id: <20210116105228.847073-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bluetooth module on BananaPi M2 Plus can also be used for streaming
audio. However, for that case higher UART speed is required.

Add a max-speed property.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boo=
t/dts/sunxi-bananapi-m2-plus.dtsi
index 8e5cb3b3fd68..7a6af54dd342 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
@@ -219,6 +219,7 @@ &uart1 {
=20
 	bluetooth {
 		compatible =3D "brcm,bcm43438-bt";
+		max-speed =3D <1500000>;
 		clocks =3D <&rtc 1>;
 		clock-names =3D "lpo";
 		vbat-supply =3D <&reg_vcc3v3>;
--=20
2.30.0

