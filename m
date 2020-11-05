Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7112A80E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgKEOaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgKEOaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:30:02 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F992078E;
        Thu,  5 Nov 2020 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604586601;
        bh=7Cpc7oTk9waps+0sn1Z129Z3jSrH4E4ebAchcTAYVZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyqaZINUxyFkyzMBgavBB8W7enAKYN679T/uskcZreZ/usqQGL/BnUfmhSVI7ngY8
         vS2fVGjT5idF2Pk1fQPKPzqMz4p+9gZncgpg8W0iR6e1ilgbn2By0Cb9x0JqK2QlBx
         ABz21xTbYfH9fTLS7WIui1kyeav9pBNyVBeeNHQA=
Date:   Thu, 5 Nov 2020 14:29:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20201105142949.GB4856@sirena.org.uk>
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-5-andre.przywara@arm.com>
 <20201105134142.GA4856@sirena.org.uk>
 <20201105140322.GH82102@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20201105140322.GH82102@C02TD0UTHF1T.local>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2020 at 02:03:22PM +0000, Mark Rutland wrote:
> On Thu, Nov 05, 2020 at 01:41:42PM +0000, Mark Brown wrote:

> > It isn't obvious to me why we don't fall through to trying the SMCCC
> > TRNG here if for some reason the v8.5-RNG didn't give us something.
> > Definitely an obscure possibility but still...

> I think it's better to assume that if we have a HW RNG and it's not
> giving us entropy, it's not worthwhile trapping to the host, which might
> encounter the exact same issue.

There's definitely a good argument for that, but OTOH it's possible the
SMCCC implementation is doing something else (it'd be an interesting
implementation decision but...).  That said I don't really mind, I think
my comment was more that if we're doing this the code should be explicit
about what the intent is since right now it isn't obvious.  Either a
comment or having an explicit "what method are we choosing" thing.

> That said, I'm not sure it's great to plumb this under the
> arch_get_random*() interfaces, e.g. given this measn that
> add_interrupt_randomness() will end up trapping to the host all the time
> when it calls arch_get_random_seed_long().

> Is there an existing interface for "slow" runtime entropy that we can
> plumb this into instead?

Yeah, I was wondering about this myself - it seems like a better fit for
hwrng rather than the arch interfaces but that's not used until
userspace comes up, the arch stuff is all expected to be quick.  I
suppose we could implement the SMCCC stuff for the early variants of the
API you added so it gets used for bootstrapping purposes and then we
rely on userspace keeping things topped up by fetching entropy through
hwrng or otherwise but that feels confused so I have a hard time getting
enthusiastic about it.

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+kDFwACgkQJNaLcl1U
h9ApKAf+L+RsRcER02kUvtZaA3aURIv7gEO9F8JuiH9/H3k1obk5bhnah70SMZfH
7DAuojVb0QQPx47KtqF//t8Zf0NBRcbzOH8tdcT9dra1LeCyeFWX/aTR5jjxPECj
qHsdK0a8Cp73kXJpz83zbCuZcxzDVXIJkQZs+9OAAFVH/l5kriIcsT2DDXbA/gJN
45gX+XnMHGRoDoiMu5LfRGA4YFqWYqiJtTau2Njm203qFQL1de4sD5VGpaLM+IXk
bOVcl9wuMwxWRy7b7JRaJ1m5lE7kXVG/RKYeZUoCekZtDAqYdcU5t7n7QrNKJAJW
xIIvhhLZjhtp/RhDtiI0lL4B0ENuhg==
=hyQv
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
