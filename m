Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1372B2AA311
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 08:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgKGHmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 02:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgKGHmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 02:42:35 -0500
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D7520704;
        Sat,  7 Nov 2020 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604734954;
        bh=/Nx6GNYibA0Lp1RdYl6hW7mxOH1UmCuCU069gcP3gs4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=yJWvWc/gNpkadD/OBa6LLOUQYL6IcWGLhyGAubhPqCRQpETfryX1TqTXPwCaLL4I2
         bNvFriX3YULOj+h/2cDmF2FEACQZnIMgUwwJ7Z03QCmkwtxTZyeTqCuYeHP2/92A8+
         gXfhw+qaC6jJ+Mcdj2KbxBgSIiLimY4U8GaGM/mU=
From:   Felipe Balbi <balbi@kernel.org>
To:     Lindsey Stanpoor <lindsey.stanpoor@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, heiko@sntech.de,
        cnemo@tutanota.com
Subject: Re: [PATCH v4 1/4] dt-bindings: usb: add rk3328 dwc3 docs
In-Reply-To: <CAEr9=gsH2UhjMO_55FKmGKS0DYrT_-XKf0iwCKCNc93epbiXNw@mail.gmail.com>
References: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
 <CAEr9=gsH2UhjMO_55FKmGKS0DYrT_-XKf0iwCKCNc93epbiXNw@mail.gmail.com>
Date:   Sat, 07 Nov 2020 09:42:26 +0200
Message-ID: <87ft5ly5nh.fsf@kernel.org>
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

Lindsey Stanpoor <lindsey.stanpoor@gmail.com> writes:
> On Wed, Sep 2, 2020 at 11:12 AM <lindsey.stanpoor@gmail.com> wrote:
>>
>> From: Cameron Nemo <cnemo@tutanota.com>
>>
>> Document compatible for dwc3 on the Rockchip rk3328 platform.
>
> Hi all,
>
> Wanted to give this patch submission a gentle ping.
>
> Rob Herring acked the documentation changes, but I have not heard
> anything
> from the USB or Rockchip maintainers. This patchset would facilitate USB3
> support for Rockchip rk3328 devices like the Pine Rock64.
>
> If there is anything I can do to help move this along, please let me know.

Sorry, it had fallen through the cracks. It's now in my testing/next.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+mT+MRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaRDw/+N2up7hCZG55bDPN8oLRW452ZCzSwXD70
l5s+0/0dgPw6mwsSoOH1Xd/tPdtLS5gAgnNCYZzBiiCgFBgeaHKwQQ6vweSKLRRG
BYWVAQuU2dnEZN2lCq29/CilnywKd8Rx05V1UDtoHcVPmioMi3Z8F957s5ggAo+w
6GgrjcI2h42zsm13oqOgBAU92gik5toDEzVjW999/oGOdH+aZFLd5k3GC+nTVlmf
AOwYDiRAHHHcIWfbKOz2ZtpkP31b++y4OcNUzZPgIIp+WO5kNm+BiSjuC60kAAuL
kyC1WOg1uOXRP6IYQp3l90tO8VV3ZHshxxeLssbQ70TMggZacCCl/pg5qR0I8/Gr
G6SM1bpCIhlw9LwTF0rstbvtFUVVWEWQvfmpKaQMlFvi3bcDPbv5Q/94pYvwKemK
ieD+dK0K9ZvNAQe3+CqPqH14tIbNKZ8E/u/CFp+kItL6pUf+iVfd7urFbn+Ye8A3
EU1C3iJEKNiwoDGPWJUB13DlqgyJyn0AC8twRhB1dvqW2B2+GqU7tTfKzYvFDJx4
MAVBSVKmdTUUT6idPFYbo9BvK84tz9EkBcOqYXEKvEL0LgKgbfD6rOKUxcC3p+GV
BKUkhMVmTFGGcRYsYZNytla0ioWJ+Q880PA5pQ1WBoXyHhpw4EC11tjQoEgQLcDs
FcTTx6Jz0S8=
=ZUy6
-----END PGP SIGNATURE-----
--=-=-=--
