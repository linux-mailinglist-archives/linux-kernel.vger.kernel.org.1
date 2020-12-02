Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6602CBCCF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgLBMVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgLBMVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:21:08 -0500
Date:   Wed, 2 Dec 2020 12:19:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606911627;
        bh=DsrXXY2h/yIcoRTDSQa3tc2wpMVRYr+OV3sf7ETbV58=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=1G14kmIfls6m5J3f769odFT9c818QTKnGGr4LysiyQaqKIbxsw5gJPPsIrd2LMo/w
         j75duz6xhGrjIgMOrkvqbB5QzjvQ+UdyJf4XzL3+M/+3Kk5iCmYFoTMLQA2d2fyzxj
         9n/vLCppCnfMAs8RD6fQov9DDfm7G/h77U1Ej9xo=
From:   Mark Brown <broonie@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Message-ID: <20201202121956.GA5560@sirena.org.uk>
Mail-Followup-To: Sven Van Asbroeck <thesven73@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
References: <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com>
 <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com>
 <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com>
 <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
 <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com>
 <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
 <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com>
 <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com>
X-Cookie: Sauron is alive in Argentina!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 01:43:36PM -0500, Sven Van Asbroeck wrote:
> On Tue, Dec 1, 2020 at 12:13 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> > I am not sure if DT maintainers accept that we revert a DT change just to
> > handle some change in a driver. Usually they insist on fixing a driver and
> > live with the DT. DT is carved in stone or could be ROM...

> This is above my paygrade, but I've always assumed that the devicetree ABI
> is an in-kernel ABI, i.e. not a userspace ABI. Meaning that it is flexible and
> there is no obligation to keep it 100% backwards compatible. Of course Rob
> Herring may want to keep it as backwards-compatible as possible, but that's
> an altogether different thing from having a userspace-type ABI.

It's supposed to be an ABI, though sometimes that gets broken - in a
case like this if there's only a very limited set of users relying on
something that's going to make things harder to maintain and which don't
in practice distribute the kernel separately to the DT then it can make
sense to just break the DT since realistically nobody's going to
actually notice.  On the other hand if people are distributing the
kernel separately to the DT then compatibility definitely has to be
maintained.

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/HhmsACgkQJNaLcl1U
h9CI4gf/WYSrziOVDt0VgkhsyLkPps6cXkjghuRjFYQvSvUxy3Tdk61vCc+YxR5C
iAXbjj0di9YynTT+nwnWrOMPeMWMCho94YAU7CCSOoXrVI+IFSMsf3ArPcQRIdEB
5UUdWnOAU9oZ2jlJgST7two9uRieFcKO/opIRLzvh4HHoP8q8etBt95Te773VxA2
2Vpd6bqjNenGBZWj9q/g3e74NDzm8Vny387AmYhjLt6EaI8teSTOo1zgK67zujua
mEtuTTZFtpFM5pp2TyIYPDCULet+2KfB9QGXHlIvEnObo4Y/R4iTzWq83Cge9ypG
r/sxG5pCNhwYp028Ar0pyYLVLMQqwA==
=XtRo
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
