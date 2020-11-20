Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03C2BAACD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgKTNG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgKTNG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:06:29 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473BC22264;
        Fri, 20 Nov 2020 13:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605877588;
        bh=WV1hO7Un5WlicimVZRyv5OXMPrTB976+s6qssL68KDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXgxJA5XIDHgmxbRuQdcu1y+OumFjOiaJdkSrPu8nLViceKznWKS67iFx24YP6Hby
         GMHL+Mu1nq8ytrYaGmADHBCuvC+sF0YbgDwR5Vp8FgCraTJ9lw2OoarOPRO2Nm7LTe
         fFndI8ibpPZNARyY+U02EV18zsxE9ppL5COzqMRg=
Date:   Fri, 20 Nov 2020 13:06:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <adam.ward@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/9] regulator: da9121: Update registration to support
 multiple buck variants
Message-ID: <20201120130607.GC6751@sirena.org.uk>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <a2b4186b47e4786bd856ec11d2353b7183c22af2.1605868780.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <a2b4186b47e4786bd856ec11d2353b7183c22af2.1605868780.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: Have at you!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 12:14:56PM +0000, Adam Ward wrote:

> Checks DT matches tally with variant maximum and register accordingly.

This changelog doesn't really explain what the change is supposed to
be doing or why which makes it very hard to review, and the code is far
=66rom obvious.  I can't really tie much of the change to the words here.

> +	if (max_matches > variant_parameters[chip->variant_id].num_bucks) {
> +		dev_err(chip->dev, "Too many regulators in the DT\n");
> +		ret =3D -EINVAL;
> +		goto error;
> +	}

If this validation is needed it should be in the regulator core.

> +	for (i =3D 0; i < max_matches; i++) {
> +		const struct regulator_desc *regl_desc =3D
> +			local_da9121_regulators[chip->variant_id][i];
> +		int id =3D regl_desc->id;
> +		struct gpio_desc *gpio_ren;
> +
> +		if (chip->pdata->gpiod_ren[i])
> +			gpio_ren =3D chip->pdata->gpiod_ren[i];
> +		else
> +			gpio_ren =3D NULL;
> +
> +		config.init_data =3D chip->pdata->init_data[i];
> +		config.dev =3D chip->dev;
> +		config.driver_data =3D chip;
> +		config.regmap =3D chip->regmap;
> +		config.of_node =3D chip->pdata->reg_node[i];

I *think* this is all open coding the core's DT parsing support.

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+3vz4ACgkQJNaLcl1U
h9Daxwf+L4d+fMaMRA6c7R/z2ADUHL5zgoX4YxLEot8A3kyRzN0wqdlGLIXhkVfY
i53izTg0XRw3XkV58zxAlXDl6PGzNcdMSRkrQipZRpk5aTTZ/AQ1H6KI+SYzSTU1
bskdQZiPB1Qvyne02uoDrrVAdpTHRQSaXwxwvNYFFhB1pIYuCEPnOxemZAgQBdq6
wSqPkhtanhvBYQOb/jujS6PTMFVUiKdTLzf0C5zv3tq7SOcNHUBm5Tx+Tm6qWnMi
9+1HyZZNAxKGULUe6qrIzBpSxkQnrystbSmrGlXxcAQdWVMgAdZyNQcpqc15pccl
nJPude84TcmE/gxpGj2F88uFG8lLZw==
=LXvo
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
