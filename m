Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5502D7682
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406157AbgLKN1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:27:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732317AbgLKN0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:26:38 -0500
Date:   Fri, 11 Dec 2020 13:25:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607693157;
        bh=zV0+PJVqq/6Ty7VyrOTPWj/asMAFtHbEdvX2cea7ICA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7kf59SLpcwsLqDjWeoPIsvlkD68M1JT0CT59E3SfYcmFdr2ZnfOOywgjdOEWZ67O
         2J2yqocrm6CqM6y5DYek3RASwjzbx2pIP3WznUVLABMnWXfdrzLkKWUp6ebXDGBQc0
         YY55J9AQIuupy//VHBoTIpIZ7Di6R9P5T+1NS5bAdwytQTGiwA2h/Rb+JcXUi68ac+
         EUl4XjjHUZvk88VYqCH3Z0Qw8cgjno9NMYP6EJZpB6XBC3EuO0OHuLgQdvqhnbQpVh
         SHS98Rsg93FIYxtNJbrJs3H5WYjEJ10MG+iPioBfNoAfkt5/tiLN9eTQjKdlSdylE+
         2YHqB3Ubx/UcQ==
From:   Mark Brown <broonie@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        troy.kisky@boundarydevices.com,
        Gary Bisson <gary.bisson@boundarydevices.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add pf8x00 regulator
Message-ID: <20201211132549.GC4929@sirena.org.uk>
References: <20201206002629.12872-1-adrien.grassein@gmail.com>
 <20201207135551.GE5694@sirena.org.uk>
 <CABkfQAF4AANtxptY+XB2cR6hpz2i2Km+F5U=R67J57zSfnoGMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <CABkfQAF4AANtxptY+XB2cR6hpz2i2Km+F5U=R67J57zSfnoGMA@mail.gmail.com>
X-Cookie: Nostalgia isn't what it used to be.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2020 at 11:24:17PM +0100, Adrien Grassein wrote:
> Le lun. 7 d=E9c. 2020 =E0 14:55, Mark Brown <broonie@kernel.org> a =E9cri=
t :
> > On Sun, Dec 06, 2020 at 01:26:28AM +0100, Adrien Grassein wrote:

> > > Add dt-bindings for the pf8x00 driver.

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.
> > Look at what existing commits in the area you're changing are doing and
> > make sure your subject lines visually resemble what they're doing.
> > There's no need to resubmit to fix this alone.

> For v2 I just copy-paste another commit message to be sure to be conform.

For patches for a given subsystem you should use the prefix the
subsystem uses, for regulator that's "regulator: ".

> > > +            $ref: /schemas/types.yaml#definitions/flag
> > > +            description: |
> > > +              Only available for ldo2. When specified, use the VSELE=
CT pin
> > > +              of the chip to control the output voltage of the ldo02=
 regulator.

> > Shouldn't there be a GPIO specified somewhere or something so that the
> > VSELECT pin can be controlled?

> I think I read better documentation for this point. Sorry, it was very un=
clear.
> VSELECT is in fact an input pin of the chip. The configuration just enabl=
ed it.

Then presumably you need some binding to specify how to control this
input too?

> > > +          nxp,quad-phase:
> > > +            $ref: /schemas/types.yaml#definitions/flag
> > > +            description: |
> > > +              This allow regulators  sw1 and sw2, or sw3 and sw4 or =
sw4 and sw5
> > > +              to work together to deliver a maximum 10A current.

> > Presumably this must be set on both the regulators being grouped
> > together?

> Not. Only the sw1 configuration will be taken in account.

That needs to be documented then.

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/Tc10ACgkQJNaLcl1U
h9CUHQf9GdhzT1l0bJ8ieJTDzGxj4ZTRet9hmpKDkIQ2sf7tccI6LR2cVXIXu5UC
vn31RxDC0hVhjaYiQEjsd14iZgHevqGDXbeiOHgkNKJHAjneYh6CP2KqqHhCcXki
wWcR4cr0nkEzEpVImPL5Viwl8Kni+0W+BORW99WN3XaDXuUH+A3JgLMkk05Mktht
k0RyjlziY8tFChrgfeoJkvDxdlausoH6GIj/NkjmKnN1MbcHS4f19OhIIMmZIn4j
X5BP2GKyzB+VtNixJHnqmyomm+nzNHNQLco5le8nZkrvGErwaK4FyQ1vnLhG5l4g
c/EONq9oC6OKLzmxf9BEph4oi4Y+KA==
=FEnr
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
