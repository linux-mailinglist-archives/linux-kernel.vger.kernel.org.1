Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2805F2EBC3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbhAFKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:16:51 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50947 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbhAFKQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:16:50 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9E7C4F83;
        Wed,  6 Jan 2021 05:15:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 06 Jan 2021 05:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=myqDyFHEH+iHmGhF+arkhLZIvpo
        yTTjFTgIeO/Smd8Y=; b=hKTiTjrqGjRlhbd1pzB8kwBmEOX3IWRlJiQDO59VROE
        bnxgdaemSwa6uUaxcAlGVyFrpvuboMb8KgyUqr+624iaIa5RL9pwZs64wioemp0e
        bAWqsovml3cVAPEVxYteg2ggMq1HgGKsHPBaG7OLeai3UUaPd43IpAz2NJ9qyySO
        gxjPIc8713GPTOvarjRronI2ngWwOeNJgz0wT61QvRPGl+5ZmZ6zXyregXxRxxSs
        VLTnsiUhlRUMaX2k/LNWv9/feUUIEDRW6HwmWr5SqU+0D2jIfQH9M8rb/FQZMaaO
        iQ4uTD0ZK0h037kuzlcEnARbYUDJ7Pa3+nUU372xzrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=myqDyF
        HEH+iHmGhF+arkhLZIvpoyTTjFTgIeO/Smd8Y=; b=FYbDgJUi8nOpK9zgFZsNu2
        X8VSnTL3L+0m0howma5SOdvFVOKjkzcWdTY8e7Bkrl5Pp30oUM0I3qn79Ur1vZ73
        DQusEdqbp08b7MaUK9Wsc+zSHlxx7sqs20OrO1+RUzNr6V7T96cW/Xpw7GnHp8rR
        TJXwUFkifjeBideC7rCpSnJing2im2YHJUpdv8UP5W1PCiYLT4EyzpCOY6Jw0VqX
        gVafeZa2FsoBfOXLnaB5zIZ0FMsoCBgzwiEgtYZuQ8zmJhbqbidbHr5q1Xqbp/6q
        bm9HX1kQ1dVUKuFKDog8WOs1raCAa+UN5DL8xlYs5+FNG+2lsZ+aW/e6q22QVrfA
        ==
X-ME-Sender: <xms:0I31X-iMCfE6bE4tatiMX_uGX1TewFSMhjlPrnB29Flb3llZwQ01sg>
    <xme:0I31X_CKf5OWMkbyD8dTJkKC5GanejFACRxq4ES-KUJ5lq-R0x_zJVamVysrSthBw
    lRfWxLf5sO66oprR0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:0I31X2EgwpBLCd690Vr3VbevIqZTqc9NHhNxSdVelROlEXJ5ewEfTQ>
    <xmx:0I31X3RbDkinrsrFWVsmd477z1jxHFtXjXYyowIl27KNsLqC3zGqQQ>
    <xmx:0I31X7zsercNzSMP3hcP7h_0EqUKYPuNio7qSXIonFzn8xzLGNgjdg>
    <xmx:0I31X2oyBdA2GJRlm1PvA76tVTc7WZKFPoENyO1UudUt3VRUy49-Tg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D421E24005D;
        Wed,  6 Jan 2021 05:15:43 -0500 (EST)
Date:   Wed, 6 Jan 2021 11:15:42 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v5 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210106101542.zziwdyhq7arysrsj@gilmour>
References: <cover.1608721968.git.wilken.gottwalt@posteo.net>
 <0deae76aec31586da45c316546b12bcc316442ee.1608721968.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4dpzakz5ltrecyhc"
Content-Disposition: inline
In-Reply-To: <0deae76aec31586da45c316546b12bcc316442ee.1608721968.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4dpzakz5ltrecyhc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2020 at 12:35:10PM +0100, Wilken Gottwalt wrote:
> Adds the sun6i_hwspinlock driver for the hardware spinlock unit found in
> most of the sun6i compatible SoCs.
>=20
> This unit provides at least 32 spinlocks in hardware. The implementation
> supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
> reading a register and released by writing a 0 to it. This driver
> supports all 4 spinlock setups, but for now only the first setup (32
> locks) seem to exist in available devices. This spinlock unit is shared
> between all ARM cores and the embedded companion core. All of them can
> take/release a lock with a single cycle operation. It can be used to
> sync access to devices shared by the ARM cores and the companion core.
>=20
> There are two ways to check if a lock is taken. The first way is to read
> a lock. If a 0 is returned, the lock was free and is taken now. If an 1
> is returned, the caller has to try again. Which means the lock is taken.
> The second way is to read a 32bit wide status register where every bit
> represents one of the 32 first locks. According to the datasheets this
> status register supports only the 32 first locks. This is the reason the
> first way (lock read/write) approach is used to be able to cover all 256
> locks in future devices. The driver also reports the amount of supported
> locks via debugfs.
>=20
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--4dpzakz5ltrecyhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/WNzgAKCRDj7w1vZxhR
xVSRAQDE6lse+M9BP0DGGYDJTyjLqYum3Yd32j++s3uJJRfMuwD/eoSufCjQUaSg
JGRx332nSsJmPX1/W4d8jDedJ+gBTwA=
=GvoN
-----END PGP SIGNATURE-----

--4dpzakz5ltrecyhc--
