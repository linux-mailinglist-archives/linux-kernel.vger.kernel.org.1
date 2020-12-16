Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24B02DC70C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbgLPTY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgLPTY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:24:56 -0500
Date:   Wed, 16 Dec 2020 18:25:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608143121;
        bh=PQh8MgitMMRTJ60/Nwws7AtEslJGNdmnhBmfc90g5Zs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzxPAbtz52iIuyu+HH+KHls6Kv3vZrbPaLFGYwHQKZoDUusfgBI5w2s32N6gfpC70
         YnmjAlzKleRxMAzbDtQpAGmBzRHUyBSMAclGPRR14/Bn4Ebhp+YJnrH8LNcYGN+JSc
         c90xBPBuNn5SHy2CiiHIMMxekvtzy71u0eWGebRlhwJNNEGzJyOoGacL/3fy4KgRSo
         4h1u82nm5iMGroeRsgcGqak5pqtuh2pdmoq033Wr2qWkEiSegGhlIcA69GieNbPw6B
         QFOxyn4eVAg0xvRp27UVcFERxl600m/1EE1LTYPFyS9Z2zSFJBH/RNjD+vPHdS5j5i
         RGIg8lH1MQmjg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] regmap updates for v5.11
Message-ID: <20201216182509.GD4861@sirena.org.uk>
References: <20201214144753.1DA3B22B4B@mail.kernel.org>
 <CAHk-=whOwGP7G-6rn8ZPwQJHhGiS1MxW06n7YY0TO=P8xHwf8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <CAHk-=whOwGP7G-6rn8ZPwQJHhGiS1MxW06n7YY0TO=P8xHwf8A@mail.gmail.com>
X-Cookie: Why are you so hard to ignore?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2020 at 03:47:47PM -0800, Linus Torvalds wrote:
> On Mon, Dec 14, 2020 at 6:47 AM Mark Brown <broonie@kernel.org> wrote:

> > There was also an addition and revert of use of the new Soundwire
> > support for RT715 due to build issues with the driver built in, my tests
> > only covered building it as a module, the patch wasn't just dropped as
> > it had already been merged elsewhere.

> Ok, this made my diffstat look very odd and very different from yours
> - because I had already gotten that driver from the sound tree, so my
> diffstat looked very different from the one you have - and instead of
> being the no-op that it was for you (add and then delete), it showed
> up as just a delete for me.

Yes, that looks good - it matches what was in -next.  I had actually
meant the add to go through instead but I'd not noticed that the delete
was winning (I think I checked this in -next at the wrong point), I'll
make sure things go through for v5.12.

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/aUQQACgkQJNaLcl1U
h9BxVQf9G4woXAuPe7fIlWyY0XYfuftvR5KGYu6eVu3+gxyG+1RrkcAMqKItl/p0
E0ZpuHTxiM56syQk6L9+7Z4JeiJPITZWUg7h87IfApIMyqOvSkTIlxpQR5krUyTe
StdH0Se9HDzlWuQ26kB93NESp1vtrLf3uiB+0HoycSlhOjePEzlnJ/o1OoChzhN+
cKarrbp1rCCGz6CTP+44KV7HX+lMINCn13UvHDdI8rhV4ivO50/UZkUW22TbJvVa
QdzvZYLYhAg6xw8A/nW06ugfuDsfJrryBJz/w/T3KpW/+k1gydrKI70fE3K19g40
wxCDi64/hVrT+ZwDLM/jh+/CPOaRzQ==
=4a/7
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
