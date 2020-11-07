Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196822AA47C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgKGLAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 06:00:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:51088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgKGLAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 06:00:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1AD8FABA2;
        Sat,  7 Nov 2020 11:00:13 +0000 (UTC)
Message-ID: <c151dd008c9a28d0a394076df6815718bb636128.camel@suse.de>
Subject: Re: [PATCH] firmware: fix spelling typo of 'wtih'
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Wang Qing <wangqing@vivo.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org
Date:   Sat, 07 Nov 2020 12:00:10 +0100
In-Reply-To: <1604737181-14464-1-git-send-email-wangqing@vivo.com>
References: <1604737181-14464-1-git-send-email-wangqing@vivo.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-f32P5sZ6nmD3Qwz6rHr9"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f32P5sZ6nmD3Qwz6rHr9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-11-07 at 16:19 +0800, Wang Qing wrote:
> wtih -> with
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!

>  drivers/firmware/raspberrypi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberryp=
i.c
> index 2371d08..30259dc
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Defines interfaces for interacting wtih the Raspberry Pi firmware's
> + * Defines interfaces for interacting with the Raspberry Pi firmware's
>   * property channel.
>   *
>   * Copyright =C2=A9 2015 Broadcom


--=-f32P5sZ6nmD3Qwz6rHr9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+mfjoACgkQlfZmHno8
x/5vkwf/aP8qdbMJ0uVs5IQSUeXdBCMNHD6KA68i8mR+dzZ2WTgqv6KGU1esUH3o
wmHCKLYeXIdtvXHTYi5XofWnlmm5WbHpbEpibRZAgQ40DOjQMe3sUfIedSuSnLVa
icszvvHXUwmBsiqesU90ZmKIaEn42ignuxqPq2WfHlNjbJNH5ykAYgCFx1uUvrcC
QcjURlj+kphjNGlk0dT6Kk80JorAzFh8Gq2YPAqFAgm62SWdT+iqx3WN2hVm/9jH
v4p4Crk0jmXKQbJd7tlrQTPRUP5rMv2rwtKPwjdtdLfCkOo2A64+0AQMN49jjVg0
40ZM7nwCQx9JYcujF8SfZFCzSFf5bw==
=VLuK
-----END PGP SIGNATURE-----

--=-f32P5sZ6nmD3Qwz6rHr9--

