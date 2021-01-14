Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492C32F5F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbhANLPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbhANLPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:15:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23634238A1;
        Thu, 14 Jan 2021 11:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610622896;
        bh=HEn6x8XwIMQYX5cf2Cfwj/acaJyDmQOqh8W59GekF8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7u08RCLdM+KtZsvcdKRaIMwQwwW+USMkLqv2FG95OT9E3vTITF7t82wi97ZJqYog
         trIPVU4lmVePaaR7vfeitaonyAmiKNYCM0keKY9/HxE20EFIl02QNkvTzVzwWk7GGC
         u1iuXXs+6pLCsJ23d1+AmpL7iTKgAJMoq7akF+4EnW9epo6tq8Mc3VWvWw8rTqmP5l
         FCwB5wG6gCBQHqyuC1ec23U3TmMaoT1ivo/D0hu0/UqfH6ImGVo1P60KQdWzBhHbOm
         z3XW/LW+3zL5ygnfZO/xpQU+PAheuw3LsLhrXGO44JBJuJ+/XPo3SsEr7xDV2H6lUh
         VQEJiOuajCz9g==
Date:   Thu, 14 Jan 2021 11:14:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Rob Herring <robh@kernel.org>, kuninori.morimoto.gx@renesas.com,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/6] dt-bindings: audio-graph-card: Add plls and
 sysclks properties
Message-ID: <20210114111422.GA4854@sirena.org.uk>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
 <20210108160501.7638-3-rf@opensource.cirrus.com>
 <20210113152225.GA2334778@robh.at.kernel.org>
 <c12a846f-9e79-4646-e7f4-397f074eb613@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <c12a846f-9e79-4646-e7f4-397f074eb613@opensource.cirrus.com>
X-Cookie: You have taken yourself too seriously.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 14, 2021 at 10:31:10AM +0000, Richard Fitzgerald wrote:
> On 13/01/2021 15:22, Rob Herring wrote:

> > This appears to all be configuration of clocks within the codec, so
> > these properties belong in the codec or cpu nodes.

> audio-graph-card doesn't have codec or cpu nodes. Those were in
> simple-card but are replaced in audio-graph-card by a simple phandle
> array forming a graph.

> I could assume that all clock settings apply to the codec and that there
> is only ever one codec in an audio-graph-card configuration.

The suggestion here is to put properties in the node for the relevant
device rather than the card.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAAJ44ACgkQJNaLcl1U
h9C5hgf/c2ZJGYL10xAvFbrBmbviZFuAh9cGNdSkafHv1OUH4E5CZNwTOSCwi+CE
fJ7wykl1RjbEdTBdW0LFyMN47/dHLLFh2579jfRqVgBlEHn9oRLyfdJZjhjbrFfb
FApz80U1oaVv6OlzmGdpzXvtuyqBooIt9yYyd3n9yFWWoetQGT9gn/ulWrrL3qyh
J5GYZl0aoCdzxl2pA++666p7B5SYtwedDO+NeRVpuHVSvz/nFl7JKHoQWYaVXTmx
0MTbcB+BtfSwN73s1YQW7CXmi+Pa2nDg552Wfld2eSf/lYnqBpPohF0jU05OAb1y
vPPBJMABELNIG8+Cod8+RCi7wDzaLQ==
=3PWv
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
