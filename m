Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B4B2ED21F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbhAGO24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:28:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbhAGO24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:28:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45D3822EBF;
        Thu,  7 Jan 2021 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610029695;
        bh=wq0bmkT0v1XJd/qFGy+kwVjV7IzBlnb2YgG9BaaPlAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rx27ouWQ6IOJLohgRuNphzufjwGjIZTKJdUtwm5WUXxfzOtwRWhIhg3DwfS/sxA/N
         2E7nOeEnaEupq/NmPzzorvpPmAGTXdZ5H0DL7XOGYrn4C+ygRrTkyD6daNGIYaCmjC
         +oW1fPsk31YHSy3CY0SXYce7qZxXilkgQUlFhTjacmsSL48lL29CWW6cOGld2Qg7Zf
         BiLYY1zGRuRH6pXwnsPLAhpe3eOkWZ7iSkEPr+lnOwENl6oXPs/yxdjzxvoD3PKXSJ
         iwq2xYGROQ8ujnneTRz/nDp+mmGnqQRzqJebZwmxsIspZ9rd7VosVzTxjfZwTTUvmb
         u/Fv6nTTnmvbw==
Date:   Thu, 7 Jan 2021 14:27:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chris Chiu <chiu@endlessos.org>
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH 1/4] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
Message-ID: <20210107142746.GC4726@sirena.org.uk>
References: <20210107090625.107078-1-chiu@endlessos.org>
 <20210107090625.107078-2-chiu@endlessos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <20210107090625.107078-2-chiu@endlessos.org>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 07, 2021 at 05:06:22PM +0800, Chris Chiu wrote:

> +static const struct acpi_gpio_mapping *cht_rt5645_gpios;
> +

You're adding a read only static variable with no way to set it.  This
doesn't actually do anything?

> @@ -3780,7 +3782,6 @@ static const struct dmi_system_id dmi_platform_data=
[] =3D {
>  		},
>  		.driver_data =3D (void *)&intel_braswell_platform_data,
>  	},
> -	{ }
>  };
> =20

This is an unrelated change which removes the terminator on the array
which will cause issues.

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/3GmEACgkQJNaLcl1U
h9CLFAf/evzCs5u2gB5dTDWM0EbQ+WNYz3+RPiTWt8YOnZcdvn7CNyuOxA4daHhN
qNtKWt3HL5iVv6N0QVm+KIApX1j/VAN1Wa+LKoSpJHh/+XlL2v2h9Gkcx/JqM2zi
JYUj35rMJnL+TotjeOw+dtDRsWueo3IUN86o2QJX5SLBFwUXMdSFkW9VEsLu+2l7
quPzgEelg/tSwEegKNlPPApb9uedQpKNy2w5gngtpSUQH8IGGxxISSAQF1Cdgt8h
mCVLS53h93BEajHCGRlv6GPuBKTkgRnvyzbYEHgmJEpGihxxQPHzvyzjj+OlAXB5
sSHjR+6+BfSP0CY+bG71x+PSPHwD9w==
=w+Ra
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
