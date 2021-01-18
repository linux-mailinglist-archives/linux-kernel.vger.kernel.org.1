Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4C22FA8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436918AbhARSbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:31:03 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49859 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407621AbhARSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:30:11 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 40A395C017E;
        Mon, 18 Jan 2021 13:29:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Jan 2021 13:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=TrwoMjews7HeqMv3rqhxGGZrx63
        dLxThYRqHNKQaQHw=; b=lPZ4+SBA1r7o5A5UVLaiZnMi3b1gr0+40OgPXepEqQd
        bBSYn4H0JA3nwqIjxX8RV0ruiOYwZKVE2XJnXQ+UywVu6We+y8oUVxw35TBZhFMg
        za1BTTp2Qxzjidy03ucMoks/zQ0kwzMxQb/NV2CYE3YLZT6Yby69s06FkJZBQVld
        j6ge3GivDOPc5Z3zlNaNo4hsezhv7v0EWoxwTUr9TQr/HWOdseuMDtPRXrTmALje
        6RjdnMGJYga1KCTbEsZj8FmQmboYfJuEIOBsl8TA4/mn8UUsqz0CS49qUpj48cpS
        lWDsb/4a/5V+bmZyyAp1pH3lf+FVsgTDBC0p/EvU2iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TrwoMj
        ews7HeqMv3rqhxGGZrx63dLxThYRqHNKQaQHw=; b=g9TXwBu8DP0yHAEovVMVqF
        qn5vaEI9w3HWF0NCbte2NxoaBO1O9w3UAVx5QWPZa/zK92iGmJ2T4zpjKeLV9IbN
        Afc6AD4Ka8xMS9mS5RpDxoRjoZIUt9uRh60VDHh4K/8aqXUJdQVij6+QrV+M9BsC
        HbnU3gW513JkqrpDk5USdClH41UK/9eub2Uz2EtJuoRezRA76ylty6lZkj6v3QNr
        4Z0B0+2PN2PYYtwjWTY4qf/YQzMHwwP2eAikyK/V5FR8XrEP5pu1UvDdJ8Zawvkb
        4vGiYPUMFwQxADG/rB8gvpbwCeaonllOITrSrDjgkYtoy7NLeI6sfckhS6S15CnQ
        ==
X-ME-Sender: <xms:edMFYF23wDGRpykbnayjbvs1lV65Xxck-5WlYT0h0cd9qKv92oTrXQ>
    <xme:edMFYPWoBTgmLTg1Kcn0TX5yetaqqczXmkwqRS-7cVIBEXqcLWq2fju6NJIyaSrTQ
    Nd363OprC8v1TPlS8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
    ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
    gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
    keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:edMFYPWR2xC57X2vw4WszoDuaUi1RjciPrNMLlj0J7p-5WofwpC43A>
    <xmx:edMFYOe-3OCp72W-tgo5d0xqqaplVj9hEcIjScQLMFbtLbz3t2pFeg>
    <xmx:edMFYIVTBmupV7dCFGFDssPX-oPVZc8Rr4ak6iO4YlSXEFjDkPVsDw>
    <xmx:e9MFYOFXI5-85xDLMC72GSRF4DX6RFhhVAK9JfyMuVUv26g7NIT8kA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by mail.messagingengine.com (Postfix) with ESMTPA id 71454240064;
        Mon, 18 Jan 2021 13:29:12 -0500 (EST)
Date:   Mon, 18 Jan 2021 19:29:10 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Klaus Jensen <k.jensen@samsung.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme: allow use of cmb on v1.4 controllers
Message-ID: <YAXTdohFxR5J9hwY@apples.localdomain>
References: <20210115063046.274495-1-its@irrelevant.dk>
 <20210118175956.GD9901@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9zh8nUPFMjIf71aB"
Content-Disposition: inline
In-Reply-To: <20210118175956.GD9901@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9zh8nUPFMjIf71aB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 18 18:59, Christoph Hellwig wrote:
> Thanks,
>=20
> applied to nvme-5.11 with a little tweak to remove the cmbmsc local
> variable and a comment explaining what is going on.
>=20

Sweet. Thanks!

--9zh8nUPFMjIf71aB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmAF03MACgkQTeGvMW1P
DekhmQf+N40f5rDRmSO7CSlFQfYPi1ynofliDqBI66v4OxHRADZzgnezvED991Sf
kuaIBY+2CbBWpYmgHJt/M4C+EvsG46EpCCKYafu749XfswVkNGsKOPkBFl/4n5z6
1odJHh7U/m1YGOpxKJ58k2ciqWAVeymThGqfSAyYZhqbhPToemWH1ryPoLhuJp84
EWYW0xiwLM74dP4AzRY+r0osYR+qU7ZxEXNwdWq0r2UXS/ErAghTzSKODhzVtwYI
zuiW8m3Sv2nOWK9b7zUjgI/7cH43En6xzxJtJm7t7ffbBbfiy5dDG42Ra8REJZ5k
eKd5vJkp7yBPzL9EJ75U7gvcgf7Ycg==
=uyHI
-----END PGP SIGNATURE-----

--9zh8nUPFMjIf71aB--
