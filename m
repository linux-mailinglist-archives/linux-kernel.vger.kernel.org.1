Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918692C11F8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390337AbgKWRac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbgKWRac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:30:32 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B93420756;
        Mon, 23 Nov 2020 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606152631;
        bh=jZAyf44XEJ63YGzntuI9QS9uCCqjwsUWpemYZO6K/j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzPbjJyR3S1ljEHznqiVrGFIQL/DdLsBKTX3+U4jClP0SaqKnA1h6ryZ8b2lfoQUz
         JxotMk8lfJUnr3W1fhISc1DIJWGoVX/pTjNVUeiwdEve9+CL1jcpdYLjxQKJYsTqBz
         llWOrIZ9DcIAqyOfeLqMdvGd1UsdmhNKvvacA5Dk=
Date:   Mon, 23 Nov 2020 17:30:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 4/5] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201123173008.GK6322@sirena.org.uk>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
 <20201119191051.46363-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/0P/MvzTfyTu5j9Q"
Content-Disposition: inline
In-Reply-To: <20201119191051.46363-5-cristian.marussi@arm.com>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/0P/MvzTfyTu5j9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2020 at 07:10:50PM +0000, Cristian Marussi wrote:

> +This binding uses the common regulator binding[6] but, due to SCMI abstractions,
> +supports only a subset of its properties as specified below amongst Optional
> +properties.

> +Required properties:
> + - reg : shall identify an existent SCMI Voltage Domain.

> +Optional properties:
> + - regulator-name
> + - regulator-min-microvolt / regulator-max-microvolt
> + - regulator-always-on / regulator-boot-on
> + - regulator-max-step-microvolt
> + - regulator-coupled-with / regulator-coupled-max-spread

Please send a followup patch removing this stuff about only specific
properties being supported, that's just asking for bitrot and is equally
true for most regulator drivers - people shouldn't have to do do an
audit of every single regulator driver to add a generic feature.

--/0P/MvzTfyTu5j9Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+78Z8ACgkQJNaLcl1U
h9BL2Qf/TbykoE9PqJE+toHFuAdOeziZcfji79JoqyXjCRXfFqkAldGCKFr5XeEa
QAUG+FKLLWSRcckC6qHkDJ9fC+aKeudUlkGA1cZ7PNq65AJ5z+BoPQptOxcICH/7
QM08KDCSSS1X0bhaAosqwDHx/N93Svqy6AekVf/gKAN1GvQv0EaGTVpWHSiFpNkX
+2/QLCXehqa61xMrx8hzTmSGmNFuih5DOYlkDueIu1N1VhWmJ7PNNhb3STWDOw62
hZ0afLS+NihPL6dD2cNcGcW2sgK66cxtWKBlMVXnm9Pq7yt71tUyN8qH/vs2ckd8
O+pVojSjx/fIoCmL2hdd/eBRjpvrkg==
=wP12
-----END PGP SIGNATURE-----

--/0P/MvzTfyTu5j9Q--
