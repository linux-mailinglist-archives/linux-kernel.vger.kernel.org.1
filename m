Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6533B2FA76B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406867AbhARRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:23:17 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:37543 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406846AbhARRDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:18 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 583BD17D7;
        Mon, 18 Jan 2021 12:02:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 18 Jan 2021 12:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=aCtNSj2HSao+inp7HktheCsuocF
        99GwXfTqjyswziGA=; b=YmLl6ohx+f/H98h3T06lnAm/WOzNKJTW+w+ivVzrw0k
        ZwO4cQuBMzTlcR48KM7Jk6cNtx0VeQD0CZYzuyxQixumZsTn3SJYd6HpFwmTIKse
        Y3eRtFc4FraGZZr2Tgd2hcCc0LDQVVztg9JQxJN/uV16206MZ+QmBxlDzExyZMdW
        J8nDYTrWi0paEK2WzXxoAThbRk4WAU5eXaW9otGzW0GW/1shH93zLaVWBETrXB4o
        vK25ouBsphmeTlA82a7GtkmyW7xK9mbbLoDHDD8oISrya62zhZeF8osfBFDi6DZq
        Bn/BIEI43Wz1t7vpNoCzWfD9EtQbHP0gzIK5ENceiaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=aCtNSj
        2HSao+inp7HktheCsuocF99GwXfTqjyswziGA=; b=goAJu6a2PkWzLVoI5TzHDV
        3qNGVTJSoT549oRMRnGLiKp7LSHx6VSJJ4NcJUqCdwgEPxbMBdMd7NPBOzjQzoao
        D9y+Q4505Uy6SyS3Vqg5QZ2ME5s2AonZ3C7h0Nk41QOX1CwP8tDlgTAvHuUjkpZN
        GinevSF1KKKWYpy9X90aj9eRuuYqYvtUKO3J2JVzQo7bQO4lAW2AWBIm4Tw0G8+G
        e9HcT1ClJae1FUG+mTwu1gbhDe8ykavWibA94csvt29X79hGx1LHvSblPXBvcEpg
        uLJJDW9ZdDjFZ4eYMKC5bTXBW6Hk3ygFEYHB3GGgAfcryA0A7a81C6+6oacMYecA
        ==
X-ME-Sender: <xms:D78FYBKSxS2xI0HBDiWz9-uPs0txxHM6xdC9AGEnbgyONe7yKHVWbg>
    <xme:D78FYPLIFb-HJEfHuYvDuUVQUtIfbL3UizoiBw1HzAHNLRBRLc9C0Dzjrrc2GuVtM
    YO-Z4eN9xHWTB5wWTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:D78FYDF8XXIdRsJIWFDRLvCro73wcz5mka3Wb2MT2HsOogcSsEz5yQ>
    <xmx:D78FYEncskvoEJh4tittN-79TgzpDNqdOPE4PO-qfzsR2yKXikN-4Q>
    <xmx:D78FYAJOCBD9If8Jsh_f4ax6Uh1XH1PRFtd4hnpUR3TS49lNOjCnJA>
    <xmx:Eb8FYB1S_eRrJiDxVxAXKcXmJXHwlTiIHT8M8_ucBaodfnZDid_uiHFWwI8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42FEF108005C;
        Mon, 18 Jan 2021 12:02:07 -0500 (EST)
Date:   Mon, 18 Jan 2021 18:02:05 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] drm/atmel-hlcdc: Rename custom plane state variable
Message-ID: <20210118170205.bflnpka2eutrryyp@gilmour>
References: <20210115125703.1315064-1-maxime@cerno.tech>
 <20210115125703.1315064-3-maxime@cerno.tech>
 <20210115204324.GA529973@ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qdgoqrhxkbmwjqu6"
Content-Disposition: inline
In-Reply-To: <20210115204324.GA529973@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qdgoqrhxkbmwjqu6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sam

On Fri, Jan 15, 2021 at 09:43:24PM +0100, Sam Ravnborg wrote:
> On Fri, Jan 15, 2021 at 01:56:55PM +0100, Maxime Ripard wrote:
> > Subsequent reworks will pass the global atomic state in the function
> > prototype, and atomic_check and atomic_update already have such a
> > variable already. Let's change them to ease the rework.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>=20
> I assume you will push this patch as part of the series.

Yep, that's the plan

Thanks for the review,
Maxime

--qdgoqrhxkbmwjqu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAW/DQAKCRDj7w1vZxhR
xS4KAQC4Q57cifiOtnbWri+uKleeQ4EjvTJxRqYQUuWj921DowEAkcxlz2fzgD6C
196JQiStZArABUiHXItNhtJlsgvCoAA=
=WccY
-----END PGP SIGNATURE-----

--qdgoqrhxkbmwjqu6--
