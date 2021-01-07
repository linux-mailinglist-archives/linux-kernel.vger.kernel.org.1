Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65612ECC90
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAGJSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGJSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:18:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C96E723359;
        Thu,  7 Jan 2021 09:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610011077;
        bh=3b99B5hcU5gcABvFGNkykkTy1Z8xAW3bQryP5TqOALk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dxOltKXYn1KPbS80NeHLDWjIVow9TmpZsbVBzStdwP9f/s3kL4WPYz127yEwn7zbc
         qbnNiB0HaWrUWwrnJSOFmi23MbuOBijhigyxml4SI6z+TQMlViIOmJzXyd6HeASM9o
         Z2aeIq61PcERHpUuiIYXsP+7Z+CBcAfgMEkn0yOmyJE97nuWrfLf6bkZllQtFzHvOc
         UwHrGz2sdpY00GkXMGu5LZ/NeXGi6wEsDeXIIdsTL3/4xnb6tlE1SHzCDORADsiieb
         AXatGAWfBfPgGaV6uHHOHCv/dcOsqjlwOrEfJUH/SjgS2ZY9j8b2rQ16cki8pmuEGn
         Sl4OpJt/7GLPw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Albert Wang <albertccwang@google.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Albert Wang <albertccwang@google.com>
Subject: Re: [PATCH] Revert "usb: gadget: Quieten gadget config message"
In-Reply-To: <20210107090604.299270-1-albertccwang@google.com>
References: <20210107090604.299270-1-albertccwang@google.com>
Date:   Thu, 07 Jan 2021 11:17:50 +0200
Message-ID: <874kjtcdhd.fsf@kernel.org>
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

Albert Wang <albertccwang@google.com> writes:
> This reverts commit 1cbfb8c4f62d667f6b8b3948949737edb92992cccd.
>
> The log of USB enumeration result is a useful log and only occupies
> one line especially when USB3 enumeration failed and then downgrade
> to USB2.
>
> Signed-off-by: Albert Wang <albertccwang@google.com>

you can use dynamic debug to enable it whenever you're testing.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/20b4RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbSjA/+IPADf+9ypDbcBfYFaMSe6pLQWHlSv7zH
/t7xW+ZJQqxoXuRgFpTiOaRxbLBqwnZqDG4/109Ly+KCmV85NUDvKfjG12JsWg05
kP+kQmxNgGcTLuGt9rcVX3fNpZxrzAdWiNhKhYp5yCejwa1/jt1lfQ028Y2pb//C
LCJ2Cy8Bfu6aFsUkfaUizFdsHBJcrHeDBhV+vCCE89nmkN614P2XAiHMU6XWN1Nd
z0eHhdQUlXkyvpAUYniUdwce0UJzpYw3oDU3ULzl9qtfPYslJjI/KLNaEUFsNlLZ
7fEPHs7RHZ92OAvsknCMY28oin+rFjhShFDrabl9oFYHrYlxQ+OhSTfe6SssguBY
7FRHP3pqUOQFkC24dQJY+tp0EhfU9TI77Ml2Jox7aBNrBbzQRJverWXxgGeyKucs
quvBlaG6olBURf4Eo4CV77n3jXW+nouZLHxMXQBn1YOrwH1QoWC6BEl4V6dX1j5B
QH98KKIBfx0+qfF03BCpF3uOj9OHNGLcwuix+eNS02sgnzEcIZwgity/vxL3OV4s
y5UoWf3aK+yThWnc9VSWhhDUVc9MPlwjiNEf/Vu1GoFzIqvG0X1wpQAdSsCpm/YU
x8BDDwhKWfiXNchkjINxGP7l2peJ9Fa/67pZLWPIxqdbeh+iGE1M18fqUqvB32yK
j+WeEnaj/4s=
=wJzN
-----END PGP SIGNATURE-----
--=-=-=--
