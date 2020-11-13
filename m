Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05A82B1F20
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKMPrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:47:20 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7E0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:47:19 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so10437415wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RzxehcEQi55BLjvHXynEGsq0IfRnICUdVEOd5tjr2p4=;
        b=FFO7hPyarD6uHGcKfnxPDiZmQZvtMUxcZUpVVi5Q0RorTbPt02XCNHuL4toB1VIG1T
         lgJKm75256rQWP4KmFBOPrZWavZPYKb3oD2UGR8cdaMBkY26nqlo8kOvbE1S6QGKabBP
         uSo7H7pK67EUKBcGsbCvyycAMaXkX40COp3EDwceBIkcRlr4M9pT9l9B/+6xZkUnlCh/
         b80/zvUNUCwY0YQakalJqgGzGBjbxZDhixTWFPvYrn/Ok1BgRwuw47mx/j35UTTVk64L
         /8WNSf+U3a+9VtQzOjc/X9g8DdqGVbCREqydfcWZfaMNATJBUvGRWAU/S4rUVP5SI+VJ
         BZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RzxehcEQi55BLjvHXynEGsq0IfRnICUdVEOd5tjr2p4=;
        b=pgvnjPi0bBhfo5CcY5uMZdWC/ZeKOp2ilMZMFn4FGAIhZE74MniYg39ZNx37f6DkR/
         Lci4w+Ae1NqSeXK3zqi20GJ7MP7JinImffvmsrqFqoZorAoT1tHihnxVLu/5ZtkAEZzY
         7+HAuic9OAebVyDfQDVpLChdqBZdVwy0i+P/V6KIskjUs0R66wrrwG9zPQsDrbB0kQMU
         +BJuQ0kQSb37PJtra1X2RH0NITitxO1HKUyBZvfiZT9g6GgldhUx70nSRwZw9Yd2+/mI
         SCCbAq9ygzCb1oOokYtrY18jgbVgN4Av2NIEO2SO8KUPC0xcpKlYc1QbCZCy1JG+/2eC
         vYmg==
X-Gm-Message-State: AOAM533X1SvPc/BcploBKYJZciRXJTlQ7DU/1YplGFJSaZSEo8Pchto0
        CAQr2104onIx8+zGlXKden9e8JJ8gug=
X-Google-Smtp-Source: ABdhPJxBgeQkxAn3IPe18YLHZlaApnJRL42wQAyPKxWTAw9ztQmu+DGgxQWRjZotByWzlW+b9vnyYg==
X-Received: by 2002:adf:de05:: with SMTP id b5mr4185842wrm.131.1605282433602;
        Fri, 13 Nov 2020 07:47:13 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id c2sm10817830wmf.47.2020.11.13.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:47:12 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:47:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] Rename ioremap functions that include request_mem
Message-ID: <20201113154710.GA1408970@ulmo>
References: <20201113070343.lhcsbyvi5baxn3lq@pengutronix.de>
 <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 09:53:25AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> here comes a patch set that implements the suggestion in the previous
> mail so we have something to discuss about.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (2):
>   base: Rename devm_ioremap_resource to make the implicit request_mem
>     explicit
>   platform: Rename devm_platform_ioremap_resource to make the implicit
>     request_mem explicit
>=20
>  .../driver-api/driver-model/devres.rst        |  6 +--
>  drivers/base/platform.c                       | 26 +++++------
>  include/linux/device.h                        | 32 ++++++++++++--
>  include/linux/platform_device.h               | 43 +++++++++++++++++--
>  lib/devres.c                                  | 18 ++++----
>  5 files changed, 93 insertions(+), 32 deletions(-)

To be honest, this is getting a bit eccentric for my taste. Yes,
devm_ioremap_resource() does more than just devm_ioremap(), but that's
why it's called devm_ioremap_resource(). It's a compromise between the
new functionality and practical symbol length.

The kerneldoc for devm_ioremap_resource() is very explicit about what it
does, so I think it's fine to omit some of the details from the symbol
name for the sake of brevity.

Things get out of hand pretty quickly if we start incorporating every
single aspect of what a function does into its name.

Thierry

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+uqnwACgkQ3SOs138+
s6G1KA//RCDKlG5NqIb4+T9VlcMNJNcPgGOrfczLU5KLYmOZq5U2Sf7lyTkAZJvW
e7EE/njspRrRTrI1jXKF2DTND3J7cuKfO+Vv6aJHid0imIQHX6Ve/Hq0dZUB6x3q
Ve0ZVIHqX7DAP4OA8jvTAXD08uwezaSizd58/o0egHb1LFFYcatRehXO0TRnShAs
75WpPLY7EL5S8LwRyWdRYuXj/wTvqagHo4X3GjB5Tb1LhkbXAwnkykQmnbrLO7ih
DdlBZBVDs6wni3aXP6Cdhi6/moG/dUivvV/zcjzyEATxditywfJmO53sVUkd7rDj
W6oE9c9HjdSih089/K/RKj7u684XM4pj3k+0SxVZpie7vcW7+uhCD9Tccry3p+xo
BZd3WZeZ+yH1yDyjpusE3+rkjgi1RlCnnCALw8YaMdTUoUukZuCPwSNIuQjWZndy
iaelWmSc2SPNy82Ehwt3n0zMPbwgbKYxnhLbPRlzpbgxngjfCSxMLHDTJtZhILTa
MMbFNfjgAJ1bl+F5LKN0E2ERpYvP/5Fln+7x4H1H3+S0OA4uSGN9dhAmRC5qv7lq
fwnbiBis5ABeokMz6jY+xvHYGx3baE19hJBygc2FvAJHAiPk1jnX8l+DqAEKki5u
yeX6Uilw383GK2dUcVgyuOYgGjR3Ugt+w3RpJWds7rn2R92uaPQ=
=z0wu
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
