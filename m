Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5FD29E73D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgJ2J1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:27:13 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43643 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726212AbgJ2J1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:27:13 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4197C5C00D1;
        Thu, 29 Oct 2020 05:27:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Oct 2020 05:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=UzAu8NK8uIq2npbopT5aSGfEzHe
        1C9AHKEoq7ZMMT24=; b=J9Y+17LWSq5sLr3lWihKFgecDRhbvet5hzGUekXPVkz
        HiVEs63Kc6BPCVIk7y/AAUv0SyN+gVQLmnhCOknqleIL0HsGdfaeD7piseqH4yK9
        n7Albm0vtT9pXhnQS5FeDLOiEngLEftLJJ0S+cSEiC9Va/j2XzWKuQE1RUNxBdHk
        io53aldGOdOenHMkEbICQp9YZzQVz4ZVJ6cq4wBGEOcFhGoC1zLlwj/M+PxlC2hD
        LdmVqXTMppAZrv03lky7mSJOxlZmLYYeYA+KrLhQC2PsGHh6OQbvKcQfgTc480pX
        3LQ2bZmWHNreEMAHbHUa/H+7VOz7EX8dFzwA7KmQddw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UzAu8N
        K8uIq2npbopT5aSGfEzHe1C9AHKEoq7ZMMT24=; b=d9spZqnRdN7ZjrAM3DYgLs
        cysh5L4Oya0EqwzHjWcduG2YS/YcS2aOHYRcqApT5vCFFXB27oaYoxg1L3j8Sz0Q
        OOgp+OuOXWrN39O+s185nNkH4sBw9EP996RlqV8vfE3fp13/skADXzBIZITzmind
        JzqQS3hj9rtaGxsSg0UtZorQ9ZO7qXlwukXrihjfZtAipuKLe0/wZS6h6UF/NEGw
        +ifA9ofPPLQFBhLWYq0HCjXvWDcuf6UEz4i6IwxtwcUPdft1Pr8WRVnoQ5MsxbYQ
        df15Ozs/JzlQhz1oKmboqGNrvPAvqLyMmjVVQPiKtMDx4j2Y3iiUbly3qNzKzezQ
        ==
X-ME-Sender: <xms:74qaX94ARh7U8OOh-tLPcyyMiJGPnrvi4CGO5Qr8Ef09sbrbyYUxOw>
    <xme:74qaX67uM2HFnUH-P6GKCC9qXNlU9aHBqYJ63TiaRljvs3770rPL7_xGeDhb2icja
    JX5ZSs7I-xUXJG12mU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:74qaX0dMVe9XkAd3rQ66Ktrn2CHJsDYVlO5sCWeAWZhsXwCu096Xug>
    <xmx:74qaX2KwMLKPPSO0R-ivxZR8dywjdws7bsPUJxqRI6b_9kJQ7CO1MQ>
    <xmx:74qaXxLqzm8KWGtgp7d96nNqb83nwmvQI4Zx0T6idF7YWZKbhdi-YA>
    <xmx:8IqaX2qATm-nPHN4oxMWnVSSl9ChEa59g8SPM0Czq9te9gczaQsEAg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A16D4328005D;
        Thu, 29 Oct 2020 05:27:11 -0400 (EDT)
Date:   Thu, 29 Oct 2020 10:27:10 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] drm/vc4: hdmi: Add a name to the codec DAI component
Message-ID: <20201029092710.iyijg37jezwh5vff@gilmour.lan>
References: <20200708144555.718404-1-maxime@cerno.tech>
 <CAPY8ntDgx67bba2NtNVToEZaLrX5cmrdTB51=0L7qV5F5UOJiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gxkmhv6yu6yulli4"
Content-Disposition: inline
In-Reply-To: <CAPY8ntDgx67bba2NtNVToEZaLrX5cmrdTB51=0L7qV5F5UOJiw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gxkmhv6yu6yulli4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 01:30:32PM +0000, Dave Stevenson wrote:
> Hi Maxime
>=20
> On Wed, 8 Jul 2020 at 15:46, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Since the components for a given device in ASoC are identified by their
> > name, it makes sense to add one even though it's not strictly necessary.
> >
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Applied, thanks!
Maxime

--gxkmhv6yu6yulli4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5qK7gAKCRDj7w1vZxhR
xYqOAP9JvMVugjx3JTtjlRitnxpJDOXVgxCuJwNKbLmGzuZLywEAl8tNYMEi6+z/
tqgqUfkOPzH7GnrCTZhiPW7Yq08Qlwk=
=nRwf
-----END PGP SIGNATURE-----

--gxkmhv6yu6yulli4--
