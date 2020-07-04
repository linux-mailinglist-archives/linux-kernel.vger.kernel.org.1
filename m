Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B85F2146B1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGDO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 10:56:36 -0400
Received: from orion.archlinux.org ([88.198.91.70]:55194 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGDO4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:56:35 -0400
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id 30C231D3582743;
        Sat,  4 Jul 2020 14:56:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on orion.archlinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=ALL_TRUSTED=-1,BAYES_00=-1,
        DMARC_FAIL_NONE=0.25,T_DMARC_POLICY_NONE=0.01,T_DMARC_TESTS_FAIL=0.01
        autolearn=no autolearn_force=no version=3.4.4
X-Spam-BL-Results: 
Received: from centaurus (unknown [37.189.45.160])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Sat,  4 Jul 2020 14:56:32 +0000 (UTC)
Message-ID: <72aa9cf8c9bc46548c29742f55be7d3b0c002971.camel@archlinux.org>
Subject: Re: [PATCH v3] HID: logitech-hidpp: add support for Logitech G533
 headset
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
To:     Kamil =?UTF-8?Q?Doma=C5=84ski?= <kamil@domanski.co>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Nestor Lopez Casado <nlopezcasad@logitech.com>
In-Reply-To: <20200704004745.383271-1-kamil@domanski.co>
References: <20200704004745.383271-1-kamil@domanski.co>
Organization: Archlinux
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GdT9r/VywNZa2Mspbe4R"
Date:   Sat, 04 Jul 2020 16:01:43 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.4 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GdT9r/VywNZa2Mspbe4R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-07-04 at 02:47 +0200, Kamil Doma=C5=84ski wrote:
> Changelog:
>   v2:
>   - changed charging status parsing to account for invalid states
>   v3:
>   - rebased against Linux v5.7
>   - changed variable naming in hidpp20_adc_map_status_voltage
>     to camel case
>   - corrected comment styling in hidpp_battery_get_property
>   - dropped usage of test_bit macro in hidpp20_adc_map_status_voltage
>     to avoid using `long` type
>   - added bit flag definitions in hidpp20_adc_map_status_voltage
>=20
> Signed-off-by: Kamil Doma=C5=84ski <kamil@domanski.co>

Seems like my concerns were address and the patch looks correct.

Benjamin, Jiri, are there any implications to keep in mind of always
polling the device every time we need to read the voltage? I don't
expect anything major, I just thought there might something there I
should keep in the back of my mind.=20

Cheers,
Filipe La=C3=ADns

--=-GdT9r/VywNZa2Mspbe4R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl8Amc0ACgkQ+JPGdIFq
qV2UYQ//RszgLx10wEQNOJcwL2CzwReRT3sHGA8Cjx26fCzqvgofQ7lLBgdrdsIM
WgYzFiDY6Q9r9Q+P0ZrUlpvOQES2OnA/7kYY9ViydF+sy4fH8LIUciISzVTsvO7i
YYGRgln5ufeZ3d6McoHvnfjezOYXstGPpcFdGGgCFqk1dmKZ85crDr2Ql9LrbAeB
of8Lv8IzNwZG8J6q2hHmD5KZV4b/XASsWSyR7zKd17A3EPOfE0vC0IvSKWEveegM
pnSau/uC9YvSKAZqCyK/WEmCu3L2GqI9GX0WxAzK5jpoxKfYLDk0l4VJfGPHJgyr
ck1YLhDM8cvQKY/DVkbLrN9dQbcYFDZj6rfOOKxaw+028qrRCJ1I95mvG06wfa2B
Vbf5gAyv1fe5mrZIGuXR2ksSdKFJpebIzwSNwTtbhr9xTkduA7ZyNH8ovJEvyjIo
dl8b7LKuutOh/ssB6/zx7yWOWLxmHpBTGaBvJm0g96+cfufLD81Li6PKLbFTAEDc
yIh9OElKD1JWLdYYucgiMHbplUDzVTBuyZZjs9yOwDZwrFZqqvuKUCrEdQCUS8+1
m+LSDcr473w5i7vsgh4NEAZz8w/9tIfyxOyTaakBBdGJrpP5fBhI5conQWEHCYld
kyYlH/iO5df/7tQWLJqifQE+Hns7WbESReFidcIZEF5ozll4AtI=
=8KEs
-----END PGP SIGNATURE-----

--=-GdT9r/VywNZa2Mspbe4R--
