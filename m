Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5022CA955
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgLARND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgLARNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:13:02 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5522206D8;
        Tue,  1 Dec 2020 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606842742;
        bh=LA/wyI+AskkviTCy4hXkk/OQ8SI/xkbgqynthnKkfrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BgB3WbMzAIPQBd6ApotKIIDrl50qszhyaW2UkK+t8EHwqSRABA9g/yztKH3hOALVF
         U5WetMNXk9HG97zmBOeXIuSt+551K9WAAP13xTs33vDe9rIBB/ITd1iGCpkPZKY1li
         9sWqzWIAxvsucj1nr+CQ8R7F+nXhjB+moOApdDw4=
Date:   Tue, 1 Dec 2020 17:11:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Message-ID: <20201201171153.GM5239@sirena.org.uk>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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
 <20201201162035.GK5239@sirena.org.uk>
 <8D0E8CDA-96EA-4900-B5B2-0AD371EAD046@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Content-Disposition: inline
In-Reply-To: <8D0E8CDA-96EA-4900-B5B2-0AD371EAD046@goldelico.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 05:41:54PM +0100, H. Nikolaus Schaller wrote:
> > Am 01.12.2020 um 17:20 schrieb Mark Brown <broonie@kernel.org>:

> > I think the problem here is more to do with where we started than where
> > we're going or how we got there - things have been glued together or
> > happened to work in ways that mean I'm not sure we reasonably understand
> > the situation we started from or all the requirements it has.  As you
> > say I'm not sure anything beyond throwing the API away and starting
> > afresh would really help here, but that's not really how we tend to do
> > things for a bunch of very good reasons.

> I think the key problem is GPIO_ACTIVE_HIGH 0 and GPIO_ACTIVE_LOW 1
> in device tree blobs. But that is so fundamental that we have to live with it.
> So I guess that even a new API from scratch wouldn't improve that.

Yeah, that's definitely part of it - more generally there's multiple
places trying to determine if the signal is inverted with different
interactions/expectations.  Having it in an ABI definitely contributes a
lot to causing trouble though.

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GeVgACgkQJNaLcl1U
h9CPMQf/SsrwU3DUXaX7CJ7+bYc0OzNzeBvjKkMchBWxHcnEyR7EKhZwHXxNhxbq
cH5SzVmeuM5I/HsQ0FGpI07ZRWo3nAUlA2QVEOjXYJ7fPFw/bMn10xi7KJzo2aNg
gWjAJtp8PfaW2J+bjoVCcRxyS5ppsBNj5AmSHr1ZDxHee4TZUZ8MvlbMvBXGkt6L
4PO0uMJ79QY3KuNzKr+GnceyW+mhcGIuW9OSJepMx+yK2m4ZmsRKy9kduN7Rg0WJ
ugMF9UY0qZHpsyXEjlgbaUJTOUBMZYhX36f6iUh3hHuTMZXrfEaoK3CEAj9jToYl
d3aLIj3j80SU6HUmqHYfdkfAqmMcsA==
=45IK
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
