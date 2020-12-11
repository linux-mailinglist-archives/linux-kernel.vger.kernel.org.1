Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608022D7AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395112AbgLKQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:27:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgLKQ1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:27:01 -0500
Date:   Fri, 11 Dec 2020 16:26:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607703980;
        bh=D6PkJnLwPkrx/3nU/EoMY178LXorbA8/thVLoD5x+gg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSToW0aVjFM7A46kyj5fNwO6lsvjA8fH1bSfIe2FIt27w1A/uLILWKHpwANn0GkYm
         m8YSK4wkUsGMLzthrzLiuMX962yLju3OOZvdAJ/KTbDGqmwjlY3gIvFIVm229KHcZ8
         5Xbc4KHrmdfwsJ133V83EWMsvcx5PCQp8FpT2FYJDEcHZnMcWrtkohxJUby53gdsyV
         hmkH9SZfdSs/tc6Nh16K2pBfjwxqu+MQzSiE4ZJeCNtRA2v+f+ncQKBbigjS2eskVv
         cHP+pNiFeCSwwFDoGatvDwXRzbcwVCGb6FnmaEXCkrk1FzBg4DRElKivXnMIkoflvb
         Je8MPbDrjFPIw==
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20201211162612.GF4929@sirena.org.uk>
References: <20201211160005.187336-1-andre.przywara@arm.com>
 <20201211160005.187336-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
In-Reply-To: <20201211160005.187336-5-andre.przywara@arm.com>
X-Cookie: Nostalgia isn't what it used to be.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 04:00:04PM +0000, Andre Przywara wrote:

>  static inline bool __must_check arch_get_random_seed_long(unsigned long =
*v)
>  {
> +	struct arm_smccc_res res;
> +
> +	/*
> +	 * We prefer the SMCCC call, since its semantics (return actual
> +	 * hardware backed entropy) is closer to the idea behind this
> +	 * function here than what even the RNDRSS register provides
> +	 * (the output of a pseudo RNG freshly seeded by a TRNG).
> +	 */

This logic...

> @@ -77,10 +117,20 @@ arch_get_random_seed_long_early(unsigned long *v)
>  {
>  	WARN_ON(system_state !=3D SYSTEM_BOOTING);
> =20
> -	if (!__early_cpu_has_rndr())
> -		return false;
> +	if (__early_cpu_has_rndr())
> +		return __arm64_rndr(v);
> +
> +	if (smccc_trng_available) {
> +		struct arm_smccc_res res;
> =20
> -	return __arm64_rndr(v);
> +		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
> +		if ((int)res.a0 >=3D 0) {
> +			*v =3D res.a3;
> +			return true;
> +		}
> +	}
> +
> +	return false;

=2E..seems to also apply here but we prefer the RNDR instead of the SMCC.
We probably want to either do the same thing or add a comment saying
what's going on.

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/TnaQACgkQJNaLcl1U
h9A37gf/YcdpiwbfAu6XhOilbKoh0HHz40BryiT+RzRxWBTZRHBqVwt49G6le4SV
pqInBtPCBnSGvT05jK0C8hSzEU6LKN0OrRToGzUJqsMi1Kf7rDwCs6gA6CVURIwY
wSXxNuGD3c9dGXCtip4pRhY4qB5PZ9FcVbgWVu84CnrCX6efa7DbDMBLdX7S03g4
NWvYxTwnoVswk5CeltpcHx3xzvY4IH73h5UNycV6UEYj0AiNrKf9YIfIqtk55uLh
x+GtUS8mlxj9FDrhW7J2z/+EgDjZ06XF4yP/iVLSDmCaFOwrck0Mi/6ypeF59nMz
w2FoqjLlhrzqojVUxLk/SEg4y5jECA==
=0YV1
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
