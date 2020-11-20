Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372402BA677
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgKTJoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:44:46 -0500
Received: from www.zeus03.de ([194.117.254.33]:58136 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgKTJop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=8Twhw8N2/x1rWRtqq1j1hIZiT6gO
        57ge+7Zy+bk5zbc=; b=00gsGl7sgjMQzEX9gErboy7zZiyPqxihtZ7dgAWTmeVI
        5hVrK3c8RnAhrNRz2x0IlNPGvQ2Ch3cnV7nCsHcRmuvQkYCDjKy6IoVoE6g2uLFi
        cDBghC09BCZfWtSPlFB9R1q3u8bS/WjUubMLz39cAAnHvzBh1rQlny/VNpB66Ec=
Received: (qmail 1413809 invoked from network); 20 Nov 2020 10:44:43 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Nov 2020 10:44:43 +0100
X-UD-Smtp-Session: l3s3148p1@SVmysYa0NtggAwDPXwi7AEBAgYxIRHZX
Date:   Fri, 20 Nov 2020 10:44:42 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mmc: tmio: do not print real IOMEM pointer
Message-ID: <20201120094442.GA2353@ninjato>
References: <20201116164252.44078-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20201116164252.44078-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 05:42:52PM +0100, Krzysztof Kozlowski wrote:
> Printing kernel pointers is discouraged because they might leak kernel
> memory layout.  This fixes smatch warning:
>=20
>     drivers/mmc/host/tmio_mmc.c:177 tmio_mmc_probe() warn: argument 3 to =
%08lx specifier is cast from pointer
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl+3kAYACgkQFA3kzBSg
KbZ3BA/9Ge4QmT0WWRGO4YzgxY1scUkUeySGQRe1BhY5PpqAocL3IWdM/PRfY4vZ
RUz2blttOZYrcC20XGD1nbEk/VeFv1obk5huYZLeBgEIMyoKInDXcSe550+PU+Wc
bRCthO4B8PRVK7qWGsiU4EqF1ojq7n+tzm2JP5DFtKJhxVPon3R1BbX6+mJInEM9
BkGzafdOOkNuShpbCw3wbuNyVZLEQPXjYN+MnXYXzER+Yb/ZChv6yJumrjl0QLOW
5RTsOiqXYwaWtxJZAyOqVRYp7vL7pOzp/Urs64iwx1L9U5oLO8AN5wBXLwgMzX9n
4yRlbbuhchao0cjHWWg6MvDzKCjeyW0HGns8cf7p4koEV/LucQxhf0n+BdUG0GVX
FzNTCZiLABHRQ+Wv0yJ9qPAwpp+x2zdlEnualKMrjSxgY6snUk2bDBjzdoBAQ45J
V/oBuhMJSfWe9ze1PXPabvXpU1NrUt6tM4xxI6KqKoPzZ6qkPMVcPIebjRh+uvrv
lV95aNPBIJKIPgJTE6yGx5BYmnSeXbgusuuTYvFsMMHsO0Fk0krd7Fc2SWnbJW77
2+bomUERBZMN07ckyTLV7IAAoMcoYIHY/zrlgyOYttvxBE+rqQ7THXEYiOn+jtUz
EbHhKSMWWOkDG49uVv0lkopfpzG0BcnFBWzrd+E+4PggPIjC9jw=
=pmSN
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
