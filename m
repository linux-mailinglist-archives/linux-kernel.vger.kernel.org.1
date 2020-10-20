Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87257293B19
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394365AbgJTMT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394348AbgJTMTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:19:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 427942222F;
        Tue, 20 Oct 2020 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603196363;
        bh=v6hvzZnm5fO2LRuaf67yjm5Dmk41dAfQBo695kCsG/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJJ/FkLcr/+ezJTlcNE93HVLZFVLAgVCweDitu6Xjjt0lx+j8u2muD2BZeJ5OKhWC
         F/KlgfG/e+ktLqHgxyHqT+l5ubxWadGxHAgHIGncHt3ye3W4AT6Lo4pKaqTEUvnLor
         29xF8Osd83iq1oX9q5S63X53T3HoF89FKQDuSJiU=
Date:   Tue, 20 Oct 2020 13:19:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alexandre.torgue@st.com, arnaud.patard@rtp-net.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: Re: [PATCH] ASoC: cs42l51: manage mclk shutdown delay
Message-ID: <20201020121913.GB9448@sirena.org.uk>
References: <20201020090457.340-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20201020090457.340-1-olivier.moysan@st.com>
X-Cookie: The people rule.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2020 at 11:04:57AM +0200, Olivier Moysan wrote:

> +static int mclk_event(struct snd_soc_dapm_widget *w,
> +		      struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
> +	struct cs42l51_private *cs42l51 = snd_soc_component_get_drvdata(comp);
> +
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		return clk_prepare_enable(cs42l51->mclk_handle);
> +
> +	/* Delay mclk shutdown to fulfill power-down sequence requirements */
> +	msleep(20);
> +	clk_disable_unprepare(cs42l51->mclk_handle);

Why not use a switch statement here?  The control flow is a bit odd with
what's basically an if/else done with only one branch in the if - this
isn't idiomatic for DAPM stuff apart from anything else.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+O1cAACgkQJNaLcl1U
h9A/vAf+JYXtEW1+AAEACgq9gDYA589X13HKVS73HAERhV2VefPqsSWHlF+UhKx1
YUOU94GV71Ch7RLyaoFfQhaxVZghyjDXxWeqsMe1mJwxVfBCAxq5N6Q/Mm/hyORl
fA62L8BHyO2iDoJX72VoaGN0HLxTzqWvHXvnhU7tfaaTAVVVdNpBPSya+pbU8EM6
Ya6XwOejv7Rr3wcO1OsmVJfxW+n4xjyrM06oM+Ld7VSVTXKxdaAgltBthCPxD9pO
Km4xA9vhbo76xXiER2/arnWKgqSsXAT8bJbK5oipa/RlpnpFXZvokhd0bxBmkOop
xss2mjf+rEEkN3hJS2irSUZb0/X5sw==
=Yz7U
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
