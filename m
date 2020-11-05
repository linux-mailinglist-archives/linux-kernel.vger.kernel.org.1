Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617592A7FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgKENly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:41:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKENly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:41:54 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBB5F20729;
        Thu,  5 Nov 2020 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604583713;
        bh=4w//0GOBcyazzgOmqfL5NKULnMf1kmugV10nGsnPnCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0S+M/t95EKp2myinviXxYBn/BVNlmZenfledxlLsLuLXYeNEUag6xwL4pHwW23yE
         CKLpj6aYbmL1uY8vflma3+jebsh3Rzddy8UhnShGvtINtt6rQPcSVhZpQYGil8i2uY
         Q20pR7IzGI7f6VesD8+v9DH4vegwrZx4D0ScIsJ8=
Date:   Thu, 5 Nov 2020 13:41:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20201105134142.GA4856@sirena.org.uk>
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20201105125656.25259-5-andre.przywara@arm.com>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 12:56:55PM +0000, Andre Przywara wrote:

>  static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
>  {
> +	struct arm_smccc_res res;
>  	unsigned long val;
> -	bool ok =3D arch_get_random_seed_long(&val);
> =20
> -	*v =3D val;
> -	return ok;
> +	if (cpus_have_const_cap(ARM64_HAS_RNG)) {
> +		if (arch_get_random_seed_long(&val)) {
> +			*v =3D val;
> +			return true;
> +		}
> +		return false;
> +	}

It isn't obvious to me why we don't fall through to trying the SMCCC
TRNG here if for some reason the v8.5-RNG didn't give us something.
Definitely an obscure possibility but still...

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+kARUACgkQJNaLcl1U
h9DYuwf8CUvDX3fgFkHQzB4oHxVc26hBdjs1LMP8HGSRCDcCKTl8g0oPmxO620Eg
Gi7jDuTY0fyXAqxIJY6mqyAxuWwoEhN37zqHBqDKoIIQoqr7S2XenF+4PZauH7A/
3/E8QnNxZCWUCZkgmjwa5GAa5Yt2SHNnZOXe4kx81SHBdMBcMgM4VnVS1eag/Rsu
5PZ/HFJQAB3PQQQ4+MtYkWqfurTTnQruH/sT1CxWa6WHbUWwStSsmtrbjwLx/3nz
SHD1UXnMH5WycZQ55m++AGD9xzSZGFRlbgEcXltNPMg8ern/xeCt5EpCKl262D+I
ujIYv72Mo/6CrpMqQrXsK7jzc5pHHg==
=6PnH
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
