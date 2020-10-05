Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6157E28353A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgJEL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:58:38 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39289 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJEL6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:58:38 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F34275C014F;
        Mon,  5 Oct 2020 07:58:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=V+uFLpYx6nAJ77NtMIURoXi08Dk
        JIviDPy8V3YFs/48=; b=GsQPiz2EP1RQzggToSL7NKobinp/Dt6NFTRqoxgslnR
        Cltip6fehazqBaSRys5Kh04rpgqFS4VwQgGJhKvf4GYENAg7uxqcT0ssLzuyKB2G
        mRFEGnhgntV/dC7NjXryOBSPXJ6IA3IWrYZOA0cRrOSC3tPiiyc9R8L0f3KZLOXT
        dm0NZK/Ms4it0ALmy8W1alP+qDu5qTHBs7ytyQusbhJjpYjXULkjhzsIppsx0D+2
        +kjNImC6qV1AjLqpuojoa4GyPovzgbGetc2i7TxouI+P77vGMj6lmtCSz3hBdL+B
        EvDzwPm3mU4Sw2vUJWOevpBCdfnyk9sJ0AY+x/R3xIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=V+uFLp
        Yx6nAJ77NtMIURoXi08DkJIviDPy8V3YFs/48=; b=AyG1grSnD2XqOl/+zr5CT+
        hzS9FiwlafJLnxkWslEwQolWUs64bWn110ZvMlXTBTWS2AqVkIY2nAh/VHNgX3FM
        Baxqs+XnYq1OsQLdhHu8CHe8O/hqLz8khtrGjebQqJBXhSmbgmqjEZabNGua/ql2
        Y9/E9rcSQTZ3tIDksYfDNBfGCjDWeXXVxxFnHyZcUNfokvlI96gn3jN37pBZATTg
        kIdz+reiVyP0ZcqXE7tUgNQCe5MADkIco44mhGg2VJ2cfNZhCF1XQlyP9vXXYQG7
        dX7QFvi+KYrL/z2XvK8mKk+J6SR0X8zzsOIGKtEZDLAeUNRKI/HmHIp2w+27pDTg
        ==
X-ME-Sender: <xms:awp7X23BvW1NQ2T8iGLWhiZWhuW_-JUBA5s0k6oiPEAN_K7qAsH2jw>
    <xme:awp7X5FlBVQooTLQ1W5osFj07s0K6U9ouXTRIJ4Gg9YXrK75xBglo5i0Z_JIQMxic
    s-Qbfkcr4j-Aq3xdwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:awp7X-7cmPZMeiIMSE9Y_ylFHf1v6m_Kqk72htreqg-HAJL0_Fz5Kg>
    <xmx:awp7X31R36lxIlOn169o0muJuEHYDlDa9tDh2_Hfc4-jpgcJjzPweA>
    <xmx:awp7X5HEy7jA-S5GKmMWWYdGlDbVXk2WcSOrinLiws0_YLRdwPokrA>
    <xmx:bAp7Xw12R7jpSf3o02erwvx1rsDaZA1ERVauwo0c0Uq9wOJMmhCXCw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F1573280059;
        Mon,  5 Oct 2020 07:58:34 -0400 (EDT)
Date:   Mon, 5 Oct 2020 13:58:33 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/25] ASoC: sun8i-codec: Automatically set the system
 sample rate
Message-ID: <20201005115833.rbs3bujsofkznpik@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-19-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="75xucdkd6m3f3jlz"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-19-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--75xucdkd6m3f3jlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:41PM -0500, Samuel Holland wrote:
> The sun8i codec has three clock/sample rate domains:
>  - The AIF1 domain, with a sample rate equal to AIF1 LRCK
>  - The AIF2 domain, with a sample rate equal to AIF2 LRCK
>  - The SYSCLK domain, containing the ADC, DAC, and effects (AGC/DRC),
>    with a sample rate given by a divisor from SYSCLK. The divisor is
>    controlled by the AIF1_FS or AIF2_FS field in SYS_SR_CTRL, depending
>    on if SYSCLK's source is AIF1CLK or AIF2CLK, respectively. The exact
>    sample rate depends on if SYSCLK is running at 22.6 MHz or 24.6 MHz.
>=20
> When an AIF (currently only AIF1) is active, the ADC and DAC should run
> at that sample rate to avoid artifacting. Sample rate conversion is only
> available when multiple AIFs are active and are routed to each other;
> this means the sample rate conversion hardware usually cannot be used.
>=20
> Only attach the event hook to the channel 0 AIF widgets, since we only
> need one event when a DAI stream starts or stops. Channel 0 is always
> brought up with a DAI stream, regardless of the number of channels in
> the stream.
>=20
> The ADC and DAC (along with their effects blocks) can be used even if
> no AIFs are in use. In that case, we should select an appropriate sample
> rate divisor, instead of keeping the last-used AIF sample rate.
> 44.1/48 kHz was chosen to balance audio quality and power consumption.
>=20
> Since the sample rate is tied to active AIF paths, disabling pmdown_time
> allows switching to the optimal sample rate immediately, instead of
> after a 5 second delay.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--75xucdkd6m3f3jlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sKaQAKCRDj7w1vZxhR
xcMoAP0VnmnL+YZV1XZJZnqzg/CJMusgUc589nBY+ScRNBMUdAD9GgC2Pkd19b5N
8Utf9wLt408n2EvTGP5C5TigjVif2wU=
=nbq2
-----END PGP SIGNATURE-----

--75xucdkd6m3f3jlz--
