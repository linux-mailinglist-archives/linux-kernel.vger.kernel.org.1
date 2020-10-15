Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A655928F78D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404904AbgJORSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:18:32 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35164 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404897AbgJORSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:18:31 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1960C1C0B8C; Thu, 15 Oct 2020 19:18:30 +0200 (CEST)
Date:   Thu, 15 Oct 2020 19:18:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 5.10-rc0: build error in ipi.c
Message-ID: <20201015171829.GB5636@duo.ucw.cz>
References: <20201015101222.GA32747@amd>
 <87imbba7qk.fsf@nanos.tec.linutronix.de>
 <3e6b7c98fd8221a7878aaaa6c1bf86f4@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <3e6b7c98fd8221a7878aaaa6c1bf86f4@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I'm getting build problems in 5.10-rc0 in config for n900. ARM board.
> > >=20
> > > CONFIG_SMP=3Dy
> > > CONFIG_SMP_ON_UP=3Dy
>=20
> On its own, this doesn't break anything with multi_v7_defconfig.

I sent config off-list. Let me know if it does not arrive or if you
need more info.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4iEZQAKCRAw5/Bqldv6
8kvsAKCGHUyvjjyL7C8FXL96LgCigOt+kQCfY1LYUJzSkXZrg7cBaxwsu9Z5Fc0=
=w3CC
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
