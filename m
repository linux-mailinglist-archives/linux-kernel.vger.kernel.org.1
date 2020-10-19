Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C79292D83
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgJSS1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 14:27:25 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50792 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbgJSS1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:27:25 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8ABE11C0B76; Mon, 19 Oct 2020 20:27:22 +0200 (CEST)
Date:   Mon, 19 Oct 2020 20:27:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: sysfs filenames with spaces
Message-ID: <20201019182721.GA14004@duo.ucw.cz>
References: <9b6f5c32d244131dbd63b55b085b3b4173144b4b.camel@perches.com>
 <20201013171754.GA29185@duo.ucw.cz>
 <575e7e2eb77ee5c26c3ac8fb6cb863890e971a16.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <575e7e2eb77ee5c26c3ac8fb6cb863890e971a16.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-10-13 12:48:49, Joe Perches wrote:
> On Tue, 2020-10-13 at 19:17 +0200, Pavel Machek wrote:
> > On Mon 2020-10-05 19:41:15, Joe Perches wrote:
> > > This doesn't seem like a great idea to me.
> > >=20
> > > For my system I've got:
> > >=20
> > > /sys/devices/platform/Fixed MDIO bus.0/
> > > /sys/bus/platform/drivers/int3401 thermal/
> > > /sys/bus/platform/drivers/int3403 thermal/
> > > /sys/bus/platform/drivers/int3400 thermal/
> > > /sys/bus/mdio_bus/drivers/Generic PHY/
> > > /sys/bus/mdio_bus/drivers/Generic Clause 45 PHY/
> > > /sys/bus/pnp/drivers/i8042 aux/
> > > /sys/bus/pnp/drivers/i8042 kbd/
> > > /sys/bus/i2c/drivers/CHT Whiskey Cove PMIC/
> > >=20
> > > Could these filenames be avoided in the future or
> > > even renamed today?
> >=20
> > Does not look like great idea to me, either. Hmm. Is there filename
> > with "/" in it? :-)
> >=20
> > But I guess you'd need to cc relevant maintainers and that this is
> > going to be a bit of whack-a-mole.
>=20
> An option might be to convert any invalid filename
> via an alloc and substitution in sysfs_add_file
> and similar free in sysfs_remove_file.
>=20
> Emitting a logging message describing any new name
> would be useful too.

I believe that would be dangerous... renaming existing entries and
risking duplicities.

But ... some kind of warning when such entry is created might be good,
we'd then fix them manually.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX43aiQAKCRAw5/Bqldv6
8uVrAJ9S6jPaYGU2xO1irvScMx5MhPf3DACfZ9m0O55biK5H45pXCfG474toIto=
=ssDG
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
