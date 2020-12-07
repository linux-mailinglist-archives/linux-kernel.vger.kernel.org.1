Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267332D0DCC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgLGKHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:07:53 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:35101 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbgLGKHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:07:53 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8C623C5E;
        Mon,  7 Dec 2020 05:07:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 07 Dec 2020 05:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=NbC2rEyqxYKunHDEfwzu0AKzVpe
        iws1VQtlVFzi38L4=; b=VqgVpTxNvPLk2cQTzwO3Txv1qM8ENYD2ADo3vR4JqCs
        waIWbiUxFblI+r3kyhykZhjihHR4miHM8HYprjdn6VLs4C5JvU+omiE0Vu1B8F3w
        TIouqejq6CZFllExC2XkAjoe6YkwITlJ6YdxWVszj+f1Vj+oyS50XMEB2giYJE+5
        tqpso+B5nWpQ39wDuqSsU12yoho+QIj7y3THsA60vcc/N7d4Z4Ft+n4sT6HXBjcm
        imPH13uSKLxnJ4lodG8pMOVSjWOOH/eeMEEzQq9bIXw6ACBolwjTbf0zwsOlXAqC
        hSyXkVhx9Hcd9Ja0LbQv+xkLfZXYfLVazNZK/Gv4/hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NbC2rE
        yqxYKunHDEfwzu0AKzVpeiws1VQtlVFzi38L4=; b=HQsjYMEMqp/I4of0A4Hq76
        sREvII8R2Q/vxtwwv5cNOK0lcjSImpDkM3A2O49wJzALl/JxSUJTiizhkRnP1hFp
        T6pFxcnS0lxKmdN+fvGQpbFK2SvLpEj+7xGHkDviohNFBgK/kbBnEldnE2qb7JEX
        KMR2jZCpARA/w//z8wwcgpA5j0pft0cNLnRbYssEWf3DkteXd9Xydmw0O/b2g0Dq
        XxP9czrV+QxswrUAv7Km8hhY4Hx6R8urp3zUl9ty/ux+EV3J/S/SOdbmrQCheT0O
        CHqQGZRxpiDCa3tatOWI3QNj5jUag94tVgbSSDhSJkRBHctKKauO/V9xdd8jr8Ug
        ==
X-ME-Sender: <xms:yf7NX6mtAWzoxFiubplz7DDy4QzmypUqmUp2Q6GplXktf4SpcJNDEA>
    <xme:yf7NXx3jfmzSQu7IQM9Upvz2OcYNliErkDPiMxV0ch3p91kR6bxThFYYIzYC4M4tZ
    x0fJcmt27t6Ao5TGug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:yf7NX4oZL65sp7DWD1LDlf4OEaceQhWC6SutXMJV-Z5B_lurRaggVA>
    <xmx:yf7NX-lHG_emeDq2X2wZNnaFNPqe6hAHznxNqBzAIJEyAWrX9nbzEQ>
    <xmx:yf7NX424SE6yX880rpRkPuY9pnZC4HbNu9Y9-rACU0kUrFmPf89vXA>
    <xmx:yv7NX5lui0VwRSR5ZxqJJ3oGei1_VviWoffb5Cu_1XAwIKMPZLd51Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C3E68240057;
        Mon,  7 Dec 2020 05:07:04 -0500 (EST)
Date:   Mon, 7 Dec 2020 11:07:03 +0100
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
Message-ID: <20201207100703.tfavhmexbtrzucry@gilmour>
References: <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io>
 <20201123125332.2p5z3ew7svszvyfs@gilmour>
 <009A22D9-AF20-45C4-9674-13334B3EFFBA@aosc.io>
 <20201128103827.d6sfc2eumli2betx@gilmour>
 <1666a61f6ea3e7d573795f9000a0b096c7b7dee0.camel@aosc.io>
 <CAJiuCcfEcM+Dksm4uoRPCiRepDSnEmp7pr8Qk5EsFSH_zEOTYA@mail.gmail.com>
 <C8F86F90-14BF-4857-9DB8-7968A34E4656@aosc.io>
 <CAJiuCcc=s6xG7Wzfx6PBU0e3BHz+YRpU=t0Ef3EcTp9k11Dkzg@mail.gmail.com>
 <20201201103519.b7rbkmjssmvy6qeo@gilmour>
 <CAJiuCceq4J=9obLTJ9TL=ci55bupc552ymGOH9z-feNTbq0hSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7z2tcet5tgoj6v36"
