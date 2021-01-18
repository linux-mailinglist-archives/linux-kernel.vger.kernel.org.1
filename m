Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98622F96C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 01:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbhARApt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 19:45:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:43933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbhARApe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 19:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610930620;
        bh=gXU+pmJAx/Srx89sGelD0TBxqNFf3Vqg7Z0WTiZBIZg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UuggZ2gSOiq6Q/7q/mFGs6GNGwDdoUEiJGGnx18mVldmWwIkVph8oXuUDnv0eVay0
         S1NOR7Ko9hxyEDnjMQDxJDhyRDfYfPtEAFRMYxn9AVT+GhILDDTxDdVaUNqLvju1vb
         O4GSYLnvLYIba7haUm+Tu+s0NLU4DIeuWvN9eDDk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7GM-1lCsPx42DS-00Bd1n; Mon, 18
 Jan 2021 01:43:40 +0100
Date:   Mon, 18 Jan 2021 01:43:38 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     kernel test robot <lkp@intel.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v8 3/7] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <YATZuivr8CzHI5X2@latitude>
References: <20210116194826.3866540-4-j.neuschaefer@gmx.net>
 <202101170941.YsXQPP40-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O7p+jIe6VGt9TJs9"
Content-Disposition: inline
In-Reply-To: <202101170941.YsXQPP40-lkp@intel.com>
X-Provags-ID: V03:K1:vilrVV2DrTSMuMU4gCV0RxBMwhE9ZRDHqGeX8r5tIgBr72m7gTu
 smZENaWlbVxMkD26Wrcxqj3PKal23mw05wgSvkJBRA1EQRtHNSzQOjfplX80/5BBqnSW1Dk
 Sre+gNEKF9I5D9/QOxQN5vC5lu/x3Q4KdGTLvkhG009bwsKlLLD7L8bBajEGjcfAZvNBvzA
 AtP0MCNggJdmhL5IlOIaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HS8mgoXnaBo=:F8okTTyjBAuWVerAgaEBMa
 4GYXoXTAE+ra41Y1iYfOicJthAojKAZ29UuKjIg8Mjol54IEf0T1ddESdve+u9ui9lJJhbZcR
 reY17eA7gy+AaaiNq07E7Ese5sCF7TOitWMLG80x0X3AZ4MkIZ9eYOYx4BRXEAgT+Fl/qUuRH
 opyZSIGJtoCaGr+RsKbecThDvjnzB+qYmvETWqQ8IJEk7lrMvMONvSeV8/uKTZsHsuyJHxQGB
 2QQ8VxIGfS86rNE+G7u0Z3n+zyWlroRmj4c+EaO9l3p99/1uASIuMUMCdiKWne8zabf6IE8H3
 +soCLiVMYw7vzhO0at208r0prrCcCMSIoC3OCj1dEPZ7H1QF0dO1w0Hjn2ihJdGU2vni7eUsj
 hNKSNPDVqifApH7bTP/5+2RVuoc8UyMfq/lL2Zs57aUzgnJj1TI4gPd9KlxsJGlgJTe44W2j+
 tSuH4tv/Xu+0wZzkrX9UqX6kH/VBO4CzD7mIUoMj9DKAtumak9XjrQZBtS0a8CeurxqpEt9nQ
 /ZAdDSJmXFBneXAvaDB6WcOkHaJ5oVOlSVMw9lW6S3E4UW7MPRWFe496S1HJBHmYJjN4I9Blz
 TL1yLtFE9IUJ7YaEJK9/+sLvyKJtHhbBRwWJBeW7lsn0y8vI1RfaADHYFp86JDM4DHezbtrvD
 W9IDx2Pf8lCJ1lm5frpypr/sZYZ/o1wSkRJcZfXKpMGeoAD7Eyx8Xh9riRFMT1cAAvRzrBPGT
 co3dzk/Twa6Knt8mVNi9e95yb/sA2OjTvTBYz34MeXrsszP294S5kU0QMgZOquJbdKCiisiDe
 e9IeJM6Vh0QL2hAJxBPr/QXHvi/EIUEtt5+X6qKx6Xaj3hF9973caEawLdVgZC3YQKjvvN6hA
 3FnYnw3fVDANASXW/7ug==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O7p+jIe6VGt9TJs9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 17, 2021 at 09:22:01AM +0800, kernel test robot wrote:
[...]
> >> drivers/mfd/ntxec.c:127:10: warning: variable 'res' is uninitialized w=
hen used here [-Wuninitialized]
>                    return res;
>                           ^~~
>    drivers/mfd/ntxec.c:116:9: note: initialize the variable 'res' to sile=
nce this warning
>            int res;
>                   ^
>                    =3D 0
>    1 warning generated.
[...]
>    124		ec->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
>    125		if (IS_ERR(ec->regmap)) {
>    126			dev_err(ec->dev, "Failed to set up regmap for device\n");
>  > 127			return res;
>    128		}

Ah well, that's a bug (present since v2 of the patchset). The return
statement should be:

	return PTR_ERR(ec->regmap);


Thanks,
Jonathan Neusch=C3=A4fer

--O7p+jIe6VGt9TJs9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmAE2aEACgkQCDBEmo7z
X9tqRA/+PqlL45s54xWqOzK8lVtozSM3i1ziUswKwZhNr6vvXJbu8BM3gzZclobB
Pt0ek354ANgy27t8oxqxmZP4p6szJ86TzBq1fjxIA5vEEgGfYtM+fgNYGpqJ2kVz
Fixbr7ArXPWMJdINlCB6Bfgu3SU8h+J1ZQTRxX6hwt/+/Y+fGe5vprsLAUWzu599
Ya3BGXb4oHn/bVkuA5DxHGBi1jqXGvH05KnZts10nRqUuLHRIXu/ly4qY6/3FIWH
d/Nwk2l0HNuSjyzjgBTrpkQ4m4O/cPYC19iXIjuZE7JDRbPxLHzCjkNTj8ro1Or2
6U4VekxlBBiXGB71sdGx24loeHRsj8ti5GV9G6gpzl+dCcB6XNnX+cJ3oBtLsILJ
tB0zGhSajykfBlrQRGVgwabqpq4RePeTaWApACmXIAX5ZKnGqAkOk/dYPZsqdovf
MGHTs0ZAVoMVLu2PXYSYa//9u3D2RBSwJ6N0pImy63LShJHtWKZFeOkdeD/Pp3if
HhIp1NlaZpHc4mjJAMBFb3Uc4eYbZ4o2c7s/JNaWlnmI9JIa0IwnZyvJjZzCv/Ap
MSdh0+8812Vjwxj7VEuQffrPr5TOlYyDsAXcD8G5OHhYES0HeiA6PEOLwmkAzwQq
JddKIQNyhoWbWXFqbT7U6cA7q3i1pAVrk4EFk74S1SNaWLPLWSQ=
=c3CB
-----END PGP SIGNATURE-----

--O7p+jIe6VGt9TJs9--
