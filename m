Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A32CA283
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgLAMRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgLAMRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:17:30 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0096420663;
        Tue,  1 Dec 2020 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606825009;
        bh=l1GMxy6iYYXn5R+UWIsB1z155EjYuFIt1upiN5dmCW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMxvM3raXFd7SGQ1Yt4DbT7Hfc26CI3m4ardFEzNDPohzUGGyN+A/UMu5hfGKveea
         D/Huo5em1AsSUY8zr7kc05h9F+E7mIZ3NlXY1TQeoApiqbU0iQ/3aJWnVhNdKXRlhk
         er9URI9OTVS4v4DH4N5xPUz8RKiOnrzXYXYvqDjA=
Date:   Tue, 1 Dec 2020 12:16:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Message-ID: <20201201121620.GB5239@sirena.org.uk>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 09:59:43AM +0100, H. Nikolaus Schaller wrote:
> > Am 30.11.2020 um 21:13 schrieb Sven Van Asbroeck <thesven73@gmail.com>:

> > We knew that there was a chance that our fix would break something else.
> > But hopefully "it fixes more than it breaks"

> Then it should not have been applied to mainline but fully worked out
> and tested.

If you want to see better testing of things in mainline please
contribute to the various kernel testing efforts that are out there,
there's a huge range of systems out there using the kernel and it's
simply not realistic to expect that they'll all be covered, the testing
effort for the kernel is very much a community effort.  If there are
things that are particularly important to you the best way to ensure
that they are tested is to provide that testing yourself.

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GNBMACgkQJNaLcl1U
h9A8KQf/SJCVGLfb20XnxsWxv3d7a5Hzl+nO6J2lIXx4VNC7JgmndrFDe/y/PXnd
zKpo9X7lQQPcc989cRELFTN11pXj8SwdMTrT5N3jUivBQ21hWkTdAUjNW62KnaSY
FhjT4rfXT9k59AvDATzj/r+h17HJFX6s3HuArYNWmbqpefMXfuL326/Ct1y0R8qv
ajmoMSmS464pW7ZukDPgI9MPvc/SWsQjZoljfT5uTZVx+DR8HzhRAbVP5tnGxIPy
0EjM9/FLbx4VuZg/mhq3lBSQtaXjyh1JmegIh9VgXPLosH/VeJQrr9N4wGGjYJvV
/rqV5U1YGZTrImBMmcebpvg39n2lFg==
=NkUm
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
