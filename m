Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4326B27FBF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgJAIyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:54:11 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60579 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730378AbgJAIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:54:08 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8589B580289;
        Thu,  1 Oct 2020 04:54:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Oct 2020 04:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=aCuInhZvme0gvNR2gwI/zQvtYmr
        lJy91lYSNBnXMZcY=; b=Ss8leWBrTndXP2dNlMLxQ8EvPcUa3y0saYFq9O9y8hJ
        7w/SSZ+E6/4u5srBu7bP4XKLdGI9ZmP4HalWrsHQ7/dHjAzCcAst0wAJqme7s9nP
        9jIzqUeP1xJhC5fHhGQ7Q8ulClZZ6gtWOshTLPUascdSQqUpvIPcjnCr+iILpBVZ
        etR1Tig+hywUufMsgebRKB3WzwV9LAc3SQMruPwgxqjWlkXU/pZ17Pc/cxS3FJVe
        GUquXl82pjekK+kh/qbbdqUu6MjfI5wDSHSMQCdbabmqiJCgqUIM+Gxm6C9VO2Is
        kiR90qIcB0Urfv00mZ2SE2mz/SqXoiTiegwtfW0PrTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=aCuInh
        Zvme0gvNR2gwI/zQvtYmrlJy91lYSNBnXMZcY=; b=grEj/yD/j2hIrzAecibb4R
        8NFSVpkyVwITqSLHhnxJnNMt29Bc48Sbs0eo91xQDCHk38Vmq/hFgQlTUiR3EbQW
        6cHpULy60f7ZfzU/7IiRBgi6P6we6mP4w4KKkKSkJS/y1NPvh4T/hepE3YvvL0cf
        n9J4lrwrpiKVIODYztie0mbZrBN1VtYsRh1IgciYRvdUXlbvE6Em6vsnwpR47afR
        vIm3uwEgJsWXa9ovQvA2XynCeV0MKJMWWjWtc+eZZi7jLzBSU5XlyeeTBI+8pWdi
        HiqdXtjIUb96zvlCDGwPNSUs2iugSEWWUxIhNeO6PxalNGSbTnTT5RJoPc9v/suw
        ==
X-ME-Sender: <xms:LZl1Xy-qD7YQx_9lhkYY7j09qmSZ1ErbyaTwR4viGPGRSe9zbfRqPA>
    <xme:LZl1XyvM24S305SN4ANFtqQrZtfMi1FZaD_m_ewzITd_oE5nbeokzLJQCqsHrE0Kn
    b0jvfEd802jBItwZ2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedtleegieefhfeflefgjedtueeuudeljeetgeeggeekjedulefhuddvveeifefg
    leenucffohhmrghinheprhgrshhpsggvrhhrhihpihdrohhrghenucfkphepledtrdekle
    drieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LZl1X4DoCISpS4fzbbu9LCczyuU5G8ATogQ_Qs1tI8HvKnLgP7rg3g>
    <xmx:LZl1X6dqkdM5YqVbROvU8BQsNMFRwh2ik17SAb5aTrOEuB1edy7MAA>
    <xmx:LZl1X3M39Br45bLrsONqKrfC3rQiftIsKDCTFxm7gB1wSy4fIsT2jA>
    <xmx:Lpl1X0nBWCHlUs2Z0hzWzvdHl_TUuzV5Yh2zY1MtGcJ_SXNdrEXIAg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A3CA3280059;
        Thu,  1 Oct 2020 04:54:04 -0400 (EDT)
Date:   Thu, 1 Oct 2020 10:54:02 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 80/80] ARM: dts: bcm2711: Enable the display pipeline
Message-ID: <20201001085402.t6mzzwzplviunhoc@gilmour.lan>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
 <20200929221526.GA1370981@ubuntu-m3-large-x86>
 <20200930140758.gummt3umouva3wyu@gilmour.lan>
 <20200930163823.GA237050@ubuntu-m3-large-x86>
 <cacbaef2-4221-50d8-3c5d-efab9f1a9c04@i2se.com>
 <20201001064843.dlewcu3b7dvqanyy@gilmour.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq7qpluuzzoo6pw4"
