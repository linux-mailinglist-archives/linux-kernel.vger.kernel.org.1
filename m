Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83139278DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgIYQSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbgIYQSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:18:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E47B32076B;
        Fri, 25 Sep 2020 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601050711;
        bh=pARXzuQweWzMGyLglB+Cl1uA4InYoHIq2Zz9Hovb3XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCbvTnIJ434Xjb01nThujbP9Fzc2PhllL/uHmfxCbcAl+ceWtDjlIbIYQvy9NN6K0
         ZBBcRYoe3eszWUxlsqe4AJOq4aEEcbkiSw9+7tXZR2KrDh94O+ifThsCoStdxRPx0U
         BpYR4fjCFjKTeWEHiAexquW9xlOhGtF+G2rEgn2c=
Date:   Fri, 25 Sep 2020 17:17:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] ASoC: qdsp6: Drop of_match_ptr to fix
 -Wunused-const-variable
Message-ID: <20200925161736.GE4841@sirena.org.uk>
References: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
 <20200925084925.26926-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline
In-Reply-To: <20200925084925.26926-2-srinivas.kandagatla@linaro.org>
X-Cookie: Onward through the fog.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2020 at 09:49:24AM +0100, Srinivas Kandagatla wrote:
> The of_device_id is included unconditionally by of.h header and used
> in the driver as well.  Remove of_match_ptr to fix W=1 compile test
> warning with !CONFIG_OF:

It's better to fix this by adding #ifdefs around the table so that we
don't have unneeded bloat from the match table in !OF cases.

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9uGB8ACgkQJNaLcl1U
h9D5mQf7BN4ggDuq0D7tgkLzPkFtKb1QByqki2VZPAvHhk9BfXQvZze88i1f4v9m
PJUnVApRXyrSeBEnbVE84U6c0YlBjqLtfcuPB1k4OJNHfC/HYmRhDcxYs3UzOfkE
42e2sLaxZCEtywxU1KI8C0ZA6v88A9UTKarqQ6UoMuR3fK6zvypAtcYQgFMYLd9Z
CESA+BxYeR52+mZNzjGe4YWvs7L94N2KsoZgXe/Ti1K0IPgmjHdx18wDf8LsFbCt
Q4/mbKDCubywsQzha9IGILFbPByAnjceD2qtptSYWl8mrcrMz+be0KGhyGzUDnyD
N94QdvaIZYVuH+t+AiD+ziRSFsbkWw==
=+N7A
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
