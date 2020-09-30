Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35C027E573
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgI3JnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbgI3JnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:43:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50DA32075F;
        Wed, 30 Sep 2020 09:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601459003;
        bh=NvWW62h6WWBuoP9glEUGad2o5z5ZaSoXYNbdyewWpfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjDwd9YSoUyv+dpsXfnzgBGt4E/j76OicGy2vhR9ddwirY3wCYjfASguWn46kZOiv
         8ruRL3DsrDUhDPwHvqdx4lM6nuzPudd+kQmj++QznnxPhPsDIQC6KOy2EmrG7cRY8u
         heV9Vbf+e7rjkZEEFR+MnsXHLCDvcCr06gPu15CA=
Date:   Wed, 30 Sep 2020 10:42:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, cy_huang <cy_huang@richtek.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: rtmv20: Add DT-binding document for
 Richtek RTMV20
Message-ID: <20200930094224.GA4974@sirena.org.uk>
References: <1601277584-5526-1-git-send-email-u0084500@gmail.com>
 <1601277584-5526-2-git-send-email-u0084500@gmail.com>
 <20200929150624.GA583524@bogus>
 <CADiBU3_7wj7W2evOAG1GM991OigPYy4FXraeOLCVreaMO86HXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <CADiBU3_7wj7W2evOAG1GM991OigPYy4FXraeOLCVreaMO86HXw@mail.gmail.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 10:23:49AM +0800, ChiYuan Huang wrote:

>    Due to that already merged into your regulator for-next git, may I
> send the patch to fix Rob's comment?

Of course, yes please.

> And I also found one line need to be added into rtmv20 probe phase.
> Please check below.
>         /*
>          * keep in shutdown mode to minimize the current consumption
>          * and also mark regcache as dirty
>          */
> +      regcache_cache_only(priv->regmap, true);
>         regcache_mark_dirty(priv->regmap);
>         gpiod_set_value(priv->enable_gpio, 0);
>=20
> Can I directly merge into one that includes Rob's comment and the
> above line to be added?

Please make it a separate patch.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90Uv0ACgkQJNaLcl1U
h9DO1gf9HplYJj7OmCi5xb/uLhaoCwyFB4DFVHa+ZNtrQ7RSlJDaP0ar+TSNrYqJ
qQDG0MWoJ9oJreEsQTpNgshIYquX9nX8/gTlXgkbCTHH41FOrVIO6/mYc4v0g8HZ
ypv6umuXeIZJDzJwBS2eqe6E3VvfMgS8jhcZQs2lDoXGdpC0q5JEEHPpdEi1Kigp
KzkCMIAeYwehfVz3K1xSl//zVbQrTCq84EQ0UNSukhmmDnppWRK7MLe5oBIieMAq
2bxURIF811cUdgS3OKytI1oe8fS49HYzetyLK3LfGsTDakIWY2fyZEqeFuKRD6HS
/zjQ59OfMtVZZqBQ37fjdN6Zg4PKKg==
=boR4
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
