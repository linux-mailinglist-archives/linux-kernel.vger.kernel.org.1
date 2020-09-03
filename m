Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E1725BBD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 09:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgICHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 03:40:34 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:60797 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbgICHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:40:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id C890CB01;
        Thu,  3 Sep 2020 03:40:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 03:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=3d+fTLgpTQcvjVM12OzE052YfvZ
        PoumZnCP7vT0BNTc=; b=myWiETMlIlUWHiTv8WnuXR+IYKbfeY5RfHZzjkLV+Xw
        vOJYm7vw+zvumPkFdHPXWFtkzhTYSTTd0kc6GrkplI4ro5xwGlVFKwTKqL6jra1X
        ksTvu1GJCw0OMAelGSu1027OYyKQ3kBURhut6zWOaxQfFjr8GlcY8lBvxPNqzMtK
        OUGZeAYHEmTpCkcZhosndWdeEoOKeOFu53O8EXVO+Tr4dFCir9889Qe1u5Uvg/c1
        TI26DKLLToqDDNovI8WA/o22S9QZub5mhlrJF27B32oa6Gf8IKWigG8fYNu7ORL0
        u1CsM+fhrutvTxQq7l52RBAsbBGUHfPKY1jS0tXI8Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3d+fTL
        gpTQcvjVM12OzE052YfvZPoumZnCP7vT0BNTc=; b=t8qsS6P2vWW1REZJvCGNSX
        pl+k4eLlBP1UE8HWUavDheeb/zxkwmSlFYeSGsvk2ur7ajehHxmyBh6HsxfT0MTi
        nFwP/PWOXjXKxj/z0XBSr1lbAUNYXhVRRRa0q9QKX/Ay1bndTmlUSrTr3Mv6tqRg
        tANMq//E+NVwezpXe9BybmRJ8g/ws8isYuYOH0xt9sc8aKKf6ZP6mxjQ/p/dT7f3
        JoVGPXZUtrGj6moTYiCmcOLj35IsjjIxhqgapxa9SOIZe8iL9Zi8yI/cWnZWxJk0
        HF/RZCc3Nm9WIzf1B2PXx2YlfVkXHDBDjDD6wIj0mWJgHPfs0s7pQlec9/TFcfUA
        ==
X-ME-Sender: <xms:6J1QXzSLhYLxfFGknODb2Ae788cK4MRv0U__qoHhytLcNehHxF7T9g>
    <xme:6J1QX0wZ00GfzX-DW7jTfsMiazYVBF7irVylDdk8drpqpT46dWVqtG1I_Kidt37sM
    4mW4mcntfl6uilkk8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetledvveffgeeuheejtdegteekueetjeevgfeivefgieegkedtieelgeeh
    gfetheenucffohhmrghinhepsghoohhtlhhinhdrtghomhdprghlshgrqdhprhhojhgvtg
    htrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:6J1QX41lDOEAKklcccok3PNTKENVssFgMkCkLSLaNvr9uiQRf7otdQ>
    <xmx:6J1QXzBXYx56KO9G0c2dZiPyU8blePa1PPP7wOuwfvb0n6u7BlmuCA>
    <xmx:6J1QX8gDJW05sUPuBsSsEmZYgl8HEB7XuS5a6E4dHUBtVH_Ssefv9w>
    <xmx:7J1QX9Z3lVLD5oQ8MuHNjreGVonrk0LKnURgO8FmaqAX-A6Vheti1zbGe6M>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6B68C328005D;
        Thu,  3 Sep 2020 03:40:24 -0400 (EDT)
Date:   Thu, 3 Sep 2020 09:40:23 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        peron.clem@gmail.com, Chen-Yu Tsai <wens@csie.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH 05/16] ASoc: sun4i-i2s: Add 20 and 24 bit
 support
Message-ID: <20200903074023.jccqp45br3er4h3g@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-6-peron.clem@gmail.com>
 <1e320dfd-9388-54b2-dba9-7def0bf4bbad@sholland.org>
 <9148679.oVN3Z7rve9@kista>
 <fd714cb6-3650-1eb9-616d-33c00f1442eb@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hf5an3s4qg2ib7h7"
