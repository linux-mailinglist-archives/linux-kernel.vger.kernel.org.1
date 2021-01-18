Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DE82FA0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404156AbhARNG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391961AbhARNDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:03:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0B2722571;
        Mon, 18 Jan 2021 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610974984;
        bh=RbUnzS/4nrd4iAPnXubrFVzey/trFbxTEw8uynBL4vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URept8pFVDB9rwLoEwDMKPFgawKQQErcGW+41JY9ajp9+488Qm62OqabuqQXQayyM
         AWv1aDQVmufIWjRqhW6SYCN1zq+Z/RMy1S+5tfVEZwFv6MGqVCSqPlFLE1DzKSNqct
         gTErdRypZnsa4alg1jpx5XVVP0zUGUjXEuLthu8jLLhsQkoAee1gMh9oOGsD/VT2US
         DqDxxdD6BrDsHt+Y8dO9xNnFATFZpRVgHLW50hDgslMDU2rnAtTHvklw544Q8xCq84
         IJDPbfbAcynYwCtHLwv6hLnvKIblOsY7+ASWQxUZ1g1nQmrjyBMxrB2DBGQqAFXFyv
         50n/WYEB4CCaQ==
Date:   Mon, 18 Jan 2021 13:02:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org,
        Christian Hartmann <cornogle@googlemail.com>
Subject: Re: [PATCH v3 3/5] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
Message-ID: <20210118130227.GI4455@sirena.org.uk>
References: <20210117212252.206115-1-hdegoede@redhat.com>
 <20210117212252.206115-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <20210117212252.206115-4-hdegoede@redhat.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 17, 2021 at 10:22:50PM +0100, Hans de Goede wrote:

> +	/*
> +	 * Some DSDTs wrongly declare the IRQ trigger-type as IRQF_TRIGGER_FALL=
ING
> +	 * The IRQ line will stay low when a new IRQ event happens between read=
ing
> +	 * the IRQ status flags and acknowledging them. When the IRQ line stays
> +	 * low like this the IRQ will never trigger again when its type is set
> +	 * to IRQF_TRIGGER_FALLING. Correct the IRQ trigger-type to fix this.
> +	 */
> +	arizona->pdata.irq_flags =3D IRQF_TRIGGER_LOW;

Are you sure that all the relevant interrupt controllers support active
low interrupts?  There were issues on some systems with missing support
for active low interrupts (see the bodge in wm8994-irq.c to work around
them) - it's entirely likely that there are DSDTs that are just plain
buggy here but if someone's copying and pasting it smells like there may
be some systems that actually need an edge triggered interrupt that
they're getting it from.

> +
> +	/* Wait 200 ms after jack insertion */
> +	arizona->pdata.micd_detect_debounce =3D 200;
> +
> +	/* Use standard AOSP values for headset-button mappings */
> +	arizona->pdata.micd_ranges =3D arizona_micd_aosp_ranges;
> +	arizona->pdata.num_micd_ranges =3D ARRAY_SIZE(arizona_micd_aosp_ranges);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id arizona_acpi_match[] =3D {
> +	{
> +		.id =3D "WM510204",
> +		.driver_data =3D WM5102,
> +	},
> +	{
> +		.id =3D "WM510205",
> +		.driver_data =3D WM5102,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, arizona_acpi_match);
> +#else
> +static int arizona_spi_acpi_probe(struct arizona *arizona)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  static int arizona_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id =3D spi_get_device_id(spi);
> @@ -77,6 +191,12 @@ static int arizona_spi_probe(struct spi_device *spi)
>  	arizona->dev =3D &spi->dev;
>  	arizona->irq =3D spi->irq;
> =20
> +	if (has_acpi_companion(&spi->dev)) {
> +		ret =3D arizona_spi_acpi_probe(arizona);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return arizona_dev_init(arizona);
>  }
> =20
> @@ -104,6 +224,7 @@ static struct spi_driver arizona_spi_driver =3D {
>  		.name	=3D "arizona",
>  		.pm	=3D &arizona_pm_ops,
>  		.of_match_table	=3D of_match_ptr(arizona_of_match),
> +		.acpi_match_table =3D ACPI_PTR(arizona_acpi_match),
>  	},
>  	.probe		=3D arizona_spi_probe,
>  	.remove		=3D arizona_spi_remove,
> --=20
> 2.28.0
>=20

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFhuIACgkQJNaLcl1U
h9DDuQf+K/1+R35NC7d0uVDYwSsGKNopg9Q3xtbFzKERm2cKHfqao/bdeSkrbhhD
kSUm+L9X1I/LHkGzdao5920MXJ9gmzbIeolpSH6ygVv8KZ7odJPV+H+Bkly+ZTe7
ZRAoBiuUFSVpe/3lZV7YBMlbH1j8U8lIeJ3SFPzz0dokrgezToTeBJopK/kI1z7k
7GHKPF00b/CDy2A5abeXIE7pn2fUwVascc95pz9aVgtO638joDZiczuKmlrOiv/v
g83/Wc36+jmZqVR7ptTGKXK6KyQzScNYlTWCnZBeWzkhx3KE0PAe1Ez2kyozu6Vw
wG3vYuzhX/7yelouc25AU/i3lruPkQ==
=lhY6
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
