Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BC11E7AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgE2KvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 06:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2KvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:51:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32FF12075A;
        Fri, 29 May 2020 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590749483;
        bh=8U5a1MO/z+2ZYlwKk6XRLF8rVuKQjTLWUExCB3LYACU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFWxS1ztgF79SyVpUQemcY9sOvMWx3w6HJQdHEx1bdpMD5OZsd5mn7/PwlwJnJEDG
         frMwXDfE3HEbu80flevuCV7MI9KwVQPmilVIuKv14juyus32XuYXir8hUr2/1Zdmvd
         Ll9nzqBDCb03dLnFfDLWmTcRuBxC0LnfdZ4RcA8I=
Date:   Fri, 29 May 2020 11:51:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound: tlv320adcx140: Fix dt-binding-check
 issue
Message-ID: <20200529105120.GE4610@sirena.org.uk>
References: <20200528144711.18065-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <20200528144711.18065-1-dmurphy@ti.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2020 at 09:47:11AM -0500, Dan Murphy wrote:

> Fix dt-binding-check issue

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Q6ScACgkQJNaLcl1U
h9Al+Qf/QviqRDpXTXjaVEBeM9WTzOiVI+TAiCq5U+WkWU9w/gz3bgkFgNvZzs8R
dK+hJsKzDojpzy/B7rewKyte5BjkUuoOBM+LNCkWn+Qiz9qEJ+XuL1Z+CA5gjUGa
dMtWxHnfgLJb14xcPJLH0BFkRu4aSqvOc7m8v6efre4tXJt7TAV5MaPG0nRHoMM/
9ASsWT2VUmMRpSzeCFGq+azL8NoZJLJpCtmGNSbsrAF5s98TAPibUpVbmvmchDW+
ZubEbXbfnhspEIbzRk/iFvC8SremBRme9Dsga7r3i7VcRRp/HVeU0RGnE/RUPSB+
P88zBO0iQmEjlYXnUZdtBSOdfc2b7w==
=STRG
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
