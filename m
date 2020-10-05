Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D383283544
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgJEMBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:01:47 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55659 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJEMBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:01:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BBC295C0174;
        Mon,  5 Oct 2020 08:01:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 08:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=3/H/39oxCLXovEWnpX8PI6zHWcX
        eyqwfHyRWts2U2fM=; b=tzCd4XNqUTmbWNU5fbF1TR29JdwpF3+pukn2b+Risf/
        R1Fr4x4FJhWUjscdTbyJBOU3sD7XqhGglk3g3T/5MO5HBVSibOayD+nflepicYzL
        Nfgxaz/HrVlxSR5R69/FRujb3SdhhT7RTmMlLqzXZJWECgVjodJmLv/BBVUMfoKn
        nadJrXfUQD1k94Ln5CBU1tJJ/xnXnbb9q/p49MY/Im3moSXE+TPlmVTTXxSMp/7t
        1/T8UxCMnUfGhMRG57Tuu93qHvhPHO6S4fSdK3PVBC8WEBgQFHXWSbFSlGPnlmCF
        JlbpWg++Xg4ulOnZBaS410CEgA6rz/38HZvoEugi81A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3/H/39
        oxCLXovEWnpX8PI6zHWcXeyqwfHyRWts2U2fM=; b=e4gSgW+lJRcnZ5P4RCeDy1
        YT8CcTBWOMBy5rrxFfFR76Siq5FAHdhT4yBDMptPwmV9BgHDDHPBh3IVeLoyKIuL
        jtQEmJqcCz29iT+1ehrzme4XFsJNpT40zfOgybRPR+XRGn1q9IKbIV+W14KeT7/0
        lFGq+7CCgOPvL7XxAYAXXtzdmrvqfnU/KrVG1RpBqA8ZqVer7fyQGzbRPrSIxcmN
        AA3tK1oylf8xIqnBzkzPTIf4+Ufs8x1f5m4dCoOtOicGtPYLc72EZdfJyRHyVeqj
        QnEclISrsmoqA+6t4NAKVuL8wRtZdr/fvXe0TXZyS6dPW1ztOc9Evad0v7dFHO2w
        ==
X-ME-Sender: <xms:KQt7X8K3udJFBwyKnZrYZ8D9fWiNjn3YdECbJYJKPMeiQ7QxiGlDxg>
    <xme:KQt7X8Kl-X4mpUxOaBTqQ7zRytSW2_EumvrMEXmJh--nNPcCrznB8o7eB1KuPnK0w
    h6lwMC1pfYExy18Asc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeefnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:KQt7X8s3cF2JEK3rXCIICvX8OR3P9g97Ibd3Ooi7liWm_dS-Ph9yiQ>
    <xmx:KQt7X5aP71isW2ch5U4fijcF7B-FnrMtRaksBBzyEOJVRYU3E4ouZw>
    <xmx:KQt7XzarjMeGSpX1qQhzSBI1SL_HtmWbFyBo5p68hS0AT3Eu545GZw>
    <xmx:KQt7X34kAP-iGMjy63BYhJyxscVu1RCtxC-_T9P0VXBk0UBjZXlAgQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A66D3064683;
        Mon,  5 Oct 2020 08:01:45 -0400 (EDT)
Date:   Mon, 5 Oct 2020 14:01:44 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/25] ASoC: sun8i-codec: Require an exact BCLK divisor
 match
Message-ID: <20201005120144.2fgkyrx7fkpd476i@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-22-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nlxn7rikredzkrun"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-22-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nlxn7rikredzkrun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:44PM -0500, Samuel Holland wrote:
> Now that we guarantee that SYSCLK is running at the optimal rate when
> hw_params succeeds, and that it will continue running at that rate,
> SYSCLK will always be an integer multiple of BCLK. So we can always
> pick the exact divider, not just the closest divider.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--nlxn7rikredzkrun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sLKAAKCRDj7w1vZxhR
xaP+AQDSfmb1WdHbLnosBAzOuSmNxcUnAg+f3Sum33yq/W1gXwEAsjekGxOguqkP
4Vz8tWyglH4rjtvTAKk0+AFDmbnhjwc=
=t2Ji
-----END PGP SIGNATURE-----

--nlxn7rikredzkrun--
