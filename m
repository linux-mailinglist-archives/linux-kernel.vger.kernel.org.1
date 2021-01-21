Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59A92FF0C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbhAUQoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:44:54 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52135 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732681AbhAUQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:39:22 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6AEA5580524;
        Thu, 21 Jan 2021 11:38:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Jan 2021 11:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=jGeQp6cCdgRQb61rYx3MEZ5kn8M
        eELzWsDuny0yRFYw=; b=SRiREtqkD3dJbRr71G5KSiZ7ANboAAwVVTw9kq3m2Gn
        03DtHyDdBA0/ZHBb7GXWXH8J9c7br/Yd8IvKhD3leABgjjZ/k11/MapTmzPNco3X
        LYP3HV89lOSlsUUeOHovLQYxyvWrTiB/2e/gXYO8+GK8BBxggH2N70WTZbwNcFKJ
        OFJ2XdUvUWDRnp/r6nQn9Jjns2yF9k2nRj8IG4dsERPZgiC2wNulFne6haT2pAhe
        v5et/hrzhSMqR0AjAJ31TrySZv3PpZvhdyQetuykK3qFSgF72MvsGsxwAt0tKivA
        YZBYe5FbA6drsht6sKDoaEWDajcCzBSDRmYnVe+ymAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jGeQp6
        cCdgRQb61rYx3MEZ5kn8MeELzWsDuny0yRFYw=; b=UTP4rOuBX7YVXF9N39RbTg
        uLPjVNQv+MIddZqkFLxuSreA5/hSqPoeal1uoOz9k/OxbYfEz9pGa/YZOD4iIIZn
        wEmPUERIAlzxskN0SzyuIGDb8INGdVlvxz/gVOOV0BKiSQ8yjiYJGAuVWD/e3yj1
        P5QFqXobplP+/X3Yw9t9zaLyK8MQOYQJ1+8hiqw/6Ldxlgyl3eXGZmZHH15rYFpy
        TmUj17ZUGdGk/2WemnhEpinSBoFygaLtXE37zNYmklJ12VZu1r0MBSfpxrtICfzx
        vYvVHNyi941jsK/zXzuCllF3iJAYRqOI17OHEz47urZgc5t8bfAYtFDhepRFD3uA
        ==
X-ME-Sender: <xms:CK4JYCCqEqGKfKxFlhywgyMKRceDbXEwZcM6vJMrDVIfGVGeamcb4Q>
    <xme:CK4JYMhLQTe50LGYFP2gk5nga4Af17BtWx1EvAQUh7Kfd1uFUhQDeCyb9y24EKSos
    gPk_MZ499fwLhbcaLI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:CK4JYFlMo3SH-xvEDCQdvBfiPhar0QJCUCqpr8R6poBNNrmbEx37Uw>
    <xmx:CK4JYAzkDjUsICY34BrnI1k6kIAdM--8A0K5q8QyfoDhFSmKSrpLmA>
    <xmx:CK4JYHSljdekmPHnk_gI1sm6RCsqFbiE1kYi-VQN-lJMRtQSQytxMg>
    <xmx:Ca4JYPZyeT5niKWodAbw-j7RMRofwc-pMqGInjX2pAr2rwtDvlF7xg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF38B1080057;
        Thu, 21 Jan 2021 11:38:31 -0500 (EST)
Date:   Thu, 21 Jan 2021 17:38:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 02/21] mmc: sunxi: add support for A100 mmc controller
Message-ID: <20210121163830.5fhrr3qx4kjbqj5y@gilmour>
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-3-andre.przywara@arm.com>
 <20210118132854.yiwn7rnvcyexgqim@gilmour>
 <20210118155228.3bd0e909@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ev4lppgespatcttv"
Content-Disposition: inline
In-Reply-To: <20210118155228.3bd0e909@slackpad.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ev4lppgespatcttv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On Mon, Jan 18, 2021 at 03:52:28PM +0000, Andre Przywara wrote:
> On Mon, 18 Jan 2021 14:28:54 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> Hi Maxime,
>=20
> > On Mon, Jan 18, 2021 at 02:08:29AM +0000, Andre Przywara wrote:
> > > From: Yangtao Li <frank@allwinnertech.com>
> > >=20
> > > This patch adds support for A100 MMC controller, which use word
> > > address for internal dma.
> > >=20
> > > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com> =20
> >=20
> > We should also disable the timings setup in probe to derive them from
> > the DT. This is causing issues on some SoCs already, so it would be
> > best to not make the situation worse
>=20
> But only for those new SoCs, where we have the speed modes in the DT
> in every case (so only new ones)? And this disabling would be
> SoC/compatible string dependent? Happy to send a patch later if that is
> what you were thinking about.

Yeah, we should only do it for new SoCs at the moment, based on the
compatible.

I guess at some point we'll have to remove it for the older SoCs as well
since we have reports of it failing for SoCs as old as the A20, but
we'll probably want to make it as smooth as possible.

Maxime

--ev4lppgespatcttv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAmuBgAKCRDj7w1vZxhR
xar2AP0ZvOuZtBqouyeCYUoO43ULetRbYn4+luZtYdfkCy5wRwEAmk9MFsIvaryi
3Z1PylgeJOXUkjyhVGs+lWSsIYh91ww=
=5rlm
-----END PGP SIGNATURE-----

--ev4lppgespatcttv--
