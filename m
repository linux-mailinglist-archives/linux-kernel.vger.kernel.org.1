Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1479726B7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgIPA0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:26:51 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47999 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgIOOH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:07:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4C37BD38;
        Tue, 15 Sep 2020 10:07:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 15 Sep 2020 10:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ZsYljQnhriZe/ZshzGVfV61EVwP
        l4CB2g24GkCXak0U=; b=Tr+gG+gfXYprfU0dwaniDlSxsm1cdZ/d+T1fGfamgbr
        T3yrepvmZ2eqIVUZy2JYODBsflm/VbQs6xLHKusvgHBuKhjeQ4zCkIRD1v0tnlc1
        Gul0bKe3SWvL5qr+qx9IwuPEM4yPJY5LUQYRp6KIqhLC5y1mluDt5Cg/q15tyDCs
        WyXHn/YipkgZC0Qlt5OgfEsMg+hfoRs66KyXYn7KjA+2iiYLyyt5sFKdevfrsd/7
        SYqUuF1Fdyh5ETomY3xt9DTrK5UNM/Bb1HP9Kp8yDfB7veUAiGN1XCTtjZqv9cEi
        HL1o53ZJ+HZQDIek/2xlM+CmVS8ub+22Lb26jvWnpzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZsYljQ
        nhriZe/ZshzGVfV61EVwPl4CB2g24GkCXak0U=; b=hCbhARLGkK+x1BhaM8W9/X
        g7kJu6dWkhLQAYgQ0N1q5Uf9wf03iE71V6snvEwnXbtj9ZI72749qGJigx+7TUKe
        H9R8cwJ4B/TyrRLz1gA7eGl2R0kos1wqYrFKZ+GhKXfOqy0XsWXTwallDtl+P6Qn
        yp/pHmegSJkXJnvZG3+xvSGB6x8Xq/i+zRyEaz51GveUPCYfeCWos6EhopsKvxgI
        iXoer3I7aQ0d6PvFAJRmJVkCbvroY/1TXBBNzaqQklaMH3/2oRGZs9Pq0uU/qC5o
        Jz24UozgLGkeuYp1NAQfxa/RsxZ2Rry95ceZRH6CNErC+zGAXGVXsgkhOtuwWMdg
        ==
X-ME-Sender: <xms:pMpgX1nNBhDOiBG6z-bNsxcpkp2C5VwxJYUEzURkT2QOeXz-LPJzVw>
    <xme:pMpgXw2BZbPk5cRuCCSNj-SgoCy0yDlwvrLNRKsxRNkULJcunn0DAVGYW2l9NTdX3
    pqUNTIKerfo6ZJoeY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtddtgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeevveefffduveeitdegtefhhfetueffteefffdvheevvdehteethedvleffgfej
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdeikedrje
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:pMpgX7r4hcm-vqyGS__s1mmB5IJ7zW521wksGaESAjABZp7rNvBJ7g>
    <xmx:pMpgX1lv3QernoOfTZNQvfcKzyEffLP1u4Q8eD3Dd4ca3VjiBRdUtA>
    <xmx:pMpgXz0joltblLN4c9i1pzUvD1eUOF3Hyk_qGyq05Az0q89kJ4XW1g>
    <xmx:pcpgX-Qqbl32c4r3Y75LFDJiTQh2saUkLYAKF56WW2-RlWQ-r3y7RA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 80F82328005D;
        Tue, 15 Sep 2020 10:07:32 -0400 (EDT)
Date:   Tue, 15 Sep 2020 16:07:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu
Subject: Re: [PATCH] clk: bcm: fix kconfig dependency warning for
 CLK_BCM2711_DVP
Message-ID: <20200915140730.37n4q6y5si3evdlx@gilmour.lan>
References: <20200915103749.38126-1-fazilyildiran@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pc36h5bdn5kiukmz"
Content-Disposition: inline
In-Reply-To: <20200915103749.38126-1-fazilyildiran@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pc36h5bdn5kiukmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 15, 2020 at 01:37:50PM +0300, Necip Fazil Yildiran wrote:
> When CLK_BCM2711_DVP is enabled and RESET_CONTROLLER is disabled, it
> results in the following Kbuild warning:
>=20
> WARNING: unmet direct dependencies detected for RESET_SIMPLE
>   Depends on [n]: RESET_CONTROLLER [=3Dn]
>   Selected by [y]:
>   - CLK_BCM2711_DVP [=3Dy] && (ARCH_BCM2835 [=3Dn] || COMPILE_TEST [=3Dy]=
) && COMMON_CLK [=3Dy]
>=20
> The reason is that CLK_BCM2711_DVP selects RESET_SIMPLE without depending
> on or selecting RESET_CONTROLLER while RESET_SIMPLE is subordinate to
> RESET_CONTROLLER.
>=20
> Honor the kconfig menu hierarchy to remove kconfig dependency warnings.
>=20
> Fixes: 1bc95972715a ("clk: bcm: Add BCM2711 DVP driver")
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>

A similar patch has already been sent (and merged):
https://lore.kernel.org/linux-clk/20200903082636.3844629-1-maxime@cerno.tec=
h/

Maxime

--pc36h5bdn5kiukmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX2DKogAKCRDj7w1vZxhR
xfrJAQCOeDmhakarLsbt+yINpOgCOufsbVA1745++DLY9IndcgD+PojGRoq3d+ha
hJxZ7ac1zRI6a8uXokgmwIctEEWw1wM=
=HnS8
-----END PGP SIGNATURE-----

--pc36h5bdn5kiukmz--