Content-Disposition: inline
In-Reply-To: <20201001064843.dlewcu3b7dvqanyy@gilmour.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jq7qpluuzzoo6pw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 08:48:43AM +0200, Maxime Ripard wrote:
> Hi Stefan,
>=20
> On Wed, Sep 30, 2020 at 06:52:13PM +0200, Stefan Wahren wrote:
> > Am 30.09.20 um 18:38 schrieb Nathan Chancellor:
> > > On Wed, Sep 30, 2020 at 04:07:58PM +0200, Maxime Ripard wrote:
> > >> Hi Nathan,
> > >>
> > >> On Tue, Sep 29, 2020 at 03:15:26PM -0700, Nathan Chancellor wrote:
> > >>> On Thu, Sep 03, 2020 at 10:01:52AM +0200, Maxime Ripard wrote:
> > >>>> Now that all the drivers have been adjusted for it, let's bring in=
 the
> > >>>> necessary device tree changes.
> > >>>>
> > >>>> The VEC and PV3 are left out for now, since it will require a more=
 specific
> > >>>> clock setup.
> > >>>>
> > >>>> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >>>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> > >>>> Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> > >>>> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> > >>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > >>> Apologies if this has already been reported or have a solution but =
this
> > >>> patch (and presumably series) breaks output to the serial console a=
fter
> > >>> a certain point during init. On Raspbian, I see systemd startup mes=
sages
> > >>> then the output just turns into complete garbage. It looks like this
> > >>> patch is merged first in linux-next, which is why my bisect fell on=
 the
> > >>> DRM merge. I am happy to provide whatever information could be help=
ful
> > >>> for debugging this. I am on the latest version of the firmware
> > >>> (currently 26620cc9a63c6cb9965374d509479b4ee2c30241).
> > >> Unfortunately, the miniUART is in the same clock tree than the core
> > >> clock and will thus have those kind of issues when the core clock is
> > >> changed (which is also something that one should expect when using t=
he
> > >> DRM or other drivers).
> > >>
> > >> The only real workaround there would be to switch to one of the PL011
> > >> UARTs. I guess we can also somehow make the UART react to the core c=
lock
> > >> frequency changes, but that's going to require some effort
> > >>
> > >> Maxime
> > > Ack, thank you for the reply! There does not really seem to be a whole
> > > ton of documentation around using one of the other PL011 UARTs so for
> > > now, I will just revert this commit locally.
> >=20
> > there was a patch series & discussion about this topic, but we finally
> > didn't find a rock solid solution.
> >=20
> > You can have a look at "[RFC 5/5] serial: 8250: bcm2835aux: add notifier
> > to follow clock changes" from 3.4.2019 on linux-rpi-kernel.
>=20
> I couldn't find that discussion on the archive, but based on the title I
> guess there's some patches that have been merged this cycle for the 8250
> driver to do just that (868f3ee6e452 ("serial: 8250: Add 8250 port clock
> update method") and cc816969d7b5 ("serial: 8250_dw: Fix common clocks
> usage race condition")).
>=20
> However, I'm not entirely sure the clock notifier works in our case with
> the firmware / MMIO clocks duality

I was a bit intrigued by this, so I looked into it, and it seems that
it's worth that it used to be. The core clock is supposed to be running
at 500 Mhz in most cases, and that's what we're setting so it shouldn't
cause any pratical issue.

However, it looks like on my board now the firmware reports that the
core clock is running at either 311MHz or 233MHz with hdmi_enable_4k60
(which seems odd?) and that contradicts the documentation here:
https://www.raspberrypi.org/documentation/configuration/config-txt/overcloc=
king.md

Linux then comes in, changes the frequency to 500MHz and breaks the
UART. So either the doc is wrong, or the clock driver is.

vcgencmd measure_clock core reports that it's indeed 233Mhz and I'm
running a year-old firmware (built on the 2019-11-29), so I'd be
inclined to think that the doc is wrong here or we're misinterpreting
something.

Dave, Tim, any idea?

Thanks!
Maxime

--jq7qpluuzzoo6pw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3WZKgAKCRDj7w1vZxhR
xfXhAQDFSw1QCBRSnfLzXomPVG2hE9XEQuCVtTqq9KDlhYul7QEAyzFgfN7GAZQK
DDQsA+8Ty05gotg13ZSiA3io2xi10wI=
=fxeW
-----END PGP SIGNATURE-----

--jq7qpluuzzoo6pw4--
