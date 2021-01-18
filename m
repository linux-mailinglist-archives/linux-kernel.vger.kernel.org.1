Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7482FA5FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406506AbhARQWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406554AbhARQVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:21:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E545120715;
        Mon, 18 Jan 2021 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610986851;
        bh=c2vVpih3i95NJnI8vf6iq+cWxGzir4SmoRY8nZEYKsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpMFIoLteDM5YsC7y7x4dDjxA2CYAJPPFnczAFBHkIfLJwqIaqswPwxE5K5NPAaAR
         pvtsGsNcQrMnOX0fuUy6nudt7w9ybkpmWxEzwwHDoocgYhfEcLP3lJSXmSXfqwxzhl
         D1OxD6L30PRL1Tm103Q8123/npwLH2iiE1+TvfNRehJmB0EbptAzVnfYh7KECz75lT
         jB9fW/cBsdSeYU0LOW/gIFj4yNT2zgHexekNgonlK0Lvg581NxnljEJQSBSN755Je9
         393XtnvaMHAnV3oQnWFunGVDBb9CSXEg5rmx8VuoxPFJGOUDad1fErmVMs/vXuZToD
         M1wWMq7uR/9ng==
Date:   Mon, 18 Jan 2021 16:20:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] regulator: hi6421v600-regulator: move it from
 staging
Message-ID: <20210118162014.GN4455@sirena.org.uk>
References: <cover.1610975633.git.mchehab+huawei@kernel.org>
 <d0a7cae3c654d25e01b0c436e00de55a21cd7f64.1610975633.git.mchehab+huawei@kernel.org>
 <20210118135440.GM4455@sirena.org.uk>
 <20210118170245.1bf5160f@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Content-Disposition: inline
In-Reply-To: <20210118170245.1bf5160f@coco.lan>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 05:02:45PM +0100, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:

> > If for some reason the PMIC is sufficiently fragile to need a delay
> > between enables it's not clear why the driver is doing it before
> > enabling rather than after, presumably there's issues with the regulator
> > ramping up and stabalising its output=20

> I don't have any datasheets or documentation from this device, except for=
=20
> the Linaro's official driver for Kernel 4.9 (from where this driver
> was originally ported), and a high-level documentation for this=20
> hardware at 96boards site, which doesn't cover any details.

This misses the point.  To repeat, if the driver is hard coding
a delay why is the driver doing this *before* rather than *after*
enabling?

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFtT0ACgkQJNaLcl1U
h9AyLQf/USNxx3EbzqfpSSHhNirhnkb/sC/qHjE6y5A1a/NBfHjUnqSukoxOZyvE
I/ri25KPFMXjiXzFqLiKzDQ6qp/1NrxSRO4jYaBAgCZ+AkkaBHOdcrH9QY4KVyD2
WAQ9m/66fz6T889YM8CShRLiSKtGKgWUlqZhpGB5eBC3YjNoh033UcWpF549eTF9
jFMXv+rm0aVUHKj0HGjIAp2UdxJpHyOzOLWcbG6GLlniaXQhz6b6kuQsQiv3CVqh
u2sD0D7REi1ur/1HKEGVIG2X0jAXfNBKO9qlIh+bQuyRhyEt21zQf5sGHN4pJ+qg
yamtABJJ0IgyfWAEVfjWwk+RWrUx6w==
=tOni
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--
