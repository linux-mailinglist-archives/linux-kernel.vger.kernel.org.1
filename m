Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA432B0302
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgKLKqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:46:33 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34953 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgKLKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:46:31 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 46B965C0236;
        Thu, 12 Nov 2020 05:46:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 12 Nov 2020 05:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=oJmrTdQ/GskCivVlDNrQ4x5ek5n
        vHyw0AbCVAhSZZ44=; b=s9I22IHf8ccwJjBhsMn9WICLlGH+pQpmklAkH+AOqYR
        bnnL3qeotmtpu0oZ2fw5AbB2cYB3kP4S1iKifJhKrgUwi9IN45Pb2TZMv2O8w91c
        kJx2/MvhD9sAGBiZ7LyORParo6pbljrNpMiiFgmswvg5exsuk3GW77/+kmlrcF9N
        yMcfzuqI/GUZWnIrBnJ1Mg6PBnqBZjwXpGqxehMiAaYJiyrjGZ1xBKICBcJz6NAR
        3hHKOjW9Ffg2yiP0GCCUzgf2iYsSqOUmjN28UQHB9+tLKZ7qf4uZhKZy5vfzBfCW
        dL7ZdB+luPDFeDDwo2DHbiogDHJcVmVSkoVFGbu+BBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=oJmrTd
        Q/GskCivVlDNrQ4x5ek5nvHyw0AbCVAhSZZ44=; b=fwDb9AudngobCqknECMsao
        J45EH3thkVEJEJiH7oSy0pDzd0R4B+jUOeGoiEpF3bNHUZgHLokBJkXkjDSc3Gwj
        bW4xGPqh5qSLf+CffrBFrGV0qLC5ris9AX9mkdh7QqzJ27E9Dxqk2c4+QjE6J6oG
        97Dxxpk6G3OhSzC+FrghsD+eIZF4ZAJOi19Ui2Un6Sq6SafYNe2gJkYWoARX/YGU
        +atDkO0H1Ec04E+zqwxzSHxL2P8s/1MtKwU9NsZAS+uWUO160w9oMac4oECJe+6Y
        IyfbkjClN0zUV1JoJGBD0CNzYV9g7wXdy5MhiQnDRQefV1kmrpqyfjQHa7Y/qkvA
        ==
X-ME-Sender: <xms:hRKtX_yaBBkyKVLss9Bxoivng8xnUkRVptGjS5T-p4wC1e3g_BpMmQ>
    <xme:hRKtX3SBenrBP0gi3azpD5icvdd8rCmNLfapFOUF1p4_HrHi7H77Rk_PTYKzZMbwa
    bIMEeNfRZPXx0IPNhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveevfeffudeviedtgeethffhteeuffetfeffvdehvedvheetteehvdelfffg
    jedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:hRKtX5Wuxxzd6FzebQ7OQ9yRhQi0nQEN5Y6gwXZGrJAlaP3yKVDI6w>
    <xmx:hRKtX5ifHhRaRY6MCA3MF0jOmkUGr2wG7E4_mcqJ0VscrpF4TGE_Ng>
    <xmx:hRKtXxBI0EATQkW4QdTnReuGX4RjUCz3Dq-ViJja9CYDmkJPx-0HQA>
    <xmx:hhKtX-4FYTHi3RhwlXBqjf3SMCBAaXPrUIzOECFbxIulT-P0m_VIrw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 398113280065;
        Thu, 12 Nov 2020 05:46:29 -0500 (EST)
Date:   Thu, 12 Nov 2020 11:46:27 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     wens@csie.org, tiny.windzz@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as arm sunxi soc maintainer
Message-ID: <20201112104627.sl4finod5ruzhmd3@gilmour.lan>
References: <20201110070002.14546-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qqwtx7xtooylxpe2"
Content-Disposition: inline
In-Reply-To: <20201110070002.14546-1-frank@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qqwtx7xtooylxpe2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 10, 2020 at 03:00:02PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Add myself to sunxi maintainer so the mail can cc me.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Unfortunately, this is not really the process for doing so, and being in
Cc of the patches isn't what a maintainer is about either.

To become a maintainer (if there's already a maintainer team in place)
you usually get asked by the current team to join them. This is what we
did a couple of weeks ago with Jernej for example:
https://lore.kernel.org/linux-arm-kernel/20201009074423.10708-1-maxime@cern=
o.tech/

You would be asked to join the team based on a number of criteria, but
usually that would be because:

  - You've been here long enough that the team knows that it can rely on
    you to stick around for some time;

  - Over that period of time, you've helped maintaining the platform
    already, which means that you've helped solving the current bugs and
    / or issues, done some new development, reviewed a significant
    number of patches, etc.;

  - You're getting quite familiar with the kernel development process;

I guess eventually, we definitely want you involved, but we're not quite
there yet.

Maxime

--qqwtx7xtooylxpe2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX60SgwAKCRDj7w1vZxhR
xaxuAQD1LWtH/OeRU9MtkIAH9fa1p5PWQHyqzsA69ZWrHPTulQEAs79rZnuUd8y4
zthDtdp3jFCOmF9ZcZHFdIXQ7T36Mg0=
=NuVe
-----END PGP SIGNATURE-----

--qqwtx7xtooylxpe2--
