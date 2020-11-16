Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E022B5393
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbgKPVOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbgKPVOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:14:45 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1612D20888;
        Mon, 16 Nov 2020 21:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605561284;
        bh=gfPKngfD4EQ5z/E0JWLSCaRtEJGlbAeJZSIz7NPV6iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X376lL2cJOXe6PhlDjQ5Zwe9eV8jBFDfigG4u1a3nqjHJmxEgescHE+takZ8xjEFt
         NPsWJAwEbTdLp5YwOv3AJwnV7WVSeBfVHLQoNfQH8MEq17sLZ/niUMQAfcNxdY6kq4
         vbPd4OELUe3lxc3M9iP6uNOM3WmyPJiSDEhMqewY=
Date:   Mon, 16 Nov 2020 21:14:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>,
        open list <linux-kernel@vger.kernel.org>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] mfd: cpcap: Fix interrupt regression with regmap
 clear_ack
Message-ID: <20201116211425.GK4739@sirena.org.uk>
References: <20201111170613.46057-1-tony@atomide.com>
 <20201113102134.GI3718728@dell>
 <CAJ+vNU0T0qS282MU-FRy8zNLgjnvF=+-5k=XxxXhZw6k2cgASw@mail.gmail.com>
 <20201116185903.GD4739@sirena.org.uk>
 <CAJ+vNU3Qrbd8bez+eiHaXrvntqpO_iDM0PSJN_RTAV5W6a7uOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3Qrbd8bez+eiHaXrvntqpO_iDM0PSJN_RTAV5W6a7uOw@mail.gmail.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2020 at 12:43:57PM -0800, Tim Harvey wrote:

> What are your thoughts regarding the issue of  regmap_irq_sync_unlock
> ack_invert ack'ing by writing ~d->mask_buf[i] which ends up setting
> all the other bits not trying to be awk'd? I would say that the device
> allowing an interrupt status to be 'set' and keeping it from releasing
> its IRQ is strange/broken for sure, but I'll need to work around it
> somehow.

My initial assumption with ack_invert would be that any bits we're not
acking are inverted as well - if we just write 0 to those bits then we
might be spuriously acking them.  I'm not sure if there's something that
is being missed with how this hardware is modelled or if it's just a not
entirely thought through hardware design, if I'm understanding it
correctly I can't see anything that can safely be written to the bits we
don't want to ack.  Either we cause them to be asserted or we might
clear them incorrectly if we race with that interrupt asserting.

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+y67AACgkQJNaLcl1U
h9AXwgf5AaFUxdfQuCTAUysGSkuVWkSME/2FIu4Q173zTyhFBKTZJJRo8omHShRO
nC+yAwuZ0tt05i79HmkWTSdzztyXr7pgKmqhO3xsXdShBy0Yun+xmzVByP1yUg8V
bHkKx/B10fChWqqRy4an9hIn935wRGjrsVrthOmvrKnTt/Mh2d6Z7Vf2CkZrlT9v
yeArsHCqIdpZQz8XCmB7MHpbyxEQWEXpbGMu178jwO+dK/js6YA57K4KkKrLzEHW
0jSLGf1FboaXSeDiJ6PrTAKl8yPnfh+VqDyKWDv820GRWtPxr/ld3V0zZvcPJSdE
gk2HKaFWQWV55si+iLoeFCcwBUAZ1A==
=TGnP
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--
