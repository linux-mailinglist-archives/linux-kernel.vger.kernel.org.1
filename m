Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E052F8A40
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 02:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbhAPBLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 20:11:06 -0500
Received: from mout.gmx.net ([212.227.15.18]:58265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbhAPBLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 20:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610759369;
        bh=6Klx+LARlH5Cs/YxTUDW1nPNa3j7+K+6thHFi7p4CDc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=F04wAek49VGqeiKnYAJTG9v4WihCEv06/nCziCFbc9aohHp4wGSu39BIjW6N0HSiB
         J6SsEi6hrLTaNEsyCtDlpDIkKpHENnQiW9AAM9xn21IExCQZCslKyu1+ovt0DHDNnL
         ltQUGaIFkGoboDKfF3q9wWuh7QrbIuoRfsIFZQBQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1m6NH90msc-016vrH; Sat, 16
 Jan 2021 02:09:29 +0100
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
Subject: [PATCH v2 2/2] ARM: dts: Add board-specific compatible string to npcm750-evb devicetree
Date:   Sat, 16 Jan 2021 02:09:06 +0100
Message-Id: <20210116010907.3475405-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210116010907.3475405-1-j.neuschaefer@gmx.net>
References: <20210116010907.3475405-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8rNNa3QIKUy2rcCEKxnb986WyN5l+vtqixISTwjiUhIp0yuKC08
 hsMYUimN/HrhIiUmhMEC0UjWyzDgLYLQyd3fPx/cBytF7pS9It4/Ir0uVOfzVEg4ZwF9mhX
 ujeo2IWy2IEeNw+OavJR81FEi3amVMW4C1tf3mvuQiHeZ0/yJK5Wlj4fFOZlreOeqtltrBK
 7P1QhI7z12+ZgbD0UIafw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:azurBNzh7rQ=:vfMBbkxcD0AuNM3BKSTFUK
 J6+Ws4mHnb9rZhKMNxm+dBMVdg4G8Ik3aRaCUghMXCMWvRb1tJiahSlmqOc97Kyy2fSzg3vuk
 EIEQoXhG01dp6zNnvTaLjEML1FcUp3lJk3WH0o0Z6To8LmTSlxFXD7+sU7IfuHxqC74O0NQtI
 cch5Cd6AXqJbsXg8SWuSd03w7taTXX+bA+jxElpz/a70EETUgv54m2LAJphftbUYuIIYeT1CE
 aBJItQ7nyzCVPg4oEII+RHJ0O4lBDHiLMBQ4KzYTvkiG1Vaiat5WFX53PA96Y1+Ta7CrBB4z9
 sjgdAywrYU7KIE5KEDrssz9RNPeSpYAQcxGnZYvjrQ8wY27ZYhMyPIb5hZgAf8YzJc3vPkzgV
 FvalpOEynxoC5vpWmdbeE2z+NIpgjuGPBoYEPiPfc4JKAtFNqxMEPlynUHcL6XK22L2M/soQE
 bNfXf315Z3SDjrAkFZwjWHfKMpXNvtVq2/xhATSdNNRmCnuGUPksNEsQfl4kztkigUINPWnIB
 C9TjZysr6e73HwHYteb1dPap0JqxsY5O6tWfqL62ddm+DrPmI6Ef806xI5zeVf0Dwf+OcmVj/
 UMrogLTVjDv7CSDR0QctLCXQkcDvjYGHaSaKXxjsuYgFqdJRYa+JwDO9adF4ABg0+66RYPV6N
 OcPHToRVflTFzroKOUFDwvVgI72z8IXadEnR+s/8XK4mMbCTA7CzF28F7acEK3c7dBx+pLuDl
 6S5GbBJzutmmpVePLMeG3RJkvwD+LuYxNdrx3kryxM0/rs17eIuBOy01aPtReYSX+F3Xq+jlv
 D4q+h7uMt7LAkJVf+35ZZP/QwhgYEjhHBYZ0mT1UW8irONzf2DZohmFdGjhUHkAHnOxI4auIe
 KzgklZRvDO6HhWer1ksQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the revised binding, the devicetree needs a board-specific
compatible string.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- no changes
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

