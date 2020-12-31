Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1822E8038
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 14:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgLaNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 08:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgLaNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 08:31:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE40E223E0;
        Thu, 31 Dec 2020 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609421465;
        bh=uFyi6qCM4XdCJrYaY7F2FT8n8IxEKWuq7KkMy82dDsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qg7cMHH3C0nK4Sb2r7cWswvFyrJHIny843JvK01AlG5v4RNFoLuwyQhVjXu52FjfN
         /RWCFj9YBI3kEni+wtsHOWKhmThSHwYl9AUB+oP9OhSSAv0fDF4ktKkVHpCUQI9GyN
         Av4riy1gH4szyj+RQVfajfUuY5imGJgwSpRRTbi8WVYtLv+8HmpLLlmMee6fmtdIp0
         MPWfffl+ha08QXZbDpZeBMEgKma9QMCNE43Lfb/nT0DwTmFTyFyCUe90mlta1mxOfe
         K26xhh2EYHsaM3ymyjN4mxlRlCH/4umV/ly4RGfyJsN6t6pMNMfa2H3dhv6M/EBtp4
         PrNRFSmgxoq9w==
Date:   Thu, 31 Dec 2020 13:30:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH] regmap: irq: do not allow setting irq bits during ack
Message-ID: <20201231133041.GA4720@sirena.org.uk>
References: <1609191951-15590-1-git-send-email-tharvey@gateworks.com>
 <20201229130629.GD4786@sirena.org.uk>
 <CAJ+vNU3hWOdXUoogCH0U_WvYaMMaFBYs8D30KEg96ctgkhBqyQ@mail.gmail.com>
 <20201230131402.GA4428@sirena.org.uk>
 <CAJ+vNU0rC65wCpt3m+_pp6Qufw8Ni97Z4o5j3n3LTqBYzCvyxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0rC65wCpt3m+_pp6Qufw8Ni97Z4o5j3n3LTqBYzCvyxg@mail.gmail.com>
X-Cookie: May I ask a question?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 30, 2020 at 08:37:17AM -0800, Tim Harvey wrote:

> It 'is' inverted ack because the device I have requires a '0' to be
> written to clear the interrupt instead of a '1'.

Right, yes - misremembered there.

> The chip I'm using has a status register where bit values of 1
> indicate an interrupt assertion and to clear it you write a 0 (where
> as the typical non-ack-invert case you write a 1 to clear). The chip
> I'm using also allows you to 'set' (by writing a 1) to bits that were
> not already set which would keep it from de-asserting it's interrupt.

> Honestly I thought the commit message was very clear. What exactly is
> your suggestion? It is of course confusing when talking about code
> that handles both ack invert and the normal case (let alone the new
> case of 'clear_ack').

First you need to write a commit message which explains what the change
is supposed to do.  Like I said it's things like talking about how "bits
are set" without specifying which bits you are talking about - which
bits?  You mean other bits in the status/ack register but especially
given all the talk about ack_invert in the commit message and the fact
that it is very unusual to be able to assert an interrupt by writing to
the status/ack register it's a bit of a jump to get there.  It could be
something to do with masking non-ack/status bits in the register, it
could be something to do with confusion about what inversion means, or
something else.  Something like your above explanation is much clearer
than what you wrote since it explains the unusual behaviour of your chip
which causes problems which makes it clear which bits you are talking
about.

The behaviour you are trying to implement here also needs to be opt in
since it will be harmful for other controllers due to it being racy, as
far as I can see with your controller there is no way to acknowledge a
single interrupt, we have to acknowledge them all since the only
sensible thing to write for any bit is an acknowledgement.  This means
that if handling an interrupt races with a different one being asserted
then the new interrupt will be acknowledged before it is seen as part of
acknowleding the original interrupt.  You could also express this as
doing a read/modify/write to clear just the bits that are asserted but
the effect is the same so probably an ack all mode would be easier.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/t0oEACgkQJNaLcl1U
h9CMUgf9HmHBsYfvYjnCnk9u490lZJyD4ywtAF1CXd0UL8IkCA8rs5s3iFGzAcJu
keepgLrOkv9SpJfEfXhUE6yugzKfHrALEXG0qGnoERKMigHoCYyO/2SFn2mNCFMc
YylcwQjjRE83K2IyAglP8RJYc5W32g9CJtoMT9kdSEexJCGIm4h96RG64ecnOA/v
p7n/OxEJ+yuq5Kk2G/+GsakXv8R8hRKTqAF9pzxHWEVkCzbaLbHpgFirwAQmOrlz
a+TSmQwxfwDCeCRaaCz2Mf07L3UFW42TWvmMqQzKwbOZa02CVU54P7cqsVpnrIMI
a/G3oHBGtwCeQitJs/4RUCmPPIF9Mw==
=JdOG
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
