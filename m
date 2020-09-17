Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09F926D9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIQLSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:18:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:59357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgIQLOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600341154;
        bh=kcQG8LFPG8ZdF1tJX2ReXp1ymOvCchPakQITfwi7wsY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Y0CyJcHBMRDPMPuX2PKnhSpyKPj4vGhFGJ+VXcwYhVPuQ5oyd7yqAuZCtkU41/hae
         6Ip6g4mVwIrPw74TfScGTnbkv9/cMZ8kWE5gdpiTL46+DK+TV6U+dnqCn489H/LdH/
         4jNX6TF+U3V/rfQdj3wusmUzKck9X6Yx65BtCnGQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1kuPW53Tk8-00bYPT; Thu, 17
 Sep 2020 13:12:33 +0200
Date:   Thu, 17 Sep 2020 13:12:27 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: mfd: Add binding for Netronix's
 embedded controller
Message-ID: <20200917111227.GG3306@latitude>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-3-j.neuschaefer@gmx.net>
 <20200915005034.GA593718@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <20200915005034.GA593718@bogus>
X-Provags-ID: V03:K1:ev2u5S77GN0uZkDCjBOntRbHT8/sSZ8XUQEayhtkySNmP8+bRfn
 aDiBBQGrJse0BLqsSGvKr5UIq13EnWQMgp3+BrzC0A6nE5NV93CereLlHSYFWSaxwAWVTff
 3u5cMb9C+fDculSIeXHokBZWKitnyLBgvzrskB5K4vJFJUaxMpF6MqCdAS/wpHr5Ejecq63
 WXGDMG79gAVqrYk1oO96Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:liIOoiwsTjw=:tSEH9I+n+vpcI2O3j0hCq9
 UPjvcynyUjS9hC+G3dilzmXhSSfPTl5WhvRbor8J3nZ8Qk94VYQt2XJmfnceeXlpuaG/ECccS
 ujfZZJKX79LPZVlWrKc5JQcQS9rhdW5UXivYsiR8dxM5KSmq405PuSHmRc/m2D9qXKOWpyd0S
 BxK3BWPWXF8SyCYc9J8kCLzdGD5w+JbPRjG0TuugpUNz7Yr2ltVHO7rnfyhKFNe8Zx6An8mhU
 I3AOt3nAO27M9pX0caK0SYWiHFTxe/5zMIXbjsz789k7OvVKzL/B3+NmgQjW/MEI8QQO0Xwbk
 oNDSTPGp/MceKhhoPR+QI/dR3ymlHS3sm9iaoPXDUWskgYJJBFag2vc8ak3wOe8a+bDDnXfjU
 8gzABgtupdNSokcPRWPFjvXWIVqPK0AmIgNSaADdNm5NHLBhirtIswaQdYQVAcX/WPSXVQNRw
 aGLVD+7C5M1UFSpLL/NnrtSH3HEELKYoAnG1vFt7raFuOKnG4GIqG9jLv3V4z8iZ6XKlqvL79
 FklIGS7VQLYonQsWHXfkaRmawzazgkEIU2kPfN1qXPR5do14uXOfa82Y/I5YA29gLX6Um43Wl
 9azqYltFFGEniSzq3rPn2tbS5xG4r9R4xuCpxS/uOdKzBo+w6wt5+RuZWi7e6Q4aqyZteQ2x6
 6asJM8jCZRUY4emZW45AhWkakG/2HqqdA2p4cIjZtlRndxAbmeFFuBbgidNWK3Xi1jacYjDJ/
 oX/CEFOpAWQKwFdQ7F5+FsRTfC44apPX5uThCQaC+YRnHQazVF0u9ozOkyCF0VjdOngBzMMMU
 ZC92TlWkLXMxXoBZ2vvw4ZgGKUcbljxW/8IpArX/VotzF39MoC3YxHr2uSbw16Ib+cpd2gCLx
 ekcUo5wu2v06RK1Rmm4vdAJyB6X5enAm/2kf0+MqLZ27k/OKtHU9hViJsHL1EpE8A4OYBzQXz
 Cpa6gmBY6q1ZYUBZfAYUkxUEJC5yjIaFQm4cuuBGUoRRb2BO9DI+XWvXRpeO1PQKjoY3jee4E
 QpCDvgTxT5LcyCFNMIvVIhX0hYO2HJ6qGE+xZWuv5Poei2qIaOsHdpdFJN4aUBer3srIh4lUG
 iIggwF+KnRBWfuHwzwDsB5Kixc1lO8rhXXIGQL9+HHdbXRdEAxdAfEPLJeRJOe5SArAFbDVpr
 sDXuZbG0zlYry8Y2ZbYmEdCTBZqmbHxOfKjCgSgq38mvZmzW6ZJlwc6pKzbhmg9MixceuNS2Y
 0oylYwMhH9NgAmRcHQFa9ew+azH3xJSPEZgT6Ow==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 06:50:34PM -0600, Rob Herring wrote:
