Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631A22A0A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgJ3Po0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:44:26 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39528 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgJ3Po0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:44:26 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CN67B72Fjz1qs0P;
        Fri, 30 Oct 2020 16:44:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CN67B649sz1qv52;
        Fri, 30 Oct 2020 16:44:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ZGZQQ6uWxFJ6; Fri, 30 Oct 2020 16:44:21 +0100 (CET)
X-Auth-Info: oCko4kOVV9bSFGSiWx9nh6Yq9889MkbD8f+dbL7NnSM=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 30 Oct 2020 16:44:21 +0100 (CET)
Date:   Fri, 30 Oct 2020 16:43:37 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME
 support plans in Linux time namespaces
Message-ID: <20201030164337.347fe961@jawa>
In-Reply-To: <871rhfoo7z.fsf@nanos.tec.linutronix.de>
References: <20201030110229.43f0773b@jawa>
        <871rhfoo7z.fsf@nanos.tec.linutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/_jqYRZN8T2/HbbtXNFCRlTS"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_jqYRZN8T2/HbbtXNFCRlTS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

> Lukasz,
>=20
> On Fri, Oct 30 2020 at 11:02, Lukasz Majewski wrote:
> > I do have a question regarding the Linux time namespaces in respect
> > of adding support for virtualizing the CLOCK_REALTIME.
> >
> > According to patch description [1] and time_namespaces documentation
> > [2] the CLOCK_REALTIME is not supported (for now?) to avoid
> > complexity and overhead in the kernel.
> >
> > Is there any plan to add support for it in a near future? =20
>=20
> Not really. Just having an offset on clock realtime would be incorrect
> in a number of ways. Doing it correct is a massive trainwreck.
>=20
> For a debug aid, which is what you are looking for, the correctness
> would not really matter, but providing that is a really slippery
> slope.
>=20
> If at all we could hide it under a debug option which depends on
> CONFIG_BROKEN and emitting a big fat warning in dmesg with a clear
> statement that it _is_ broken, stays so forever and any attempt to
> "fix" it results in a permanent ban from all kernel lists.
>=20
> Preferrably we don't go there.

I see. Thanks for the explanation.

Now, I do use QEMU to emulate ARM 32 bit system with recent kernel
(5.1+). It works.=20

Another option would be to give a shoot to QEMU with the "user mode" to
run cross-compiled tests (with using a cross-compiled glibc in earlier
CI stage). The problem with above is the reliance on QEMU emulation of
ARM syscalls (and if 64 bit time supporting syscalls - i.e.
clock_settime64 - are available).

>=20
> Thanks,
>=20
>         tglx
>=20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/_jqYRZN8T2/HbbtXNFCRlTS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl+cNKkACgkQAR8vZIA0
zr1kdQgAxMpyJHLr7oWeB34cpyPU5D+gz+HgLKq4LZS/Tf7xMe4aZuwmPAti5FCn
Nxu9Mv3r5j/g33jV8ZD0GJih+/Bey+5HYk3veAnLsJ78j3mERFT6z77erMMqDC0T
Yl1BxjbIpFWRm5342R1o6EUoGmxGFRkWESPr/GXpNdFJZDSHUcb+MRDrtykzQZic
ImQbZ51jg51gRkdfWme+0fcx1+J4nX/9QnClW2vRFR6hKK21vtsPxfzS+x/jANyZ
e/YpF8wSgVwQHFwaZikW3mlJQHJMkkyTBcETFsWlca+2IS0fTE4kAq3g7y+hUFAz
I8scySUJAxMivKdyQkuSktPm2TyPQg==
=YQGD
-----END PGP SIGNATURE-----

--Sig_/_jqYRZN8T2/HbbtXNFCRlTS--
