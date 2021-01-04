Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4AA2E96F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhADOOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbhADOOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:14:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95FB52245C;
        Mon,  4 Jan 2021 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609769636;
        bh=oqztWhFAZMPdxzyKlwb//7PmFe7TTLE83m1Z9TPVaEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKW/2yvAczC2Qcx4GHy0h6O1SUctibjcRTVbNo6njkQqeWBgZiGOx7D1o2b9E9Lrb
         17Io8T0KmdQe7/tHWrbr5QrxAARe8pIrHV8krqfTUwos2pTTTlqbmtmLp5axckNM0C
         G+MQKWwNq8XSLH0qyBJfTZYKL9WmXr91ozuo53y41S/2XFnaNbWUYeo98gLMbN/Bqd
         aoSzUbYZRlUTl+XiWX9OwCqifIfzGjB2uZPTBXiJT5soWNqZblYqryLjwuosbIbUfD
         sIuCQaXVGEx0jA5vwVBA/zJJOpEUwZBAl1pWaV4JYX0unGSkUMIdKf2Myiwg2SfCor
         ZbUPKhIIDY6iw==
Date:   Mon, 4 Jan 2021 14:13:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH] ALSA: hda: fix SND_INTEL_DSP_CONFIG dependency
Message-ID: <20210104141329.GG5645@sirena.org.uk>
References: <20210103135257.3611821-1-arnd@kernel.org>
 <s5hk0ss94kr.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <s5hk0ss94kr.wl-tiwai@suse.de>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 04, 2021 at 03:09:24PM +0100, Takashi Iwai wrote:

> IMO, the problem is rather the unconditional calls of
> snd_intel_dsp_driver_probe() in snd-soc-sof-pci and snd-soc-sof-acpi
> drivers.  Those calls should be done only if Intel drivers are
> involved.  So, wrapping the call with ifdef
> CONFIG_SND_SOC_SOF_INTEL_PCI or CONFIG_SND_SOC_SOF_INTEL_ACPI would
> work better (although those are a bit uglier).

Or stubbing them which might be neater.

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/zIogACgkQJNaLcl1U
h9Cs2gf+L8LA4jGPihc58O3+2gVfjpoTLwqR18RhrGsAJrQAhVjPb6+muvVH4rVw
aKm648duaehQ4484pZXS/LUtyEw70+N8RHhchEfyfHu47SVF1Avku3rjsqSIZQF0
qNe8HDF5kJ0npw2mazr/Iv+P1Uv7Yti9GVye63MmAaImJe5HPX9DmfQspj3zeIXu
NMFycv6wLpMoo4L0P5qxFxCkVKVZXSjeJED7/uXQVrtpSJzcWhU+cUn7HI/J48gl
Esu9cmu5UJLHzMbVpzhHxbH/L6GGljPGWxRfWoP9gP/GasEfv5q3gjBHeOLsPEgp
YnyLj/Uegu5vdqyK+bVllUs1klgm3A==
=HwUk
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
