Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E2927E852
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgI3MQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3MQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:16:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F1E12071E;
        Wed, 30 Sep 2020 12:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601468211;
        bh=6LXq8gQ1YOm/ULhKrDEsjuVBjE+t/GvywlEKlPJeIwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yvvCKGaQPY/0J9zohn6rjekHLo3V4n5o5xuCmbyd0fGBwVaPl4VVDTUiKMJWiD5nw
         Yi/ioiuVWJUBokdZ1dXniV6YUJ2HVrOk7/nbHR9SWTj6Wuh1wC5P5kbCgQQ+wO/zG4
         9nTGgR/3TmrP6B/MmA5JrS8yjbx1H4tNupEZR6Cg=
Date:   Wed, 30 Sep 2020 13:15:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        rafael@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org
Subject: Re: [PATCH v2 1/2] regmap: add support to
 regmap_field_bulk_alloc/free apis
Message-ID: <20200930121552.GH4974@sirena.org.uk>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
 <20200925164856.10315-2-srinivas.kandagatla@linaro.org>
 <20200930115915.GB1611809@kroah.com>
 <20200930120849.GG4974@sirena.org.uk>
 <20200930121100.GA1616135@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAgJxtfIS94j9H4T"
Content-Disposition: inline
In-Reply-To: <20200930121100.GA1616135@kroah.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAgJxtfIS94j9H4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 02:11:00PM +0200, Greg KH wrote:
> On Wed, Sep 30, 2020 at 01:08:49PM +0100, Mark Brown wrote:

> > We have managed versions of the other regmap allocation functions, it
> > makes sense for consistency to have managed versions of these too.  I
> > think there's a meaningful difference between a simple and expected
> > wrapper like these and infrastructure which hasn't been proved out by
> > users.

> Ok, do you think these are really needed?

> A review would be nice :)

I applied this patch the other day - ea470b82f205fc in -next.

--uAgJxtfIS94j9H4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90dvgACgkQJNaLcl1U
h9CIIAf+JybWoPGkKVaBPJiSpiAgkz7QPd60n/DEPROggQpFDdDWfwq5e8bPqYt3
OHGCWnf2/3iU0Y0+FmsjaqXKsYk/7rbhSiuVZvu+AM567pkO24IOHVT1CywN8uUY
PoWIC7Ndu0ojMJI3sr29AucRDUCUKhqVd9slHbFQWTWuFuLBoEFgZAFXgg3jvFuD
CLEYenylSDz1eBjwZ+1a6ypyy7TafJ6SyKvrdEAO1+8sIIs3jmxhXJIBb3kM9Mf5
zqV741lUEZwJKE0OqkEfObPPt68GeEqTyIYGbvrLQ2Wi/5yCkgoh0gzYdx+pbbNz
nyjOcXsojBy33jlbYpegPM9lpHgPPA==
=4nBl
-----END PGP SIGNATURE-----

--uAgJxtfIS94j9H4T--
