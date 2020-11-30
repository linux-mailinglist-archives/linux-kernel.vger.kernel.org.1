Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0212A2C867E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgK3OR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:17:59 -0500
Received: from mail.msweet.org ([173.255.209.91]:56382 "EHLO mail.msweet.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgK3OR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:17:58 -0500
Received: from mbp16.lan (unknown [143.131.4.103])
        by mail.msweet.org (Postfix) with ESMTPSA id 0392780691;
        Mon, 30 Nov 2020 14:17:16 +0000 (UTC)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6107053A-E9BC-4591-A376-26450E530539";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Fix default q_len for usb_f_printer gadget driver
From:   Michael Sweet <msweet@msweet.org>
In-Reply-To: <20201030223419.3780-1-msweet@msweet.org>
Date:   Mon, 30 Nov 2020 09:17:15 -0500
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <C4FD0F03-E71F-4234-BF35-8BDFB7898900@msweet.org>
References: <20201030223419.3780-1-msweet@msweet.org>
To:     Felipe Balbi <balbi@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_6107053A-E9BC-4591-A376-26450E530539
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

I submitted this a month ago, and aside from Peter Chen's "reviewed by" =
response I haven't heard anything nor seen it get merged.  I know you =
are all really busy and I don't want to be a pest - is there something =
else I need to do to advance this patch?

Thanks!


> On Oct 30, 2020, at 6:34 PM, Michael R Sweet <msweet@msweet.org> =
wrote:
>=20
> The usb_f_printer gadget driver uses a default q_len value of *0* =
which prevents
> any IO from occurring.  Moreover, once the driver is instantiated it =
is
> impossible to change the q_len value.
>=20
> The following patch uses a default q_len value of 10 which matches the =
legacy
> g_printer gadget driver.  This minimizes the possibility that you end =
up with a
> non-working printer gadget.  It is still possible to set the q_len to =
a
> different value using the configfs path of the same name.
>=20
> Signed-off-by: Michael R Sweet <msweet@msweet.org>
> ---
> drivers/usb/gadget/function/f_printer.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/function/f_printer.c =
b/drivers/usb/gadget/function/f_printer.c
> index 9c7ed2539ff7..4f3161005e4f 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -50,6 +50,8 @@
> #define GET_PORT_STATUS		1
> #define SOFT_RESET		2
>=20
> +#define DEFAULT_Q_LEN		10 /* same as legacy g_printer =
gadget */
> +
> static int major, minors;
> static struct class *usb_gadget_class;
> static DEFINE_IDA(printer_ida);
> @@ -1317,6 +1319,9 @@ static struct usb_function_instance =
*gprinter_alloc_inst(void)
> 	opts->func_inst.free_func_inst =3D gprinter_free_inst;
> 	ret =3D &opts->func_inst;
>=20
> +	/* Make sure q_len is initialized, otherwise the bound device =
can't support read/write! */
> +	opts->q_len =3D DEFAULT_Q_LEN;
> +
> 	mutex_lock(&printer_ida_lock);
>=20
> 	if (ida_is_empty(&printer_ida)) {
> --
> 2.17.1
>=20

________________________
Michael Sweet




--Apple-Mail=_6107053A-E9BC-4591-A376-26450E530539
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAEBCgAdFiEEkIbDzcZsP1Y8+PQFvmfHXsgfMkQFAl/E/usACgkQvmfHXsgf
MkQ+gBAAvktf6PWS+GR7rs/cKwwAi4kVZ5A3VeZdhgg5OOmc07p0QUz08zLl6iOq
ejY1tcikCxaHnLyW20dDewWalIBiFkzY3NW+0AebASaj/awdDTec29TsctXss/yJ
7NUoWwBR2QoHpjMT1FIkrrnxH4mb2QACq4FI3T5ReCsdVutq7ed6sDFs7nJ4/ki6
0Q0QmNzET2ifwOXFdNhCJf1XrtOZdOo/fcViGr9j8eeNaPmxCLsm8CjzdGzBvtgw
kYBu6RqbUINgfPhz2ZthXZrJMuS3gSRQ8L+YWB6hdvmqx3mQH3xXSgZAH9CpaBTy
MvK3JM7Ip38bz8zvTLZEYGZMG7LLS56IpECNn0Ttf4f+uzIX001jWqaDHm4Ks/Lg
LFC1kSygooa+Yd9Lb83fiBXsAUOwQtyicjeeQX+mEhUKfwIxo2tV7Gt9gmRD1GMJ
iy10OqXqTJtOa/4DcaXCOka//oAQPZByCZ0no9EIeUkzXXj8r88s6rcDbjbpUBah
pmhCwcNsEyGmj3Gdlu4CAP2duMuLWKZnMatAWToqPCRf3pPxDwBIFjaIGVv7XEbM
iLFm6sOxCA9ksQbN0JCU2ub4Ux1ZSsigL/QdWyn7wglUUXdbGbUlKr9rS9Dkf3Ig
ZphO/EeVM1TSCWcqQxXv1uWkNamM7DJbOJJ0ct9yEmZF119CF+A=
=B/l8
-----END PGP SIGNATURE-----

--Apple-Mail=_6107053A-E9BC-4591-A376-26450E530539--
