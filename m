Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204FF2E79BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgL3Nka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgL3Nka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:40:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 311C3206A5;
        Wed, 30 Dec 2020 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609335589;
        bh=3nvYtVZTXnIM2M4Es4IA8NhqT2hrT6e/e/fHzUmGonk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCM7SoqnDQbtmAYiVjD8IQagRSlir2xY2QvKCgEulnDLwY9gFC8vWqzD8lUrllYFV
         qOMpDYnH69n8qKziXYApw7Z5xI4YpmKdNR5duUMBRc3a7H63cuCl9l2EBzB449wMHG
         Jt9MfhPyB9hK3Go2I3piHOpBUF+u08o+5P7kf++Cvs44Z5caKlvC2e96krJbcCLPVn
         uX6EyoMFdYvSFdXlwqgts8G4kX73/32I1KJYukH+0kuFdlKdvRCepUvKG26Si8HZRP
         FOW8exn4DhSpbMl9b5neKgfEFrJvx92R695EjQx5AuGNAjEQHFdnLAY04calno0aaV
         bEfJ6VSAqDH4Q==
Date:   Wed, 30 Dec 2020 13:39:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3] regmap: debugfs: Fix a memory leak when calling
 regmap_attach_dev
Message-ID: <20201230133927.GD4428@sirena.org.uk>
References: <20201229105046.41984-1-xiaolei.wang@windriver.com>
 <d516efdd-7e66-13fe-3798-cdea5ff012dc@web.de>
 <PH0PR11MB5077EC74C0A81ABF8F082BC795D70@PH0PR11MB5077.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5077EC74C0A81ABF8F082BC795D70@PH0PR11MB5077.namprd11.prod.outlook.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2020 at 10:14:22AM +0000, Wang, Xiaolei wrote:
> Hi Markus
>=20
> Thank you very much, very good suggestion, do I need to re-send a patch t=
o fix this problem, or modify the previous patch and send it again?

Please feel free to ignore Markus.

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/sgw4ACgkQJNaLcl1U
h9CyNwf9EDK99jUBj3cRoPF87/iQOCwAunHmFz4I5n9mpCIYg264KCgOLSqUCDM7
U0sY5o0G3vxQqqoZsAMtTDgyTimscRCjXch3wrTrB7J8KJA1j8twUCYWtIpFECn3
nQ2g2QtlMky581G8/SM7LieziVp+cY83eJS4f3R//dZBINmyQWLe1JYcB3MABkTd
6Dov+4dn0msCL7xs65PYBz9HSVJX8z75uemS3bbJIYLUKiAuC0K1auOK6PxTOaBT
P4K+quQ8zj/8UHDdBWIiIM+lF6lgaNrqr5V+v0EzV8TrCKBGBqaiyCx/lBDrpEKs
NwT2skl91yKqscQpcc+EABdcC+OzFg==
=Goo3
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
