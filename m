Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD8B27C273
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgI2Kdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI2Kdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:33:32 -0400
Received: from saruman (91-155-214-30.elisa-laajakaista.fi [91.155.214.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DE6F207C4;
        Tue, 29 Sep 2020 10:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601375612;
        bh=bAPtax7RD0CoQ/R2rcD84KgfgLQp5cy751IU25Gs3Ko=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GkV7lnovyXkbNt1b4tRVfvV2m/7Vnokv9MrDEeOfOSERhAPp1pmSIvLy0BaBwQzWj
         3hqCqroFfh5JtdUYNuKelzxVL5HcFaiPpwxFPmS7/WV4VLz/B2M2pfK3WdBxtWT+g8
         o0YhdAdYWFVMf93ZzdRgrc6XrAWUVEJ9GLw8ofxM=
From:   Felipe Balbi <balbi@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        kishon@ti.com, martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/5] usb: dwc-meson-g12a: Add support for USB on S400
 board
In-Reply-To: <5e69947c-8a91-af7f-ed86-996920109e79@baylibre.com>
References: <20200917065949.3476-1-narmstrong@baylibre.com>
 <5e69947c-8a91-af7f-ed86-996920109e79@baylibre.com>
Date:   Tue, 29 Sep 2020 13:33:24 +0300
Message-ID: <87eemkan4b.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Neil Armstrong <narmstrong@baylibre.com> writes:

> Hi Felipe,
>
> Is there anything to change in this serie ?

I've been waiting for Kishon's review of drivers/phy parts. I can take
the rest, but without Kishon's ack, drivers/phy will be left out.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9zDXQRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZXiw//chxtvTjBs+jiNPt7tUMjifjIDCHu21fs
u7W2cgENV+fMPM8LHPnWYHqIKR1vb3UtxapUdmDJ3oZKncXUU3KWgJBh50Ge9pCP
JoGi3HTyz9RX/Rixq0RvCAqHOJaUIcckSiWs0R9XVdjUK6fGIeMOULYkMXxBv0ZV
2acywkHbL2/3tEzjo5SyYZymkDF2VtitAqyjo4l5E6QuKG74BiycpFumP7zv5gTp
hbXfNgJ1i0/jkrr7GrMuW5UN2D1q8IDFEl20SICrT4t2+WkN6MpTyio9Hd13xP5w
v3QVP4wi2tmn2KB+Ws5urK8ei8B4mJ/qL0RU7ayg1DCs/YrYYBJZOd3t2xLbewCD
YTnLmmbQglU4MzyV1Ksagiu96jgz015M9qNVvsPQJd+OuLPkj4M3Tgj7lpnBI0gX
3JBf/ckeBrxp6+Z9hUFcxl2Snmi7kyIlwdW9RgTkaZRzVGWZxqsibrOhQooh7lnL
gsh7u7x6yDq4V0XjrcbADfOiRh7STgCaNCiUl37RY/XNijYMBpe4I46QBH0M0O4Q
IP7mYZes99dpVNoW/1PWHbU0lAQkk2rCHCzfctK2Hme3E4btfhdE6VDt19m2+rPL
miLW3nnu6EklacrOOSGxlIu4aldQek5d2OoanvScM8by5lzwsUN2i23BQNkmqvgk
km83ncYBpHQ=
=0oUh
-----END PGP SIGNATURE-----
--=-=-=--
