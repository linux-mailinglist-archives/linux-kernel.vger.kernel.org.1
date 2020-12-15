Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B282DADBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgLONHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:07:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbgLONHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:07:14 -0500
Date:   Tue, 15 Dec 2020 13:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608037593;
        bh=Uod4nMpOOrRjOsLENvuzNJbN8ELO9H00HLMh+67VhI8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxPq4f3fLULk2R37OL6R/QFMvBb8RWD0uwv4YI+BVl72raahZDbRUQC0gQWG/6p2V
         +LmcZJnPKkKFP4AVL/cqy2myi4hgp1tuNOnZmB2RwIxUczJXhUBCPVnIG/xAvgaTGZ
         ufkEChjqUgXdRJVcD9lR4HowXRd13oKK1Z6whTcujhn3/8/H8HdrAwpzmBhF9o9nI1
         JfsWiENeyL2L1C2NRxDHyqS56jh+qMZOr+PeVDegOKipiNYvJIjfgRsIgULelyXTVX
         O3gNxw1BnMKN4JsQqjy3fZWi01vqnapj6DE9Sy2fLXM8GMobfCWBmBbj8E/Q3reK7V
         7HqHyWxvhemZg==
From:   Mark Brown <broonie@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 0/2] Add support of nxp pf8x00 regulator
Message-ID: <20201215130622.GD4738@sirena.org.uk>
References: <20201214225851.23342-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <20201214225851.23342-1-adrien.grassein@gmail.com>
X-Cookie: In specially marked packages only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 14, 2020 at 11:58:49PM +0100, Adrien Grassein wrote:

> this set of patch intends to add the support of the pf8x00 PMIC
> regulators. This family of PMIC contains 12 regulators (7 bucks
> converters, 4 LDO, 1 RTC supply). All these 12 regulators are
> configurable via an OTP memory and by i2c at runtime for some
> specific properties.

This looks to have raced with the addition of support for the same
device by Jagan Teki - unfortunately I didn't register that I'd seen
other patches for the same driver go past so I applied Jagan's version
(both look to be based on original work by Troy), sorry about that.
Could you please take a look at what got merged and send incremental
improvements on top of it - I do notice that I missed the use of the
wildcard compatible in there so that needs fixing at least.  :/

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/YtM0ACgkQJNaLcl1U
h9CzUQf+LlkFufXlpHyrDMO25NjkdjPOwmbWd7bzhrYkT22KV9OlfBpdd+vyax52
oHyaE4/RJNXapo3iK8DpzpmZ8C+Ooqq7pee6idfqsV2KMVdOEmssgjDUl1/dUUbf
CTXQRVgsQ0bhYzouVBErHYwhItsCos1ekIbLq1Xd4pNLUwsnTEsMUrLR+AzeUk46
YJU65mYjUc4neULuAKnK5PneEScBsLR/I/ACHrfAzZGADeSVHnYkhgZMyvYs4BxX
fBeUnZoShVnFERzj/YkYqdc6WhglQ+K0lVlAa2yrZzI7BeIGova8RJU7/MiVq3Nf
5Svrj/0oc9J1kKaYFejqIkYP1H1ObA==
=qF4t
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
