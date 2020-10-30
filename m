Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295912A073C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgJ3N62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3N62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:58:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F552072C;
        Fri, 30 Oct 2020 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604066307;
        bh=adyPaigieWINvpIzCWk3XM6mFalffwbDJrfjZBicvkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LssxqxVewnCDY1JEzRLqdoHAD1GDS9d+ghDN2JRk2WfI6f/FIMqucTLWc5iK/D4Fh
         WtJeaq9SSuBGjWSDn8+lWrYhq62u/c4wjuWuA+oUCLUawzURUyth1ybsuhHMLm84UE
         UdHPJSJoRMUSKI1Cu7f/aPlNv/fDDPevgVAYG61c=
Date:   Fri, 30 Oct 2020 13:58:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        kuninori.morimoto.gx@renesas.com,
        pierre-louis.bossart@linux.intel.com, perex@perex.cz,
        tiwai@suse.com, p.zabel@pengutronix.de, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com, nwartikar@nvidia.com,
        swarren@nvidia.com, nicoleotsuka@gmail.com
Subject: Re: [PATCH v4 00/15] Audio graph card updates and usage with
 Tegra210 audio
Message-ID: <20201030135820.GD4405@sirena.org.uk>
References: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
 <c98d63a7-f311-a94f-abcc-1c5a87ba8025@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <c98d63a7-f311-a94f-abcc-1c5a87ba8025@nvidia.com>
X-Cookie: Blow it out your ear.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 30, 2020 at 12:04:50PM +0530, Sameer Pujar wrote:
> Hi Mark, Morimoto-san,

> > Sameer Pujar (15):
> >    ASoC: soc-core: Fix component name_prefix parsing
> >    ASoC: soc-pcm: Get all BEs along DAPM path
> >    ASoC: audio-graph: Use of_node and DAI for DPCM DAI link names
> >    ASoC: audio-graph: Identify 'no_pcm' DAI links for DPCM
> >    ASoC: audio-graph: Support empty Codec endpoint
> >    ASoC: audio-graph: Expose new members for asoc_simple_priv
> >    ASoC: audio-graph: Expose helpers from audio graph

> Would you suggest to keep above in a separate series and thus not blocked by
> below doc updates? If so do I need to resend above in a next revision or if
> these are good to be picked up?

It's probably better to split things up given that the dependencies for
the last bit are on another series.

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+cG/sACgkQJNaLcl1U
h9CSfAf/X5PzOOD5Jon1mVsaFPbij6n6esmY9LRtfZ4vDDwLZec683WNghZ/F/R6
GxeVN81r0vv+6uhh6f4TaTD0+/XU0nc8aXQBgXs/6DHNALqX5b6GWaiCQRioYP6W
QCD4gpybdIGuWvb2ONWsApLC9ciddNTZvNFeM5RprZQloeMjYUKGiQJ+tzUrTfrs
Qce0dpEqTMk/37BF9z9fDqOPwScX4a0529QSD7zbAaSDKe4Pfcnad45MnjYprNZk
Eaf9QiHtxpfvpqrIHvuIhPMgdOWGSsaZKbdQx6p7QLoftcJdFKD6sXjfUuKntPzY
BY7H6q9Z+nxCOCm3uRkD3YIGXPefqw==
=mqrB
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
