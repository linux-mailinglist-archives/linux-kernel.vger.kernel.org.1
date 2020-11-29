Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62F82C79FC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgK2Q3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:29:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:45949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgK2Q3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606667218;
        bh=ZdaS61ocSCTccgRlrvrlpB5FIH+3x7hg7zRIPHr6i34=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MnFPXGPw2vku/BUV5OlPe3tvjko03/nSX6Y9E0lA/HPPZRuXPMRb7r7xNPJYKLUED
         W7901hcYRBpMm/pLaniWoKE/QrVLD6tNQ+t8f4Nd32QTFAEgRu4sB/xOrlVZJM6w3J
         wLRLW9gcz3YWbHPqgaObrbNDWv2HqB7qYJDVDVvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from workstation5.fritz.box ([62.143.246.89]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Md6Qr-1k9FNB2fnH-00aD7G; Sun, 29 Nov 2020 17:26:58 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Willy Liu <willy.liu@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] arm64: dts: allwinner: A64 Sopine: phy-mode rgmii-id
Date:   Sun, 29 Nov 2020 17:26:27 +0100
Message-Id: <20201129162627.1244808-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SJLhc46VH/ADt0FelGIyVaiGRm2u274NfG2HIcI30sp4zMt0BoT
 NiUittyROSYnJO4ezFL9Zy3hpfNvULKc7uxbUFJ6nbLuBrBz7y4gL0XthVB9rhMCS0v5A+v
 HXFhg4Ml9plzM6fhDk8XSt9jiByaEYAXFbap1KXsZOslnV1Uh4nAxUT9m57lrb5EEqE1yHV
 uJ+0ooQSlIQyqcL0u5YKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I7nSpszWH+4=:f6RrG4/NKlDOKioxewIwUa
 XGLnOoUZkXKcb/KSsmV3tRydVDLllCr9Jqh368TOehshj3SpnpoY6k4PQvc9zZVY/LhwCDqvB
 5yNbQou9DrKPp1Q8F7KL1YZvjtETyh0LEiqK+ea/SWUb/bOgEdRvtNcFWZThLEin2J7fp1h9T
 8Mz62hNM9LAm/5G5wSTXVru8eMAJALGdnrTjRlIlij9worNJWe9Dcn3iFYIomzLGqFGEdrhsn
 +UjB9WusuwORp7XTLP3z9nL5H0Rkf5NKO9k2ODXfsXAmn/6s6HaOUJEgG5QrgSGAy0f7BRJWU
 OAMs2XCH9vdOGTELYfQTOt4uUk2+t6cQKh5hglzSkO6iqbgLAKYfiAVg5f1LpRQpxwjxj3elR
 IvNA54L0a4YLfXvEJ+Mym2Av+0tnOUw3RGz+OrTPHkeihoH8NFFclEP8mxosPvPpjTNR9c82C
 LUBRH6QIMpOlZFBQc7r5RaKH1NOcIJhFBZpaTUVE9wgYy8a5N1PhEKCXY2F94iIUJS6+xIKHp
 YD1hz6YdiAPGBhA8SDJAsgJrFUIxrJSNLCal937INnvFYMxWrLBA86kTLW7CoXER4c8cXAIC6
 m9knTCvyQW6gCytJPnvvaF7nqt3s2xG2SYUiqQCbpg8fup7/EKDMcpjjfWncojkJx+f9xMxHJ
 PgeyzoX4ru07njyddiXHFAD09EpVmyXIgwgZxDQs9oXKA8Rw/m5Ow4ntffD1So71w5VohpQUw
 PEIXFSfL02fxQSO8PmtdA8+pxedzhRBoZncH88FlIurebddv+RA5TKYgwG4QpfRxi3SF6DAR9
 wtGGmcnUHiLqw+aKe9m1ivzSogFZd7q05FN3awGuTeZ4YWZE77RLUWpebNXOZARwSYNnLexKb
 Ow138hjz+V1NDtUXU50A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx
delay config") iSCSI booting fails on the Pine A64 LTS.

This patch changes the phy-mode to use internal delays both for RX and TX
as has been done for other boards affected by the same commit.

Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts=
 b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 9ebb9e07fae3..d4069749d721 100644
=2D-- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -79,7 +79,7 @@ &ehci1 {
 &emac {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&rgmii_pins>;
-	phy-mode =3D "rgmii";
+	phy-mode =3D "rgmii-id";
 	phy-handle =3D <&ext_rgmii_phy>;
 	phy-supply =3D <&reg_dc1sw>;
 	status =3D "okay";
=2D-
2.29.2

