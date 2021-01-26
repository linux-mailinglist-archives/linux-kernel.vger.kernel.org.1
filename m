Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CACA303EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392486AbhAZNi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:38:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbhAZNhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:37:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20D2C22B2C;
        Tue, 26 Jan 2021 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611668214;
        bh=7YuUvSQdT/9yQpCdwou6DuNUmWTWxxjjqnzdhUxKMK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+zW47f0+3+RQT2TlLNwAa4MyB7Ke1ery+xx05yjejwV46aDOaDvU+RyMgry83RBV
         4q/Qo2Q8HxI4Kzph+86wzFUk+4xVtP04A9Nn5cU8KHOFC8w3r7YIwDzm/V1mOeNjBf
         JlRVz/QMWztT2X4z9w1VhHJ+M3a423+Ztz06HDEQooxlFPq3c6ZL1I7UTWYfKp15tP
         DkpEtC0nHHHLo2vsBYdRPdkKoaL86XMgu/0X5u+Mx3TO8WkNV6Q9XwDxGKGeRmuQMj
         6VsoA3DJibkJjEEIkkrmcrvgejzuwUAyeyTL1/31dnAaCcsda2zeFhcUXTYQ4yn5VM
         im9BDQwWsv8RQ==
Date:   Tue, 26 Jan 2021 13:36:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org
Subject: Re: [RFC PATCH 1/2] ASoC: soc-component: add
 snd_soc_component_read/write_field()
Message-ID: <20210126133612.GB4839@sirena.org.uk>
References: <20210126122020.19735-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <20210126122020.19735-1-srinivas.kandagatla@linaro.org>
X-Cookie: I don't understand you anymore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 26, 2021 at 12:20:19PM +0000, Srinivas Kandagatla wrote:

> +#define __soc_component_field_shift(x) (__builtin_ffs(x) - 1)

Why not have this be a static inline?

> +unsigned int snd_soc_component_read_field(struct snd_soc_component *component,
> +					  unsigned int reg, unsigned int mask)
> +{
> +	unsigned int val;
> +
> +	mutex_lock(&component->io_mutex);
> +	val = soc_component_read_no_lock(component, reg);
> +	if (mask)
> +		val = (val & mask) >> __soc_component_field_shift(mask);

I don't understand why this is open coding the locking when it's just a
simple read and then shift?

> +	mutex_lock(&component->io_mutex);
> +
> +	old = soc_component_read_no_lock(component, reg);
> +
> +	val = val << __soc_component_field_shift(mask);
> +
> +	new = (old & ~mask) | (val & mask);
> +
> +	change = old != new;
> +	if (change)
> +		ret = soc_component_write_no_lock(component, reg, new);
> +
> +	mutex_unlock(&component->io_mutex);

This needs the lock as it's a read/modify/write but could also be
implemented in terms of the existing update_bits() operation rather than
open coding it.

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAQGssACgkQJNaLcl1U
h9DlKgf9FlXbJvk+CCVzGfmugYnMLXiQZZUgTx5sDr4Ulxd2ZLhz/j2mSFj8Ja2z
4nPYXI/DVdIyErnosbKx7bqd7NMhm61FhTAyr4CLbnB/2ZIRDcLw66HwsLcMtqW2
6oV0fd7YCyjs5kqaNToDn/upr3jWqOmYkKLGoOoFpIThQxce7QXmnlD1TkkmtTUa
cwUukMLQHb+kP3fTxJQ5F8++DvVZfFzRwQEuadPvzkA+uCCA/wyYT/S6+u8Kc3Hi
1vWfXsrwiqGqQEd4lsj1hPLeiJ+T/VRsy2qn0eYUUmPPj3eH00xFrwS3mXEHPVRH
K5Se9hdIHYO+s3HNPjepVcY0I0h1tg==
=mgxe
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
