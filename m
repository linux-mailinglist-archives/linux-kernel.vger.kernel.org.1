Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CAF1A6306
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 08:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgDMGYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 02:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgDMGYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:24:53 -0400
Received: from mail.siol.net (mailoutvs18.siol.net [185.57.226.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A79C0A3BE0;
        Sun, 12 Apr 2020 23:24:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 5C5E1522E4D;
        Mon, 13 Apr 2020 08:24:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8Np3a-S-7_aZ; Mon, 13 Apr 2020 08:24:53 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 1BC9C522E48;
        Mon, 13 Apr 2020 08:24:53 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id D8CA3522E4D;
        Mon, 13 Apr 2020 08:24:50 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 2/3] arm64: dts: allwinner: h6: orangepi: Disable OTG mode
Date:   Mon, 13 Apr 2020 08:24:32 +0200
Message-Id: <20200413062433.1145043-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200413062433.1145043-1-jernej.skrabec@siol.net>
References: <20200413062433.1145043-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As can be seen from OrangePi Lite 2 and One Plus schematics, VBUS pin on
USB OTG port is directly connected to 5 V power supply. This mean that
OTG port can safely operate only in host mode, even though these two
boards have ID pin connected.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index f1be3dd558ca..ebc120a9232f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -251,7 +251,12 @@ &uart0 {
 };
=20
 &usb2otg {
-	dr_mode =3D "otg";
+	/*
+	 * OrangePi Lite 2 and One Plus, where this DT is used, don't
+	 * have a controllable VBUS even though they do have an ID pin.
+	 * Using it as anything but a USB host is unsafe.
+	 */
+	dr_mode =3D "host";
 	status =3D "okay";
 };
=20
--=20
2.26.0

