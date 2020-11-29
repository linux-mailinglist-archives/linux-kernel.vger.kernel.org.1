Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179FA2C7B06
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgK2TrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 14:47:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:48061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgK2TrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 14:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606679120;
        bh=B1gWZjO1WZp93FvmWsTeHivkoj+0BuTfZ61WG52Bosc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Nq2IlrzJtbcaXEiKpsNbH7fpFs3wXbixJRhkYmERfKQ7Azda+VfZ56BxszHEWo2dO
         32BT8bzmwLJpKggiwsKdicwgHmiv8XKvokGDXGeSV68eO7WxAji3de7M1h7RkawWXV
         t2lKruHDO92gW+aqZHc18YUGrHwvKJXBScmEa5LE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from workstation5.fritz.box ([62.143.246.89]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N5VDE-1k7FGH3LBK-016z78; Sun, 29 Nov 2020 20:45:19 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Willy Liu <willy.liu@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] arm64: dts: allwinner: H5: NanoPi Neo Plus2: phy-mode rgmii-id
Date:   Sun, 29 Nov 2020 20:45:12 +0100
Message-Id: <20201129194512.1475586-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sLOZhow4UP9JKXTVtG54uxROKqtEiWpb7CSfUW6pC5FOP9r2WUH
 C9QyvU6iCrG72uuTd2+YC+D244LtXosfFlRQP9nf6JpjOQEOs0IcEW1E3+uZu06Pdu1USgt
 oV0XRr8MbkigVcE+V78kwfd4X/xBtLSK/PLIGzVy3Pua45/VftN5MOpTbEgBxvynpWbQeLN
 Hcsp/4kciXFQc0VwlRP0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BPDO18DTlrQ=:fqA7da4jXOmDidFjoB1g4g
 oLit97BYMMSwPTOMC36MzJicFzgyS7GfqCYC+Qwk9IcgotFYqYjf3REHBHW1OJj4+ldiwdUwg
 J75p6OlxhUNhwlOBklxPqIEMGbHzFPNcnaMCWy8Zh8TRsFWBKW7eY/F+evr2Fy48vhTnvW7Z3
 5yHtpIUNzbD2xOFhtKm2XMAw1D0GfmcrXkJevnCFhRWDDeow4hvEx6KoFL0VagKC94hZ3uMFs
 CPNt8uJHVEBjl/Y7XZCmXfenFFdMxTWRivLRMQkjObGZJ0leXjcjOIbLZhci+Q0/0oPMDmufQ
 TWDAB8/Db9JI3h/yb3SXsRVBSG+xqiLAYdxr6NxYgFHF1HVwOtYRoCvGqqYw9IInYW12b5bJG
 +fYcA9m7l9pTbfI/GlWgRVGrgnj2PiHmMb2E+1VDlR4oLKA14ZXvejUdyhYNBcSb+B4Tjnd9Q
 VU4BnQidunOKWXPme/VsWu+hrs2THZifA707+RhT1afyDLopPp38VN6i95kksC/Q0j4nDpu7X
 i6wzyb/jVtIZEtX4eb91sIJnmCbK7lgCPjbhqu3SI12klYn4L8Lq1OjDrDqrSKB6DV4l24mci
 IeqUbjVFyTn06P8hPfncavsYT+qXVZjousNQbPSOugAsy0hAkXO3DDp8UuETFXyXUwXYrufTb
 o38FPhWaBo0v0T/fO7eLvbdG5dG0zBxGvcpbTEK++YMCF+/LlK9E16GQnC8JbZ40S9fVjQ9bl
 0a63uDmH9Voq4zgykiiLVJlW5u8n3U0u6kgqH6ffd2KdtBIRvULVqA9KlznTL3JArire3WzCu
 ohF8lL/qIufsvnrweup14QHNNO1uKpPvHuO1bdRX22GRShrT5eDBCG0n2pz02NW6DiSSVdPwb
 x5AMqoCjrUUZ+WopWhLw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx
delay config") network is broken on the NanoPi Neo Plus2.

This patch changes the phy-mode to use internal delays both for RX and TX
as has been done for other boards affected by the same commit.

Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts =
b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 4f9ba53ffaae..9d93fe153689 100644
=2D-- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -96,7 +96,7 @@ &emac {
 	pinctrl-0 =3D <&emac_rgmii_pins>;
 	phy-supply =3D <&reg_gmac_3v3>;
 	phy-handle =3D <&ext_rgmii_phy>;
-	phy-mode =3D "rgmii";
+	phy-mode =3D "rgmii-id";
 	status =3D "okay";
 };

=2D-
2.29.2

