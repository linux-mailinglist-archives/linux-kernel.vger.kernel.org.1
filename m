Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BBC2EC143
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbhAFQfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:35:34 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50319 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726951AbhAFQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:35:33 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 085B85C0108;
        Wed,  6 Jan 2021 11:34:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 06 Jan 2021 11:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=jwxdfBd4r0R7S3adYq5aZIV8eKf
        9z7YATrKKIRT1GQs=; b=K52Cn5CBA5Um+6xbYc/uT49s7f1YUOLAebEi+82tR5C
        r5Bdtldlt3dnYGAygCQ4/Vjqr2UOM5fp1Gt5/eEs6cjws636N8myN/2lFv/xqj9v
        bOmwq4ESD3dNGf9c1aOeUZa7wVymstIQPGgZ8hPSagom13d5F7ODLY9kUfOsMqdp
        edq1O04pqd+/K/hvcLlR6okMHt7AkHK4DJzI/GLESiAh6T6glwJJeb4A06fqNn2m
        VVGTEQ33iADoJrx/vauhWFcQ7wj8agqlZImVJBk8LF5P7oxjxDTEiPEh6u3NNWJD
        9HDtuZr2Qko4KrnlJeq5dKY8oQfEHep82vnwg5gNqaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jwxdfB
        d4r0R7S3adYq5aZIV8eKf9z7YATrKKIRT1GQs=; b=LWHjF0SR06GpS9MPsVAfG9
        cHpr0wtVGxXoc6tJ8c2OuwRqSMpvCnncwQt9018ok4PDj+mxknqeSMKVQy/1W2Hg
        A/E1UoO1WkB+UqlghDppy57ZZdtNOj/PYWqRT43mewGnvJ9wT5WMkD3bY0erjBz/
        m2vYWgZuy+/GB+M+B5a2K57M+pjOcSAezJJnV67OWq++QingbEtoetUhT8uNFgrC
        vqEEruDJSMSUkmQ0YCQEBjk7qKuQBWEW8/YjlkdXrLeCGv6/NBGC4+rW+4eThO27
        o7wT69Uo750WU3RPudDR/Z2TLBui5v9IKzO4V95+Sm+NQVWC4ieWVC+u7Ep/rhbg
        ==
X-ME-Sender: <xms:peb1Xw69ldxBNYIKaw5OGSOvDCHCZQD5xoDin0pAA_IujTX1cmpHNQ>
    <xme:peb1Xx4veigeMBnJA6Dq1gOX6yxCH50MTFk7IIILu8jA-shQDVRn_E-x0fnZrqZ1O
    GAK3fK5GDWA8t9L9vk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegtdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgvucft
    ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
    hnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeguden
    ucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pub1X_dbY23ytTWT2m8xYpnmAAsmU066PE2RZ2h58LwUilD37RKrAA>
    <xmx:pub1X1J-hRbzRTAj-wqKKkvgWoh19qxqUJORizTyVlUoa3ZOjcjgrQ>
    <xmx:pub1X0I5MFKv9N3Ws1nkhYrJ4kX0B06cqUvgRJJ-8dMWJmehpxCpdQ>
    <xmx:pub1X-g-t1FgAdQcpCfHLKEwiCu0s_o7OdjaO_3p-NLJlnsVMeyk3w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B5913108005C;
        Wed,  6 Jan 2021 11:34:45 -0500 (EST)
Date:   Wed, 6 Jan 2021 17:34:43 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: sunxi: document orig PineTab DT
 as sample
Message-ID: <20210106163443.5xdotu7b5l6rwyld@gilmour>
References: <20201224024001.19248-1-icenowy@aosc.io>
 <20201224024138.19422-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qjnx6kq65a5tdxsd"
Content-Disposition: inline
In-Reply-To: <20201224024138.19422-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qjnx6kq65a5tdxsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2020 at 10:41:38AM +0800, Icenowy Zheng wrote:
> As the original PineTab DT (which uses sun50i-a64-pinetab name) is only
> for development samples, document this.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied all three patches, thanks for your persistence on this

Maxime

--qjnx6kq65a5tdxsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/XmowAKCRDj7w1vZxhR
xfrBAQCWOf2ul8xz1sv4iFWIk6xr+FOt/HhTHtSw6nzcbZ2dcgD6AhdRd5lz1O51
EgK0nfjyVFxpBs1erzjwp1AiXy64sAY=
=kJx2
-----END PGP SIGNATURE-----

--qjnx6kq65a5tdxsd--
