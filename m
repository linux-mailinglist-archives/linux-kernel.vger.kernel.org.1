Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92472E7997
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgL3NPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgL3NPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:15:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5D48217BA;
        Wed, 30 Dec 2020 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609334065;
        bh=kEuawNue9TzrnwXiRThYrKd0UdmYu3uISluZYKgaTxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkX1Yn297+wLGWLXMYqS+ZQ2+tHDUqI3/h+weZJ3dea5UrKroxu3N/nuxo0JmfSHa
         dFdPnFHgHbYqOO7rZYTu4m0X64jljvejFBnoqP7YCwqqqoCVuGancOh/cnLVJf7UMe
         Pivc5pj3CabQ9hFbnvPYPJRnCgsCNUKUPf9KZoBZtwPyK46/8SUOwvL+RnqetZf/Q0
         fYoSokgw7GVrdcjK6y0bREKK1srj2soWEurgcfKdZvHJGJX63qOhoU1jhaXSNoTR6H
         1wctVJLVnYNMCXE8vb9tNytEWDsGcdGciKVMpHbSyLC2P4Dyo0Xs/gt3CT/shxHTFR
         MBMBGzrhO0yeQ==
Date:   Wed, 30 Dec 2020 13:14:02 +0000
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
Message-ID: <20201230131402.GA4428@sirena.org.uk>
References: <1609191951-15590-1-git-send-email-tharvey@gateworks.com>
 <20201229130629.GD4786@sirena.org.uk>
 <CAJ+vNU3hWOdXUoogCH0U_WvYaMMaFBYs8D30KEg96ctgkhBqyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3hWOdXUoogCH0U_WvYaMMaFBYs8D30KEg96ctgkhBqyQ@mail.gmail.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 29, 2020 at 08:23:00AM -0800, Tim Harvey wrote:
> On Tue, Dec 29, 2020 at 5:06 AM Mark Brown <broonie@kernel.org> wrote:

> > I can't understand what this commit message is trying to say, sorry.
> > Which bits are you talking about when you say "if bits are set"?  Isn't
> > acknowleding the interrupt clearing the bits asserting the interrupt?  I
> > can't tell what the problem you're trying to fix is.

> If for example status=0x01 the current code for ack_invert will write
> a 0xfe to clear that bit which ends up setting all other interrupt
> bits keeping the interrupt from ever being de-asserted. With the patch
> applied a status=0x01 will result in a 0x00 written to clear that bit
> and keep other's from being set.

But that's not an inverted ack as far as I can see?  That's writing back
the bit you're trying to clear which is the default ack.  Why do you
believe this is an inverted ack?  In any case the changelog for the
patch needs to be clear.

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/sfRkACgkQJNaLcl1U
h9Dtngf+PfNgCnvF4MCWZrEmFoPjuACYzqTyBE4kjzySkcrVNlzaiycSICYWjq27
Yp2nAXT824UsZgX3N6dem4QhSy9uoDHdri9QsfsBzi1BV6GefjscdUIQv/8e7ygw
QSaF0tLJA9ciO6cwrqR4YPpnWw91vRMIw4ngMQa1/vrDHxNn/XbwpOCiKwFoyEyx
jd3fiBRt72k/hmqCdPBGDMbs+JHgYjgGasNxjHkxKI1xf8Z9bv9A3py4ltso2PQz
IaX9C7sRRtAWY1D43FKBdUq7KnU4ly67fhQ2CvQUO6mT10b4tA9/+j0ShrewjloH
bJxDKMqAyQ1FXZmDZcFqK23EFINGUw==
=Dmq2
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
