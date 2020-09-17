Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD9526DE54
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgIQOei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:34:38 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42273 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727452AbgIQObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:31:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id AB3E92DE;
        Thu, 17 Sep 2020 10:06:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 17 Sep 2020 10:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=dBcaRg6P4rVD8VwgeNGJk/SEdhP
        6leuSbEdEW1YCNws=; b=SCyVaRuKlcoPbbT6EFa1cbOegF9VSphyTErRlGUsEdQ
        z8NMD5ILBT3tdbwFO/mwkCcxrYrh7vBPjMS9WCjOrFPpGCXUR7hNQpAx09D45ODP
        HkB1W8H90oBG+Fb1nR9cdxCro3waB4/MwfjWPfDkU/OWjt0PRKy+80rfmiHXSoy3
        HlD9Koj00iANSVYxm4mgXcYcJ1xtyipErHgEAFMNnGuOIc2/7v3Z5nqmsi67bCMz
        cVDcCQQNaGg0yB61PbaldzTKAGG/HC8wN2wQZLCvTdtHWC66C1wi7j4kluBgrKY2
        IUPe24hWtI0sowcj1zIHo9mhLf7Uv85UZyBPwpT0+vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dBcaRg
        6P4rVD8VwgeNGJk/SEdhP6leuSbEdEW1YCNws=; b=LZvQpw5tm1mnjd4zGiXs+s
        I4ExZZTNj1QuOuE4KzMlvpZxokOSEGPyzH/Sd765fW7ViYcOhAGvyRWxoHDz/BSz
        OGpWG+SgByF0sQuGQYtcXgMDxvWh8hbbA4+1dhcBsXLFm+6aQ1sSO9pAOrvEwZnl
        v6jNWi/2s6R26viwSecdZU1KQY5dZ5jvd7RQXCyrDM0aqOPQFsiVVQ0jyHu9xs8C
        voVt03dbSSl/kooe3H7tEadyLWzWnVs8p5lxn1LeiJfRio16ttRvCqdUdsrl9ZD4
        owfMHa03hvYeDr1GgqODnFWs3DqE2dF1E93DEgPeV7JLpGbgTbR+FRbX3Pn3cJSw
        ==
X-ME-Sender: <xms:VW1jX8ptKxN6mzo0ATeDsYCcRuwNIEVcVUxrBNlhU2NUZYQGEu0JLg>
    <xme:VW1jXypXT9h-3FhBcFyIYzPD83NG9ykJ9gLvJiRXasddkH5fEfseHlh5M1BVGOK0F
    tVCmrGRAkSJ9ZkiJxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeetgfejtdelgeffffeitdfhtddvfeeijeffteelkefhledvvefggfdujeegieeg
    hfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeeltddrkeelrdeikedrje
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:VW1jXxMxMCCI1CM4cs2qiQGWtjg_Wk7X9X_27aLidvCrlmYCWmes5A>
    <xmx:VW1jXz5jA_0INEvL0vXKTZm4qV6vDZi3x7v1ZUu7TvsmjN6l4lw4uw>
    <xmx:VW1jX765BkO4ysL_ZXYO29PtPhuRcUgOIQ-kulQ0VnNN-E8uRlamng>
    <xmx:WW1jX_h2qHDy4Bt-VmJzKH35s3RSMAELqhKLtJJRZ7vdfLnzgeT4UjihXmI>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8DAA3280060;
        Thu, 17 Sep 2020 10:06:12 -0400 (EDT)
Date:   Thu, 17 Sep 2020 16:06:11 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
Message-ID: <20200917140611.5qpsz24yfii5kzcn@gilmour.lan>
References: <CAJiuCceF340FiLvyeXNZtvqftQMAmk=MtFDLT_9696ix+eH1Yw@mail.gmail.com>
 <20200729143927.47f5tbuaob4ph3lp@gilmour.lan>
 <20200729151548.GB5612@sirena.org.uk>
 <CAJiuCcdf=TNLPTUPzHP9NzPHqdxG06TRDkQfONY+ScK0DV_v5w@mail.gmail.com>
 <20200903205851.gdnpthserywsxrbs@gilmour.lan>
 <80b5a4e3-c8bc-9521-4ff1-12bb6424516f@sholland.org>
 <20200910143314.qku7po6htiiq5lzf@gilmour.lan>
 <57f8bdeb-14dc-583e-ffa8-43d7a9f1bb24@sholland.org>
 <20200917132128.e6z4gwoluipbzigm@gilmour.lan>
 <CAJiuCcdWQRVMeTLvxibZ37CF9BMiC_L2bWBDiin2Uz0CWq2FuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ey2pcwi4beb67jg7"
Content-Disposition: inline
In-Reply-To: <CAJiuCcdWQRVMeTLvxibZ37CF9BMiC_L2bWBDiin2Uz0CWq2FuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ey2pcwi4beb67jg7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Clement,

