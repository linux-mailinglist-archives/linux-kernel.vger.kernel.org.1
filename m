Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751A4279510
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgIYXsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:48:19 -0400
Received: from mail.v3.sk ([167.172.186.51]:37922 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729729AbgIYXsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:48:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0BA08DFAA4;
        Fri, 25 Sep 2020 23:46:33 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tbbmJsb1OB3I; Fri, 25 Sep 2020 23:46:32 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8A98ADFA9E;
        Fri, 25 Sep 2020 23:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zS0_M9PEKX2e; Fri, 25 Sep 2020 23:46:32 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9DBF1DFAA2;
        Fri, 25 Sep 2020 23:46:31 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] ARM: dts: mmp2-olpc-xo-1-75: Use plural form of "-gpios"
Date:   Sat, 26 Sep 2020 01:48:05 +0200
Message-Id: <20200925234805.228251-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925234805.228251-1-lkundrak@v3.sk>
References: <20200925234805.228251-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes validation happier.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/=
mmp2-olpc-xo-1-75.dts
index f1a41152e9dd7..adde62d6fce73 100644
--- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
+++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
@@ -227,12 +227,12 @@ &ssp3 {
 	/delete-property/ #size-cells;
 	spi-slave;
 	status =3D "okay";
-	ready-gpio =3D <&gpio 125 GPIO_ACTIVE_HIGH>;
+	ready-gpios =3D <&gpio 125 GPIO_ACTIVE_HIGH>;
=20
 	slave {
 		compatible =3D "olpc,xo1.75-ec";
 		spi-cpha;
-		cmd-gpio =3D <&gpio 155 GPIO_ACTIVE_HIGH>;
+		cmd-gpios =3D <&gpio 155 GPIO_ACTIVE_HIGH>;
 	};
 };
=20
--=20
2.26.2

