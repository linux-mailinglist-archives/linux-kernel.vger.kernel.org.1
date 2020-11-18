Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC772B80AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgKRPhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:37:38 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37393 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgKRPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:37:38 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D5F0D5C017E;
        Wed, 18 Nov 2020 10:37:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 18 Nov 2020 10:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=x4uO1ZuZIrJiF7QiCN6K5UF0mU7
        0q5CXvCZ3IEy5VII=; b=kFGMzxHTjtd5zKVqlwN2ZLiLbw4sWfjFL0MIM/RHG45
        n/3gMBFw/Fc6sEGIHfK5GytsTqarnevR2LkRkhwaQWmHu1rw6xB5wCws2UmudbXl
        1wqBeTNleTYsL2k6054nw41GhntP+ZB6k2mqxJstKnYggGk6RAtLVQgITvh349JK
        4/kzJw+QMlUIwMzQmuJrESZSkVU00YW1bPufyHHpVWiaLKPTT+Oc3P2lX00AyR6v
        aEaopc97G3YnP2fSpJsAYH/+MGEkgI+uAtUlnNae2eXmE/2FgI4yBhdCpViUJXhc
        56wExRTVBJceufts1fM10PttfepIM1L/88DKJBlKbHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=x4uO1Z
        uZIrJiF7QiCN6K5UF0mU70q5CXvCZ3IEy5VII=; b=CFuKqTIn/e6GzGqrSAEQxo
        kBMtXrEPlF79p1uSXYeib644DK8aXh0qrc9hR7UaMPt4hblnzFfBYH5naQx9FRcJ
        T+0q2jQyh8UOFHj7yv4pDA4Hn9Qp/22+jpka11QQIDlc7UqfsPgrW+RJalJRaNca
        iYqPVfJk7/aPKnM9LdSoja7zYUjdzJB+gvxbmTs+MKGtUzrp25B5XLrWc919NwMR
        JTL/1Pf0b7/c54D0E/5Q5J7nG4B8uLVX4f0kMoWL8FcZo0l0UVlDLerHNzwonD36
        2td6oAW71ZFbXDUAh+T+8sE0cKC1o369xEP4l9jSggZbAXbWYe+48AqyCD4Qb35w
        ==
X-ME-Sender: <xms:vz-1X6y6dbeTl8rxrcdx-e_YUgcHeIxOYPDz5Go-WeTr2JUGpM3wMg>
    <xme:vz-1X2QfXWnS6bMG5CF6zpTUFGNe5py4bNfFSQHUx7z-JIo9qoU94qEgUYIqSKBKd
    QFahaVa4Olvi4D5wcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefhedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveevfeffudeviedtgeethffhteeuffetfeffvdehvedvheetteehvdelfffg
    jedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:vz-1X8WNaibGRRwsHaNyQnbIzjWwlDZzF9ndHdEE_8zEfGZzQVRepg>
    <xmx:vz-1XwjHPONQh7oHivF5IgaQ0mTtwozgSrnN6KAXlOc7ZanevkdKXQ>
    <xmx:vz-1X8CyVQPbRGzU2CmmvEexAZ5kSZskV0xWjqxk7e5OEn488EZPMA>
    <xmx:wD-1X74JsCNnd5WifsGqrkU8OrA_M2dmHv4uDHBno1NuRviG4SfXYA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 256CA3064AB6;
        Wed, 18 Nov 2020 10:37:35 -0500 (EST)
Date:   Wed, 18 Nov 2020 16:37:33 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
 <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ax5hpchws2jve5tb"
Content-Disposition: inline
In-Reply-To: <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ax5hpchws2jve5tb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wilken,

On Wed, Nov 18, 2020 at 11:02:40AM +0100, Wilken Gottwalt wrote:
> Adds the sunxi_hwspinlock driver and updates makefiles/maintainers.
>=20
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

A more descriptive commit log would be welcome here, for example
containing on which SoC this driver can be used, and on which it was
tested.

This is the third attempt at that driver, and you can find the previous
versions here:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20200210170143.=
20007-1-nborisov@suse.com/
https://lore.kernel.org/patchwork/patch/706512/

Most of the comments on those series still apply to yours.

Most importantly, this hwspinlock is used to synchronize the ARM cores
and the ARISC. How did you test this driver?

Thanks!
Maxime

--ax5hpchws2jve5tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7U/vQAKCRDj7w1vZxhR
xQzvAP9APC8fwWSCTOQ9an+HbUMCocME/0N1wG/KKU2fHt630gD/VTfNUcWHoxXM
h6KGAD6e1roJ7j2sNMmziTrSvx9sHwQ=
=hUYy
-----END PGP SIGNATURE-----

--ax5hpchws2jve5tb--
