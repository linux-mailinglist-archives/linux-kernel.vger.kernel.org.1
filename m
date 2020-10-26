Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E903298929
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772717AbgJZJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:10:35 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:56531 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1772629AbgJZJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:10:35 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CABC7891;
        Mon, 26 Oct 2020 05:10:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Oct 2020 05:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Z7SxqbGCmhesWtk9dI+V0IXSxnl
        8dc8UkZs07jmPSzg=; b=C+COPZV07ITR5Cs0YuJ2xpBvuwXeqqd0PPjuFX/BXPT
        uRedklYsOQfj8zI6sHBswKp84YPHMdSsEQGm/qhNkXvm1c6Fzl3ooxjJ14sOHPSZ
        lAZFSRoTCx9fpV/pMnC1gnKNNpManRKbpp26cLA/ji8KF/z0nuGuJSJM6jPdIrOB
        jYzvZjdy9D+uVprId3DFwh3/Nd6Ot59C8gi01D5wqT01O1MmhmRQUYtxinb6fd1Q
        RtaVpgXzMSWftPaWzP7dY6HW19rOlpe67/FY32n/QNxUsYoGEXSg8iX9S68rC8kR
        tslnAvKJjoTa8l2uPdCKg4jdTAdDnwku9+TqwUOT1xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Z7Sxqb
        GCmhesWtk9dI+V0IXSxnl8dc8UkZs07jmPSzg=; b=rc2IInb9n77qB3yKVUIr5O
        PC3yKR6rntnvjRvQFuUIpZiX0Y44X1VIh94vlXK9ySMpowbVBHPGtZ4ck3Sx/Sgh
        1yJrN3lIapcdO0U/TaYSsOf+imuU+zSKDfGtSV9BhT6bSZ5uQiBIXRXai9u4UsAN
        g59CCBIWPJ2LBQ2uPZyPAcO7L7SfPjoOQ1jap5A1wLWbIgRXti4Y0rV8fjKE5fJt
        eizfu7N58c5A/WFp4DPuAeoQ+o0vy/H9p7NxeL5EmxrTNEM83JkiMMNJaqwditGA
        n83lYDwqJt21fWzX8LlNIEVGCwCUu1we07brnseayd77h6e79sAZXVKLVcrAFsPQ
        ==
X-ME-Sender: <xms:iJKWX8nvkoSAJuh-aMJU1q1dM-u7140X6ABka7i21rXTPbJLXaNkGA>
    <xme:iJKWX73KQBmf7Ml7ywn4d3XpDKlEDI7lnIPAvhawzPWoQUfgVz1lmbNVKHpORT3j4
    6H_KC0Sxv1dPxdtXTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:iJKWX6p4WLq5ZdT6dlvxEzjWf0TtRKEs64w1eveuAPTcQ5so-r86pw>
    <xmx:iJKWX4mIr8FLZ05a5_26QyZ0fbqoIZdr1XMAhLQOe8WyErtZssJ6ow>
    <xmx:iJKWX6389xTlUOxld5FsjdJobjI847EQhjJm1c-YgLD6HhU38kYsNQ>
    <xmx:iZKWX9SnK_oz6k4hxbDRiTY5iizF5BdpkfEb5o9fEz7SUrg_-iExMg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 84412328005A;
        Mon, 26 Oct 2020 05:10:32 -0400 (EDT)
Date:   Mon, 26 Oct 2020 10:10:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix ethernet
 node
Message-ID: <20201026091030.eoll5hid5e7n4dnk@gilmour.lan>
References: <20201025081949.783443-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3dh32pw7ynavg6qc"
Content-Disposition: inline
In-Reply-To: <20201025081949.783443-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3dh32pw7ynavg6qc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2020 at 09:19:49AM +0100, Jernej Skrabec wrote:
> Ethernet PHY on BananaPi M2 Ultra provides RX and TX delays. Fix
> ethernet node to reflect that fact.
>=20
> Fixes: c36fd5a48bd2 ("ARM: dts: sun8i: r40: bananapi-m2-ultra: Enable GMA=
C ethernet controller")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--3dh32pw7ynavg6qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5aShgAKCRDj7w1vZxhR
xVXWAQDO7tfbaxh3gz2L+RvAxvqAbelGnJr+FS1Xip+lHp4WuAD+Mw7xaL7fslcP
pxTWuzQJsNtvbRGsHzax3dajZ1OH5wM=
=Ef27
-----END PGP SIGNATURE-----

--3dh32pw7ynavg6qc--
