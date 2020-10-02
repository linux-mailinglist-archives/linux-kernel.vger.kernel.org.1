Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD084281668
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbgJBPT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:19:59 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36195 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgJBPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:19:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 908FB58027A;
        Fri,  2 Oct 2020 11:19:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 02 Oct 2020 11:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=fuQIVEvbO1kono/iv5RweNEUdex
        BHUOR2cPd1pYmjME=; b=nNNES+vRA5nSWOMhmD6PUGtfn6V+bz3Mr5Zlqg69LkK
        DEvQIAJdKl41PkYIQEmaybih5VPO+JtgWyLYm2I1whLgVuKcnaulkQy1lMWav7sh
        x+uxhoR2ajTlVGpqdRC/NcgrAmkDDdDhjuOeX7guHYGWi1wSoFq5QFBhHC3ksjZB
        XC58OvFi2C15UWdtRCdG+Ytj9fAYx5FkcM/YwjUy8iy08e4QywYmJkj7AHFZZOQM
        3o2BeLdtf057jUa33FL38F3IEJA5QO0rzoQDp8qPXmnz9h4lm62gfJpXJhn6KzOU
        MU0Uejm4jYhgOoTZGsd40bGkFSCGEIaYiPfMSwgLUCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fuQIVE
        vbO1kono/iv5RweNEUdexBHUOR2cPd1pYmjME=; b=OPSYYDacNIz8xaN3rE1XW5
        O7jmnX+wyJ4TAQbkxDHndriO22UN2WqBlGPB03KM1PMF2o0Dk6cjl3BflabE3p55
        Eb5Peu68ioymn+e0Ts+WAszPr2paJ24WNNUsn1LK8Q9m/S3I8oDYUsMMppvtyBwi
        P7jmuTh/hJuobkd77O0RXJH5fy7+SXb/0VWUCxI14o+iwEwHY3QZsNusJt4R7u+u
        CeiYPGV4Y8ghsP7VdkE8N4LsznY484t0PxXiD+JgFYyUIFCsEQrujMEgzx/X12ev
        h/SObmZCk5v705q1ph/+5zaT8mYJuLjUfJWEoeyv8TqqUpLn/jb0b0zwTUGTc06g
        ==
X-ME-Sender: <xms:G0V3X7B-kWFdoRZkosEXDveZLLJakLqL57FCO1v6GEyeHxsDpvTIhA>
    <xme:G0V3Xxgt-_TENB8Yok2IG9NAkYyz5p1Kz1o0-kbikLZLaykaoSsT7kxtfFWoLbAEp
    61nhCSLGzr4cLs9RUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:G0V3X2kb9lKn9jsTkas5tYx6Eq8RwTyx0D1o3xgnR6ni3ACUlpPkRA>
    <xmx:G0V3X9xtGQcCzC3GVKnw1Bn3qDgTz5ijWQZ6-ewKo-u30RiO6e5NSA>
    <xmx:G0V3XwQzmynkPOiZnLyLPrBoqgso-Vzzw5UGzt5trL0jxM7lQO-IXw>
    <xmx:HUV3X0ZN5O5ZcfptTtg7Lps7ZaTpyJ_xEmSiZauEthjC3wKwpyfmrA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9B758306468A;
        Fri,  2 Oct 2020 11:19:55 -0400 (EDT)
Date:   Fri, 2 Oct 2020 17:19:54 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Tim Gover <tim.gover@raspberrypi.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 80/80] ARM: dts: bcm2711: Enable the display pipeline
Message-ID: <20201002151954.wazqc5riesdomlpx@gilmour.lan>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
 <20200929221526.GA1370981@ubuntu-m3-large-x86>
 <20200930140758.gummt3umouva3wyu@gilmour.lan>
 <20200930163823.GA237050@ubuntu-m3-large-x86>
 <cacbaef2-4221-50d8-3c5d-efab9f1a9c04@i2se.com>
 <20201001064843.dlewcu3b7dvqanyy@gilmour.lan>
 <20201001085402.t6mzzwzplviunhoc@gilmour.lan>
 <CAAvKZ65WqQqH-9JVdb5M6HcKbR3yQdvZha8n9UXXCfciYRq4aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i5tdrqg3g66y6hmr"
Content-Disposition: inline
In-Reply-To: <CAAvKZ65WqQqH-9JVdb5M6HcKbR3yQdvZha8n9UXXCfciYRq4aA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i5tdrqg3g66y6hmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On Thu, Oct 01, 2020 at 11:15:46AM +0100, Tim Gover wrote:
> hdmi_enable_4k60=3D1 causes the firmware to select 3.3 GHz for the PLLC
> VCO to support a core-frequency of 550 MHz which is the minimum
> frequency required by the HVS at 4Kp60. The side effect is that if the
> display clock requirements are lower than 4Kp60 then you will see
> different core frequencies selected by DVFS.
>=20
> If enable_uart=3D1 and the mini-uart is selected (default unless
> bluetooth is disabled) then the firmware will pin the core-frequency
> to either core_freq max (500 or 550). Although, I think there is a way
> of pinning it to a lower fixed frequency.
>=20
> The table in overclocking.md defines options for setting the maximum
> core frequency but unless core_freq_min is specified DVFS will
> automatically pick the lowest idle frequency required by the display
> resolution.

I'm wondering if there's some way to detect this from Linux? I guess it
would be nice to be able to at least detect a broken config to warn /
prevent an user that their situation is not going to be reliable / work
really well (like if they have a 4k display without hdmi_enable_4kp60
set, or the issue we're discussing here)

Thanks!
Maxime

--i5tdrqg3g66y6hmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3dFGgAKCRDj7w1vZxhR
xZd8AQC71Lqm9Rx6Bn25r4vP5tv4+LK2v7EXwVZFwoR2iTjOJQD+PpZ4o7Ra/Hbr
Ot6j3CIWK3fNTLCOC2ZtYnNoXoJi8QM=
=OfVU
-----END PGP SIGNATURE-----

--i5tdrqg3g66y6hmr--
