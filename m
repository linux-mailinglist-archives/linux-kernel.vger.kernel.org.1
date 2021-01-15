Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD2F2F848D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbhAOSgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbhAOSgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:36:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBF892371F;
        Fri, 15 Jan 2021 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610735762;
        bh=nrEh5qKyFfcqrhQvojtYrOk8oDWspF+B8YHetNxIp/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iud4H4qhXR7cQadVrAZeKW3YsK9FY+a6ESBYwIDqPuHCrVo1FTirO4xZK11ZOcx4w
         lhdZ3iWiiuaAn4db+D3/pACYwfMX4PgMM+8a8xbdgSVUg7jiPuTF7k5ib0JRsxJSKN
         KVHM0ZKAqeNP8SirE7ocjw16rqeDu9UblTqtmNxE9ILFVn6VZm8ZouQno8BaYniDS9
         w5JgP0NzqNUtXEwrQWs06NtyLpp7p+YZE71C0qfm6seHnuP4bmj6AzuO4Xr9H03IIh
         efYdqRW3fXg/wbTZooTu8cCrpK04KhjyeRoNQ4YCcqFFboCllOz7SB/nZ5LhcnH2wM
         T2NdtCgMzFaIQ==
Date:   Fri, 15 Jan 2021 18:35:27 +0000
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
Message-ID: <20210115183527.GG4384@sirena.org.uk>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
 <20210108160501.7638-3-rf@opensource.cirrus.com>
 <20210113152225.GA2334778@robh.at.kernel.org>
 <20210113160917.GF4641@sirena.org.uk>
 <ee3d0b75-dc2f-9994-19a4-a3c3f21a2c65@opensource.cirrus.com>
 <20210115131142.GA4384@sirena.org.uk>
 <1ec5e5f4-f672-2c60-23a5-9d985b943379@opensource.cirrus.com>
 <20210115152004.GD4384@sirena.org.uk>
 <d67f805f-2813-14e9-0c4f-5948ec73f7b0@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline
In-Reply-To: <d67f805f-2813-14e9-0c4f-5948ec73f7b0@opensource.cirrus.com>
X-Cookie: Debug is human, de-fix divine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 04:15:21PM +0000, Richard Fitzgerald wrote:

> If I do:
>  	sound {
>  		clocks =3D <&clock>;
>  	};
>=20
> 	clock: clock {
> 		compatible =3D "fixed-clock";
> 		clock-frequency =3D <98304000>;
> 	};
>=20
> I can clk_bulk_get_all().
> But if I remove the 'compatible' from the clock node, clk_bulk_get_all()
> will return -EPROBE_DEFER and log:

OK, so if this is only supposed to represent a fixed clock on the board
separate to the CODEC then yes, of course you do need to instantiate a
driver for it like you do for every device on the board.  However it
shouldn't be a subdevice of the CODEC as you had it originally, it
should be a distinct device as the above has it since that is what
physically exists.  This obviously won't configure the FLL at all though
(which was what the binding you were proposing was for, the above is
definitely not a direct substitute for the binding you originally
proposed).

> > When we say to use the clock binding what we are saying is to use the
> > actual clock bindings to describe the clocks, not make a custom binding
> > that looks kind of like them - making a custom binding doesn't address
> > the problem.

> But I don't know what you mean by "use the actual clock bindings to
> describe the clocks".

> What is not clear to me is how you want me to use a clock binding to
> describe something that isn't a clk-framework clk. If you know what you
> want, then please.. an example would help explain.

The concept of a clock framework is an implementation detail of Linux
which should not affect how the DT bindings for a device or system are
written, DT bindings should be clear and idiomatic as DT bindings.  The
goal is to represent the system in a clear and standardized fashion
which is useful to OSs in general, not just something convenient for
Linux as it happens to be implemented right now.  Current Linux
internals are not a constraint for DT bindings.

In this case if you can't figure out how to parse clock bindings without
moving the clocks over to standard Linux clock APIs (which seems likely)
then it follows that if you want to describe the clock configuration in
DT then the driver support for these clocks should use the standard
Linux clock framework.  This seems like a good idea in general anyway.

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAB4G4ACgkQJNaLcl1U
h9Ajugf/V/c7kkx7kjE3+tn6nJNrg21PFVDm4St0hGGrFYbLX5tp94E++n7e+0S4
1O72CIgQcws/PAoj49e1eR9ucRcZztKs5ahuZNxEtGti7ASiGaVfsP63/496zQZN
VPW5tOl/xrSw4kNiMkoCSZXT4Izm05XeLtLvV2SQxeVevR2ifnp38Ms5KTEG9PXT
q5Kecf+CmTuIXlFFvyY3eD5Pqdvqe7F7obdoOxUET3NEEfuPYtRCA7YLHmFu/EfH
Co3vKlM5RmSi8s4RJ4jXplNFEGMDSjfdLbvrIUPFl/fC4aHMIRk0sAQnKftj9vkO
rs0GP4a8Qfuiyb0YYpMLrw2ora7WTQ==
=sFv+
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--
