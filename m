Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7AC2B6BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgKQRfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:35:36 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:49383 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729476AbgKQRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:35:36 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3F1332DE;
        Tue, 17 Nov 2020 12:35:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 17 Nov 2020 12:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=meHdDy6BRi3pQI1PYAxBRKF70Te
        kf0he58ok6zfudt4=; b=Hgk7WoT0M+/3lg25vD71cctbQeTmspip0Zkum8hPTGF
        3RsFy+2c9PKTBFluVSsmeBFwtuEU9a03DqxeBbRZxj+bkA0garGDdEBqVivtTv9i
        kmsyVFCq7kFA9hsVYRD3jOTWN2LK+IUbBK3L0pK3MAW+F5F0YdyIoOIWn1gbXxNM
        P281BRZ3nHHHYszvNoa3FsRugqcHf3Fkp/d/UH1D8baEmAo/+bspTD96/L8Lk7GW
        q+1pgA2nr8EUoNNcXEgSLJLtc0UGGvG/tGzRCLYw1w8nQSIX8Ux5uZ9yuz383tPb
        QKtb+X7ygppyIotJMz1hl2rXd51MH2A8HCfq6/VMgKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=meHdDy
        6BRi3pQI1PYAxBRKF70Tekf0he58ok6zfudt4=; b=Ai4mbjDF5DT5lEehvxihRU
        yS80MIGess9E7VAy8/TQAU/vnjvhQuBymi3STh8dUDplqR32laC7GE4t+2/ahz8L
        RrPLNuRTTmHSoOhuFLTPx3uZTasil9oMgMZ9ogwpEzujHwMk1KjTymklK838xwyf
        5gDRFIIHu+d44bLLJP3e0Rw55u8d5vHaOYYlwcPH7VsP3t5/PJXjrUTOlnMCVY2i
        rCZFWM3d+45kEpz1hMKXD0b1t+pMR1qPPy+uO/3ZZpbLNKYDWWOreD2gzpUtoPqk
        TuFhitRGthCGykAoq7ELgK0xylQwEZhUQjyU8cgb0Mi+ra0oprZiXubQWyoT0FtQ
        ==
X-ME-Sender: <xms:5gm0X8QlozMKi81T_3QuzJaCTrcub94Fwe3U0E28C2JJ4zDnmCloGQ>
    <xme:5gm0X5xIC6HqTVOB3PmpQ6nZ6JqvBWfYGXuC0FV8VOTOUrrO-DPVzEeAK7nd6DYLb
    TJQkXtFZne9xT8jTng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeffedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeugfffvdetkedtvdegleekfeefveffvdeiuefhkeetudfhvdffgeetgeej
    feetjeenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:5gm0X51qOuTKwinh-nS5ec3WtC0eZnu3yfYY2oXossOgvKzWQbz2MQ>
    <xmx:5gm0XwDfR1zy_P3LPa3YzyEEn8lHgOjTnt1BtiQiBp8JPAPZqYTHNA>
    <xmx:5gm0X1i3N63r3laeZL2p6jCbrB-229rWvHeAEFY-ZvueVUsRZ_B1ng>
    <xmx:5gm0X1bKG98Hx3nHOvIiPQQh0OtKjsgSqFNolhWMeOjkUm7jsQJj7Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 029313280066;
        Tue, 17 Nov 2020 12:35:33 -0500 (EST)
Date:   Tue, 17 Nov 2020 18:35:32 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: BananaPi M2 support
Message-ID: <20201117173532.qhkshyzx3dcbz54s@gilmour.lan>
References: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
 <20201116155253.n3nuvzxup6izhh3m@gilmour.lan>
 <1b4bc573-05ae-7c93-75af-50af12054b86@orpaltech.com>
 <CAGb2v64-Tq1ZsmX6D7T+s2XiooQwJDdwe2oO=1aSDGjU1c9TnA@mail.gmail.com>
 <d4e7ee22-8090-e165-393d-33a7363e554d@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ql7d4pjl4nbos3xh"
Content-Disposition: inline
In-Reply-To: <d4e7ee22-8090-e165-393d-33a7363e554d@orpaltech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ql7d4pjl4nbos3xh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 08:06:19PM +0300, Sergey Suloev wrote:
> Hi, ChenYu,
>=20
> I have tried to build and run linux-next=A0 by tag=A0 "next-20201117".
> Now the boot log looks different but the kernel still hangs. See
> https://pastebin.com/gFk7XuBc

This one looks like you just had the wrong boot device?

Maxime

--ql7d4pjl4nbos3xh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7QJ5AAKCRDj7w1vZxhR
xXPUAQCo5d5/rstd+VWRJU0RCjl3DphxPxNCdVRwGjNVjFGIOwD/c8hip2z13KdR
AUksQlq/RaJz0X94f56OxQoKTcnelgw=
=LCqQ
-----END PGP SIGNATURE-----

--ql7d4pjl4nbos3xh--
