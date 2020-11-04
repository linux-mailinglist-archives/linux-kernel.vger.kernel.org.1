Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9D2A6D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgKDTE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:04:29 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36559 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730159AbgKDTEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:04:12 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B783E9AF;
        Wed,  4 Nov 2020 14:04:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 04 Nov 2020 14:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Q2SYH6K4Nqo96bsFhKCbE6Bdp7q
        7RD+0bBhw2ThOJsY=; b=SDqic7k/DcDWl2EO9ALuM3U7/DnWZ6sK1g/snvZi4lv
        r5fOnF9y7CmbyHdObLSuj3PPgjx71jq5/4er4Yu86fF9WANn2uVicjUspN3zDb26
        USW3aI2zBAfevIGc9Lr3FaJa3f4OvSx7zN9M0J58icY/OXEJ74o/SDQjT+o9Repb
        0w/P7wwW6kM+7F+HwfodAloSRuzWMKQLkQIfvO08SV8Fz/SyjRBHeKFWCpFpgtON
        ku8IECAXftM07mdYk3g4ex9DprCs0joFDpBaXGdVy3gV+mifGdqp4if2S0I4YU4e
        cyo5bfLIHxeNQQne5FQPHkXhHdp/ZpCaXUcRC/8iSHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Q2SYH6
        K4Nqo96bsFhKCbE6Bdp7q7RD+0bBhw2ThOJsY=; b=UqJGTyP0StfkG/sXt9uuOG
        oaPu76n2k2xHgzuzKScrsP3gUZ4NhayXHmHwbzBJoIxLvLdyvVxguP1BifKeyhNI
        o5OlmhBL3mNf/aYQMqCcnGGtZJf8iXAnZFJzAj+HOYysCJZK3dOd2t+bBipOXokd
        dSJlnTbZPqs9hF2vbTFr3CT1FYvd+j3DrHmHCgUyt6nT5+dVIqm5y6o9WrmHjDve
        /kTa9j72woBy3bI5wxCJn5r2mFveByc5ZWOC6paUioSF0M1oX1BouAHJTLmLrmTE
        vC4Si1ABSRqxoA1IMCIiMNHo8CnKG5C4MeeJbPUtFu6Ufxm+ErjB9/EqlZYyEgMQ
        ==
X-ME-Sender: <xms:KvuiX2at4Ph-Z2d50upHk3Juxnn5_ilo0OxiStJz6cge--0ftkbL4A>
    <xme:KvuiX5aUcWlQUfSxnZqJgSnmPHvhisAsEehOG_D0IKlbXL5USNDu9AkmSdPYE-LWZ
    AqFA58iVxOZncMdYEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:KvuiXw9gg_YR0iQNSbAaxKcX6x9kb0HAKbqlfRS66AaZnC2ESwnV5g>
    <xmx:KvuiX4rM9NIbcDLSlSTNmLVUVAuFN0W3arJgBDKE2jQqwgGMoFAuSQ>
    <xmx:KvuiXxrXejms3S5Ql3DKyTPfoxngyOKqHkKpY-GwoU_sggyrftUlMw>
    <xmx:K_uiX43t-614gSUKhNrgAJGyGs4XEJfvxwU5-kfFawcd4dZNRuZjuA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5CEA6328038E;
        Wed,  4 Nov 2020 14:04:10 -0500 (EST)
Date:   Wed, 4 Nov 2020 20:04:08 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] ARM: dts: sun8i: s3: Add dtsi for the Elimo
 Impetus SoM
Message-ID: <20201104190408.krxoqm2fei3kboud@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201030234325.5865-4-matteo.scordino@gmail.com>
 <20201102100540.wkqoy4nilmee7mpv@gilmour.lan>
 <5ea8344baa73068f30945ca5c76f582ca4844b3e.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uxcttehbtep2djxm"
