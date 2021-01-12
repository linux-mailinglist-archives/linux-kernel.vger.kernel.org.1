Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B38C2F2507
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbhALAnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:43:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbhALAnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:43:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DCA5224BD;
        Tue, 12 Jan 2021 00:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610412160;
        bh=ixruP2jH6jsjZSfS1b9tO6gucm00OKQq+Tt59fxAIQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2ar9cwlhCekx8U9xqAaUt5oxbm+Pz3pY88CGx06ZcMOayXZMW96cYZz7tqFJbjBK
         XNxsNgF5xW7mMHZ3XqRI706mA+qaSk5/chLY0waCTgQdazPZNubdDnLhAbQlKm4+4y
         NhDWH2scjUFZ4qsktVls5o9g+29OhMz74+7RdXhlXFoUSUX7S0U2k0dAHxUEgkJ3aI
         AY8iR3O1YM5/pJ5WT2PH/aTkwXGpuFlO9nCrD/c75LmK9x4dhHj2jpF3hrqX1N/lxl
         akQkOJWQFg34PSAQ0ceUCudkBaEX03Hfy2fI8abrIR0mkFNzC5A511Q3IUniUTpoNL
         Q8b0MupcLQzmg==
Date:   Tue, 12 Jan 2021 00:42:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
Message-ID: <20210112004207.GN4728@sirena.org.uk>
References: <20210107085942.2891525-1-yuhsuan@chromium.org>
 <20210107135459.GB4726@sirena.org.uk>
 <CAGvk5PqMCEib8Yr=V4SxT0BBMoC1+yGXm0y+52+LwC5dPQUVnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GOzekVbrLdOLv44p"
Content-Disposition: inline
In-Reply-To: <CAGvk5PqMCEib8Yr=V4SxT0BBMoC1+yGXm0y+52+LwC5dPQUVnA@mail.gmail.com>
X-Cookie: Too much is not enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GOzekVbrLdOLv44p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2021 at 12:57:51PM +0800, Yu-Hsuan Hsu wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=887=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:55=E5=AF=AB=E9=81=93=EF=BC=9A

> > I think the request was to sync over all the commands that are supported
> > in the EC rather than just split this one addition into a separate
> > patch.

> Got it. However, after running make_linux_ec_commands_h.sh to create
> the new cros_ec_commands.h, I found there are lots of difference (1092
> insertions(+), 66 deletions(-)). In addition, there are also some
> redefined variables(most are in ./include/linux/usb/pd.h) causing the
> compile error.

> It seems not easy to sync cros_ec_commands.h. I'm afraid of breaking
> something. Does anyone have any suggestion? Thanks.

TBH that seems like a big enough change to split out from this and done
as a separate series, I'd be perfectly happy to apply your original
change.  I guess part of doing that sync up should ideally be to
refactor things so that it can be done mechanically in future.

--GOzekVbrLdOLv44p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/88F4ACgkQJNaLcl1U
h9AUXgf+NGKX1X7yUNmCGqQyYEJS+HdyisSjro4ojSQQ+LK3e9fnBBUOFoOg1Y+S
rCgD6DHL041jBL/BV1Eh9e9B2j+nbzI3EqDUHLOjfd1zmKHfV23qLbvGkwaNUoF6
Qd3Yb1bG4DCZtDymdhI/90CsM3rRamfrYOI4TwmkMASsRbU1PkmnNxmuUNqZRhxL
kdT3mTVgtA8p2SzXIwBJzpS7ves32OGVGcMSO0ZXW8TCiLLO/vAhTDv8Bt72BSei
FSEzehrc1QDdX5z3gYDG1aKOLtTeklrUSgYWpvjH5Fq8kfcfOBCSkIYv4mhGHvee
6/ebyNfgdP1O8aXF3gURGpw7m8oYGQ==
=N0ny
-----END PGP SIGNATURE-----

--GOzekVbrLdOLv44p--
