Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F821232162
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgG2PQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 11:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgG2PQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:16:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BE420829;
        Wed, 29 Jul 2020 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596035766;
        bh=yDdQDhe0aUkPneMHf4V7CtUIlgiQ6JNskljZx+0L3lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gei8T5JG9mkokmueZzsBGcLX8YlboI/FeJehVNWoEm6q8np1zBgiz2xRJCgZ50WMa
         duK94SsDjx3dcUQZ/qxbD9kRvbRfotqQgGnuG/YP+L9oby0LuER4sQU432e+thWKZc
         11er+SlaUzGnZyXJ12P5ZS9ynMsNXAF4xj3riDgw=
Date:   Wed, 29 Jul 2020 16:15:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
Message-ID: <20200729151548.GB5612@sirena.org.uk>
References: <20200426104115.22630-4-peron.clem@gmail.com>
 <20200428081321.ht3el26yqhsnyfm4@gilmour.lan>
 <CAJiuCcdVs_drs40Q6537BYfz24F7NmC6B8S5-Lt4V4ggs-FXWA@mail.gmail.com>
 <20200429123529.y24dpy63wxq7uvkt@gilmour.lan>
 <CAJiuCcfXqizcq_JuXRCsqEqM2562cr1SGJ0pmy07jcJxAXojOw@mail.gmail.com>
 <20200430084600.samghw4zxb5zdbez@gilmour.lan>
 <CAJiuCcf_LHrJ6QdZgH8HyN6TRiT+GiD+t4UggFCrz-VwVHXV6w@mail.gmail.com>
 <20200504120942.lnrxnnmykqnvw3fb@gilmour.lan>
 <CAJiuCceF340FiLvyeXNZtvqftQMAmk=MtFDLT_9696ix+eH1Yw@mail.gmail.com>
 <20200729143927.47f5tbuaob4ph3lp@gilmour.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <20200729143927.47f5tbuaob4ph3lp@gilmour.lan>
X-Cookie: May all your PUSHes be POPped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 29, 2020 at 04:39:27PM +0200, Maxime Ripard wrote:

> It really looks like the polarity of LRCK is fine though. The first word
> is sent with LRCK low, and then high, so we have channel 0 and then
> channel 1 which seems to be the proper ordering?

Yes, that's normal.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8hkqMACgkQJNaLcl1U
h9BWOAgAgZCmz5kPu3UP5TIzHU0FAftm7xaaVdfAgv4E8uT1NNTTa8BP1dvsplb9
Y4S5BMhGEtD8QKO8xfJOn2rmCsNNVxKbTcu17pJrU/deNmnoT5F4TnYr08pckTcp
0lR7PGk2ue9IcXFaDjzjTEHRy6OAm607BBjXyWVAhr3eM9KxVObTR/xeYaXsW0pl
524o3XwTcNKdjkYC+zmF/wcrJ98vThoGY3AIm/2dwJJ7/LjXGWxE0JVMMoA7o4RZ
6DbNVGZyRaha3iLUmk75+d8yD+Bub8C+/xZUDzZX9dskbmerGio/TCFJhG24cx+w
zXy5TYbMMqUp7E3+lRX8m6sRgBuA7Q==
=1GYE
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
