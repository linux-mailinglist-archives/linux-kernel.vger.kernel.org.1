Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208B52C9FED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgLAKg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:36:29 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:42101 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgLAKg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:36:28 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 76F0B12F5;
        Tue,  1 Dec 2020 05:35:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 01 Dec 2020 05:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=oz6p5x/QbLAW7+IBUGLdhx4F0HL
        +K5Oy/AFGUDAwcE4=; b=SzDRRZE59hIzqlsDZgIAznoq/YIZ83tsAPvQFGqQ4mF
        Nb6FBA/sDgsGgzBsPWM/1ms5fguJGuYHNI/MQ6waV6AhGrAOBbRm+Ee389mkcuLj
        NfPd56g67E1XqOGO+HeVbPVBUBw0oY9QoZKTGAYE+PHGeg6MPP9k4BbADrGhebFA
        6SMS1N5sg56b/eGhXB7UilST1EeXQzdXPYJtVDrTQcrCWxY0odurlQP7tRIgv1LC
        F8pW+RykZbpIQu3vN+zIjjtF69RgTu7hu7qgIcP9RporDpNGQMZd6iEdhyJGOj4r
        5PrnoYAGL04HEkOgQ9G/p00UFAHHrja7atW2d0Xx/rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=oz6p5x
        /QbLAW7+IBUGLdhx4F0HL+K5Oy/AFGUDAwcE4=; b=JaVKH7Nnw4NVCPMq4EVON7
        Xdl3V3ZnPwJmxiYPvWMcXPHUqkk4mL0N9+cuVjosWbiPOyEaQoMYCs1BXvO+vsUq
        p8xBdXdYzmevilUGvoAyl11SgxvxW5PxTj0QI7drU/fRhPqXvH0TYlSspxGW3gwN
        evN84Kacc0Q0BToFb00jwusGdnoPe1nfb73uSulzvfrgwjdzmm65gDW6gJjMGRQr
        wP0d02TEhBHVqmnlfEkGfRSldfIIbt7Jhmbfg4dTXu2yWglEtEKYCoOcLIa5jCgp
        lIuqHpkVxr1LEqwvnTzg0lo7IcLYk+IVfmGFeohDo0zeraJtrX9DCj6K8t6it1Zg
        ==
X-ME-Sender: <xms:aBzGXxdbl2jT9M4ETO_J_V9UeeL31bJXyv3z9dsRZw7Iww63ncDB_Q>
    <xme:aBzGX_Lz8dehFIaaE_2KIb7CPtFSfPfeeli1q8lW47jdkQZV1wdj4LhpySn4uvZpF
    mGztuoLsYu0Yket-jU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:aRzGX3Y_bbNOqxPm3M7xaungyKOP1f8HZTt4Pi1m0oou6Qqbv_-62w>
    <xmx:aRzGXyv2-iKRIjHodFRkNVguZ3UmbC48N3k3a6WYIdoLDy_9wMrgGA>
    <xmx:aRzGX8t7qKaBQUiqQime3b-SDcjNTkpIw9VwXWUyCMkV8u4QIQYpFQ>
    <xmx:ahzGX-Qj82O3Zr9aZT4SAm1sq0ACMJkPb7CX92QDmYPtuqvVTn37PA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C40CA1080064;
        Tue,  1 Dec 2020 05:35:20 -0500 (EST)
Date:   Tue, 1 Dec 2020 11:35:19 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT
 for PineTab developer sample
Message-ID: <20201201103519.b7rbkmjssmvy6qeo@gilmour>
References: <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org>
 <20201123111512.y7lbwsipbkcpuleb@gilmour>
 <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io>
 <20201123125332.2p5z3ew7svszvyfs@gilmour>
 <009A22D9-AF20-45C4-9674-13334B3EFFBA@aosc.io>
 <20201128103827.d6sfc2eumli2betx@gilmour>
 <1666a61f6ea3e7d573795f9000a0b096c7b7dee0.camel@aosc.io>
 <CAJiuCcfEcM+Dksm4uoRPCiRepDSnEmp7pr8Qk5EsFSH_zEOTYA@mail.gmail.com>
 <C8F86F90-14BF-4857-9DB8-7968A34E4656@aosc.io>
 <CAJiuCcc=s6xG7Wzfx6PBU0e3BHz+YRpU=t0Ef3EcTp9k11Dkzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rgqpgfhy623krart"
