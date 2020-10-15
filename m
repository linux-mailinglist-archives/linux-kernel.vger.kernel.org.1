Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C3328FA17
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgJOU0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 16:26:55 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:57482 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgJOU0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 16:26:54 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 894671C0B7C; Thu, 15 Oct 2020 22:26:52 +0200 (CEST)
Date:   Thu, 15 Oct 2020 22:26:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 5.10-rc0: build error in ipi.c
Message-ID: <20201015202652.GA21085@duo.ucw.cz>
References: <20201015101222.GA32747@amd>
 <87imbba7qk.fsf@nanos.tec.linutronix.de>
 <3e6b7c98fd8221a7878aaaa6c1bf86f4@kernel.org>
 <20201015171829.GB5636@duo.ucw.cz>
 <1d6af6a15b71e77c268428ffbc519d6a@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <1d6af6a15b71e77c268428ffbc519d6a@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-10-15 20:41:32, Marc Zyngier wrote:
> On 2020-10-15 18:18, Pavel Machek wrote:
> > Hi!
> >=20
> > > > > I'm getting build problems in 5.10-rc0 in config for n900. ARM bo=
ard.
> > > > >
> > > > > CONFIG_SMP=3Dy
> > > > > CONFIG_SMP_ON_UP=3Dy
> > >=20
> > > On its own, this doesn't break anything with multi_v7_defconfig.
> >=20
> > I sent config off-list. Let me know if it does not arrive or if you
> > need more info.
>=20
> Try this for size:
>=20
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 10a5aff4eecc..db923e0da162 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -81,6 +81,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
>=20
>  # Generic IRQ IPI support
>  config GENERIC_IRQ_IPI
> +	select IRQ_DOMAIN_HIERARCHY
>  	bool
>=20
>  # Generic MSI interrupt support
>=20

My OCD prevents me from doing that! :-)...

select needs to be moved line below, for consistency. And yes, this
fixes it for me.

Tested-by: Pavel Machek <pavel@ucw.cz>
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4iwjAAKCRAw5/Bqldv6
8mi9AKDA75hzxsL88pbr6LPduA5DUGGRaQCeMnD0ATyhz8Pgg76rX6sqQQLoQUw=
=JpNP
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