On Thu, Sep 17, 2020 at 03:55:45PM +0200, Cl=E9ment P=E9ron wrote:
> Hi Maxime and Samuel,
>=20
> On Thu, 17 Sep 2020 at 15:21, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Sat, Sep 12, 2020 at 03:29:55PM -0500, Samuel Holland wrote:
> > > On 9/10/20 9:33 AM, Maxime Ripard wrote:
> > > > On Thu, Sep 03, 2020 at 09:54:39PM -0500, Samuel Holland wrote:
> > > >> On 9/3/20 3:58 PM, Maxime Ripard wrote:
> > > >>> On Thu, Sep 03, 2020 at 10:02:31PM +0200, Cl=E9ment P=E9ron wrote:
> > > >>>> Hi Maxime,
> > > >>>>
> > > >>>> On Wed, 29 Jul 2020 at 17:16, Mark Brown <broonie@kernel.org> wr=
ote:
> > > >>>>>
> > > >>>>> On Wed, Jul 29, 2020 at 04:39:27PM +0200, Maxime Ripard wrote:
> > > >>>>>
> > > >>>>>> It really looks like the polarity of LRCK is fine though. The =
first word
> > > >>>>>> is sent with LRCK low, and then high, so we have channel 0 and=
 then
> > > >>>>>> channel 1 which seems to be the proper ordering?
> > > >>
> > > >> Which image file is this in reference to?
> > > >>
> > > >>>>> Yes, that's normal.
> > > >>>>
> > > >>>> Thank you very much for this test.
> > > >>>>
> > > >>>> So I will revert the following commit:
> > > >>>>
> > > >>>> ASoC: sun4i-i2s: Fix the LRCK polarity
> > > >>>>
> > > >>>> https://github.com/clementperon/linux/commit/dd657eae8164f7e4baf=
e8b875031a7c6c50646a9
> > > >>>
> > > >>> Like I said, the current code is working as expected with regard =
to the
> > > >>> LRCK polarity. The issue is that the samples are delayed and star=
t to be
> > > >>> transmitted on the wrong phase of the signal.
> > > >>
> > > >> Since an I2S LRCK frame is radially symmetric, "wrong phase" and "=
inverted
> > > >> polarity" look the same. The only way to definitively distinguish =
them is by
> > > >> looking at the sample data.
> > > >>
> > > >> In "i2s-h6.png", the samples are all zeroes, so you're assuming th=
at the first
> > > >> sample transmitted (that is, when the bit clock starts transitioni=
ng) was a
> > > >> "left" sample.
> > > >>
> > > >> However, in "h6-i2s-start-data.png", there are pairs of samples we=
 can look at.
> > > >> I'm still assuming that similar samples are a left/right pair, but=
 that's
> > > >> probably a safe assumption. Here we see the first sample in each p=
air is
> > > >> transmitted with LRCK *high*, and the second sample in the pair is=
 transmitted
> > > >> with LRCK *low*. This is the opposite of your claim above.
> > > >>
> > > >> An ideal test would put left/right markers and frame numbers in th=
e data
> > > >> channel. The Python script below can generate such a file. Then yo=
u would know
> > > >> how much startup delay there is, which channel the "first sample" =
came from, and
> > > >> how each channel maps to the LRCK level.
> > > >>
> > > >> It would also be helpful to test DSP_A mode, where the LRCK signal=
 is
> > > >> asymmetric and an inversion would be obvious.
> > > >
> > > > I had no idea that there was a wave module in Python, that's a great
> > > > suggestion, thanks!
> > > >
> > > > You'll find attached the screenshots for both the I2S and DSP_A for=
mats.
> > > > I zoomed out a bit to be able to have the first valid samples, but =
it
> > > > should be readable.
> > > >
> > > > The code I used is there:
> > > > https://github.com/mripard/linux/tree/sunxi/h6-i2s-test
> > > >
> > > > It's basically the v3, plus the DT bits.
> > > >
> > > > As you can see, in the i2s case, LRCK starts low and then goes up, =
with
> > > > the first channel (0x2*** samples) transmitted first, so everything
> > > > looks right here.
> > > >
> > > > On the DSP_A screenshot, LRCK will be low with small bursts high, a=
nd
> > > > once again with the first channel being transmitted first, so it lo=
oks
> > > > right to me too.
> > >
> > > Indeed, for H6 i2s0 with LRCK inversion in software, everything looks=
 correct on
> > > the wire.
> > >
> > > It's still concerning to me that the BSP has no evidence of this inve=
rsion,
> > > either for i2s0 or i2s1[1]. And the inversion seems not to be require=
d for HDMI
> > > audio on mainline either (but there could be an inversion on the HDMI=
 side or on
> > > the interconnect).
> >
> > One can only guess here, but it's also quite easy to fix it at the card
> > level (or maybe there's a similar inversion in the codecs, or whatever).
>=20
> Thanks for the test and the explanation.
>=20
> Quite disturbing that there is no evidence of the LRCK inversion in
> kernel vendor indeed...
> Could it be an issue with the mainline code?

I'm not sure what you mean here, this was tested with mainline?

Maxime

--ey2pcwi4beb67jg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX2NtUwAKCRDj7w1vZxhR
xRxrAP9nfs6U0OX/BDrHjiklGxUIoLAabc0Z/9aAw07KkAHqpAEAgRBRlNIKp8G7
4IxaaK0DyUTmRogFehPd8RumWrKeqw0=
=OY86
-----END PGP SIGNATURE-----

--ey2pcwi4beb67jg7--
