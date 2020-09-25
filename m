Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B459278C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgIYPMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:12:47 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53037 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729161AbgIYPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:12:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 055DC32B;
        Fri, 25 Sep 2020 11:12:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 25 Sep 2020 11:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=zGwfpF/9jIUyz2obzI9IycrXvUi
        t7yxxAspU9BtGaAo=; b=h641cFPScAGM+eHvlQ7Iclvjgtq1vHgQp6lIYcgvXUg
        7oyROeQ2KM5IIsBxRIoFPioLHd3cn1rVFeScQxjNzFj2mCDjDv7QzLnmtzyr69QA
        ZqzxEfy6t+TrS7Y3Ot5qePGUsuM5YhQenKd8TNPRhaB9cM0hilOgW+dWvKZrtx7a
        zcvbYhoKr2q5PVEieXLOxiI2XC32yrpmdW21Rd1OVk/oAgU7kw2h/hZBRDFrqAOK
        CbT+beSgS7w8kwWGIBDiX02DJvuMmnsC3KAjXwnOTkDb8PpF9mySPWP9WtQMh5iw
        PNmqOR3GzfKq0ORraK+sioEctDHkmpTRnYexCzYkufQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zGwfpF
        /9jIUyz2obzI9IycrXvUit7yxxAspU9BtGaAo=; b=gzjEDCtkmXew8d3+kf6G0n
        rVveRQKUMrD5pUSfc61tDpYp9GqvyexoC2R+bqGPqDeEGxkqyfPG8jcRR01w3Bof
        1A5542S2rioiCoIpcFUHdx5AvbDyc6DmqqUQjO+7nvFSgQ+u45aNdFU70Fcw1LsW
        Z8CvqtokcCX2k9sJyJ+SXMwzI5WRzT9NFCoVHMqXA/PwZsfisE4Vq7MOpkRfZvf0
        0gqLKPEe6+IOb5ADIAMoexv582O9pefK1VAIIyK28HQ+wxKls/uvQEolTJiaNe1w
        hdwtfIoo66NHc3sTvqdjsbE7C/r2TbtQAdk1n246NJd7MU1B/WUHhAR5grR/8uzg
        ==
X-ME-Sender: <xms:6whuX8UTkiDvdcIEdXHYskj7iUTmCIpf71vDXwCusi-h45858sT6CQ>
    <xme:6whuXwmFh3PL6QCNECHDeXMSUXE1aS3TEmcuDjz7_rJKsVdx1lpq5JM02JK2TQwdB
    g24qBfPgy6D9psm2OM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6whuXwYT5luhM180CChhJ4YvATR0gadXyKzsPv9XWXzXVcDhCR3I8g>
    <xmx:6whuX7XpeNhXhJvOrSnq-kEzCJYYW1gtpYkMYMxegJn1goAtLW8FyA>
    <xmx:6whuX2nkk3LpK3x09JenCT7qFMH1lxI3MIHr9yI8A_72-vsUjtZR9w>
    <xmx:7AhuX3Dz0NcMVnMB6C8d-FrXw8lF87MR-EAh6U9OIH9wsNtHVCRUhg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8107A3280060;
        Fri, 25 Sep 2020 11:12:43 -0400 (EDT)
Date:   Fri, 25 Sep 2020 17:12:41 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/7] Pine64 PineCube support
Message-ID: <20200925151241.kfmytlff4grswtzh@gilmour.lan>
References: <20200923005709.147966-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nyfk5vgvdz5erxdo"
Content-Disposition: inline
In-Reply-To: <20200923005709.147966-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nyfk5vgvdz5erxdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 23, 2020 at 08:57:02AM +0800, Icenowy Zheng wrote:
> Pine64 PineCube is an IP camera based on Allwinner S3 chip.
>=20
> This patchset tries to add support for it.
>=20
> In order to make sure the system do not hang when camera is brought up,
> a fix to AXP209 driver is needed (sent individually), otherwise the
> system will hang because it changes the voltage of LDO2 when LDO4
> tweaking.

Queued all the patches for 5.11

> Icenowy Zheng (7):
>   ARM: dts: sun8i: V3/V3s/S3/S3L: add Ethernet support
>   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for UART2 RX/TX
>   ARM: dts: sun8i: V3/V3s/S3/S3L: add CSI1 device node
>   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for 8-bit parallel CSI
>   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for I2C1 at PE bank
>   dt-bindings: arm: sunxi: add Pine64 PineCube binding
>   ARM: dts: sun8i: s3l: add support for Pine64 PineCube IP camera

However, I guess for the next patches to the v3s DTSI we should just
have a simpler prefix (like v3), it's really taking a lot of characters
here :)

Maxime

--nyfk5vgvdz5erxdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX24I6QAKCRDj7w1vZxhR
xaiSAP9nAzj7b0MYSHVd/GYpJTMQ4IekvW7A9Vvsjgmn/oldnAD9GXTWE58DiBAP
rnZXMhp1Njyyc9laZxEvCkfklg4rogU=
=kyre
-----END PGP SIGNATURE-----

--nyfk5vgvdz5erxdo--
