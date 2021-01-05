Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41D82EB0CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 18:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbhAERBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 12:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbhAERBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 12:01:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B1D622CB9;
        Tue,  5 Jan 2021 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609866042;
        bh=K8rAAgbvgJOrltjvqkkg0lKreghPjvGcwr3u28D1o1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2e3w+dPlvG0kpAb41jDf4ut+9Cjd3hvHKHLzFAQA7synFGutVGBDDCc7CBTfoBlY
         SuT3hxxP+KHcPF1mPpnQphr528eXRg/yqECTmmyOyeSMMP30in6a9A9qC+D8KvjDo3
         h8LBLezI2sikU00ALAIDmChhSk9yW9s3yudCv/IIEvQyvJeJoXUMyKSCwTmmuhC5GK
         pupZVtUjmjE8XqvV+9xPbxE8LokyQOp7pHhu9kgHT1nbCsiw+bdo/+K+kCb3EnUG98
         QjJRmHCiDGJ+BOSowS11T/j0hBIqbMDTLnWPETcwKvfUqwzuRLSOMoqd76TEZjf1oh
         vOdpYEAN/jabg==
Date:   Tue, 5 Jan 2021 17:00:14 +0000
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
Subject: Re: [PATCH v5 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20210105170014.GG4487@sirena.org.uk>
References: <20210105163652.23646-1-andre.przywara@arm.com>
 <20210105163652.23646-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Content-Disposition: inline
In-Reply-To: <20210105163652.23646-5-andre.przywara@arm.com>
X-Cookie: I'm ANN LANDERS!!  I can SHOPLIFT!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2021 at 04:36:51PM +0000, Andre Przywara wrote:

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

This still seems to be preferring RNDR over SMCCC for the early seed
unless I'm misreading the diff?

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/0mx0ACgkQJNaLcl1U
h9BbEQf/UEKW05M2JoVuTX8s89SZjgXY0yURCLUGmFG3oR3xya0eOY6+tciI5z+h
6tNafYEkfQZGH4c77s1utt4oz1TSvE9tlaCycjwtdJSFy7wzcnRLsqhHwK2/Gi6F
pFbVgbcLLIEUzxZ2EwOK0RsDPp49N2bGA2r1KD4EpLwagHXBZ9YTu+2fm01HyFUY
SXDH/wiiVXzDS9N8v/r/GIHZr+DAsnUj3Qt2Z4/08PeaRF7FSkPU+5KysKg/XOWK
O1kQQiRiHrPq/Eu88Woo2xbF+zUs5RH1NQ/DRejwJv90kRN9M/YzY4M2WzuX1azR
uRVPqPzk5c5tt5jx6FR+vrMx4XgIAg==
=8VqE
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--
