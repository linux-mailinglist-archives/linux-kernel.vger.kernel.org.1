Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C740C27E83B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgI3MJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbgI3MJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:09:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6072076B;
        Wed, 30 Sep 2020 12:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601467788;
        bh=1GTC8SRCnNrTosWqqklpAjzX1/ju1u6RMterROWEPhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SoqqiXYYtCbZwLv4CBr6ywp70susjjkAUuCRez4RifJf9NOx43xODsr4FFvhprY8w
         lspN1oYnnMMrdX5SmSKCgxUH4oKweQRBBPjFQq8qxuq62RG9Tn+xRNHpBhRcYY5+ZZ
         ZkQrBxFE+djGs0NuF0qGLuRjhzr2t27n26maZdD4=
Date:   Wed, 30 Sep 2020 13:08:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        rafael@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org
Subject: Re: [PATCH v2 1/2] regmap: add support to
 regmap_field_bulk_alloc/free apis
Message-ID: <20200930120849.GG4974@sirena.org.uk>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
 <20200925164856.10315-2-srinivas.kandagatla@linaro.org>
 <20200930115915.GB1611809@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Content-Disposition: inline
In-Reply-To: <20200930115915.GB1611809@kroah.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 01:59:15PM +0200, Greg KH wrote:
> On Fri, Sep 25, 2020 at 05:48:55PM +0100, Srinivas Kandagatla wrote:

> > +int devm_regmap_field_bulk_alloc(struct device *dev, struct regmap *re=
gmap,
> > +				 struct regmap_field **field,
> > +				 struct reg_field *reg_field, int num_fields);
> > +void devm_regmap_field_bulk_free(struct device *dev,
> > +				 struct regmap_field *field);
> > +
>=20
> You only have a patch that uses these last two functions, so why add all
> 4?  We don't add infrastructure to the kernel without users.

We have managed versions of the other regmap allocation functions, it
makes sense for consistency to have managed versions of these too.  I
think there's a meaningful difference between a simple and expected
wrapper like these and infrastructure which hasn't been proved out by
users.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90dVEACgkQJNaLcl1U
h9DqdAf/UwybsAE2LFW9S9QqUszk6U+MXn6TU63FjYLKKYN8rOlIXL/H0VTyKO9D
SXNaLaMKOXyfzUoyYJ53fGbGGBMJ8EiNVusJGslDmGdr7kvIS7t65hkk0Jp5eiRc
By20kZf/SWuk1ZHXyXKPUCZcBebj3bHxLkZkhsA4X89FXELPFc6NlzYbZrUF4MXg
mMqyYwJXfU16KZYKoZ1yWz7SOoRTra3ytNhk/z/nEFpXqgwfQwL3CaSVubGanNkw
AjX61+6+Qmh/K6MuXqnj6DxdmxdxqdgwXqKleDOkGbBPV9ExnQH9gcdswvqcxwB2
NhCtpDOmDdsXMWFKgJBsKLSNefUrQQ==
=QsFr
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
