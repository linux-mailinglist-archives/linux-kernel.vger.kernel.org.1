Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B002ED49B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbhAGQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGQod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:44:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06DA923403;
        Thu,  7 Jan 2021 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610037832;
        bh=vuM9vAjQJkgCU4xBUoFmKddeaCN97wvKiCrb9wFq5Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3c+nbeK0+kwJq39ghmw5I0A2Sw54HCgrv/tFM+DIHWYNS3ROj+9a3hGG/ymGzI+U
         Pu/rXvAE/ZQSwa0q//9N/EPrkdjLh0vVY7DxaJ2Dl397bBnVDmJKFh9D/VwUypQUdp
         Koza40wb43KKwHbactJTZwJb6+Lfd4gI28RLFuDEu4ytqWPOykodoaP3uyYKRp6H49
         IqdKD5U5ReSi/UR6ny56E3jUPVg35RtPdVfWOd7PdDhiZ5cDQsI/at36xOfyfq17CN
         A9Y2/u0XWCDapFMk+HKm9WPeJuUFo5n6Ahsnik1mLa3Q2JgipctO2/gyBqRrmfOu5f
         yF6y3JnRGKLFA==
Date:   Thu, 7 Jan 2021 16:43:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Joe Perches <joe@perches.com>, Jaroslav Kysela <perex@perex.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        alsa-devel <alsa-devel@alsa-project.org>
Subject: Re: [PATCH resend] sound: Convert strlcpy to strscpy when return
 value is unused
Message-ID: <20210107164322.GF4726@sirena.org.uk>
References: <22b393d1790bb268769d0bab7bacf0866dcb0c14.camel@perches.com>
 <s5hpn2j2rr3.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <s5hpn2j2rr3.wl-tiwai@suse.de>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 05, 2021 at 06:55:12PM +0100, Takashi Iwai wrote:
> Mark, could you check the ASoC part?

Acked-by: Mark Brown <broonie@kernel.org>

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/3OikACgkQJNaLcl1U
h9CliQf/fWBovJb9ILFKC38hv8wOmoZfK1W6JdCZ51RizmOwpB+ucVe7GG03haN1
hrh54Tj0NzpYo3cuAEWPMRIXiWisE77mm2MOGuf005H8oB58ETQ1B6GM/odbNEuA
MiHC0MdNL87krLHKIKQLKfx0FZ8K1T3VjvmJminiHTKtP90SPWWh+m260M7rFaMN
IreAoGI0QSZd2QYlX4/rcLgcAWhQdGBBSmn5L0bzHD41sobO5Cy74nJfIUovvtMQ
HZsgPZH/VmGJm931ztYmln9NuI9vhi76GYVeWlXvo8NNa+1zzGqpyQMjp9I8vUob
Nc1ec/s5nRsTNcrfpEiiUwOd5EMVCg==
=u4EK
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
