Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308482FE200
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAUFsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:48:05 -0500
Received: from mail.v3.sk ([167.172.186.51]:43214 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbhAUDmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:42:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4E37FE0AA4;
        Thu, 21 Jan 2021 03:37:41 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HsLto3Ueifax; Thu, 21 Jan 2021 03:37:41 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0DF9CE0A82;
        Thu, 21 Jan 2021 03:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1CLtL-kJSw_c; Thu, 21 Jan 2021 03:37:40 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CEB8BE0AA5;
        Thu, 21 Jan 2021 03:37:40 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 04/12] ARM: dts: mmp2-olpc-xo-1-75: Drop linux,usable-memory from /memory
Date:   Thu, 21 Jan 2021 04:41:22 +0100
Message-Id: <20210121034130.1381872-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121034130.1381872-1-lkundrak@v3.sk>
References: <20210121034130.1381872-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the linux,usable-memory properties; the schema is unhappy about
them:

  mmp2-olpc-xo-1-75.dt.yaml: /: memory: False schema does not allow
  {'linux,usable-memory': [[0, 528482304]],
   'available': [[847872, 519245824, 4096, 782336]],
   'reg': [[0, 536870912]], 'device_type': ['memory']}

They've been cargo-culted from Open Firmware and I don't know what
purpose they serve. Perhaps they are meant to provide the OFW runtime.
In that case it's still okay to drop them from here; OFW is welcome to ad=
d
it upon boot.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/=
mmp2-olpc-xo-1-75.dts
index e16171ddd93ec..0f8b5ad48deed 100644
--- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
+++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
@@ -33,7 +33,6 @@ framebuffer@1fc00000 {
 	};
=20
 	memory@0 {
-		linux,usable-memory =3D <0x0 0x1f800000>;
 		available =3D <0xcf000 0x1ef31000 0x1000 0xbf000>;
 		reg =3D <0x0 0x20000000>;
 		device_type =3D "memory";
--=20
2.29.2

