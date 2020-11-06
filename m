Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E632A9536
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgKFLZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:25:28 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59483 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgKFLZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:25:27 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B828E5C0153;
        Fri,  6 Nov 2020 06:25:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 06 Nov 2020 06:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=5Yj3pXQpJQALCaR6UFoEFtk+Vub
        KVPBnWpRqxnrhHuA=; b=hWy03zmZAFHytdBzXtRpvB+dk5szc4oggqunvmdsEG9
        nRPEZTtoG5opxmFZ9nQ9YfZLJd1vXQlPSaSXFLqUfh9AmvmZdz1Y9U+2Qh7TU69f
        Xq2e+LjwG9JDuvgMTSPb5640nMbOXFv1ntpbEMdApnzMxWBLqByNT8WliAisxrYb
        SJ77ywApQbCpQKv7eX41a6VXDcaiFtkESdwHPkzFmsutlrCpFw2ijkWwCDQCd3wA
        KPLadfTHIUIptMXf78+Ks2/+jMCnbuApz5C6KzSz6DedygeAoxSYKxA8Cp5XDOId
        NRYYGpAcAo2dl6gto6JesaKgpQmmBIVJ7/6k7MKy7Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5Yj3pX
        QpJQALCaR6UFoEFtk+VubKVPBnWpRqxnrhHuA=; b=VjeOVWhemV1v/e6auJzZYU
        ZK2Z1qQIAHO68il7TtIO1CKuqb/JGiBP9zh3CSOxh7ORpQnpnX3EhI2aeLyqxozK
        UjZiVnZ9C0kZNJtEKz1U8MKbTkUB+YZgj9iUrQM3qjHn4T/fr9cjKEdUTRbPLrVK
        frEFDdxVFipyL9hdjfcVqYoAgwRnwjfqn2f0kDf+4KEY9oWXJ/Kghcdu0Zm7ccqP
        ldraG4zvuGqKdgh954moHudsjkl3e04XXGFi0kf42e1iLyebnLylyianeqqGMWg3
        F6QyqoC/PwWD9p+f7exoQqLTtY+gAsnuwZIf0cpt5yptJgeXpr1ewpjXXHP3Rb6A
        ==
X-ME-Sender: <xms:pjKlX7g-r3OzqBlGUPtnfOMef5Ff20LIcRFrW8gOUMu8HuO1DuLg8w>
    <xme:pjKlX4AgjV2gEIjnjguaeC4k6ZTlAIxTFBkPQ25yniNlARUVMYC8xKzfLyG6rVU2r
    TPkJQG-Lhd9hYymheY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeeutdfgjeeuudehvefgvedvtedtud
    elfffgffekledtffekgedukeejueevieegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pjKlX7Euqo2-BA5LBlOv0mx-1RB-u0yUA1HUiHPfhoRoQIx6pN6cBw>
    <xmx:pjKlX4RTeAUrsrwxoSorifplE-EwnUKWjq1FvD2TUd6gf3yhOs1Hng>
    <xmx:pjKlX4zrNyEuZPSiSZbfCDhBAcu7_Lyy_kuWVPjPFLUVTe6Y6HZgNQ>
    <xmx:pjKlX0_Ez6RW8-1GDku0cacMMZlvryr2j4dDCvTFVqVQzbvc3j-46g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3BF5E3060067;
        Fri,  6 Nov 2020 06:25:26 -0500 (EST)
Date:   Fri, 6 Nov 2020 12:25:25 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Yu-Tung Chang <mtwget@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
Message-ID: <20201106112525.rhom3yedunyf2qtn@gilmour.lan>
References: <20201102100157.85801-1-mtwget@gmail.com>
 <20201102100157.85801-2-mtwget@gmail.com>
 <20201103113743.5764tj2ryrht4dfs@gilmour.lan>
 <CAHRgzyOao=w6Yyqqvi1Z26=rfJgumkzDbWLxD+_5uaLmyAWiQA@mail.gmail.com>
 <20201105171051.ducvxcdj5jfarmgn@gilmour.lan>
 <CAHRgzyNzXk1uJzEVLvrqPu2CT8jzF+5UFEubT6kEtF=8HVgROQ@mail.gmail.com>
 <CAGb2v64HyUn8KjPPA0JBA5tPaxX7-keNfs+M22pL5SmETN0FQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o5cxt6yl5jkrofc6"
Content-Disposition: inline
In-Reply-To: <CAGb2v64HyUn8KjPPA0JBA5tPaxX7-keNfs+M22pL5SmETN0FQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o5cxt6yl5jkrofc6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 10:10:10AM +0800, Chen-Yu Tsai wrote:
> On Fri, Nov 6, 2020 at 10:03 AM Yu-Tung Chang <mtwget@gmail.com> wrote:
> >
> > Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2020=E5=B9=B411=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:10=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Nov 04, 2020 at 04:07:48PM +0800, Yu-Tung Chang wrote:
> > > > > > +&uart1 {
> > > > > > +     pinctrl-names =3D "default";
> > > > > > +     pinctrl-0 =3D <&uart1_pins>;
> > > > >
> > > > > This should be already set in the DTSI
> > > > >
> > > > uart0 as the debugging interface, uart1 as the external uart port,
> > > > uart3 as the bluetooth.
> > >
> > > What I mean is that since it's the only muxing option, the pinctrl
> > > properties should already be set in the DTSI, so it's redundant to put
> > > them in the DTS.
> > >
> > I can only see the definition of uart0 in the DTSI,
> > because uart1 as the extension interface is exclusive to NanoPi R1.
>=20
> Maxime, to clarify, UART1 can be used with or without RTS/CTS,
> so there is no default muxing in the DTSI.

Ah, right. I've applied the patch, thanks!
Maxime

--o5cxt6yl5jkrofc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6UypAAKCRDj7w1vZxhR
xULWAQDtMJJRAnUKqx7U3L+DoVsH4mBZm+cp6aPjSmezn/xztgD/amXTl45vNkPz
Hs9hPJMRhRwjXBx5r8+fAmbkQ0RdbQQ=
=SP/I
-----END PGP SIGNATURE-----

--o5cxt6yl5jkrofc6--
