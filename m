Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05BE22623D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgGTOfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 10:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgGTOfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:35:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E4022482;
        Mon, 20 Jul 2020 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595255746;
        bh=Y6B8G2b8iXkRUX81X59D0ldjRYsc+RbBqg3PqviG4i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=daUNMmoHRUK4zWKdc0rKOIcsSto+m2ePq2+ZP4P4/UqPa4OoYXlkg8zURwTkQyd/V
         EagKKCCxF4k5r/V6g+ROkYptxpCGVuO52qqK3ts3QO7ZKptuIIhxJk9aPUJo59T72k
         JMAVE0dDL6j0SDlEI37/vciyoXF5r+77tvoOAqQA=
Date:   Mon, 20 Jul 2020 15:35:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 4/4] regulator: core: Add voltage support for
 sync_state() callbacks
Message-ID: <20200720143533.GG4601@sirena.org.uk>
References: <20200716042053.1927676-1-saravanak@google.com>
 <20200716042053.1927676-5-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Content-Disposition: inline
In-Reply-To: <20200716042053.1927676-5-saravanak@google.com>
X-Cookie: Be different: conform.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 09:20:53PM -0700, Saravana Kannan wrote:

> -	if (!handoff)
> +	if (!handoff) {
>  		regulator_disable(rdev->boot_limits);
> -	else
> +		regulator_set_voltage(rdev->boot_limits, 0, INT_MAX);
> +	} else {
>  		rdev->use_count--;
> +	}
>  	destroy_regulator(rdev->boot_limits);

These sets should be completely redundant since they will go away when
the regulator is destroyed, if there's an issue with that we should fix
it rather than bodging around it.

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8Vq7UACgkQJNaLcl1U
h9AbBAf/Qddst65GAAbnNtlWRzGwI2Gvnz7Bv2M5dPDn/n/jZaiJqz+IWb0KPhLN
6xE0tm2LMe8VfwkD4EmsHzw9/vYtpO16Z3VjAaTeOM3PjwKM9/+7a8UnrNrxuBDq
iX5rH3HgVWDmp7k4BA3um4jYvBu7vyecRgDRxTiR3YtkDaBX+Cw8Me88N//0qWUo
j/YryC9irJnU4dYCskZAlk4qNqfqiryT5aBcTiAXvuMenH92UFKnJJ4A4Nr5sUW2
lAlHr+iSENeXoMkx6IPCtrsh+/SaxBC3CnEE/UtMC15vYsd8GXK/Pf/XojWZdjfu
tM1yz0WLp5BRZechDOvwHmu9MMDeLg==
=kWv2
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
