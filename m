Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A789A27BD02
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgI2GVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI2GVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:21:33 -0400
Received: from saruman (91-155-214-30.elisa-laajakaista.fi [91.155.214.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B71E20BED;
        Tue, 29 Sep 2020 06:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601360492;
        bh=dnqbDMCRs84eTHz5elPvtLuyKRU7ZTZKZvZADL2pPH8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hWroEyfWj9Yc2joeUSG7hgz8U+CHLD+pt3IWHBMy8QwSvcoG3EJF391iNm9LIYLjs
         C1STzMJO+GtvRVwb/e507InQghxe9tI/wSPk90xYNqvuJXpLwdlgg6kbF9Wrlp3jN1
         F3nh9lU5dejfLk7Utnv2ZS/ZkPgRE056Tg/CODGU=
From:   Felipe Balbi <balbi@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: document a new quirk for dwc3
In-Reply-To: <20200929080923.2a365748@coco.lan>
References: <cover.1599549364.git.mchehab+huawei@kernel.org>
 <cb821a8b5ef2d44ce32c8ce1d01c34b7afb70eb2.1599549364.git.mchehab+huawei@kernel.org>
 <20200915163814.GA2084568@bogus> <20200917091821.0de18caa@coco.lan>
 <CAL_JsqLucKWwgBVAoyXpm1mCD5-OvFj2pM_q2+tcyA+K9fCnKg@mail.gmail.com>
 <20200929080923.2a365748@coco.lan>
Date:   Tue, 29 Sep 2020 09:21:24 +0300
Message-ID: <87pn659k7v.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Ping.
>
> Felipe,
>
> Em Thu, 17 Sep 2020 08:47:48 -0600
> Rob Herring <robh@kernel.org> escreveu:
>
>> On Thu, Sep 17, 2020 at 1:18 AM Mauro Carvalho Chehab
>> <mchehab+huawei@kernel.org> wrote:
>> >
>
>> > IMO, adding a new quirk is cleaner, and adopts the same solution
>> > that it is currently used by other drivers with Designware IP.=20=20
>>=20
>> We already have a bunch of quirk properties. What's one more, sigh. So
>> if that's what you want, fine.
>>=20
>> Rob
>
> It sounds that this is the last piece for us to have everything
> needed at the drivers in order to provide upstream support for
> the Hikey 970 USB hub.
>
> Could you please merge it?

Pushed to testing/next. I'll send a pull request to Greg this week,
unless something goes terribly wrong on linux-next

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9y0mQRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZR/g/6A/awS1ucwGO2YXjX09+rNM5M8NTvj65D
NjsVi4GdO4vN1iy4jv7PhCd8MxSTAnqTn/c9Zm65zw875VvY9GFEtLXEcwMell8W
IRNz38FLbaGED16qy4uyKEJDWLJS9/LmDXE8Ssof/VKF9rwD5ZEAds05mEz1IDZv
ccgWY8dNnN2bNDLI9TblHHsqJmGJKUrGNuDxoCRURR3Bqg8pVZ4r64O/8PxnrCEc
OWtgX9sVOrLz9QIXWTu1at5BlnBK8LW+jYA2Bmb8yy7CmUTFNByrbQ+AdfIZoNMw
O1yveWGWfAsU454cF42bJNuN580rANCNcXQEy/tRdAZTKNvh/gohZ32gyYoHsXFm
eiC4O5AYVqp3vRr0C7JHByZyzh64msFyBmr3N3d15sH431amNKDZ5O5tXJhK9sKB
PzzxDyNYlrTK1fNs4ny998Wx9qONolpvEqFvLUwiyYM4n2P0OBew+H/q+3Ktn+b7
qjIb64a1WfSwXglPcYDmM7GSFw2LuVpMmya2AzSPJyTbTwFHcWHw869/gQYlFtvM
Ex4O3suwNl/SRoYXu2ekA1bmjQTuphbi+AWlxQ8yYgeFNRHo2e+E3iYMu/we54gb
Y49wUh6xJpOZCqfN23m3fbdurAz1R+FVspj7QPzk2Gt/GbrNC6EpaZgOjskrdNv+
d6ZsJowIemE=
=KOoM
-----END PGP SIGNATURE-----
--=-=-=--
