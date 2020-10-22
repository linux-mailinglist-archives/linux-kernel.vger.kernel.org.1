Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA90429626C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901478AbgJVQNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:13:53 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43135 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2896298AbgJVQNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:13:52 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 53E3C5802A0;
        Thu, 22 Oct 2020 12:13:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 22 Oct 2020 12:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ixh/510Haf/p9X2/V7HbKAJjNIS
        VDdGLgM5TvEAXzfU=; b=UxvDlTqozmSDWjwT9SYPVhrvwNNbuW4FWhkZ6u7+eVE
        0DhToDftB2Bxb4N7txF383B/xDhANSlpGnhjqtr1eKo6jL8JFBrT7qurwLCNpy4i
        MYxrAokTa/8Yzo8NPugTM59OCCMH71FdMlloEHwphYs6p7i0KsBpmFLaA1At1Mob
        plAVwHzDqGNTvJtor7m0KwECw8wzwU8G9DeoI8Y0kQHAFzfnPH8srXP+yaqxjY6a
        P9W1de80tyLiuakn65a1+08JEvr9eBjqW8/Ua66sqdAegW2eeYEOEGytjTJrsz7y
        SUPGyn2Q115M0Og8uHZUuWazn4W0YfxNfGgvkmKSybw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ixh/51
        0Haf/p9X2/V7HbKAJjNISVDdGLgM5TvEAXzfU=; b=I3QzhkwzE/3XjJUFFv+EQo
        LIezOs9zPrppuzGFAfBrL36sD+yMhqVd6zRfTbNzR5cVqdTjGvLvY5G1O0LCCS0M
        QkaJbMVpv+akQAHzItPlMTnBkllngZuriZd4xLlGkRQHYiJdpKN2W6YykfeJlfmv
        LW4fHhXtKDytknBzHgKgsHntvOevALB2QOF8m+CY0Te7OwGeY6zzMlpRAm65tqDs
        l1ca96/GFbCsGMyOWOE+r4YA0hAgaK45AinwJLz9W8AaLV1y0aNKDHLoxhUthF/Z
        qYWpm15izz3yVj+bcuGdcA6a0Q2NbMrFWAlynIP6EW5+tqUfwlLbLjRI1GsKGywg
        ==
X-ME-Sender: <xms:va-RX6mtffWuYcQeRxTHY0HBEWNM3bP_4FVBQd_1gOpG2qoejcxoeg>
    <xme:va-RXx3jSl4dqsWtS5Mw5S0ULq3H5SG2sPBq_JAKK6KY2XLqEkXcGu1olOcM_Tvts
    fGbWI9QcioZVsaBreM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeekgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:va-RX4oZC-oxkr8LO-2O5SQYq8o8-xGoS0O3_6pl6WV3ldSjkux5vA>
    <xmx:va-RX-lHxxvyhyqD_-4Q0cH33nZpVACyMcaPGfgOBvhZQ-RmKYXWLQ>
    <xmx:va-RX424hHNG_l7CpMI8DD-9opEucSd-upLtS9InEohHZTrOjK0Ubg>
    <xmx:v6-RX-w00q5Nsjs3Avwi45i0qL1Dx2l6lJx3b6Sr9Q-GjCRnQxJk3A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EBB053064682;
        Thu, 22 Oct 2020 12:13:48 -0400 (EDT)
Date:   Thu, 22 Oct 2020 18:13:47 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/29] arm64: dts: allwinner: h6: Harmonize DWC USB3 DT
 nodes name
Message-ID: <20201022161347.llvnqaof7fy4i2rp@gilmour.lan>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-25-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tp4zfrkdauye4fpq"
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-25-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tp4zfrkdauye4fpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 02:59:54PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Queued for 5.11, thanks!
Maxime

--tp4zfrkdauye4fpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5GvuwAKCRDj7w1vZxhR
xe4eAQCm6UBIAoNdAQl4UOCa+VvbwdUDqEEuCOJTtKU3dz6xTgEA79+0F9ioRVTo
DjGx5094pbmIuS4Cp5UvZ8Du/3q7ewo=
=Ffyq
-----END PGP SIGNATURE-----

--tp4zfrkdauye4fpq--
