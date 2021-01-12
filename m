Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486F72F37CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbhALSA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:00:56 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:59914 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbhALSAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:00:55 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E6B451C0B8B; Tue, 12 Jan 2021 18:59:58 +0100 (CET)
Date:   Tue, 12 Jan 2021 18:59:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, masahiroy@kernel.org,
        rmk+kernel@armlinux.org.uk
Subject: 5.11-rc3: build error in arm/boot/compressed/.../fdt_ro.c
Message-ID: <20210112175958.GA7444@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I can't build for 32-bit arm:

  CC      arch/arm/boot/compressed/fdt_wip.o
In file included from arch/arm/boot/compressed/../../../../lib/fdt_ro.c:2,
                 from arch/arm/boot/compressed/fdt_ro.c:2:
arch/arm/boot/compressed/../../../../lib/../scripts/dtc/libfdt/fdt_ro.c: In=
 function =E2=80=98fdt_generate_phandle=E2=80=99:
arch/arm/boot/compressed/../../../../lib/../scripts/dtc/libfdt/fdt_ro.c:151=
:13: error: =E2=80=98FDT_MAX_PHANDLE=E2=80=99 undeclared (first use in this=
 function); did you mean =E2=80=98FDT_MAX_NCELLS=E2=80=99?
  if (max =3D=3D FDT_MAX_PHANDLE)
             ^~~~~~~~~~~~~~~
             FDT_MAX_NCELLS
arch/arm/boot/compressed/../../../../lib/../scripts/dtc/libfdt/fdt_ro.c:151=
:13: note: each undeclared identifier is reported only once for each functi=
on it appears in
arch/arm/boot/compressed/../../../../lib/../scripts/dtc/libfdt/fdt_ro.c: In=
 function =E2=80=98fdt_get_mem_rsv=E2=80=99:
arch/arm/boot/compressed/../../../../lib/../scripts/dtc/libfdt/fdt_ro.c:184=
:13: error: implicit declaration of function =E2=80=98fdt64_ld=E2=80=99 [-W=
error=3Dimplicit-function-declaration]
  *address =3D fdt64_ld(&re->address);
             ^~~~~~~~
arch/arm/boot/compressed/../../../../lib/../scripts/dtc/libfdt/fdt_ro.c: In=
 function =E2=80=98fdt_get_property_by_offset_=E2=80=99:
arch/arm/boot/compressed/../../../../lib/../scripts/dtc/libfdt/fdt_ro.c:373=
:11: error: implicit declaration of function =E2=80=98fdt32_ld=E2=80=99 [-W=
error=3Dimplicit-function-declaration]
   *lenp =3D fdt32_ld(&prop->len);
           ^~~~~~~~
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:279: arch/arm/boot/compressed/fdt_ro.o=
] Error 1

Ideas?

Best regards,
						Pavel
--=20
http://www.livejournal.com/~pavelmachek

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/3jngAKCRAw5/Bqldv6
8g99AKCvD+iOyBcuMwDccBHrs3/LihOY/wCfe2OmmcYd+Pcj4en/uaK5ho4Ojc4=
=2XaH
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
