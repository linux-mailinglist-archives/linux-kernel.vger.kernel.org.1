Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815CE2B0249
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgKLJxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:53:13 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55123 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbgKLJxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:53:13 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 726D35C026F;
        Thu, 12 Nov 2020 04:53:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 12 Nov 2020 04:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=+sWDnx/n+ybRIJoG2pafbzOn3UJ
        L3h7w5ofbZDMcvFU=; b=EGuzmtS/vMRW/yuTFYxtgA+Btxse1hyhbiH4MoZfbFR
        9T0yeLAw1CI1OdSQr4ivGSnZEqLaE0hYvLhdOboXXPB6e0Ju/SVKs8BAV1lJjzti
        j0atF22z2JKw3PeOwC6wA8pHDYEyAH5EqE1O/vCrXP5K9Ow51dHpurrHN7ZZrjc6
        2u9mx0PrJqA2m0pipM0Fn98sadkUHhshRUQH1CcfP/kboAvsbqEYomQUOESPmw6D
        YLEU0/fkOUXLTueiAW0f+Nw6eufrjvii/trniDJZyw6WaTLFVdLE0Wr9aQ9Mwerd
        d3Pi+KV7s9lRK1yyUvVmbdd7NBC9G1a74fBExBW3XNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+sWDnx
        /n+ybRIJoG2pafbzOn3UJL3h7w5ofbZDMcvFU=; b=j0ytNFQr8Utr00lzY+v2qL
        ufbAhvVrjELRPekWGsYrzwfiiQ32VrSfaFfgnNws+YLJ2xGZCPsHAMXmuChEi6aL
        8PhN0Bf5Kq5UE5PKL/eePnJiug0x0iMr4u6s7HZM9ahKGqr6WLg6CJfdtsydlxaL
        tmmdZ1n6RutwFXO25KHCHir9bKbYC5jVU2nKq55AMRXi7s6BBjypNfsBsNabPvHl
        GdvllCW1aWt4eeOB4aYESkMGRtsPtdr1w373DTCihgxWzd4YBzij65svqgGEkQDv
        9xWHTQUxCsy0hW1/1AanL5WOPfhE4e9ICgkMdcBHlCN2LDzJKL9TgVP6Hmfr7+FQ
        ==
X-ME-Sender: <xms:BgatX1-QOxDlGc5JJvW1InZJP7v0dM6dIwiNLbFOewV-nZKB8VOfRw>
    <xme:BgatX5vumy5eTE8iQ4jp4mqg_lymrwn2uS9vo38xpCQkSyBXmGWPlMQBNQpwDrBAH
    d123iBUSyvH19k-3hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvvddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepffeijeetheethfevgeekvdejteeghfeiueekhefgteffudekteeikefftdej
    iefhnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdeike
    drjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    mhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:BgatXzAyCEn29uOrW1Y-wEp-1EhhmqlZ5nTptWeogOoEQNB83NY-Tw>
    <xmx:BgatX5fqt56W3Q-Ol_mSeOxEIIK3-b4qSvR8RutJUSiiHK_loEeDlw>
    <xmx:BgatX6NQikIgseoABn7mCmdkSfJT1oQQ5fES3hqahQxy4KpZFab3Fw>
    <xmx:BwatX2DLuUwKfAqvCjPEf8TjGb3gENSHvSxdnq-QYpQg9aEJLgTRrQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 135813280059;
        Thu, 12 Nov 2020 04:53:09 -0500 (EST)
Date:   Thu, 12 Nov 2020 10:53:07 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Frank Lee <frank@allwinnertech.com>, vkoul@kernel.org,
        wens@csie.org, krzk@kernel.org, colin.king@canonical.com,
        tiny.windzz@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] phy: sun4i-usb: Use power efficient workqueue for
 debounce and poll
Message-ID: <20201112095307.pblcmrn6smyecvqi@gilmour.lan>
References: <20201109121214.19012-1-frank@allwinnertech.com>
 <fba49549-9a78-32ee-a55c-97499f24fe62@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="thkg54eq3saapyx3"
Content-Disposition: inline
In-Reply-To: <fba49549-9a78-32ee-a55c-97499f24fe62@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--thkg54eq3saapyx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2020 at 09:44:37PM -0600, Samuel Holland wrote:
> On 11/9/20 6:12 AM, Frank Lee wrote:
> > From: Yangtao Li <frank@allwinnertech.com>
> >=20
> > The debounce and poll time is generally quite long and the work not
> > performance critical so allow the scheduler to run the work anywhere
> > rather than in the normal per-CPU workqueue.
> >=20
> > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > ---
> >  drivers/phy/allwinner/phy-sun4i-usb.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwin=
ner/phy-sun4i-usb.c
> > index 651d5e2a25ce..4787ad13b255 100644
> > --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> > +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> > @@ -326,7 +326,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
> >  		/* Force ISCR and cable state updates */
> >  		data->id_det =3D -1;
> >  		data->vbus_det =3D -1;
> > -		queue_delayed_work(system_wq, &data->detect, 0);
> > +		queue_delayed_work(system_power_efficient_wq, &data->detect, 0);
> >  	}
> > =20
> >  	return 0;
> > @@ -444,7 +444,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
> > =20
> >  	/* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */
>=20
> This doesn't sound like "not performance critical" to me. My understandin=
g is
> the debouncing has a deadline from the USB spec. Maybe this is more flexi=
ble
> than the comment makes it sound?

It's not really clear to me what the power_efficient workqueue brings to
the table exactly from the comments on WQ_POWER_EFFICIENT (and the
associated gmane link is long dead).

It's only effect seems to be that it sets WQ_UNBOUND when the proper
command line option is set, and WQ_UNBOUND allows for the scheduled work
to run on any CPU instead of the local one.

Given that we don't have any constraint on the CPU here, and the CPU
locality shouldn't really make any difference, I'm not sure we should
expect any meaningful difference.

This is also what the rest of the similar drivers seem to be using:
https://elixir.bootlin.com/linux/v5.10-rc3/source/drivers/usb/common/usb-co=
nn-gpio.c#L119
https://elixir.bootlin.com/linux/v5.10-rc3/source/drivers/usb/core/hub.c#L1=
254

Maxime

--thkg54eq3saapyx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX60GAwAKCRDj7w1vZxhR
xWGHAQDmGJRbV80bZACkQg9QHK386dBawts71lgws8vTZO8fLQEAn43EQDv/hXjz
vgTtYcSCzPrZ4Zw1e5LbH9KJK71aegE=
=Wgu7
-----END PGP SIGNATURE-----

--thkg54eq3saapyx3--
