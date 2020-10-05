Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78001283750
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgJEOG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgJEOG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:06:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B039205F4;
        Mon,  5 Oct 2020 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601906785;
        bh=dwIWw6fJzGmxGKYpaY7zdG/+D2r5dltoQj5YSmqdnIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9NeXe+ztBp1syWhX1FJIXLwLb4bJJtjcyNA3I5qmXSp6ZuD4vxj0y0eTAPydCdFR
         Qpb6O2ug/41t24YKOyCWXOPnqCXHq1tZGlinYtHZV72fxRJbM8A94V6G093UCFKGyh
         A8bmJAtwgdNYVTIPbxaQ8mJCQU3Lo7L1TUoIIWj4=
Date:   Mon, 5 Oct 2020 15:05:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        dmurphy@ti.com, robh@kernel.org, grandmaster@al2klimov.de,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix a typo in a comment
Message-ID: <20201005140522.GA41489@sirena.org.uk>
References: <20201002192801.639743-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20201002192801.639743-1-christophe.jaillet@wanadoo.fr>
X-Cookie: Boy!  Eucalyptus!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 02, 2020 at 09:28:01PM +0200, Christophe JAILLET wrote:
> It is likely that this header file is about the TLV320ADCX140. (0 and 4
> swapped)
> While at it fix a missing "H" in a comment related to the include guard.

This doesn't apply against current code, please check and resend.

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl97KCEACgkQJNaLcl1U
h9CGuwf/bKRzx1tM8jnFK/J44PLpsS60wfI4/IYRkDXuLb7hmOjm2pLHMZfLuuXn
6nn/D4KVMG7cQ1E1l+UcOcKnL2LhczJeE1Sf6ao9js3GVfcdoqkyRp6T3qNUV5Xd
UxCDXEsfp+B0YPfwOVJ6qNwmMmHsAQQFZAQLpYeIUh7lMypaNf4iklVJAFezca2f
EcghVIUqpAbYhdKXfJxBUOb06L8lASeVdaS5SRlSH3W5GdxT46Y1BjgHxMQeLzp+
Rx1V7zrJisAscleY+Ezik8LvgwxxDrDXiODueB8UXwKE6Obvfogn/g12AWDTOM4A
Iu+c+zVZu64EA05H6Rhvk8tGsPaAiw==
=fZhr
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
