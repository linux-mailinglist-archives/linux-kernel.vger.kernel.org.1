Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400B22C8BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgK3Rue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:50:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48232 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgK3Rud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:50:33 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AUHmp5b089033;
        Mon, 30 Nov 2020 11:48:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606758531;
        bh=CDMfYwJTEEpmraRLwLrOTZ6QOJKuNRPry5I3XVLN82Y=;
        h=Date:From:To:CC:Subject;
        b=ePa+4aHiZhpEVzShMPg/qJd0s6+LGa2smIW0uQtBFU8ES70xhcjFrxDF4MJMkLVUv
         nF104hTb5yTQVj6D/kDgNPwWxJiDt2NVl4gUBDF4ExDgHKPGfKNTt12rHec9pBeGCR
         6ynAkez1CFsDf3xt8/c9a+MetYwgHH+6kC9EgLRU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AUHmpAS088520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 11:48:51 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 30
 Nov 2020 11:48:50 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 30 Nov 2020 11:48:50 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AUHmoGC052653;
        Mon, 30 Nov 2020 11:48:50 -0600
Date:   Mon, 30 Nov 2020 11:48:50 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <t-kristo@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] arm64: TI K3 SoC configs changes for v5.11
Message-ID: <20201130174850.ni4sdyz3qp67j3sz@upstart>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4g2iotpgkw34fuo3"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4g2iotpgkw34fuo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Here is a config changes for TI K3 SoCs. This is needed for booting
the J721E board from an SD card.

I do have a follow up cleanup patch[1] once drivers/soc/ti merges are in,
which I think I will need to request later on.

[1] https://lore.kernel.org/linux-arm-kernel/20201112215438.31432-1-nm@ti.c=
om/

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git tags/ti-k3=
-config-for-v5.11

for you to fetch changes up to 6b133f475a97a0839f02e3c0b937886b9adc2933:

  arm64: defconfig: Enable GPIO and I2C configs for TI's J721e platform (20=
20-11-12 11:50:18 -0600)

----------------------------------------------------------------
ARM64 defconfig changes for TI K3 platforms for v5.11 merge window:

- GPIO and I2C for J721E SD card support to be functional

----------------------------------------------------------------
Faiz Abbas (1):
      arm64: defconfig: Enable GPIO and I2C configs for TI's J721e platform

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--4g2iotpgkw34fuo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAl/FMHsACgkQ3bWEnRc2
JJ1VqQ/9FllCYAB83WehU2D6WJaLFqxFTkX1ux7ZFk5igKT4J2shaDSGYp8D/Jwy
zUW4CEHmHLoAzk3+IxqlQZrDjDHw82DlvVp/fVH/jP61DudAtmjlENWifPOQORJf
ghj0vsdnJxBSGggUj/9G+inEwAxf4Xc4Ap9wNeQDjpvXJ8FVhKFK+MyANJ0PvHnB
vG/NO3jF2h5tt/H4RJkcximhUYJByfV+HabWMfHGbVoEGhXkd5Lnja0Y5dWVESIw
Hm21krtDHzetX3wyyUOLfMfLkITgYlbFGDeVgYHK2KOvLwodg0fpexX9MNP/DYJA
dNrHSB2K8f3LfBD1yWiou7f5AJRdiI8rFZPOQK4QdH3fCOkQoOsaUC6BeCx3f6dA
RJmicNZiSaueM5/kMlFgZKaG6QLCnHCC1B68GlIJOumqVyyHe9/p06nGTu+W0Ieu
KFUyvlPe4WJuV02R5RZUQUyXiCVaPXX/9lIofk1jq4JcjJvmAgJIGULVLaeZ333Q
fpS30bkUSOtEVQifASGF1nut8GN4uaVtNsXkWt1mW7r1jPqVFVKJ+ydI+OyJ54vd
WyIx5ZDFg+1cb6z1lOuPD/X4yo2GfMdRXVqKFowtwvSOVBAWDskQ5gRfBHJ83Uud
aB0CXD52JvOw6416hIo6+d++aKmK/4K+fYooOJi8Xr7TsGp1uJY=
=wI3K
-----END PGP SIGNATURE-----

--4g2iotpgkw34fuo3--
