Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2F2D34A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgLHUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgLHUy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:54:28 -0500
Date:   Tue, 8 Dec 2020 19:31:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607455924;
        bh=CW97W/gl30N7Tnql+tuh176jP24e3MGWQGOTMcWXg7U=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=lV+2IugjN3UFo+knFDsSpVaQlyXTJ7I7B4tCE9kOPw7gmQx0vV7eOHPtPPodOjgIV
         xoH7XUFcQK7nVt0AY2KlJL0bnkW0WStPiC/nxVQYDqSjhzep7g0bZrkGYil3sKlMaU
         KpSGcWlSErt6QN6a/2GTsoIOPgh2lAYRXzeEbx/3J0Iq8mEyuasca1ufSlyvyRhor2
         ItPYYU3j0hsmW+qQjmi2qlDS/jz41/g96H4XF3TeyvbR+EdZSl4Xfz1OEMfQTKevTM
         Kyf7LNZ1uypSXCyC/Mkru0Adstn/0VC8YPfzGiqmC/hWWzeGTQ4RBWq6sDqrnn9cLx
         C7xFTYGlBhHMQ==
From:   Mark Brown <broonie@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        lars@metafoo.de
Subject: Re: [RFC PATCH] ASoC: pcm_dmaengine: Add support for BE DAIs
Message-ID: <20201208193156.GJ6686@sirena.org.uk>
References: <20201202085838.1779525-1-codrin.ciubotariu@microchip.com>
 <20201208170422.GG6686@sirena.org.uk>
 <7ab6bffa-f88e-3e2b-287a-89eee2c01819@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdJFN6SSISdF2ksn"
Content-Disposition: inline
In-Reply-To: <7ab6bffa-f88e-3e2b-287a-89eee2c01819@microchip.com>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdJFN6SSISdF2ksn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 07:26:35PM +0000, Codrin.Ciubotariu@microchip.com w=
rote:

> I do not know too much about the dummy PCM. It seems like it is creating=
=20
> a card without DPCM links and fakes a buffer, which is not quite what I=
=20
> need. I will investigate more.

Right, that's what I was imagining the second runtime you proposed
looking like.

--sdJFN6SSISdF2ksn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/P1KsACgkQJNaLcl1U
h9D/hwgAhqvbHaR1KfxYUOgR8OYqIZ8t+Sk/p3dxSXSsUEyD3k/fio5ln55VJvCH
bif2/LJGtu1Vzk0h0PI+cq09SbWx4gxgxrDC8j9BpAKQ4ETpDLqVIbqIPGWV6ENO
Rf5LQa0so/cWjlVfSKtvLZb03OoJTttL1irv+4/ZhpZUmQVSB1rrAf32tX8aenwz
jmn0Iz7Y5yfAxrXSA9siwgXDYbQt9rusqXKebVY4QCZKuZHXEJ7PbRZHg1ez1irq
NlSM4GbsRFYgqlfKHx3tUmuasVDRA78FdwVx0b7GwyXUSyNrQ3VfblzoXaUdcYIv
iPOtzRyuvSMDgcJDs6htIqfIPofnTA==
=tjP1
-----END PGP SIGNATURE-----

--sdJFN6SSISdF2ksn--