Content-Disposition: inline
In-Reply-To: <CAJiuCcc=s6xG7Wzfx6PBU0e3BHz+YRpU=t0Ef3EcTp9k11Dkzg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rgqpgfhy623krart
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2020 at 10:07:27PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> Hi Maxime, Icenowy,
>=20
> On Sat, 28 Nov 2020 at 12:59, Icenowy Zheng <icenowy@aosc.io> wrote:
> >
> >
> >
> > =E4=BA=8E 2020=E5=B9=B411=E6=9C=8828=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=887:54:04, "Cl=C3=A9ment P=C3=A9ron" <peron.clem@gmail.com> =E5=86=99=E5=
=88=B0:
> > >Hi Icenowy,
> > >
> > >On Sat, 28 Nov 2020 at 12:28, Icenowy Zheng <icenowy@aosc.io> wrote:
> > >>
> > >> =E5=9C=A8 2020-11-28=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 11:38 +0100=
=EF=BC=8CMaxime Ripard=E5=86=99=E9=81=93=EF=BC=9A
> > >> > On Mon, Nov 23, 2020 at 09:10:38PM +0800, Icenowy Zheng wrote:
> > >> > > > > > > > Okay. But I'm not satisfied with a non-public sample
> > >> > > > > > > > occupies
> > >> > > > > > > > the pinetab name. Is rename it to pinetab-dev and add a
> > >> > > > > > > > pinetab-retail okay?
> > >> > > > > > >
> > >> > > > > > > To me, naming the production version anything but
> > >"pinetab"
> > >> > > > > > > isn't
> > >> > > > > > > satisfying either.
> > >> > > > > >
> > >> > > > > > I understand where you're coming from, but the point I was
> > >> > > > > > making my
> > >> > > > > > previous mail is precisely that it's not really possible.
> > >> > > > > >
> > >> > > > > > You want to name the early adopter version _the_ production
> > >> > > > > > version. Let's assume the hardware changes again between
> > >the
> > >> > > > > > early
> > >> > > > > > adopter and mass-production version. Which one will be
> > >_the_
> > >> > > > > > production version? The early-adopter or the mass-produced
> > >> > > > > > one?
> > >> > > > > >
> > >> > > > > > There's really no good answer here, and both would suck in
> > >> > > > > > their
> > >> > > > > > own way. The only way to deal with this is to simply avoid
> > >> > > > > > defining one version as the one true board, and just
> > >loading
> > >> > > > > > the
> > >> > > > > > proper DT in u-boot based on whatever clue we have of the
> > >> > > > > > hardware
> > >> > > > > > revision.
> > >> > > > > Then will it be okay to rename current pinetab DT to
> > >> > > > > pinetab-sample and then introduce new DTs all with suffixes?
> > >> > > >
> > >> > > > No. From my previous mail:
> > >> > >
> > >> > > It can be seen as dropping the PineTab DT and introduce new DTs
> > >> > > with
> > >> > > suffix.
> > >> > >
> > >> > > Do we have rule that we cannot drop boards?
> > >> >
> > >> > Are you really arguing that removing a DT and then adding an
> > >> > identical
> > >> > one under a different name is not renaming it?
> > >>
> > >> Then we can just keep confusing name?
> > >
> > >Sorry maybe I missed some information
> > >But why don't you do like pinephone?
> >
> > They're the same board revision with different LCD panels.
>=20
> I just ask Pine64 about this and here is the reply :
> "The PineTab LCD panel change was a last minutes before production
> starts that vendor advise us switch over to new LCD controller due to
> EoL concern".
>=20
> "Pine64 communication" is not so bad we just need to ask and they reply :)
>=20
> So the issue is not that the Product was not finalized but that one
> component arrives in EoL.
> This could also happens during a running production.

Like you said, it can happen pretty much any time, for any reason, so
the intent doesn't really matter here.

Maxime

--rgqpgfhy623krart
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8YcZwAKCRDj7w1vZxhR
xYH3AP0dPxkYv/U6VJA+t3uPWhK00GwYTZ3CFhfHVGf/HccA6gD/dKv7K797LKRy
FdumRXFytt561Lnmzp/j2JD29QjL9AY=
=eIGA
-----END PGP SIGNATURE-----

--rgqpgfhy623krart--
