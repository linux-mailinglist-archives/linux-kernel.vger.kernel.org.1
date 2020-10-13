Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A09228D2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbgJMRR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:17:58 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40600 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgJMRR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:17:57 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DA0011C0B77; Tue, 13 Oct 2020 19:17:54 +0200 (CEST)
Date:   Tue, 13 Oct 2020 19:17:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: sysfs filenames with spaces
Message-ID: <20201013171754.GA29185@duo.ucw.cz>
References: <9b6f5c32d244131dbd63b55b085b3b4173144b4b.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <9b6f5c32d244131dbd63b55b085b3b4173144b4b.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-10-05 19:41:15, Joe Perches wrote:
> This doesn't seem like a great idea to me.
>=20
> For my system I've got:
>=20
> /sys/devices/platform/Fixed MDIO bus.0/
> /sys/bus/platform/drivers/int3401 thermal/
> /sys/bus/platform/drivers/int3403 thermal/
> /sys/bus/platform/drivers/int3400 thermal/
> /sys/bus/mdio_bus/drivers/Generic PHY/
> /sys/bus/mdio_bus/drivers/Generic Clause 45 PHY/
> /sys/bus/pnp/drivers/i8042 aux/
> /sys/bus/pnp/drivers/i8042 kbd/
> /sys/bus/i2c/drivers/CHT Whiskey Cove PMIC/
>=20
> Could these filenames be avoided in the future or
> even renamed today?

Does not look like great idea to me, either. Hmm. Is there filename
with "/" in it? :-)

But I guess you'd need to cc relevant maintainers and that this is
going to be a bit of whack-a-mole.

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4XhQgAKCRAw5/Bqldv6
8hd1AJ9rNb3o6WclbAEmkL8bjJgXEo+xnACgtazBnVc9dZl5UDZGMTbtPCQcB+E=
=iSBG
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
