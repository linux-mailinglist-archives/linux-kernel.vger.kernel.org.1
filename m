Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9E297065
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464758AbgJWN0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:26:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32987 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S464739AbgJWN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:26:32 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 19B7C5C0178;
        Fri, 23 Oct 2020 09:26:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 23 Oct 2020 09:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=2aej+lSH2Tmfq+QERTp8gVSpGDD
        IAV9g9tr2RqwADcg=; b=PmW3RUyNYUQc7CZZH1iysDUoGpj8XZkGzrdZahrTR2L
        n4kMgcQZ5FVQ545P3O4BO6/KKqg3Ve5nrYXd2mrMCDeEuIl8AicB4uUtKdrvaii1
        OAsmIMvvgmeYX8ViuWS8dwNfHp395nqmpG0cDr/NAep2dV81B9jQhgX2RypHWmyt
        XkGy+MADShar5aWmhmVW7f04w6Qnr0jG519SY6WG8SbStyH6PXGqmBAxfV7I6lol
        G9FEffuFtF2bQfEqcBQIMlcdt7JTGJFCkHN8UBsNWUSmNw+5ScH6lM7t3S6AE+h+
        tDturGaiP7XczpXprz+Az2rEJTDbxi9w3VqDj2xjUpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2aej+l
        SH2Tmfq+QERTp8gVSpGDDIAV9g9tr2RqwADcg=; b=qciLr2stZVs+j3KVHCtdid
        o2CmNX5A9Okxf01CHmqwZqLmFkioGPm6dbV6QGKB+enVnXIMpRE4MZzKCqL0/gLx
        YHQrkzRKEs2gaxIPED2xGLkSbFcLQDQM17O7s5tjKWrNbk6iu98q+a98v/OQyjLZ
        3A0P7doZKj9RQV6gdbdAPoNo4gx4k1NpiRrY8py0bR0MN0Xk9WlMEqtmH+LpAApt
        4WxDcSJuXNE5ie8peS9gJanr+ifk876+269XQSmq/40cwtbo+s7VlRd49ELBHwNd
        37+kP5FVPB4LdwsBu/OmMHTuYlRGo2asUluz2/hHNVqay/hcZ2fB7n22l9oWjOIg
        ==
X-ME-Sender: <xms:BtqSX2CdBgrJTcf-c2aWAWi9V__DdbUTn9wjyN-mzu9h-kQaLemq2Q>
    <xme:BtqSXwheq9IZUyYeZRsyZPrbEfEMfp1i9MP828N8BZufMPVowlErC1lK6PKzugmUW
    SnLqiIHsRBWXJuZa2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkedtgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:BtqSX5mRMkA-NwTVTX9PwKg02NfMhjw1fUl7oAvVeAdV7LTJdnTh3Q>
    <xmx:BtqSX0zgRvB1PXcWC8l5zRRl98-Z9rS_z8N6xgebMfKeOzSCqRNcXw>
    <xmx:BtqSX7SMBeZpaPCnnH0gUAz0Mx4Q6DiayP3F3VVEQM8U0O0UOckkDw>
    <xmx:B9qSX5OddInMswMwZKF61b7mh5ODaxas3WsDqtmf6DeFHWq2RU1PAA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9057D306467E;
        Fri, 23 Oct 2020 09:26:30 -0400 (EDT)
Date:   Fri, 23 Oct 2020 15:26:28 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: OrangePi Win: Fix ethernet
 node
Message-ID: <20201023132628.k7asipeprgsk3rrc@gilmour.lan>
References: <20201022185839.2779245-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xvikoaszu6hqehxj"
Content-Disposition: inline
In-Reply-To: <20201022185839.2779245-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xvikoaszu6hqehxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2020 at 08:58:39PM +0200, Jernej Skrabec wrote:
> RX/TX delay on OrangePi Win board is set on PHY. Reflect that in
> ethernet node.
>=20
> Fixes: 93d6a27cfcc0 ("arm64: dts: allwinner: a64: Orange Pi Win: Add Ethe=
rnet node")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Queued as a fix for 5.10, thanks!
Maxime

--xvikoaszu6hqehxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5LaBAAKCRDj7w1vZxhR
xYmWAP9i2zUfNme9ENt5LAc938bAw0VdBsW/pmdnpWxzd7pKDgD/TXi1uerVNTNK
Ji9mro/2E3u6M3qEed79+w9Cv4g/gwI=
=WihY
-----END PGP SIGNATURE-----

--xvikoaszu6hqehxj--
