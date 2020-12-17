Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B707E2DD3B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgLQPDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgLQPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:03:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF308C0617A7;
        Thu, 17 Dec 2020 07:02:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a12so26873010wrv.8;
        Thu, 17 Dec 2020 07:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ga2/KMv98S2RYvMmfnUwu2rGZHl7WSnJKIOH8EUBBqg=;
        b=bGMJTp7n52Ssq2cbclAal308zW2i2bGV0MID3GJNLdCe9ap8I+wb2UeUVjQKWq5mRV
         iDbiO6vkEkugXyS8t1bKX6JqcVsL32BeP9yJQJicV/vbHGDqbCiJrUnTHhPyYG0ecFBb
         Fc5/jpv4+0+iWAu+2kXo3HfA76fqUXiOSfnnKZN/p42E+z9/T8bxrRwVRt2JNMFaW9MM
         ljJ/jZfPW2KBseYcM8QwuIoXgC9gLraj3qM2wPePJOlQIfoKMUsbOJcPhXRQEMv3oh6M
         neIvF7PYNIfUZVQkyLnwfoIj9hmoUe0VudtQ3zui9dRy4g9Rvq5DBCjgMfpqcEtvH5nK
         jJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ga2/KMv98S2RYvMmfnUwu2rGZHl7WSnJKIOH8EUBBqg=;
        b=hV4DlHnJo+HuHHcN9ACZm5TJGDIMBSq6EnN2lT0jHhDVwkuPsaHZXOllXHvgXdkuuz
         wESAiB1QsTOBobMVkBGKceM0+EAqF55DJQoDVh3VfLCf/9+NoCbveOqkkrx5eBFiiNL1
         sKqSfwgnbM3uWu4hWKzUm10Bn276XOiDj+TvYOnmz+dlpWAWYANlFYh2ev17mkOao36/
         WLsYuFsU1ZXOf7233yoHcT++bdLXXETY0h4t8ZgoQoR7gWEEjfz1oSsJW+HajxJ65S9W
         PySAaTXHWiO11OXVSjJTJWf3L+DUc+MgaOJbt/xoSuYYGhJuXTvIzrik7HuI3bCeZB3p
         NZ/g==
X-Gm-Message-State: AOAM530frF6+UDPWv1YPuTA9oDyy5WmhR0jp0CkU5lCal7g4FUMx2Yvh
        dHQJdCP4OHMkqYUOc0iYAr8=
X-Google-Smtp-Source: ABdhPJx5mFZlG161O/8tcYPkP6ILf4pBrPDXprinePS09teWflTAMc/XFEgVJeH582RuPWHQu/OFqg==
X-Received: by 2002:adf:9e4d:: with SMTP id v13mr43258327wre.135.1608217360720;
        Thu, 17 Dec 2020 07:02:40 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o83sm8297551wme.21.2020.12.17.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 07:02:39 -0800 (PST)
Date:   Thu, 17 Dec 2020 16:02:38 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ion Agorria <ion@agorria.com>, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] usb: chipidea: tegra: Support runtime PM
Message-ID: <X9tzDmgDxscC+lt/@ulmo>
References: <20201217094007.19336-1-digetx@gmail.com>
 <20201217094007.19336-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7w8CkElLSiXeS+jy"
Content-Disposition: inline
In-Reply-To: <20201217094007.19336-7-digetx@gmail.com>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7w8CkElLSiXeS+jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2020 at 12:40:05PM +0300, Dmitry Osipenko wrote:
> Tegra PHY driver now supports waking up controller from a low power mode.
> Enable runtime PM in order to put controller into the LPM during idle.
>=20
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_tegra.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--7w8CkElLSiXeS+jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/bcw4ACgkQ3SOs138+
s6HgOg//Uiwad4EVxU9jw6jA4Eu6HI0/sS9MV+fj/SFJuYEYT9ZhMh4v+C4IcUZK
+EUrLvhTY8aa94CtiESWQryRPXQ0/GMu6r5JGWtIY0llUNCD9Y+dEacxUVi3SNgk
W3vj/fSIWppFlhQ73VC2ds9eGMKZW8nJLwJGKAa2fmjTmcQLv5+nnH8f35tAOCDc
BQhkYm0tHV2kdB6uu2SovBlQ/yvNrS2Bd7n466Csy/DWAxQuminrd6IbixJ44Ny3
eZzRDGJhutEorKZlZjJhpXtMkKyVUDbjIGcVHjywyIIdMvhieexSFOBDYqYOMNUz
GAbVr+sbTeeXnGZr68UYtZFRpF7j+InH7QhzHCwf0PFlg180npAYEQRTS9+joeWH
HMIMzXLIX1k89q2Itr5N64xovaZFrCSF7KXPvZnI2DTYe3Qkpi9jLbsrGrgMfmFd
28S0/3ZSLitiFU9lSorL2QUqthwWiMczmo59HODJjT833VrAiJo1yk1YhOLHvt4r
bP0LMJPvb4guYy2AUe+cvLJFxjFGGZnVjkoc1u4+dTTtnJkgTrKhtZV4QWiBXj5o
olABXsMERI3aIfPeTuLkwrnMvRpJE0BKoPYPZolJHgJ5Cqbto73hlElK8T1Fo1lG
Gj/olauzbaOhGklZmsnKXxwnqo3+Kw4lTAqIsdB6ev/wl6nWRYU=
=P0P0
-----END PGP SIGNATURE-----

--7w8CkElLSiXeS+jy--
