Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52C42776A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgIXQY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgIXQY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:24:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 205FB2311B;
        Thu, 24 Sep 2020 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600964667;
        bh=TNIV8jiawlO8N+rmVQ68o2B8523em0D1n+spp8HhaP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4H8mF+wVAS63Wa52sHiO/OEFSqGOKCdRPuVxSj1/w0lFPrGKXAp0p96rYGxeu1Tp
         NhYvX/mdgpONbJDapKD0qb0+pfErAWANbgwxgQBleCfDqLM/a1EbglWJ5EUfgrQG6c
         p29UT45ci6pl9LWolw076I2jFVFxeASqNT3lEZFo=
Date:   Thu, 24 Sep 2020 17:23:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] regulator: rtmv20: Add DT-binding document for
 Richtek RTMV20
Message-ID: <20200924162332.GH4754@sirena.org.uk>
References: <1600959891-16606-1-git-send-email-u0084500@gmail.com>
 <1600959891-16606-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline
In-Reply-To: <1600959891-16606-2-git-send-email-u0084500@gmail.com>
X-Cookie: Programmers do it bit by bit.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2020 at 11:04:51PM +0800, cy_huang wrote:

> +  enable-gpio:
> +    description: A connection of the 'enable' gpio line.
> +    maxItems: 1

-gpios.  GPIO properties should always be plural even if there's only
one GPIO.

> +  ld_pulse_delay:

Properties should use - not _ and for all the properties specifying
things like times you should have units so...

> +    description: |
> +      load current pulse delay in microsecond after strobe pin pulse high.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

...add -us here.

> +  fsin_enable:
> +    description: Fsin function enable control.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 1
> +    default: 0

This looks like it should be a boolean property not a number.  The same
is true for most if not all of the other properties with min/max of 0/1.

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9syAMACgkQJNaLcl1U
h9BsGwf+ItelO+H8EpmaJ8urPDoX/CfQCXJLdELSeIXOrUuL0NxOlMgAoqNsRPCX
WHp9vY+4mu6yHFdtd8ZEHgoCAxtkSW6s7D/8aWDrIT3iEyyCTzrC5asX5xYIO6Nb
3PKrpDVIGVNuZ9x0AiP9rXooelRfmxzYNzmeVYTkFFl1/z6caW4oTIZHWtPY4zQ1
gBILbaJZE7JbKhbmqcYnLXQcWtU+ZgmJAF53B4zpU0Di3+F70gvo1paPfm6vZhIS
F7lGA4WQU4//OrO+ILY1e+NeBojvW4OlwPTBHpJ8oaggO2LzUYvDXpQFWYiS0CXd
0XxdrkyfVG/FKFMzhmfoSW5OGqML0A==
=n9fD
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
