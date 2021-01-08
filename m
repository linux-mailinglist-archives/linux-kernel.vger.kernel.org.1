Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C503C2EFB46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbhAHWl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:41:58 -0500
Received: from mout.gmx.net ([212.227.15.15]:47547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbhAHWl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610145621;
        bh=zoPbxKl7/h63Lb9FVRa59Ce+siBolFFjisZwdmEdKTM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UzFum2fGUDHoGZoFso450mnTY/alpDyBq3w47ne4HC8CI825F6TSqT5UwpNeRygUL
         1XJ7IjQ9m282trM0VDWCzPpRe/ik8jvUJ6QXJ5LHoFMgmSSrifCrZd2NDOvA32zApo
         yAuZc5i4+PwGsGF6vKcNfdktH+TM8oOi7S8ECqzQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO6M-1k9HTh0jKi-00okPe; Fri, 08
 Jan 2021 23:40:21 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: Add board-specific compatible string to npcm750-evb devicetree
Date:   Fri,  8 Jan 2021 23:40:07 +0100
Message-Id: <20210108224008.705687-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108224008.705687-1-j.neuschaefer@gmx.net>
References: <20210108224008.705687-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BhfwAak8K6CjNf+mZXSVTbn7VQ7sg+KrjOvjneGvzbDUST8rpwy
 ICs1qJJHjO+5CopzxrfyT/AhGBBtjE8BTzm2GqBOt7Tvd6bgZ70Dx4nP6Wr+Epghln7fRI9
 nLTLyKpdakNxCyAC7OBkJyjROdkv5lq+HQZ56hjN04caCEUNAHVwiaBVCEz2ND783Aqgn0g
 vbS340YVp0ihxUpbhSpww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NoMWTY70s50=:lHz2McS2sj8PnBtG1DnL7r
 E13SqSfiCJ35zDFvTEd8sZG1Z1ruXBIz2LdJzVJEvHXGRt3njloPegEha1SncHuLfM5JC+rsk
 jdd0brladGXztdECekFtaTPUdl6uIcFPluVtvKhbEjuo2HpB5SggC9XVH3KB7U9wZk9Og7z0n
 uUln4oiT3pEQ0NIPJVXYTalMM4m3hb7CETQv+6Par1CxhYUfJb4VMEYL8evr/CTFtbKWKc9sD
 8E/PQyTGzV1cdTyra4oXn19b/t/dJEKmzifEIZkkJcqUIauZEhuAlwqA37A6ItaWWa/t6aaOD
 20PCQD39o/pZBnrOFrEHEAYP/d/NXxl4308n0Wm69KTKjxwPZsaJihiVzF02/9XrL08b14Xt8
 jgiKerij3tkx8404FWC1eMsjsOTX5y05PHejMAgyvkWVBG1qhsIo0jWvLlJuOECjUl7kPN2nr
 Z0kwFy4oyV836UjkvvRKLCpC8/cyj5hZpx5oPImIRje6AdvRifS67zpV4J27IvyFXEq9p54Tb
 /TjwB45Wzjhy1VlOCmyuwDRuvKs07rqDSmVoOIh33RZS72zIMFYh7Yw1FpnLSMphbHxhGi7dK
 lg6gF2FIpk96iAGP3jRkYjh4hD8pWx7dVK/KBp79Yvdu6ggnm1b1TQenXz5Ts37sMlQ1v1RXL
 NCeRssIcYg7CKmqApcS50h0eAZdbjXopeIqZftIDpr0ytTcZJyPbvlv2n9a721u0KaSnYZ9jv
 ZT5IHVggY1CuJmdt+E/tsdKflzbwoQioc2geFGA4j5TkBohhEx4BDDVz61jlR4eUnsTBb2NEy
 x01qLHei3zaDe9TFLhQFZb+8l1t/Yhh06qGwOpYvNbLIxL9kpcQUTgBy7C3BHyaqM0DBqyQuh
 K204ho3PGmagv2qq3y8w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the revised binding, the devicetree needs a board-specific
compatible string.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts=
/nuvoton-npcm750-evb.dts
index 9f13d08f5804e..dea3dbc4a6a52 100644
=2D-- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -9,7 +9,7 @@

 / {
 	model =3D "Nuvoton npcm750 Development Board (Device Tree)";
-	compatible =3D "nuvoton,npcm750";
+	compatible =3D "nuvoton,npcm750-evb", "nuvoton,npcm750";

 	aliases {
 		ethernet2 =3D &gmac0;
=2D-
2.29.2