Content-Disposition: inline
In-Reply-To: <CAJiuCceq4J=9obLTJ9TL=ci55bupc552ymGOH9z-feNTbq0hSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7z2tcet5tgoj6v36
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 06, 2020 at 10:03:16PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> Hi Maxime
>=20
> On Tue, 1 Dec 2020 at 11:35, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Sat, Nov 28, 2020 at 10:07:27PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > > Hi Maxime, Icenowy,
> > >
> > > On Sat, 28 Nov 2020 at 12:59, Icenowy Zheng <icenowy@aosc.io> wrote:
> > > >
> > > >
> > > >
> > > > =E4=BA=8E 2020=E5=B9=B411=E6=9C=8828=E6=97=A5 GMT+08:00 =E4=B8=8B=
=E5=8D=887:54:04, "Cl=C3=A9ment P=C3=A9ron" <peron.clem@gmail.com> =E5=86=
=99=E5=88=B0:
> > > > >Hi Icenowy,
> > > > >
> > > > >On Sat, 28 Nov 2020 at 12:28, Icenowy Zheng <icenowy@aosc.io> wrot=
e:
> > > > >>
> > > > >> =E5=9C=A8 2020-11-28=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 11:38 +=
0100=EF=BC=8CMaxime Ripard=E5=86=99=E9=81=93=EF=BC=9A
> > > > >> > On Mon, Nov 23, 2020 at 09:10:38PM +0800, Icenowy Zheng wrote:
> > > > >> > > > > > > > Okay. But I'm not satisfied with a non-public samp=
le
> > > > >> > > > > > > > occupies
> > > > >> > > > > > > > the pinetab name. Is rename it to pinetab-dev and =
add a
> > > > >> > > > > > > > pinetab-retail okay?
> > > > >> > > > > > >
> > > > >> > > > > > > To me, naming the production version anything but
> > > > >"pinetab"
> > > > >> > > > > > > isn't
> > > > >> > > > > > > satisfying either.
> > > > >> > > > > >
> > > > >> > > > > > I understand where you're coming from, but the point I=
 was
> > > > >> > > > > > making my
> > > > >> > > > > > previous mail is precisely that it's not really possib=
le.
> > > > >> > > > > >
> > > > >> > > > > > You want to name the early adopter version _the_ produ=
ction
> > > > >> > > > > > version. Let's assume the hardware changes again betwe=
en
> > > > >the
> > > > >> > > > > > early
> > > > >> > > > > > adopter and mass-production version. Which one will be
> > > > >_the_
> > > > >> > > > > > production version? The early-adopter or the mass-prod=
uced
> > > > >> > > > > > one?
> > > > >> > > > > >
> > > > >> > > > > > There's really no good answer here, and both would suc=
k in
> > > > >> > > > > > their
> > > > >> > > > > > own way. The only way to deal with this is to simply a=
void
> > > > >> > > > > > defining one version as the one true board, and just
> > > > >loading
> > > > >> > > > > > the
> > > > >> > > > > > proper DT in u-boot based on whatever clue we have of =
the
> > > > >> > > > > > hardware
> > > > >> > > > > > revision.
> > > > >> > > > > Then will it be okay to rename current pinetab DT to
> > > > >> > > > > pinetab-sample and then introduce new DTs all with suffi=
xes?
> > > > >> > > >
> > > > >> > > > No. From my previous mail:
> > > > >> > >
> > > > >> > > It can be seen as dropping the PineTab DT and introduce new =
DTs
> > > > >> > > with
> > > > >> > > suffix.
> > > > >> > >
> > > > >> > > Do we have rule that we cannot drop boards?
> > > > >> >
> > > > >> > Are you really arguing that removing a DT and then adding an
> > > > >> > identical
> > > > >> > one under a different name is not renaming it?
> > > > >>
> > > > >> Then we can just keep confusing name?
> > > > >
> > > > >Sorry maybe I missed some information
> > > > >But why don't you do like pinephone?
> > > >
> > > > They're the same board revision with different LCD panels.
> > >
> > > I just ask Pine64 about this and here is the reply :
> > > "The PineTab LCD panel change was a last minutes before production
> > > starts that vendor advise us switch over to new LCD controller due to
> > > EoL concern".
> > >
> > > "Pine64 communication" is not so bad we just need to ask and they rep=
ly :)
> > >
> > > So the issue is not that the Product was not finalized but that one
> > > component arrives in EoL.
> > > This could also happens during a running production.
> >
> > Like you said, it can happen pretty much any time, for any reason, so
> > the intent doesn't really matter here.
>=20
> Agree, that was more to support Pin64 guys here.
>=20
> As pinetab compatible can't be reused maybe somethings like this :
> sun50i-a64-pinetab.dtsi
> sun50i-a64-pinetab-1.0-early-adopter.dtb
> sun50i-a64-pinetab-1.0.dtb or sun50i-a64-pinetab-retail.dtb. But
> retail is like prod it's not explicit.
>=20
> What do you think ?

I already said what I think multiple times in this thread: the DT that
has been merged for the early adopter, devs, whatever, won't be renamed.
As far as I'm concerned, I don't care about the name that is picked for
the new version as long as everyone is clear on the fact that that name
won't change ever either.

Maxime

--7z2tcet5tgoj6v36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX83+xwAKCRDj7w1vZxhR
xdWMAQD0dT1OLbOP8Y4Rt1xw421wx928drzSaTET8HnvuRI9CQD/YOVfccphlNsN
sP7QKx7HJq+niBWklfJ9I8z8cdODLgQ=
=j1fo
-----END PGP SIGNATURE-----

--7z2tcet5tgoj6v36--
