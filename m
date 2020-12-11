Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7D82D7962
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390730AbgLKP3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730725AbgLKP3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:29:09 -0500
Date:   Fri, 11 Dec 2020 15:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607700508;
        bh=tnvzMgG8eljDkEYIrFysYNWVviji68n6KbgsBPRTO5E=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=APicdr0mfjo4vVcP8oAQDsdH2BLigI0a4Gxk/P5htV2k1V3eoUmBp7vLo5Dtw8T43
         nngsgJvRQHzKj9rWRohXSCbjseUSIeZlr6jMQVcuOL+5gKdHcs7yZ0jZBJ2LReDC1l
         6PJjQ/ypVpiDpcvqf5CU2cv8KM/xv7Z7Ne6NhRZCZbbGoLbXr7e6pAau+GLd90hmOT
         Nsro3aMPBVAI0iPZfO3lU38RdZTbPHFJrVzUPlGdDTZw+wVjDUWGvYpKAVh9qy9QGD
         3cJ4i7ZvvOz83LDBtmY0EJcS9bBohzCwg9KWqK9asug9nG8lrjUguLdFRPCxYyYIcB
         nub2x7iZmPDrw==
From:   Mark Brown <broonie@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com
Subject: Re: [PATCH v2 2/2] regulator: pf8x00: add support of nxp pf8x00
 regulator
Message-ID: <20201211152820.GE4929@sirena.org.uk>
References: <20201206002629.12872-1-adrien.grassein@gmail.com>
 <20201210221629.17312-1-adrien.grassein@gmail.com>
 <20201210221629.17312-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
In-Reply-To: <20201210221629.17312-2-adrien.grassein@gmail.com>
X-Cookie: Nostalgia isn't what it used to be.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2020 at 11:16:29PM +0100, Adrien Grassein wrote:

> +	{ .compatible = "nxp,pf8200",},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pf8x_dt_ids);
> +
> +const struct id_name id_list[] = {
> +	{PF8100, "PF8100"},
> +	{PF8121A, "PF8121A"},
> +	{PF8200, "PF8200"},
> +	{0, "???"},
> +};

It's strange to see the list terminated with this ??? entry - these
things usually have a NULL for both the ID and the string.  The string
on the terminator is never used so may as well stick with the usual
pattern.

> +static int encode_phase(struct pf8x_chip *pf, int phase)
> +{
> +	int ph;
> +
> +	if (phase < 0)
> +		return -1;
> +
> +	ph = phase / 45;
> +	if ((ph * 45) != phase) {
> +		dev_err(pf->dev, "ignoring, illegal phase %d\n", phase);
> +		return -1;
> +	}
> +
> +	return (ph >= 1) ? ph - 1 : 7;

As I said on the previousl review please write normal condidional
statements to improve the legibility of the code.

> +static inline struct regulator_init_data *match_init_data(int index)
> +{
> +	return pf8x00_matches[index].init_data;
> +}
> +
> +static inline struct device_node *match_of_node(int index)
> +{
> +	return pf8x00_matches[index].of_node;
> +}

If you need these your driver has a problem, as previously advised
please use the standard DT parsing support.

> +	memcpy(pf->regulator_descs, pf8x00_regulators,
> +		sizeof(pf->regulator_descs));

Why do you need to take a copy of this?  The descriptors should not be
being modified.

> +	num_regulators = ARRAY_SIZE(pf->regulator_descs);
> +	for (i = 0; i < num_regulators; i++) {
> +		struct regulator_init_data *init_data;
> +		struct regulator_desc *desc;
> +
> +		desc = &pf->regulator_descs[i].desc;
> +		init_data = match_init_data(i);
> +
> +		config.dev = &client->dev;
> +		config.init_data = init_data;
> +		config.driver_data = pf;
> +		config.of_node = match_of_node(i);
> +		config.ena_gpiod = NULL;

You've not done anything to parse the init data (which is good) so the
init data handling is at best redundant.

> +		if ((i >= REG_SW1) && (i <= REG_SW7)) {

> +			if (mask) {
> +				ret = regmap_update_bits(pf->regmap, reg, mask,
> +						val);
> +			}
> +
> +			if (fast_slew > 1) {
> +				ret = regmap_read(pf->regmap, reg, &fast_slew);
> +				fast_slew &= 0x20;
> +				if (ret < 0)
> +					fast_slew = 0;
> +				pf->regulator_descs[i].fast_slew = fast_slew >> 5;
> +			}

May as well just write configurations out when you parse them, no need
to defer to here and it makes things simpler.

> +module_i2c_driver(pf8x_driver);
> +
> +static void __exit pf8x_exit(void)
> +{
> +	i2c_del_driver(&pf8x_driver);
> +}
> +module_exit(pf8x_exit);

Does this build cleanly?  module_i2c_driver() does both the add and
delete.

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/TkBMACgkQJNaLcl1U
h9DIrAf/eGEes4Oi2+8dr2mGQIKrcAFKXQdOSLVQK0tnwLk3SRtCO46t2yflddU+
J1nDXxGpY1uB8YLQrF7jDuw4sAD6cz++fwLfiMFFY4WQElQcx2IU18oqUtiRZfCx
VUoJ5FiPetCkda8VSuCXj6BQVfDVIEg1tV3+UBDAtmLpZ1yh26xvSA0E7opSsSIT
z+RB8K5r/HoJRPKJ3WIELlGq/vrhdQKjFT5+/ujNG5sMvNpnrNbNowgemVdzw0OZ
Oum+IaeTv0eOpl6JmQUVS2ZkjpEuhsaHOWPbnSWyZfbWgKI+RzvRv05F0Mv3G8Nv
dyCAYIC1p6lFnhHmcV77Y4chzBrZ8w==
=woI9
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
