Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C14429A823
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895914AbgJ0JqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:46:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36883 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408836AbgJ0JqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:46:02 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B5805C013E;
        Tue, 27 Oct 2020 05:46:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Oct 2020 05:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=y6xuqD2fN8qDYQ3D3WMwzpwtvON
        lcVIjs7y8oq/0uPU=; b=tOVGOBjC2csEMKnKOks0oPKcD9L2nzYyXmwClImaoyc
        Ld8jPjVaeH8f+FroATWDCekAMfaBYMzy4/GTP94fHpO1wFW3mjKcL9gHBWiFJFmN
        3rXjc10hy1G76kr8/etfLbDNMmYIa0HF19akrWO/gkRZ+Y4J6kKD5hcH8lM+pQsU
        JwnYC5rZJE0zJX4HzZ5y/4h5Wh1a+/mus+e67zJjWdFNnfOJQN4SVdhecYyrObrx
        ZGUaj6snUeezz9kyIe+FWwPMzzwsrGK0qvhPipy73hYfEcU/8H70TbiiDwChWzWq
        MUa4IpR14kq91Pfz53yXUL7UxaMlDhgwmODkDInG10Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=y6xuqD
        2fN8qDYQ3D3WMwzpwtvONlcVIjs7y8oq/0uPU=; b=jT/3lTZ4FHSmju3OGN0NP0
        i4lMFjRsGD1eAT7QQRnmw0pBDpj5j5zn4aEiJPzC48WZiSc6mVsiWE9sDvXexqEw
        38TSSOzvg7kpDLM3lZvvjc5OBuVHKE4tbY8csLqqhZY8PkOIwX3O2SH2udz/Aicb
        7Ht5t4hbCkKmKnpJsjnakmrmzo7OCRsf4LhKxMHlr5L8aX/8TgSfyg2AoiK8La60
        IwFsbJF1eygAuJQqdZwxDcFrmunuTHjtkSwPu/gq8zjy64s5yyFTlcKa5fUNoETz
        LXcFLAOGokJMRVkHncHqGNiT94amzhoS4xuK0xIf4HGX85hyH7xCisx0r4UAq5+w
        ==
X-ME-Sender: <xms:WOyXXwFur6fabTSJcKQuhjlJCBWgTXAjnifbHaPeSvjoKZUzCPGmGA>
    <xme:WOyXX5XYaJEZY6EkoalZVWuWbQ9GnpBP0TfH2_dkSh7akORQIqjjea6zPfX1nX28N
    A4i1sgk-cYW9Hb9on4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepveevfeffudeviedtgeethffhteeuff
    etfeffvdehvedvheetteehvdelfffgjedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:WOyXX6Jt9vKtT_0RfTBdpXfm0HZA_NZxfUD-0x9dHlu252D6Ds_e1w>
    <xmx:WOyXXyGmp6vrukzie6skkTYVDSj4KQ0uBAvapOuDsHDhZx11E60IRA>
    <xmx:WOyXX2UmU7YsO4ot7kVz-Ik48L0m7MWwKRflPAg4_c2Ej9AEpp1_mg>
    <xmx:WeyXX1QQB_T5e6un9jOtsx2PUP3ynkI51765PBZGatXLHliu4_2fVA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 414593280059;
        Tue, 27 Oct 2020 05:46:00 -0400 (EDT)
Date:   Tue, 27 Oct 2020 10:45:58 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] ARM: dts: sun8i: add FriendlyArm ZeroPi support
Message-ID: <20201027094558.3fommxxa64k73ep7@gilmour.lan>
References: <20201027071648.15988-1-mtwget@gmail.com>
 <20201027071648.15988-2-mtwget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdw4wzhyt4exhtdb"
Content-Disposition: inline
In-Reply-To: <20201027071648.15988-2-mtwget@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdw4wzhyt4exhtdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 03:16:48PM +0800, Yu-Tung Chang wrote:
> The ZeroPi is another fun board developed
> by FriendlyELEC for makers,
> hobbyists and fans.
>=20
> ZeroPi key features
> - Allwinner H3, Quad-core Cortex-A7@1.2GHz
> - 256MB/512MB DDR3 RAM
> - microsd slot
> - 10/100/1000Mbps Ethernet
> - Debug Serial Port
> - DC 5V/2A power-supply
>=20
> Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> Link: https://lore.kernel.org/r/20201026073536.13617-2-mtwget@gmail.com

Isn't it the patch that you sent and I merged yesterday? If you have
some changes to it, please send those changes in a patch, not the full
thing again.

Maxime

--sdw4wzhyt4exhtdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5fsQgAKCRDj7w1vZxhR
xcL2AP47S5foec/f3EVHolKb3XTDigiUiXgqy6puGZ+JrJaFMAD/Tgdk1uK1Z+N+
ATRI6nkQkGa7UsxN3Iyr1SI13B2TRwg=
=uR4O
-----END PGP SIGNATURE-----

--sdw4wzhyt4exhtdb--
