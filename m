Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEFD2D3084
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgLHRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbgLHRFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:05:10 -0500
Date:   Tue, 8 Dec 2020 17:04:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607447069;
        bh=4vOM2hPgHrFDdyZpn+0VAXraK8YYeHWHyPRJRhYrL4w=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWtshTP78znOhmhQmuNg1rJ+1pqIGQJn7Y9xvGGdIUTkpfMxJnpvs9OHeZGKWX1oX
         t9k6cy5/I8ug6CyzAKh9eyMQq2L/Gr1VLUxuqOgZOBntDNkbzOyJTxzevadVo9K5c+
         oZmg5s9ks23enzfV0ze+jQnhMhy5nHlPzpUSDkCmtp/ahgsFvs1ZjDatiYnccjfJR0
         E2K4P42m1vEqnJWeiKob4Fz/mDhy/TuL9xX+A+iEZPYpk3mVbNDtxL/rh57k+hd4uf
         rYKOLgDMiRIIoFJoSsoLM2iahLJ3EIZif47oVaGwo1LHenXqYHYdVstQdItAfvR59F
         Xqk80Y6APf4pQ==
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        lars@metafoo.de
Subject: Re: [RFC PATCH] ASoC: pcm_dmaengine: Add support for BE DAIs
Message-ID: <20201208170422.GG6686@sirena.org.uk>
References: <20201202085838.1779525-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Content-Disposition: inline
In-Reply-To: <20201202085838.1779525-1-codrin.ciubotariu@microchip.com>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2020 at 10:58:38AM +0200, Codrin Ciubotariu wrote:

> This patch is more or less incomplete for the described scenario. This
> is because DMAengine's pcm->config is ignored for the BE DAI link, so
> runtime->hw is not updated. Also, since pcm_construct/destruct are not
> called, the DMA channels are allocated only if DT is used.
> Underrun/overrun support would also be a nice to have for the transfers
> involving the buffer allocated for the BE.
> One way to hold trach of these would be to use a substream_be->runtime
> different than the one used for the FE.

> Please share your thoughts.

I have a hard time getting enthusiastic about this but I think that's
more DPCM than anything else.  Otherwise this looks sensible as far as
it goes.  I don't have particular thoughts on exposing errors for the
BEs - we could do a dummy PCM, TBH that bodge was used in the past for
CODEC<->CODEC links but it's obviously inelegant and messy so I'm not
sure it'd help more than just doing something like log the messages in
the kernel.  It certainly doesn't seem good to introduce anything that
is visible to userspace but is DPCM specific.

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/PshUACgkQJNaLcl1U
h9A3/ggAg1ispHsW7HxfoyKlgiXncZefpDgs4m/UErOav+qf6rSQsHPAz79PrgLW
VQoADbxHDWOWuujHLtWZn2TUKLYyj7oX3drpEU3uDuQnNfKGGrN8Q7Pw6jwClZBp
mVpxznG0i4F7+6cPw/p51hU/90b//OrVIrfN5IyOLY4BdNNVT3wzQPCBtSinURJ/
8lwD5WYAerbVldG56JOq28GAEw0cfKOlRyt00eIHcnFS6wuo36T4Gjes5irgmKNe
LDyz0pDQX1s/GMb2kfyuDbY88bHXRw/xkc/IPY7QWLfEVTBcyRabJkSekI0jBaSM
q8LYqep6dgn3J8/eixPTLyojfNU8JA==
=8SdH
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--
