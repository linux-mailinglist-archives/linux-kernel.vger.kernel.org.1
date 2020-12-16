Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657392DC0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgLPNHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgLPNHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:07:30 -0500
Date:   Wed, 16 Dec 2020 13:06:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608124009;
        bh=2o4+x2xBpkUDsQk9fVbcAXekKG36oLQ96Pl/Mx9ftA4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMpS6Duk/70/6S0AYleGL9L0gUVqwpUbIcXzJeEilviKg+ZUPKiRf0Bltz83gQidH
         GKCx/F3x6aIKNXmTOxFCx0MmqIQ8CnWIJ9WcGwP07h9WKG4WRC9SWxThBFfq6aDweY
         38BgawvBT120iLv9RCSC/d565uC50APSRE1WIt6cOqCiTngItg640oVJcdWVTaRavX
         pFPo0C/Re3/KgSaoPFcDaom97IRF1TNi+gyD79JiKtwC+JJ0KFAL/u241kTNQKHRrM
         SqZS0TP2cEbkeJYvWc0GdUaJuuoCTtp3sJtHKlA20fBRpGYaxMy59TUX385n/jipme
         umMDXSfZOpvqg==
From:   Mark Brown <broonie@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] regulators: bd718x7: Add enable times
Message-ID: <20201216130637.GC4861@sirena.org.uk>
References: <cover.1608116704.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <cover.1608116704.git.agx@sigxcpu.org>
X-Cookie: Why are you so hard to ignore?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2020 at 12:05:53PM +0100, Guido G=FCnther wrote:
> Use the typical startup times from the data sheet so boards get a
> reasonable default. Not setting any enable time can lead to board hangs
> when e.g. clocks are enabled too soon afterwards.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/aBl0ACgkQJNaLcl1U
h9DFLQgAgidhdlKm5CZH5IyNEEXGlT5vTlfHc7HyVTaMCKWNuZi1zw/mEaT/yAls
fHIuDxK1GdV4TdSc3n2Dmn8ysd1lhybr6f8YcHAYffQ5C13XDx05q+PS1Q21SF5E
OGj+5Hu+8gEurYBPHA1nVC9twQiCEju3ucQZl1AP6Jd22MN+34oAeuX4J+Vdu+cN
DcoFup6U5skdDts2zRxPLQEK0CO6ZkVfw5e7ht+wRyehv3RzNzHO9IMPy4NR2JwZ
ag1EtFP0nab13C9d0m6dJjIJZKRnLYDl7N+e3MQvnBz7wyMYelgQp1B3KpgxAfh3
9Hoe3zJzDJ0WseHy1HAl9wx2wzSEaQ==
=xxHz
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
