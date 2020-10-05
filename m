Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A42E2834E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJEL0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:26:52 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53287 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgJEL0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:26:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EA4585C0118;
        Mon,  5 Oct 2020 07:26:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sBOBUzyry7tYkPBem/JiXq0flCB
        BUkJGq1lznWBIxu0=; b=F3YcXrnnuT+l174MQvZwJHkDX8LCUZLYo660Rybnzyo
        WSXm5wWZJrRkuAJ7MB52WlY5WtVDwfUY5D5fUQpbXffinWwG9Y/U4p94PXbcJzyy
        P97PR0wVOuDjcqACdqQLOy8zUC/X2zTkXa9qiWo4lKQWTa68phGZ6GX2rLssu1jl
        EloIiBzFzSLe4bIDFy7qWb+NXk0iqllSoxwJWDGNQKYSbGmdTlTYl/C+htnepaul
        MqHNURP0Tqk6Z6vHMs5fdo/QIIYCaLRizrpd/NdM0E/ai75OiABe+tgJhCbl4r4U
        Hy8sUXG0//G8pEEg7cCyEKh63URRLWYDQ2FtVdMttcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sBOBUz
        yry7tYkPBem/JiXq0flCBBUkJGq1lznWBIxu0=; b=R1Wl3QsyddKgMFQmUuj9Gj
        o6qTPnyMHy7tA7KnrUTQQQx8Dc/kYXmYAVxqCNsR7wPBDXVK7SzVKF7bMAcLl7wx
        5Upn8udtr/RlppDjHdag7+Rou4qWl/mUJg819Kpe7T1p/hXgJ/CvmLNlWG7H3o0c
        R6xHpnwPyhwg5gqFhmC5+RYPEcIEYngC8BehEPZvb3HevMGlk/QiDyqkIAlAay5V
        Nz+Pyil2YfX/hKFyjT6SJgbvBEhhnHEzoohZNVuOwwlq8u/MvGs/csniugSgpqzL
        AX+lQC2tcAiBkuh0cSg1Z6sX/kEGnVFinf4jI7O5MgipSNU+Q3lWzYQNSE+GZjxQ
        ==
X-ME-Sender: <xms:9wJ7X87vnfrG7-QnqcQcjA4-UpVu0ZfcLAnU7jw0CXKzzl8zHIbMpQ>
    <xme:9wJ7X95KkJhX-AMe5-qOXoGGCzl35DjWnDFq25AEkpzRM6IbW6TY0lp-tFvfBv6WO
    Dg2we44z6fwHAwj4Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9wJ7X7esuxj_HK2ONAbOCPrvUDg_Fzr4BCNmeO59Gwemj0akurFp8g>
    <xmx:9wJ7XxJgrFT1b_BJZyYunsaOiGntvidoIcyMZTAElg-wL9_DXa4cRw>
    <xmx:9wJ7XwLYkFTYi1uiuKHeSvXCVFPZ3eXaEhA10hk_b0eojyRX68LHAA>
    <xmx:9wJ7X5pIOvzDJNI7bM7baVAio7sxmfpfaWnQ5ckgbrOPlaO_x_1Pzg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 79ABA3064674;
        Mon,  5 Oct 2020 07:26:47 -0400 (EDT)
Date:   Mon, 5 Oct 2020 13:26:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/25] ASoC: sun8i-codec: Program format before clock
 inversion
Message-ID: <20201005112646.jhktikxgubfatbh6@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-11-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i2twgdz2xu3icbbo"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-11-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i2twgdz2xu3icbbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:33PM -0500, Samuel Holland wrote:
> The LRCK inversion bit has a different meaning in DSP mode: it selects
> between DSP A and DSP B formats. To support this, we need to know if
> the selected format is a DSP format. One easy way to do this is to set
> the format field before the inversion fields.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--i2twgdz2xu3icbbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sC9QAKCRDj7w1vZxhR
xbwaAP430fSwoZJnaZEplR6DENxrtAyPlBtLiIfrXb+MHbkipgD/Y4ZRoJd+LZwr
BS0p+bWn2tQusQMQC7pRYKP5TRTvvAg=
=2dMT
-----END PGP SIGNATURE-----

--i2twgdz2xu3icbbo--
