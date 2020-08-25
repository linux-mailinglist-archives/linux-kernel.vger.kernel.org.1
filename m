Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107BB2519D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 15:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHYNiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 09:38:08 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:50467 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbgHYNgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:36:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id AEB54CC4;
        Tue, 25 Aug 2020 09:36:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=cQkt5/9h1tAG3t0Vmxf3pS8UF5z
        0WBOMLPi+0IB7Lns=; b=nnBNGjSRs8j7RbqJooedtqpq1Od5p+/iJbsRDfEjrQM
        U4VPW7liitOs0mCSN90XtHDj0ScWtJ3F5F9gAZd98brFW6GLGBVvDjcrxOHzGrcr
        8s2bXwRsHSLGPsjofB3ux+92bi9U0/3Nn/WsRMVLGUkgr+1u/oQA++6EtiY/HFfV
        T4ifbQ6KtcJiKrKbDx2we147OrK9qy2BHSOeIvqjaCBJ2U4MkGKp0Pzj4dKgNBFw
        qcfclVTa0z7cArjeZ+NHSLGWEbUKczogHC9fXMqPO1gNBgqEGCg71B+MRX5p78Tq
        bi2wQYjCokJy+3BsycU48cG/4sCeejYgpr+h7IG8+Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cQkt5/
        9h1tAG3t0Vmxf3pS8UF5z0WBOMLPi+0IB7Lns=; b=i+5xuPI9MflZ4khnRVtrgc
        U/usSXuK7OBLwWN0I8EPO0wMb8oO/fk9pPQYiZDZnlebcR437cGu902rmLQEiy4o
        DbNk39mGtOspTYsYngpBC+wIJaoDPamAnJZT7uXd8O4IbE2i4oMjYdmvTc/eXQuV
        cGyWDpBzsde/x9H/GHYMEslzq+fPHAkepUKNTTt/FqFQi/K6XgAs1IyReTcAf1db
        jXamrsdp87itXn6lns9gcFuYkOqMChjaTYvWNYL/CQKRAw3KM3KQIyTY8EBB1SEF
        NTckH+xinZkjEpWbPDmvILf0K3omfCkfE9dA9b9ppcVijB3HaQx3QDyWZqW9DcqQ
        ==
X-ME-Sender: <xms:0RNFXy3YvuyB7yBQt8cKEzv1nZZSmal1-Fm4Yxn9DxxrrpfblWrvdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0RNFX1GV7NrUml5UOth7K7WTKyNg8hTJZKSL45xlMVedHS9MSe0OWg>
    <xmx:0RNFX66x7qCZtwbPz1snbRVbjuiqXC-kT0p_kDMlhmk0OvAeRqzdpg>
    <xmx:0RNFXz1nj-45gRjUtNrsaWJaAFewUKjLUu6ve5n1C-pBNxvmpbTFMg>
    <xmx:0RNFX0DR8HX8JgzYIDI-lUnwK2F7HzYCNVyNTppFAYX1qJNnzGoeQO8ULbE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E3459328005A;
        Tue, 25 Aug 2020 09:36:16 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:53:20 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, wens@csie.org,
        robh+dt@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        tiny.windzz@gmail.com, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com
Subject: Re: [PATCH v5 02/16] clk: sunxi-ng: add support for the Allwinner
 A100 CCU
Message-ID: <20200825085320.lpp2uvbmz5s6s6zq@gilmour.lan>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <1eb41bf6c966a0e54820200650d27a5d4f2ac160.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ejggavmyzvpnwykt"
Content-Disposition: inline
In-Reply-To: <1eb41bf6c966a0e54820200650d27a5d4f2ac160.1595572867.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ejggavmyzvpnwykt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 02:58:43PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Add support for a100 in the sunxi-ng CCU framework.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Applied, thanks!
Maxime

--ejggavmyzvpnwykt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TRgAAKCRDj7w1vZxhR
xZGEAP9AIwovkpCMtR3ClRoxntUwiDR/rQpie/Cju+np5amMfwEAgmabcB5//mqN
KMpxAytyv+GF0qj1lX7yQAteXlqxoQE=
=Q4E3
-----END PGP SIGNATURE-----

--ejggavmyzvpnwykt--
