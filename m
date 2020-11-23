Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F822C1262
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbgKWRuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730919AbgKWRuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:50:05 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE0C20758;
        Mon, 23 Nov 2020 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606153805;
        bh=G/ATYRSx04ZTfY6ztEdVXDvkxBMFAS7qHknE/7UJp/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wh5nLi7j20vQZbpn6lrz2NSsxZjdob6/OwIev52NjG+KTNjyg2SVDB+rNlaYkMnP5
         R/eMx46/Ah5jobstysGAzChAl60IwzHdvz+fAzsRVY4foDllMcldHQgqVsN/PvbnJy
         /Xo8y3xPib2sMuEgTg1uM61GvuVrpDhV6HwMXt8E=
Date:   Mon, 23 Nov 2020 17:49:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 5/5] regulator: add SCMI driver
Message-ID: <20201123174941.GM6322@sirena.org.uk>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
 <20201119191051.46363-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aiCxlS1GuupXjEh3"
Content-Disposition: inline
In-Reply-To: <20201119191051.46363-6-cristian.marussi@arm.com>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aiCxlS1GuupXjEh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2020 at 07:10:51PM +0000, Cristian Marussi wrote:

> +	ret = handle->voltage_ops->config_get(handle, sreg->id,
> +					      &config);
> +	if (ret) {
> +		dev_err(&sreg->sdev->dev,
> +			"Error %d reading regulator %s status.\n",
> +			ret, sreg->desc.name);
> +		return 0;
> +	}

If we failed to read the status we should return an error rather than
claim the regulator is off, other functions return errors so I'm not
sure why this one would be different.

> +	vinfo = handle->voltage_ops->info_get(handle, sreg->id);
> +	if (!vinfo) {
> +		dev_warn(dev, "Skipping invalid voltage domain %d\n",
> +			 sreg->id);
> +		return -ENODEV;

I'm not sure that this error message is the most informative - the issue
is that we failed to read information, we don't know if that information
would have been valid or not.  Same for some of the other enumeration,
it's a failure to read not a lack of validity isn't it?

> +	/* Allocate pointers' array for all possible domains */

No '

> +	rinfo->num_doms = num_doms;
> +	/*

Several places like this with missing blank lines.

--aiCxlS1GuupXjEh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+79jUACgkQJNaLcl1U
h9CE4Qf/atg7UVORFzOQ88YH5Fxqk0AiOlCz1PaMCo5evo3Eq4oAjUeqYK4jo0Nq
Yx+vWX8Q+/xbmv0oNedpaBnqpr8O0uE2Y6RJ4u/4+8emKzP8oV74GZNQVGWN1vT4
dYAh8fu/YS87cqaPIq7jtypXcTF3k/4mmNkb9bZguDiWkXq7XbL8UZ84BKAuOyTJ
IIZ1xriwV4SUYYbynHpwHPwZuBY6A7zWf16fbws4a+cJCZINCFj3xaI+/nWAQKon
j6qcAIPXNuChlaxLZ6T7gUkZwZ6ybDJ2M68xs+uYboRSpAbYE+umjOI7ZfqYNAMW
YqK60aLYV+f16L9i5q+C8o9LcnJ/pg==
=uDv9
-----END PGP SIGNATURE-----

--aiCxlS1GuupXjEh3--
