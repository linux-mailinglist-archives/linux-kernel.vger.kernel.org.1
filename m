Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7758D2A2CF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgKBO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:27:50 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:49867 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbgKBO1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:27:50 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5F691F4E;
        Mon,  2 Nov 2020 09:27:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 09:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=u1lasnIG2eGKOFyUdl3ID5Smz+K
        fPvZ2J9Y1zvLsTiY=; b=iqw+KF1jOGs4xVuovetmHfMFdGWrKcTwBLdH4DFT0rP
        i03a2FjI2FKimA1rfL+IzL52Z0z56B1qYkNY200dI6CyDiwuf6wOPwVI2B91Snas
        XiByXsbTbJYrNe3Fqo4+Itmz0yNuTbO8agDVV65B5tfY1GvmcIredmbLNLYmfJJI
        6QXz7LswEhjXeKn2aQdZPdYyA/nUWicUfr3YQU6517Ze1D4PLSnfO506P64KeJBA
        /M9Pqh1L1J0lS6SJd2l0DKTfyQ/D/6O2S42Gs+GV011tz6eB1dGph5wA9Mqzo1Ad
        qT6UvFMn/dN6o9iyhO3Q0lTd2VHtcUcI9jiGaXf/Feg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=u1lasn
        IG2eGKOFyUdl3ID5Smz+KfPvZ2J9Y1zvLsTiY=; b=DNlbHckHYXOGVvLvz4xvJu
        FibaPrWku0GcRJgaK8gl/fay99SUM46RfCUagOPsFxhg9nsdOOmB4GaT2HR2vk5J
        9pQ7RZ2Xtl2lfRu4xaI7hb6QhXJuWh4oXNYwz/FzCU7tP9Gr1F3dV6Yeo9YrA8Qn
        gvWJcnksGr2M/OCUsnlcFXo4bZMdHrndftl3bTg9TlWB1CX7uR00f4evybRHUc3Z
        vvbep9VqAsm8TC9h/Sogmk3sWsiZkObXFU6Bb4vvBkzZF5/xNr/B8xaUs4YhdW1Z
        O5NC/ALnNlbdaki6CL4djyGfRL49nFF4dhgrQ1n7DH30KyTY8HmYjlNIYp4FMy8A
        ==
X-ME-Sender: <xms:YhegXzGT1sldYcuh1PmGHY91RXdsVr1qBu7K_frbo9eWzUwiQ5qKGg>
    <xme:YhegXwXOvC-EOwqEt0-O61I-63149u-QB5HtDGCJypsPcEb7sx969usCGSf-FS36b
    RUvOvP_TrgIFQaPIag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:YhegX1KOeC6lVYQ555bO0XAO2B5CxaKrzdU5R_kGp8lfvD6Ep8mgTA>
    <xmx:YhegXxGxra0BOc95BpLAVuuL3IAFH4hkT2amazX3KCkv_iQYggWrWg>
    <xmx:YhegX5Vu-TUc1rGBeteKFPpx8z-IfKVMjSf4z8AKm7Ol1MqTIpz_AA>
    <xmx:YxegX3clbMs122OKg58RPi4VHY3TSCfsEqevUPlhq5Vbdlj6gUc5eg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F06CB3064688;
        Mon,  2 Nov 2020 09:27:45 -0500 (EST)
Date:   Mon, 2 Nov 2020 15:27:44 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 8/9] dt-bindings: arm: sunxi: Add SL631 with IMX179
 bindings
Message-ID: <20201102142744.lxjvu67pr7dmxzo7@gilmour.lan>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-9-contact@paulk.fr>
 <20201102101333.4bm2lfqpqnbpyp63@gilmour.lan>
 <20201102103340.GD11809@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cdmzcvhmv6crmjoh"
Content-Disposition: inline
In-Reply-To: <20201102103340.GD11809@aptenodytes>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cdmzcvhmv6crmjoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 11:33:40AM +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Mon 02 Nov 20, 11:13, Maxime Ripard wrote:
> > On Sat, Oct 31, 2020 at 07:21:36PM +0100, Paul Kocialkowski wrote:
> > > Document the compatible strings for the SL631 Action Camera with IMX1=
79.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > ---
> > >  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Docum=
entation/devicetree/bindings/arm/sunxi.yaml
> > > index afa00268c7db..0fa0c0b5d89f 100644
> > > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > @@ -754,6 +754,12 @@ properties:
> > >            - const: sinlinx,sina33
> > >            - const: allwinner,sun8i-a33
> > > =20
> > > +      - description: SL631 Action Camera with IMX179
> > > +        items:
> > > +          - const: unknown,sl631-imx179
> > > +          - const: unknown,sl631
> > > +          - const: allwinner,sun8i-v3
> > > +
> >=20
> > unknown is not a valid vendor (and you should explain why you picked
> > that vendor name in the first place).
>=20
> Ah right, it's not in the vendor prefixes. The rationale is that there is=
 no
> indication of what the vendor might be on the PCB. Should I maybe use
> allwinner here?

You should mention it in the commit log for a start :)

But yeah, we've used allwinner as a fallback for those cases so far.

Maxime

--cdmzcvhmv6crmjoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6AXYAAKCRDj7w1vZxhR
xazfAQCTALPCW+BoUtOYsJJCGdpXhyQe4JgWh6/BgXFj86SV9QD/Rmpkyj/D2Z9u
FkBRpMa2xPFAKK2SudAbNcYpnU9mcAg=
=k95c
-----END PGP SIGNATURE-----

--cdmzcvhmv6crmjoh--
