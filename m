Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15A82D131E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgLGOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgLGOI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:08:56 -0500
Date:   Mon, 7 Dec 2020 14:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607350096;
        bh=Rl3ClhuD6asNLYihK1VRtS7R/JSZN1DlsMrwplxwi/g=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtEjajnt8ljKQEi/u+UOXVY1peiPI3todyJOodCeGnW6fae9Hs93WCLZbIKqYYRjQ
         a94V+TVzyQqel1kQQTXYBts8yrs1siOKxBhI6d0QkfUaqOVHu2KftknmrBVee6LDJj
         kp2dZvK5XcC0niEyGahQ8DlUq0SQMU8YDl8w1G+NW/m0kXjKv0ZTggOIgOJx4PbjUU
         G39k/oN8Z38gLc6r88k6tAVskyUrx0QPeDSygB1iaylp3Oz29KrlP/erI6kgno5eQd
         bY/XEYlsMetIMAatHLb6ICWgTg/nRjK/aVxBXAgTnulWxKr+BgQjonql5k1cQ+b0U0
         ciIIITt5npamQ==
From:   Mark Brown <broonie@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com
Subject: Re: [PATCH 2/2] regulator: pf8x00: add support of nxp pf8x00
 regulator
Message-ID: <20201207140810.GF5694@sirena.org.uk>
References: <20201206002629.12872-1-adrien.grassein@gmail.com>
 <20201206002629.12872-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline
In-Reply-To: <20201206002629.12872-2-adrien.grassein@gmail.com>
X-Cookie: Absinthe makes the tart grow fonder.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 06, 2020 at 01:26:29AM +0100, Adrien Grassein wrote:

> +/* sw1 to sw6 voltages, from 0.4V to 1.49375V with 0.006250V increments =
*/
> +#define SWV(i)	(6250 * i + 400000)
> +
> +static const int pf8x00_sw1_to_6_voltages[] =3D {
> +	SWV(0), SWV(1), SWV(2), SWV(3), SWV(4), SWV(5), SWV(6), SWV(7),

There are helpers for linear mappings, please use them directly rather
than open coding - this is clearer and much more efficient at runtime.

> +static const struct i2c_device_id pf8x_device_id[] =3D {
> +	{.name =3D "pf8x00",},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pf8x_device_id);

There should be separate IDs for the individual parts as with the OF
compatible.

> +static int pf8x00_regulator_set_voltage_time_sel(struct regulator_dev *r=
dev,
> +		unsigned int old_sel, unsigned int new_sel)
> +{
> +	struct pf8x_chip *pf =3D rdev_get_drvdata(rdev);
> +	struct pf8x_regulator *rdesc =3D container_of(rdev->desc, struct pf8x_r=
egulator, desc);
> +	const unsigned int *volt_table =3D rdev->desc->volt_table;
> +	int old_v =3D volt_table[old_sel];
> +	int new_v =3D volt_table[new_sel];
> +	int change =3D (new_v - old_v);
> +	unsigned int index;
> +	unsigned int slew;
> +
> +	index =3D (rdesc->fast_slew & 1) ? 2 : 0;

Please write normal conditional statements to make things easier to
read.

> +	if ((desc->id !=3D REG_SW1) && quad_phase) {
> +		dev_err(pf->dev, "ignoring, only sw1 can use quad-phase\n");
> +		quad_phase =3D 0;
> +	}
> +	if ((desc->id !=3D REG_SW1) && (desc->id !=3D REG_SW4)
> +			 && (desc->id !=3D REG_SW5) && dual_phase) {
> +		dev_err(pf->dev, "ignoring, only sw1/sw4/sw5 can use dual-phase\n");
> +		dual_phase =3D 0;
> +	}

This wasn't in the binding document...

> +static int pf8x_parse_regulators_dt(struct pf8x_chip *pf)
> +{
> +	struct device *dev =3D pf->dev;
> +	struct device_node *np, *parent;
> +	int ret;
> +
> +	np =3D of_node_get(dev->of_node);
> +	if (!np)
> +		return -EINVAL;
> +
> +	parent =3D of_get_child_by_name(np, "regulators");
> +	if (!parent) {
> +		dev_err(dev, "regulators node not found\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D of_regulator_match(dev, parent, pf8x00_matches,
> +				 ARRAY_SIZE(pf8x00_matches));

Don't open code binding parsing, just specify the relevant names in the
regulator decriptors, register them and and let the core parse things
for you. =20

> +			if (ilim <=3D 3) {
> +				mask |=3D 3 << 3;
> +				val |=3D ilim << 3;
> +			}
> +			if (fast_slew <=3D 1) {
> +				mask |=3D 1 << 5;
> +				val |=3D fast_slew << 5;
> +			}

More blank lines between blocks please.

> +static int pf8x_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int pf8x_resume(struct device *dev)
> +{
> +	return 0;
> +}

Remove empty functions.

> +static int __init pf8x_init(void)
> +{
> +	return i2c_add_driver(&pf8x_driver);
> +}
> +subsys_initcall(pf8x_init);

You should be able to use module_i2c_driver() here.

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/ON0kACgkQJNaLcl1U
h9AGkQf9GmVAdk4cylUyPxmgQIX6zHhZINl0SbUM0A3tIKud69PoT51bSaBxpanO
Lk1dGfiYtrQ/ar9gVe0D1WfU1rj1g9ZCr+WAfg6RjRmhRJCGSXZ2rpREOGo7w2eJ
A9QnXFJal4p+lmgpH2c/RrlHeV0mQ4hxmb4+zTha1/3GpH6aBEJYu69c7UX985o2
dGEMpHsWy5NH52vdHV7Ua8bPj9JLdjC7UcS0L6DDBfTZF1sKZRyZC27bbnEPT2cq
Kdi6T28N9HGZa1PHJc9CqZCR7yRV2yjaZLFsXtQLirx6zQ2UTFzRtVkwP+iSg9tO
34+22vMcutgQQACzUSCMTjESjrM0wA==
=/On0
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
