Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E52F7F63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbhAOPVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbhAOPVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:21:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF902389B;
        Fri, 15 Jan 2021 15:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610724039;
        bh=7+nF2l9TtNjF6HXmyJWfi6x41zb59s8IRwjRZniglYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NT9bamE7cphEMa59UXgq5aSSmzjPkDxEc6wajUhyD3LeEwpPjmOVt/sWF4ok96KDQ
         T3Dk3yXadr5+L9Vd0GEO6pAifTTVFDCS3eRsSRXwYpVwSrjbO1SgNFxtATLJj1hxtH
         bpnqehb3VdtZiD0AUmhzD9RbzMogVTiqdvnZELwFLHGV4edteDE/mqXjFgbVkSeXM+
         RqV+pjw/G/YVXa2fsFhmTxBu/GGi0Vwzbif2d/CGPoOkUtMDB2ixyAMH2fIv6mLmNj
         zwr8AIuMdW2EPzHgbOoZkYlzBDhgwkDk4EnYTi0LwtG10eT1TAhIIDVECokl4999Mf
         Ti2rRgiuqeAsQ==
Date:   Fri, 15 Jan 2021 15:20:04 +0000
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
Message-ID: <20210115152004.GD4384@sirena.org.uk>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
 <20210108160501.7638-3-rf@opensource.cirrus.com>
 <20210113152225.GA2334778@robh.at.kernel.org>
 <20210113160917.GF4641@sirena.org.uk>
 <ee3d0b75-dc2f-9994-19a4-a3c3f21a2c65@opensource.cirrus.com>
 <20210115131142.GA4384@sirena.org.uk>
 <1ec5e5f4-f672-2c60-23a5-9d985b943379@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <1ec5e5f4-f672-2c60-23a5-9d985b943379@opensource.cirrus.com>
X-Cookie: Debug is human, de-fix divine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 02:42:12PM +0000, Richard Fitzgerald wrote:
> On 15/01/2021 13:11, Mark Brown wrote:
> > On Fri, Jan 15, 2021 at 10:35:23AM +0000, Richard Fitzgerald wrote:
> > > On 13/01/2021 16:09, Mark Brown wrote:
> > > > On Wed, Jan 13, 2021 at 09:22:25AM -0600, Rob Herring wrote:

> > > some_codec {
> > > 	pll: pll {
> > > 		compatible =3D "fixed-clock";
> > > 		clocks =3D <&audio_mclk>;
> > > 		clock-frequency =3D <98304000>;
> > > 	}

> > A PLL is not a fixed clock, why would you define a fixed clock here?

> It's a fixed clock if you are only setting one configuration. Call it
> compatible=3D"any-other-dummy-clock-type" if you like, it doesn't matter
> what it is for the purposes of what I was describing.

> This isn't a clk driver for a pll, it's just a setting to be passed to
> snd_soc_component_set_pll() using a clock binding to specify it.

So you're trying to describe a crystal on the board?  Why would this be
a subnode of the CODEC then?  Surely it's just a standard fixed clock
which provides some input to the CODEC in the same way you'd describe
any other input to the CODEC.  The above doesn't look anything like the
hardware.  But if that's what you're doing how is that related to
configuring the FLL except possibly as the input clock you'd reference?

> > Are you confusing the selection of rates on existing clocks with the use
> > of the assigned-* properties that the clock binding provides?

> I'm not at all sure what you and Rob have in mind here. Perhaps you
> could give an example of what you are thinking the .dts would look like
> to define some pll/sysclk settings for audio-graph-card to apply. An
> example is worth a thousand emails.

As far as I can tell you are trying to configure the FLL in the CODEC,
telling it to take an input clock and produce a fixed output clock rate
=66rom that.  The FLL is a fairly basic clock, there are examples for both
that and choosing a configuration for a clock in the clock bindings. =20

> > That seems like a *very* surprising requirement - why would the clock
> > binding have that requirement?  It would seem to create issues for a
> > single device providing multiple clocks which should be a pretty common
> > coase.

> You misunderstand me. What I'm saying is that to do this:

> 	sound {
> 		clocks =3D <&pll>;
> 	}

> The node 'pll' must correspond to a clock provider driver. It can't be
> just a bare node with some properties pick-n-mixed from the clock
> binding, like this:

I'm pretty sure I understand you perfectly; again, what makes you say
that a description of a clock in the device tree has any requirement
for a separate compatible string?

> So the question I'm trying to ask is: when you and Rob said use
> the clock binding, did you mean pointing to that binding from
> clocks=3D<...>, or from a custom property like my audio-graph-card,plls
> example above.

When we say to use the clock binding what we are saying is to use the
actual clock bindings to describe the clocks, not make a custom binding
that looks kind of like them - making a custom binding doesn't address
the problem.

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmABsqMACgkQJNaLcl1U
h9A0MQf9FqJR9Ff8vWBFntAW6Bpppj//aQxSRdj8Hf9cUqOn3izt8QDVsNc5+UwG
i0qQPlRQ4+so1rwDVyI11eNTbTNu0fepzlCPw9e1Q5mxwHqIHqZNTr+HctdgiIEa
41PDMPv5NXFoeED7b/q0D+u+0Wzjpt1ydDnvcv4sSZehkLjjQ+B7B7HFuwt0QY8g
1n7EiinZIaQkMnkx7krT7NzJqqR7F8PeGr40/HJkZtUwT54iwTJce9fT5HR4CUdZ
1Q2BOz4RuXrd3Frmef6SYLKNA3+z7IAvd/Qbvb/siCDaZU8FlNIEFQYR8sMtEpYS
FfOJHFjeekGzQr+MgiArBkNUW9NuCg==
=m3Ta
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
