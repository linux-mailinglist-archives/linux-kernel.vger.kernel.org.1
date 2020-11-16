Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17C2B5278
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbgKPUZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:25:44 -0500
Received: from maynard.decadent.org.uk ([95.217.213.242]:52618 "EHLO
        maynard.decadent.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732478AbgKPUZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:25:44 -0500
X-Greylist: delayed 2043 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 15:25:43 EST
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1kekXL-00031O-8H; Mon, 16 Nov 2020 20:51:39 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1kekXK-0007aI-0S; Mon, 16 Nov 2020 19:51:38 +0000
Message-ID: <ef625c1e21c492be8c423730e45e90d92b1ae899.camel@decadent.org.uk>
Subject: Re: drivers/accessibility/speakup/serialio.c:48:19: warning:
 variable 'quot' set but not used
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 16 Nov 2020 19:51:23 +0000
In-Reply-To: <20201116190122.yslib3wicn45rbuo@function>
References: <202011160942.AmYkxiJv-lkp@intel.com>
         <20201116190122.yslib3wicn45rbuo@function>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-lNInYjliUYrP/BVGlU8T"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 88.96.1.126
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lNInYjliUYrP/BVGlU8T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-16 at 20:01 +0100, Samuel Thibault wrote:
> Hello Ben,
>=20
> A long time ago you added a dependency for speakup drivers on
> CONFIG_ISA, and you also added || COMPILE_TEST as an alternative.
>=20
> It seems that some platform portability tests then think they should
> be able to build it, even if they don't enable ISA, but then we are
> getting warnings, or even errors, depending on the compatibility macros
> in <asm/io.h> in the !ISA case (here, the parisc compatibility macros do
> not consume their parameter).
>=20
> Perhaps we should rather use
>=20
> depends on ISA || (X86 && COMPILE_TEST)
>=20
> ?
> so that we have compile testing on x86 only (where the inb/outb macros
> always behave fine) to avoid such issues on other archs?

That seems reasonable though unusual.

> Or we tell the architecture maintainers to fix their out macros into
> consuming their parameters?
[...]

It does seem odd for parisc to define the I/O functions this way.  I
don't know if it's really a bug.

Ben.

--=20
Ben Hutchings
Everything should be made as simple as possible, but not simpler.
                                                      - Albert Einstein



--=-lNInYjliUYrP/BVGlU8T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl+y2DsACgkQ57/I7JWG
EQkz+w//UfnbQDFWLWLce0U9xQUMBvXQhuN6tanVINl3C4BPgNWRJgT4dPTtZc2g
DZoD+7AgT2Tlckt7T4y26vFD0sRPzB1Y994t/xgLc6KTvFZRAQh+wAjLTHBSeLR8
CxBgVQvoVsgKuJvcb2hW/F6LHYu5sYjyMr0Xe9xEkq0YEMyO9ye6mtSSQBJjYuYS
LmdBkVgbcTF8SrM8ekf7ZzEA/CFkgv0KnpGMW4MVyQsjX9WnXFK/tE2rwxDeFmym
zab7OW0pfYvdlDlkmX/r+G1sK2/uT8PMDkLwXEEYU31a5b0aAJcev/Q8uEFHbZ14
shQxgY8VOlmujpX+W0RoK84v73Za/y16m7SolZbg0ECGkKz65QaoqlezXYZotD9l
YEujqTo2Fu8tw/5bJz7vvv4NBqU3Lkk70cjojjmDQeySMVQP6efHyoLDRqd/hwZh
BFmPQZrEKCT1xeu5iTElOibNhQcMYQV3VUi30S/asqywifmTcDqEgSoLB0RkF5KE
qB/J1V+VUe6c6tlCOg5BwAbFK9iYZBkfgI2bj7UcpCnvfNBnRk3zJ0uJwqeIHLnE
D2t1fFomvyIUy82GBwQuEkmvm64RJmiXpnr1j08bNgla/jG4QGf1wg0dFxuRNntQ
cycqRNq/ouBx6/mj2mv3nOaAfxLEiMru9/nDgid7bYgbxZB2Avw=
=lQdv
-----END PGP SIGNATURE-----

--=-lNInYjliUYrP/BVGlU8T--
