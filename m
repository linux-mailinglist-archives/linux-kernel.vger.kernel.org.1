Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863852CD8CE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgLCORY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgLCORX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:17:23 -0500
Date:   Thu, 3 Dec 2020 14:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607005002;
        bh=Am5sbBz9KPVG5MJ0WkDwJtWFkBJn0CKcgacbVrvpQ3U=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=vNoaOP5AdzJgImDXDeReUz/gm66N6yorUAIobrWlCPrLyb6N3z385NZlWMUkdO59A
         hqMVK9UPOX9zSQl+m8Za1bS2+fHHHQdB2Y1Uq+44rbm0A1V0tHPlhEz2aYXfNQUmuf
         pLqIUBCS6RsU9B5QAgBpQZYB1gK8V01TbXw83dpoZU4RGs2/8AjiX6AfNKt7/hWA8+
         THM1whWLG35/4kpFR2QTTI7V3n9JfFes6sVRqH1pDsmghdlrwVGGHxJuPb6rbyF1Uy
         zbGZdfyi8XdRriLJmIEeCB2Z3ExLZFotdu7FuEPJtcIoc/5XXJsEQLcdnyBzR/3CoD
         bV1oear1lgChw==
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] amba: Make the remove callback return void
Message-ID: <20201203141639.GE4700@sirena.org.uk>
References: <20201124133139.3072124-1-uwe@kleine-koenig.org>
 <20201124133139.3072124-5-uwe@kleine-koenig.org>
 <20201203130141.ys2s7aaltyzkdena@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
In-Reply-To: <20201203130141.ys2s7aaltyzkdena@pengutronix.de>
X-Cookie: Sacred cows make great hamburgers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 02:01:41PM +0100, Uwe Kleine-K=F6nig wrote:

> I failed to Cc: the relevant maintainers before, so that's why I'm
> adressing you now. The idea is to let this series (completely available at
> https://lore.kernel.org/linux-arm-kernel/20201124133139.3072124-1-uwe@kle=
ine-koenig.org/)
> go in via Russell King's tree, so an Ack from you would be great. If you
> want the original in your mailbox, just tell me and I can send you a
> bounce (or use b4 on the above link).

Acked-by: Mark Brown <broonie@kernel.org>

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/I80cACgkQJNaLcl1U
h9CrSQf/awjDJbheVIix40ZpETUQKCiP/OzUfSuoEFpMfgIXxai/kpNgXv7PA+GI
JgvioQBGfkMhXuY7tkxdi6eXRlKVrhTuLsOAErzqbjCbl/zYEvU6McFH+K7E+hFt
AFb1M7liK50Der5DAlOGTruPxw3DfyMWGWoXd/SWlRN3Vra5RAkKuPWTHyysC+ES
AZkOwwKrRsJvjbDDw7KLV4bKBq6RoG0huNO3H9seBALjLKiOqhOca0/W3GLhV/ib
YRgaGeaVj1AlMPoEOZCk38lTPmKqBkNaDLpC10fWYX+VkslK2aLKeiQ0f3jevRE8
UagXLbti6vei8lgjFigh+Gz9o11vtA==
=962Y
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
