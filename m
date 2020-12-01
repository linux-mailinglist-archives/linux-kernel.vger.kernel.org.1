Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDE12CAB00
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgLASpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:45:24 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50203 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725984AbgLASpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:45:23 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7177C5804E6;
        Tue,  1 Dec 2020 13:44:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 01 Dec 2020 13:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=SUiTLvsbV6bTL3/Phtwc89nUl/o
        8e01fyOgokxa6DWw=; b=tzmJnjCkll13fsG22SQTqYnaewl9e0dHVz7PP3PhbIU
        40paTCivbgCQKc2XvmMQ1u5rrMdNWLR1iQlBt1THiG/dXxZYBEqEj/c8PfE7Z1LW
        TjDBH/jIaUIhao7wupB2jkmDOxWCTCrMu0WDZ2TkMVnBVw4UI3HAQIAdSkg3Uln8
        lnWCnBHvQidiRR9HJGc0e9B3GbMOHemny/udqtZ44ioNAwMDp7bXV2CMSXzWpAJz
        7VcGPESEAYf9dkCm5QOPXPG/iBuNR078VTh80uSeBxB3bG9PaaU7K+wyFdokz1nj
        I0/8zk9JQm0Zbj9XXC4nqAjG3o+FOcTYu3++7LaO3yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=SUiTLv
        sbV6bTL3/Phtwc89nUl/o8e01fyOgokxa6DWw=; b=ezZf0BPQYuBAQYtfjFLZX9
        NtDlKoEyKeuE652h/8fkNfdG8iLmWECLWAn3YOkMI+OgX6PUPvEb9ONH1wipBLtd
        WWdh8UL20dgMR+ktcnl03p94LdTt4qh68lA6nOahhnGFXFComudjhp7KxyYSpqH0
        MH5hfGxhJHpG2eoIUFzLGm0pjrIuVsnPoHVd7o09SnNFzjrue7ZSXpyEpkibzcIR
        rzupwSaujqNmE4IsD9sI65icRWmjbdLbr2omPkhlJ+0Tx1PLH60HAnoVY8KXjuTR
        mYNWKRJ+zvGRQ2nu9CvkJ3d4ZuYj3Peq3SLZxNbL5PKmP3hZ76arLGAFWNXxCKDw
        ==
X-ME-Sender: <xms:Eo_GXxVHUpD6sX0ByFAezGxpTcy15baV2DA0QQmGVw8KRj1Dpe9fPA>
    <xme:Eo_GXxk-N2TnOeO3S4lKZPzrf9M0k50d7NWuVlgDS9g57hGAZ4lr0xyVVxumjGT4Q
    sDuyqkDoeFATn5zaVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdej
    vdfgveenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Eo_GX9Y-vDGtTq65161NAUN1vdFfOX55t2wi6QhXaIsV-kG6YdNO3A>
    <xmx:Eo_GX0VxxhMDVtfHjZP9CNVF6AKcaFsalMBpY2ZcmH93ljBFZhrCAg>
    <xmx:Eo_GX7n8ITNqERzncMX6K-U7eUkD31iTePJeUDaEv0owc0ytTy7ZsA>
    <xmx:FY_GX96I8AmPS0z2KeDtdAx_HcKE7aDD02UYE5aDIoakyqiIFE3a6A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 941621080066;
        Tue,  1 Dec 2020 13:44:34 -0500 (EST)
Date:   Tue, 1 Dec 2020 19:44:33 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Frank Lee <frank@allwinnertech.com>,
        devicetree@vger.kernel.org, tiny.windzz@gmail.com,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [RESEND PATCH 12/19] dt-bindings: Add bindings for USB phy on
 Allwinner A100
Message-ID: <20201201184433.s4i3gd3tqu4jtpvv@gilmour>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <1ce71bac2732620f8fe77b23ca84e062385e7e8a.1604988979.git.frank@allwinnertech.com>
 <20201111225039.GA2185181@bogus>
 <a52f7350-b7b5-290c-c43a-020fecd58874@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ybsgrtbcvrwu3zs7"
Content-Disposition: inline
In-Reply-To: <a52f7350-b7b5-290c-c43a-020fecd58874@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ybsgrtbcvrwu3zs7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2020 at 08:18:16PM +0000, Andr=E9 Przywara wrote:
> On 11/11/2020 22:50, Rob Herring wrote:
>=20
> Hi,
>=20
> > On Tue, Nov 10, 2020 at 02:39:42PM +0800, Frank Lee wrote:
> >> From: Yangtao Li <frank@allwinnertech.com>
> >>
> >> Add a device tree binding for the A100's USB PHY.
>=20
> Not your fault, Yangto, but why do we actually have a separate binding
> document per SoC, when the differences between the PHYs are so minimal
> that we get away with some flags in the compatible match, in one driver
> file?

They are similar, but there's massive differences between them still
(like which regulators are supposed to be there, or the register names).
So putting them all in the same file just ended up in an unmaintainable
mess.

> For a start this file is basically identical to the A64 one (apart from
> the example), so can you just add the A100 compatible string to that
> one, instead?

But yeah, if two are identical they should be merged

Maxime

--ybsgrtbcvrwu3zs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8aPEQAKCRDj7w1vZxhR
xfnXAP9FypMSZjSq6z0vweAk5ps1N5G9XTzNFXwX4zxQ/nph2wD/QTv4qGa5IJSa
b+AuXORWI5YiOF6/1Z0LMTySTnZcvAY=
=rG1t
-----END PGP SIGNATURE-----

--ybsgrtbcvrwu3zs7--
