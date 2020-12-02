Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9442CBC67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgLBMGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:06:39 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49467 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726928AbgLBMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:06:38 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A4E25C01C4;
        Wed,  2 Dec 2020 07:05:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 02 Dec 2020 07:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=WzTVfJ9jLhPrO8LHxfJd3YQ4sSQ
        zAeu+DPkJtA4PFYE=; b=Uqj8zSC9K/zZ0a63bX/HbWgh3bVB9YSjU/q5oFy5LI9
        3rAVwRoLzZ21VCQyexGDfPBZHvsTIP6PPKhEolXFp2piTOt6h8qwrWFDwHacFoN7
        gwweifUT8z6fucd5q19+hrfytQOz+iJKM6ditGztC8TPldGpQMWSxIHrjOlAQsJY
        E6ZPgoUurEd79fYnu/13FO3Zr1bKsNlQ7h/LP3BASNuBdKXI8LDsqmkwuOS4mFlP
        0ZvVIAhGvr3mim5HpJ5ASaOwObVlyM6WOPFAcaCD3oRoLQ1RxhmoI+P+XbISNxQq
        DARgXTd7Zph3+4aR43/5MkbuDrXfjvWQO0GklMZX83A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=WzTVfJ
        9jLhPrO8LHxfJd3YQ4sSQzAeu+DPkJtA4PFYE=; b=HvykbETLQuHf/8NEbKRel4
        HFCEFdstJ6Dfjn7VnCm10cxIrG1krxdmi4PBFTfMYs3dIdcWkdMsAyAiqsAhfXXs
        uBF4oaAi3BxTQyMKAH9HrqkDW8s0DISPaRwE3ENJMI8Z3fmM0QbEd2Zmua0a0T+O
        4lsHoXbYsxMzhgBKvJC/b4nxacvDZpEPH5q01D2q/IjX7/Nq2RWmfO7Z18ZqxLtX
        7NgKYmWE1ie6IH6A8KT0cgGYDQu76CIQdC6XlrTkO70+PV/lRb5dLlT9hiJR+v2z
        dsQXgQ+g5UvZNs4PAPg57DPzx+o0fnyylbwspMVsxNoaAjj0gAzLrRZ9RD0xKHpQ
        ==
X-ME-Sender: <xms:HoPHX-8-w1MxNKg4BGMZPoNh8nD3WJaXDYhTSjF_A6FW9J84IUl-9A>
    <xme:HoPHX-uh9qJm4pIS38gN7yElpeMAT8hU3_QWuoQMJK82VAJIyBa2ovZn8Hf2FM9UC
    xXNIxip-oVc10YVIq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeigedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HoPHX0BrgP5-DRwoj1uuEjDsBalHy8Hy3YtlrTWx4d9FNFjiFXE9jg>
    <xmx:HoPHX2eW7GAx42Z_poLB4U5lkIVo4LdDZ0QWC2g0M62G_CYc4I8E8g>
    <xmx:HoPHXzNYFAnzgXD_Va0tvOr2wymBqMvquLWfiyh3CUl_d1sHd6pqgQ>
    <xmx:IIPHX_A9yppSgB874cECXdUQRgGRLYp5g98RMUU8lnegF7L-Q_82zw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0010124005C;
        Wed,  2 Dec 2020 07:05:49 -0500 (EST)
Date:   Wed, 2 Dec 2020 13:05:48 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: bcm: dvp: Add MODULE_DEVICE_TABLE()
Message-ID: <20201202120548.3oiv7awjcauf72gd@gilmour>
References: <20201202103518.21889-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2emeoleqdm4ve6ni"
Content-Disposition: inline
In-Reply-To: <20201202103518.21889-1-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2emeoleqdm4ve6ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2020 at 11:35:18AM +0100, Nicolas Saenz Julienne wrote:
> Add MODULE_DEVICE_TABLE() so as to be able to use the driver as a
> module. More precisely, for the driver to be loaded automatically at
> boot.
>=20
> Fixes: 1bc95972715a ("clk: bcm: Add BCM2711 DVP driver")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--2emeoleqdm4ve6ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8eDDAAKCRDj7w1vZxhR
xbsOAPwP57y3xtZm5xmf5i2I+FtQ6WGUqy8zIcK1n8Avi9sA4gEAh3G8O5ETLAF8
gcnyJN8vxqHXXlIMbcOZ3L/u7L97Swg=
=PBlM
-----END PGP SIGNATURE-----

--2emeoleqdm4ve6ni--
