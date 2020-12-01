Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC01D2CA81A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392160AbgLAQVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392161AbgLAQVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:21:46 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A612822244;
        Tue,  1 Dec 2020 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606839665;
        bh=xP4j4dXsCh30TdsYod/HR//GppU6cYvfO1KKkPvjTqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1yhp3E8gT7DGv2tlmpvZZHWpzg0LWNNQQfIxYQvkFibtA1EYqlA2q/0HNeCmrRcO
         JtUwWVIfVMuNAfT+XS4Doat2hN51sW2T4H0+cEfpJFw4pHKcVr5irWXGYd/o8uzXC8
         E5YZAmgfjOWgiNuhbuqhE8jNqObxHmf8YnndbIfk=
Date:   Tue, 1 Dec 2020 16:20:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Message-ID: <20201201162035.GK5239@sirena.org.uk>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com>
 <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com>
 <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline
In-Reply-To: <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 03:20:12PM +0100, Linus Walleij wrote:

> The reason why I shoot in the dark to convert all SPI
> drivers to use GPIO descriptors instead of the global
> GPIO numberspace is detailed in drivers/gpio/TODO
> so I will not repeat it here.

> I don't know if much can be done about it other than
> having better programmers than me at the task. Or
> less tired when they write the patch. etc.

I think the problem here is more to do with where we started than where
we're going or how we got there - things have been glued together or
happened to work in ways that mean I'm not sure we reasonably understand
the situation we started from or all the requirements it has.  As you
say I'm not sure anything beyond throwing the API away and starting
afresh would really help here, but that's not really how we tend to do
things for a bunch of very good reasons.

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GbVMACgkQJNaLcl1U
h9DRFQf/bvSVNPMLgac30kzXhteF7a25VMyxoCwA6rMBM8pqRmBuy3rZSeU7A1eb
065JN5kiKk0oHCUj59v3YYEmXmr1pCS8GFfR47Lak2Zj1mRFxBQyNp8/C+C0qYfg
iwPhAiMgszQTNBYveu7xaHc1fFBx0Lp6LXPH+A9UgH5U2ZBlBZvVpKlPyU98xL8p
ViWfwrdZ1c/haC4/O5IunDU7zCueemxw6+2diHFBPZw9FhrdKaBMl2bU7+kNo/1b
28VqPrgsyz8E1ajLnBlFr4QV6cPcs7R8dMw5Haq2Re/yPz8Mfhf5QWqO9BIeEigm
4w6MUZgsKQ9ZPPtsiQT7AxpSXqOOCw==
=pEP0
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