Content-Disposition: inline
In-Reply-To: <fd714cb6-3650-1eb9-616d-33c00f1442eb@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hf5an3s4qg2ib7h7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2020 at 09:22:33PM -0500, Samuel Holland wrote:
> On 9/2/20 1:10 PM, Jernej =C5=A0krabec wrote:
> > Hi Samuel!
> >=20
> > Dne petek, 10. julij 2020 ob 07:44:51 CEST je Samuel Holland napisal(a):
> >> On 7/4/20 6:38 AM, Cl=C3=A9ment P=C3=A9ron wrote:
> >>> From: Marcus Cooper <codekipper@gmail.com>
> >>>
> >>> Extend the functionality of the driver to include support of 20 and
> >>> 24 bits per sample.
> >>>
> >>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >>> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >>> ---
> >>>
> >>>  sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
> >>>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> >>> index f78167e152ce..bc7f9343bc7a 100644
> >>> --- a/sound/soc/sunxi/sun4i-i2s.c
> >>> +++ b/sound/soc/sunxi/sun4i-i2s.c
> >>> @@ -577,6 +577,9 @@ static int sun4i_i2s_hw_params(struct
> >>> snd_pcm_substream *substream,>=20
> >>>  	case 16:
> >>>  		width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> >>>  		break;
> >>>
> >>> +	case 32:
> >>> +		width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +		break;
> >>
> >> This breaks the sun4i variants, because sun4i_i2s_get_wss returns 4 fo=
r a 32
> >> bit width, but it needs to return 3.
> >=20
> > I'm not sure what has WSS with physical width and DMA?
>=20
> This is the change where creating a S24_LE stream no longer fails with -E=
INVAL.
> So this is the change where userspace stops downsampling 24-bit audio sou=
rces.
> So this is the change where playback of 24-bit audio sources breaks, beca=
use WSS
> is programmed wrong.
>=20
> >> As a side note, I wonder why we use the physical width (the spacing be=
tween
> >> samples in RAM) to drive the slot width. S24_LE takes up 4 bytes per s=
ample
> >> in RAM, which we need for DMA. But I don't see why we would want to
> >> transmit the padding over the wire. I would expect it to be transmitte=
d the
> >> same as S24_3LE (which has no padding). It did not matter before, beca=
use
> >> the only supported format had no padding.
> >=20
> > Allwinner DMA engines support only 1, 2, 4 and sometimes 8 bytes for bu=
s=20
> > width, so if sample is 24 bits in size, we have no other way but to tra=
nsmit=20
> > padding too.
>=20
> I understand why we do 4 byte DMA from RAM <=3D> I2S FIFO; that was not my
> question. I'm referring to the actual wire format (FIFO <=3D> PCM_DIN/DOU=
T). The
> sample is already truncated from 32 bits to 24 bits in the FIFO -- that's=
 what
> TXIM and RXOM in FIFO_CTRL control.
>=20
> If a sample is 24 bits wide, why would we send 32 BCLKs for every LRCK? I=
 would
> expect the slot width to match the sample resolution by default. But yet =
we have
> this code in the driver:
>=20
>     unsigned int word_size =3D params_width(params);
>     unsigned int slot_width =3D params_physical_width(params);
>=20
> I think slot_width should be the same as word_size, and I suggest changin=
g it
> before adding 20/24-bit support.

Generally speaking, the slot width doesn't necessarily match the
physical width. With TDM for example you may very well have slots
larger than their samples.

That being said, S24 is explicitly a format where you send a sample of
24 bits in a 32-bit word (in the lowest three bytes, little endian)

See:
https://elixir.bootlin.com/linux/v5.9-rc3/source/sound/core/pcm_misc.c#L75
https://mailman.alsa-project.org/pipermail/alsa-devel/2013-April/061073.html

24 bits of data over three bytes like you suggest is S24_3LE

Maxime

--hf5an3s4qg2ib7h7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1Cd5wAKCRDj7w1vZxhR
xQAeAP9vjuO9Y3b+CKzmLOQ15SsDQDnKlVOEAQ0bmzds+Gn3dgEAvPzB50hkYbu/
m3XNc7Nyk17Y4tBWmLWyuoQ8IodG1QM=
=gvkH
-----END PGP SIGNATURE-----

--hf5an3s4qg2ib7h7--
