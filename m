Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FCE2F3770
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbhALRnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:43:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbhALRnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:43:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF3F522CBE;
        Tue, 12 Jan 2021 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610473379;
        bh=uRhf+TyHSUoTrYHgBqCcfnTsojVy5pcXeF1jpS9l8Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyj3L8NCapEXo78clX79jgQrOT7NcEmuR2dIJo76NmnLL/T9ULPBis0FzLyml51Bb
         IMne3UeANbCG20cmSTWB3QO1fmd6PRPLAXdZZnSSWkPzJt79YJGkDRZXt+8zPc2HHI
         oy0sVEE0w3MIRUQfIzdWBW5mUSaWZiVuItiAqSrYmr0BF3f8OnajFHLeaXsf7blr47
         kK0laLCcWELLE0ss1WVQenuhx1kf5gu7IWqKeXCk0GXxVZXbIlYsdzfu2pJVf9X9Q7
         vznTVH3x071DCtR6JwJV+s1CrcFm0va4QWV3J4P7ePos+MK31zeBz0k6qkWT7Hm4ac
         CtbOfUXpN9d5Q==
Date:   Tue, 12 Jan 2021 17:42:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        Jaroslav Kysela <perex@perex.cz>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] ASoC: SOF: Intel: hda: Avoid checking jack on
 system suspend
Message-ID: <20210112174226.GE4646@sirena.org.uk>
References: <20210112130704.1201406-1-kai.heng.feng@canonical.com>
 <20210112130704.1201406-4-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <20210112130704.1201406-4-kai.heng.feng@canonical.com>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 12, 2021 at 09:07:02PM +0800, Kai-Heng Feng wrote:
> Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
> ---
> v3:

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/934EACgkQJNaLcl1U
h9DIiQf+PEUEqixskXVBjQpJev0kl6hdig9NTAKEFz/lDG4aMfUV/OsX7La50jX9
vxA05lQ0oWIDIT454uC5suBZVRSkF0JNl7ME9wXDx56sXOS1EGCcGOCBsmB3WHGV
43vW6kPn6IRBSdbrAwW7bhWJ3f4SMXd7gK9xpW/xfaVsGB5m1VymZsBX+86/o+P+
EKdDKm5EyH7pVbUjEeP0p9tePpiJ/qP1Zrjc9R7v4PwOLN+D5rCiUm+ABoHWwGBj
ZAB4o0c4FG/wbP2mQb0tS7D1Q3jUGAXwoB++Vp/4mjatkf0VkWPEMLyLH66dU8rq
ryR5H/wp6fBH7cwZrS1ZtaQfhEFGqQ==
=bkh0
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