> On Sat, Sep 05, 2020 at 03:32:22PM +0200, Jonathan Neusch=C3=A4fer wrote:
> > This EC is found in e-book readers of multiple brands (e.g. Kobo,
> > Tolino), and is typically implemented as a TI MSP430 microcontroller.
[...]

> > +required:
> > +  - compatible
> > +  - reg
>=20
> additionalProperties: false

Ok, I'll add that.

> > +                    interrupt-controller;
> > +                    #interrupt-cells =3D <1>;
>=20
> These need to be documented too.

Interrupt support is something I haven't really worked out yet for this
(set of) binding(s). My idea here was to have the embedded-controller
node act as an interrupt controller, and the subnodes use specific
interrupts that are relevant for their functionality.

I think I'll rather omit the interrupt-controller and #interrupt-cells
properties now, and add them later if they become necessary. If the pwm
and rtc nodes are merged into the main node, I don't think they will
become necessary.


Thanks,
Jonathan Neusch=C3=A4fer

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9jRJQACgkQCDBEmo7z
X9u8KRAAq5gEP5j/6Hqan0bWxs+pnmxfLfJWotg/zYwxGSXKbNeJs5wWVQ1A+Pni
DZFAl1Ai4HcClf/OEA4dU4goQrfPUwunWBXZtzRWtjyssikgRn/Ppkt/Xw8p1zZ/
xxJqR4GD1N3jaP8G1/w8TbTLNSCXuYXh3mV8bfM8PHvBf8R5rGqDLeCP2qdUQKNu
LrO7CNsUNwBwbT+/9H8i9/DLuZCiiFk3RrY9/hTS2dkIYuuJUWnzjB7TLapSNvAS
hN/58HFgjheT7YpmicfOCyGjPCV2o407QDsQN4sEiFn83dk/E1Uz9kizLuvPzzF3
ZUbmlWSGpejZWHM9RBPf9ZRwDtQFu7h7vutQ9U+2Drk+jpVD72fOgBCraAq7wndy
riFBUSvFm+jtFjZ7Z597JuMMuU1pUYv7lUxt/0D0svNGq/tTMU8mYZAxKq9XAvOb
uA9bMxXUjj/wIMK444K8gBtmMZnK/XZhUiqffKm0xuiEUzKPJIVok/5sTLroil10
vNzVBrjQb3fO/sKeB5jLbr7QJ426aYHF+nI1mGC44FM0LiAo3F/+B4VwGgDhhRAh
zrRVgrXDe/YO+yjR1+1E1NmU0CZ6C2dbdLJr3mf+T7RxHsmZ99JCZb9TFSThGP6U
gKdiSgi+T11HDeQXw559Uhf+mLivOh+20AAj+RSOg+F2NDYQS/Y=
=Luic
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
