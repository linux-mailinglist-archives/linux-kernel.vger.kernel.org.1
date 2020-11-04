Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0932A6B7D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgKDRPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKDRPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:15:44 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B485AC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 09:15:44 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id x13so17107990pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lk/HrSMIZX3aKPNkAvIgNfAeyzd/NHPhyM+CmNZRy7M=;
        b=Ju02v3ZOa0AHq4VGS7HHGn/ovGzrRVmYfqZEwXoRorqPIZcadgQOhD5fxyfTZ1caTn
         c5Vczrc27vhUMZDgmv9iwBg2HK6prGLQe9ylTgvjMAsN8SDJjtEsLhoGwjekOfhKw8Pe
         IbvYkZCXiQOu/1AneyQe8WnFWBZmQbQa/DdnwfOno0EL902mIoLtDSICWnfDvmTCV806
         RNmjFZaxAITlnF+Gj8qtLjyX4atorvV4ctEC2QXZgtb9oJm8M/zQz1yKKOUPDxNwvI5E
         dknhwgnoU5buAoKiqf06f5t+k/V1k1IT+HXO6v3gAZ74mGZSWSyG7uXOfOX4/v0m8xXH
         UGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lk/HrSMIZX3aKPNkAvIgNfAeyzd/NHPhyM+CmNZRy7M=;
        b=TJWZ5bkQmGT23avRwlYwridLI7Lohg1AatOUM2r4H43FcSSBdiky3W48EEBOOOgxiq
         mvaGmwa4jpRV6Iti+7tBqt0tmeETRLbGGVebxmgw+woOR/unjXU4oTYDKTB5ltSkqWUN
         SydCvt+wZbfdhpY/OR8yKBv4VKwcZIHH3yCkz39BCvyH2bTrWLLEXGJDeeDm8eyxXbTV
         YQdxzOVBqysHdI6TPjoie7b33mMdKjDHEUYLcs8iTXASuR868D+eyKBqrYSfiuEQaNFV
         recKApusM55Z1lAMMDP+EIZHxezzP/OpRaJkGGDG0oTPD8Sw42pH7u5Nejf9bfwVRISE
         0zGQ==
X-Gm-Message-State: AOAM533elepu2tfo4yjxvNOKN8FTeIcjNkulNzSY/qz1YH+UVh7wtAsf
        q1pJjMjJIv+zA7r+2dwOAwp80g==
X-Google-Smtp-Source: ABdhPJxmaD4FIvPAw4Fj3d+8JikUWkk+ja8IQK41iY49zkwv654b3sputJv13vT6xmYlOcE6AgCwvQ==
X-Received: by 2002:a65:5c4c:: with SMTP id v12mr22735335pgr.119.1604510143944;
        Wed, 04 Nov 2020 09:15:43 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4a0f:cfff:fe66:e92e])
        by smtp.gmail.com with ESMTPSA id gc17sm2732147pjb.47.2020.11.04.09.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:15:42 -0800 (PST)
Date:   Wed, 4 Nov 2020 09:15:36 -0800
From:   Benson Leung <bleung@google.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 07/20] input: keyboard: cros_ec_keyb: Struct headers
 should start with 'struct <name>'
Message-ID: <20201104171536.GB2322691@google.com>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
 <20201104162427.2984742-8-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20201104162427.2984742-8-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Wed, Nov 04, 2020 at 04:24:14PM +0000, Lee Jones wrote:
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/input/keyboard/cros_ec_keyb.c:72: warning: cannot understand fun=
ction prototype: 'struct cros_ec_bs_map '
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboa=
rd/cros_ec_keyb.c
> index 15d17c7170816..fce0c839e1430 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -58,10 +58,9 @@ struct cros_ec_keyb {
>  	struct notifier_block notifier;
>  };
> =20
> -
>  /**
> - * cros_ec_bs_map - Struct mapping Linux keycodes to EC button/switch bi=
tmap
> - * #defines
> + * struct cros_ec_bs_map - Struct mapping Linux keycodes to EC button/sw=
itch
> + *			   bitmap #defines
>   *
>   * @ev_type: The type of the input event to generate (e.g., EV_KEY).
>   * @code: A linux keycode
> --=20
> 2.25.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX6LhuAAKCRBzbaomhzOw
wptiAP0aHVgx8uyB3PmgxMenVpt5IVR21RvYHC0n4xFss3vSLQD+Jp6JInb2JpDZ
l2pNvVRUz9msRgylNHA4sjDTilTyQQw=
=F0yq
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
