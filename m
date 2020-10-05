Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59B2833AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJEJy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:54:28 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33567 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgJEJy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:54:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 45C385C0134;
        Mon,  5 Oct 2020 05:54:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 05:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=NEXXz0XWlTZiojHNQZwM3xMl3xD
        6YBVV2lteJc7KS8E=; b=u6sqDfvorC1NsWeqC/FKPDc+tdazdKlqZ42RWHSDggf
        MFGvfsf+YJIEycWcguOrFuM9c1+vDHdbvMnNXtRYyNQTM5Pyu6OyxI6aIs0a8any
        3qPPhsdGFdYMebbSvd3qcNzyZ5t8tjTP+RKo1L1QqRD46qTGXDJlY2eobYuEt7jX
        z8gGsBF4gV1s5pDTVYhdIyI9k//6VQ3EC6BvGNaTFQvx/Xlqqpi6Sy/SOOra0FfK
        LGXrwg7Xeq6aAxZPKYB1g0lT31imCbdxKWX2/H/HBNkxJmXMuwanuFAjuFIlxOUy
        hbZeOk3Sv7l8mQfJPKm47/kIqzG/N9KxHXPpZttZ2Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NEXXz0
        XWlTZiojHNQZwM3xMl3xD6YBVV2lteJc7KS8E=; b=DLKEkhwqAtW1uS1zJza/qB
        yly2MNJ1YOgyKGylqJoWhEAdGkH4N84FfUgXXiCrruVASa7ujx3m/rH74NrVpk62
        9ITKSK8YDQ8cpaI+zVGjtSu3O5bbCVUrrjaeRNnz/SrqK06Cmudq/hNaO9fCd8aA
        1myLpMHWatssBErRdIBsfhzR3v8DRjxM977V64Gq0WnJ2Byf0VErWBEiPjRSLj+a
        pqICxm0Cc9Sm9ymVsijncDBDW76PPCkAKm1T5zP7hdws7ug4gUIF7OnXkbennZSa
        YggNILkGEXe1uL/Ojlioy/fji2/YB7aLntiaIoC6vI4MgdK84PRyMFQdO5m9P6+Q
        ==
X-ME-Sender: <xms:U-16X7YH0JS0XGYRYC_83frwQhlvmqlvRngmf4SlgNEXgqeVG2FmZg>
    <xme:U-16X6boPnuf_G-3Ksb1-UY70xG2OGVgQtM-mHI6N_kbS64wEPTSRI0t8NbK5Op7g
    6mkdDsvAEVscwlZtew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:U-16X9-KNmPv2EZ0NwFvO55SehWVzD5US_V_qgJdPZeJ-Yy0sZcHbA>
    <xmx:U-16XxrndOufnx_s2_b1yqwIUK0OrBxXXuomO62-s2CYLlwZxuz9SA>
    <xmx:U-16X2qGoxxK_IcGWM5yJ8zkC49WJZLWx65v3TOHEm20Pdy9qSkL7Q>
    <xmx:U-16X2Loa2ao4oWTK1NMjCox0QyTeLesSve_F7vg6idv4PRidpuoXg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B5AB2306467E;
        Mon,  5 Oct 2020 05:54:26 -0400 (EDT)
Date:   Mon, 5 Oct 2020 11:54:25 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/25] ASoC: sun8i-codec: Swap module clock/reset
 dependencies
Message-ID: <20201005095425.uqpd6fn3bmcqmj2u@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ajk663v4iqcqgffc"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-3-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ajk663v4iqcqgffc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:25PM -0500, Samuel Holland wrote:
> This matches the module power-up/down sequence from the vendor's driver.
>=20
> While updating these widgets/routes, reorder them to match the register
> and bit layout of the hardware. This puts them in the same place in the
> widget and route arrays (previously they were at opposite ends), and it
> makes it easier to track which parts of which registers are implemented.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--ajk663v4iqcqgffc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3rtUQAKCRDj7w1vZxhR
xUBXAP4pHOdiB4ixCet41wFB1s8FTReQl6H2FtLwlw4PVDJrLwD8Ckm37XYge5Iv
yBhx2mCwvaPJqijjiVM8OsttbXY/AAI=
=uAAt
-----END PGP SIGNATURE-----

--ajk663v4iqcqgffc--