Content-Disposition: inline
In-Reply-To: <5ea8344baa73068f30945ca5c76f582ca4844b3e.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxcttehbtep2djxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Nov 03, 2020 at 04:28:27PM +0000, Matteo Scordino wrote:
> --=20
> Matteo Scordino / Embedded Software Consultant
> Mobile: +44 (0)7463701446
>=20
> On Mon, 2020-11-02 at 11:05 +0100, Maxime Ripard wrote:
> > Hi!
> >=20
> > On Fri, Oct 30, 2020 at 11:43:22PM +0000, Matteo Scordino wrote:
> > > The Elimo Engineering Impetus is an Open Source Hardware System-on-Mo=
dule
> > > based on the SoChip S3 SoC.
> > >=20
> > > It is meant for integration into carrier boards or, more generally,
> > > larger designs, and uses an M2 connector to facilitate that.
> > >=20
> > > Interfaces on the M.2/NGFF 42mm connector:
> > > WiFi IEEE 802. 11abgn (on-module Realtek)
> > > Bluetooth 4.2/BLE (on-module Realtek)
> > > RGB LCD Interface (on-module connector)
> > > MIPI Camera Interface (on-module connector)
> > > IEEE 802. 3u Ethernet MAC (external connecto)
> > > USB2.0 (Host, Device, OTG) (external connector)
> > > Audio Line In/Out (external connector)
> > >=20
> > > Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi | 51 +++++++++++++++++=
++
> > >  1 file changed, 51 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
> > >=20
> > > diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi b/arch/arm=
/boot/dts/sun8i-s3-elimo-impetus.dtsi
> > > new file mode 100644
> > > index 000000000000..f219188fc9ba
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
> > > @@ -0,0 +1,51 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "sun8i-v3.dtsi"
> > > +#include "sunxi-common-regulators.dtsi"
> > > +
> > > +/ {
> > > +	model =3D "Elimo Impetus SoM";
> > > +	compatible =3D "elimo,impetus", "sochip,s3", "allwinner,sun8i-v3";
> > > +
> > > +	aliases {
> > > +		serial0 =3D &uart0;
> > > +		serial1 =3D &uart1;
> > > +	};
> > > +
> > > +	chosen {
> > > +		stdout-path =3D "serial0:115200n8";
> > > +	};
> > > +};
> > > +
> > > +&mmc0 {
> > > +	broken-cd;
> > > +	bus-width =3D <4>;
> > > +	vmmc-supply =3D <&reg_vcc3v3>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&uart0 {
> > > +	pinctrl-0 =3D <&uart0_pb_pins>;
> > > +	pinctrl-names =3D "default";
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&uart1 {
> > > +	pinctrl-0 =3D <&uart1_pg_pins>;
> > > +	pinctrl-names =3D "default";
> > > +	status =3D "okay";
> > > +};
> >=20
> > What is uart1 used for? the BT chip?
> >=20
> > Maxime
>=20
> No, BT is provided over SDIO by a Cypress 43455.
> When used with the Initium carrier board, UART1 goes to an FTDI bridge th=
at is
> connected to the same USB-C connector that is used for power.
> The idea being, if want an application that uses the UART to communicate =
with a
> PC, it's convenient to provide power+connectivity on a single port.
>=20
> I guess your point is that we would be better off only defining this in t=
he DTS
> of the carrier board?

I wasn't trying to make any point, it was a legitimate question, we
don't want to enable something that is optional or could be used for
something else (like a UART exposed on a generic pin header).

But from what you're telling me, yeah, it should be moved to the
daughter board DTS.

Maxime


--uxcttehbtep2djxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6L7KAAKCRDj7w1vZxhR
xYMTAP9RnYdBwSJcIxgDEB7xxcKiAogacJhfpAGCvzzU8/Ls4AEAqqx64lbW6fPP
71VnXsKs2elZAKdEm609+fWbL7/AhAY=
=D8Iv
-----END PGP SIGNATURE-----

--uxcttehbtep2djxm--
