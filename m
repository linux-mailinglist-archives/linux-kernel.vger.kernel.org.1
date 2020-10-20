Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8CA293B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406022AbgJTM1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405865AbgJTM1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:27:34 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE4F22265;
        Tue, 20 Oct 2020 12:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603196854;
        bh=CXwIAOAAiDM5n26S2GQanT1lT++P41Kk26MXto8vtsA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Lv8QJo4kllgitzcw4QMHvECo7YuLc8bhAe98/bkFd9GDbF1oP16qU0qaksQwPFWND
         EGNRlkOqcqxlSDDN6fpK2Rqo8H53qNV+5cvHmthM3D8g+Z9ivmafV8Fmt60cDNWe0W
         xucRUo8S7D/cx/O4VSaoBtpKeMM/xRcP09SlT0o0=
From:   Felipe Balbi <balbi@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/29] usb: dwc3: Discard synopsys,dwc3 compatibility
 string
In-Reply-To: <20201020115959.2658-2-Sergey.Semin@baikalelectronics.ru>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-2-Sergey.Semin@baikalelectronics.ru>
Date:   Tue, 20 Oct 2020 15:27:25 +0300
Message-ID: <877drlf5g2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Serge Semin <Sergey.Semin@baikalelectronics.ru> writes:
> Syonpsys IP cores are supposed to be defined with "snps" vendor-prefix.
> Discard a DW USB3 compatible string with the deprecated prefix seeing
> one isn't used by any dts file anymore.
>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/usb/dwc3/core.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 2eb34c8b4065..28440250e798 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1878,9 +1878,6 @@ static const struct of_device_id of_dwc3_match[] =
=3D {
>  	{
>  		.compatible =3D "snps,dwc3"
>  	},
> -	{
> -		.compatible =3D "synopsys,dwc3"
> -	},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, of_dwc3_match);

sorry, no. You can't guarantee that there isn't a FW in ROM somewhere
using the old string.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+O160RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaY5Q//TC223tVQ0VR9Z/KOGxt6n0fg+EORCbMh
1VYozCtosc94UaPd2jxbtcXwnVYV3VbdlivEMLhcXEzuweS+KFAXtLNJnJwMLTvw
bhV6gfqdixpB+o5rFdq3I+6w1e9AVqnCo/vWTY+1bW5Bq6wRE/7us2KmvkgLeQ6E
e7im3i6zA9m6GdVsgsCF0eRp3m7zk5iRgqtY4FJWgho9+VIkm9kucCg8aVJRVLCO
cpsECo83OrLVd2wORmIOXeAWrRe/0gaSi+BY9rYNXvGYfTgdl0VDc9/06X2myicU
mT6X8Lw3ftGAEfvTKbRi5XboJKZmkawFDcZMOHmrrft0zk5wkd8E9o1JG5F2ZmJt
XeWfXs58/suZ2Squ8D/bvVP1B5mJbu5XNR64hatwy5OlYab0mGHTqViZ9ZKgM5zW
ODg463cnyDo/IDzvq2JNx6seT0AGS+EwJeKvRhNmoJ9PC0y7zC/L7lICNHb3edxQ
nqKqCwMeuXh4q/X5aD5ziP6Ov5jBuuwIrMjN+41LJqYtwNptnZb8ed1SXOH3S+an
ry9oTvSmLCzFUwGb3wtN7sWRsoRvJGsBC45Xw6rcnC6cWk+ce7QgFwKJpc/hrchx
qpfVxogK/iJQcxXzkR01vjzYKH7JlUOUWAjkB7m8dPSJljor5tKuAAqqbEYBr9iR
e23hydvTGoM=
=jEm6
-----END PGP SIGNATURE-----
--=-=-=--
