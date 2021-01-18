Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0472F9F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391478AbhARMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:24:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391463AbhARMXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:23:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C7DB2065E;
        Mon, 18 Jan 2021 12:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610972577;
        bh=fF4wtqQGQ2Oe/6iqTOjeEP/+CSVc/k3JPe+jPgdiYZQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ar035qCvQMyBju8zFR/+3aDLKPcaM9RA81lnEyPn5cg+h8+B9y+e2CuyCXTVtb1ns
         DGHqqy9wxa5u0IaGXJgYQA1CqGY+dckYCBLrhyfTZsibxJxxPt70Z1/FDNSBwIvB5X
         Hs2k49nngppxx+nRrqSoKzgZqAAWH6I8VqWXdd5ZH6rtmdO8PUr3DtuQbqd1gErBpw
         X1SwKc+plhlWKbURMEyRgIlss4Tc3WD8JH1x+I5QMZfjRAy4b7b+1av2Xa9jzKOVen
         3oTZt0fVVQpDMbDrm7tNcRsYFqVxFm5J44h1Hsn6A1AMtMp2RLP8WUHZKGJUgppXXo
         8eh2fAaySYNiQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-usb@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: Re: [PATCH] usb: bdc: Remove the BDC PCI driver
In-Reply-To: <YAVy3KKu7n522aUU@kroah.com>
References: <20210115213142.35003-1-alcooperx@gmail.com>
 <878s8qwkgz.fsf@kernel.org> <YAVy3KKu7n522aUU@kroah.com>
Date:   Mon, 18 Jan 2021 14:22:49 +0200
Message-ID: <87wnwav3hi.fsf@kernel.org>
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

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> Al Cooper <alcooperx@gmail.com> writes:
>> > The BDC PCI driver was only used for design verification with
>> > an PCI/FPGA board. The board no longer exists and is not in use
>> > anywhere. All instances of this core now exist as a memory mapped
>> > device on the platform bus.
>> >
>> > NOTE: This only removes the PCI driver and does not remove the
>> > platform driver.
>> >
>> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
>>=20
>> It sounds like it could be used for pre-silicon verification of newer
>> Core Releases, much like Synopsys still uses the HAPS (with mainline
>> linux, mind you) for silicon validation.
>>=20
>> Why would we delete this small shim if it *could* still be useful?
>
> It ends up conflicting with the PCI id of a device that is actually in
> the wild (a camera on Apple laptops).  So it's good to drop this driver
> so the wrong driver doesn't get constantly bound to the wrong device.

I see. Oh well...

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmAFfZkRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQavQBAA1MhmHql36rIsV2AInQNInIzr80zE6/75
uXso+pSgN7F5FnIhy+OGsCMim/pvrmsEYTyflB3eP8bMlclD2he7QBOEBJkRPQJ4
J22LWXPoyiP1OIuxzfenec1BJMFnA88gf6NQkE7NU4HIbZkVjz8vH1l2s+Qrhou4
CNPx4oDEc56nlAxHdWZhMjAhsiRPbf1ro4ocOeM0HoCP3jkk7xsOvAV+2iRbfbAF
tliO2Pp0ygjTZg4Q0iF7G77NhpTKYd2jlwYYOQAS6K5WaFj+GLVoimlalBePx877
3jfAlRUQj0QYDpbLXkohgRNcwyIUu2BUmhj2HUc4ULZIGpLLl9yy8LqowPo3BkLJ
uFDhlTJ/Gn6VlUpY4svIxDZhYgQ2lm3FIFT0k5s7V/NwegCE+hoKlmBEuv1mHTYI
Jh34G88ycIjO9MrFCNw7JDLB8SY4ajhI43/G5NMpDyoJF7z1wdftHs5NlBaHupd+
qaO/uDCSxxMb7eqZqgJws7YwGbjHBhyETezJjZMX8Xf7Ps6UJq++nNd+L/DAJ1iU
TaZnKx64ydb2BEQVOe1wiaBO+LU8CamWWaobRPSfym3rCoZoHr+1GknPceJdZXn4
DKkkX+PhO+zUDAe8NKnOp4Kf5ZQncny55QDj5nS8rzoczGlQNpovV1qYuiLLuql7
kHEOzNv2+yk=
=4Bh8
-----END PGP SIGNATURE-----
--=-=-=--
