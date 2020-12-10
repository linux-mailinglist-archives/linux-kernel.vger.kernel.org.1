Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BD62D6BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393103AbgLJXTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393112AbgLJXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:18:17 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E0C0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 14:33:41 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so5620018pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 14:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yHl87IgAwVQoYoagthZ9K6a/Dr4/brkjWA6ojIJaWFU=;
        b=DC2SJndkmcxWqxcWX8gv6J4dMLFjJnRPQfIfVCfoUYpMTEHl04QyifHIy9Vh9RNPPk
         82v3vP0Fkwdy1V8Zm/Xp3LrgX99BWgA/9aWaiYHuYeLNSGDMm5u9VmAlTQflJORTPZXD
         UmEdezQsYjtlOknlXbAboERncpvnccSoJqxjcCfyh9mv4B4UWB7fDM3d5tD4p/OWUNV8
         wkfuqFmA9gBFpSV0qSa2TAR4i7nN//pbL1qrzKTsWz5g2kM1UI3yRceDzTpBUssRgTCd
         XnkkBqbs4ZOeB4yZ6FAiE2NyG5uaNrihLkMg8mcicVXMoTFJTSYOfFQKHKFD9FLJYhLx
         T5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yHl87IgAwVQoYoagthZ9K6a/Dr4/brkjWA6ojIJaWFU=;
        b=W/qRGhZs6+MYUyT9cXkTwHFJhVLDuiknDTpUJAAo7B0eTSbA5m9Hq6K1gKFPfS2jLd
         LNe96KfpiFVqh0bEm6EGKQyxwZihhD+OYGPYwXNQ+qQmrOcgZSeRNnIse0zJ15vVVXgr
         htlGjY2lrRp14VmHqHvQ2xVoHECEpaLCRf75rIzKy5G/n/q+9OkE/lp791RKRVoLZjDe
         /8ztHZhyQ2/28MgKdY16Jmhy3YjSeOAj/n8AQeEny2JuASXoJHW/AGt8Ec03sGK+Y3kO
         Z09myzGX+ib/lI127r6e+1A7gRrYMsnsbevaOFDkiZRseHTMUq39LPi0rNYX5yKZm/Xw
         gDYw==
X-Gm-Message-State: AOAM530fe7Ci165N2att0rG4M7j89F1lzv9KH079VfDB5wvNCZ8yIIWL
        ojShWAJcHVXUVwKMTFx6tOuXH3THDx7TJw==
X-Google-Smtp-Source: ABdhPJwWfg7WCFYjszwuiAYhvdg+Tvt+4qdj4VsNug6NwHXasrEYU0Vi0j1HB6R+csgzNxt5bJPigw==
X-Received: by 2002:a63:6442:: with SMTP id y63mr8550827pgb.35.1607636879347;
        Thu, 10 Dec 2020 13:47:59 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id o123sm490866pfd.197.2020.12.10.13.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:47:58 -0800 (PST)
Sender: Benson Leung <bleung@google.com>
Date:   Thu, 10 Dec 2020 13:47:53 -0800
From:   Benson Leung <bleung@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, bleung@chromium.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: typec: Add class for plug alt mode device
Message-ID: <X9KXiaM4wYKkxJw5@google.com>
References: <20201210211653.879044-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RU8k2+weiVsy+tlv"
Content-Disposition: inline
In-Reply-To: <20201210211653.879044-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RU8k2+weiVsy+tlv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Thu, Dec 10, 2020 at 01:16:54PM -0800, Prashant Malani wrote:
> Add the Type C class for plug alternate mode devices which are being
> registered by the Type C connector class. This ensures that udev events
> get generated when the plug alt modes are registered.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>=20
> Changes in v2:
> - Changed code to set the class member instead of bus.
> - Removed the alteration to typec_bus.rst since it's not longer
>   required.
> - Updated the commit message and subject to reflect the change in code.
>=20
> v1: https://lore.kernel.org/linux-usb/20201203030846.51669-1-pmalani@chro=
mium.org/
>=20
>  drivers/usb/typec/class.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 35eec707cb51..29d05b45cc9d 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -482,6 +482,10 @@ typec_register_altmode(struct device *parent,
>  	if (is_typec_partner(parent))
>  		alt->adev.dev.bus =3D &typec_bus;
> =20
> +	/* Plug alt modes need a class to generate udev events. */
> +	if (is_typec_plug(parent))
> +		alt->adev.dev.class =3D typec_class;
> +
>  	ret =3D device_register(&alt->adev.dev);
>  	if (ret) {
>  		dev_err(parent, "failed to register alternate mode (%d)\n",
> --=20
> 2.29.2.576.ga3fc446d84-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--RU8k2+weiVsy+tlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX9KXiQAKCRBzbaomhzOw
wqZCAQCi/xKD0wLN6g2DzIVBSg0o0Hc2CW2jHeWGQnQsba37ZQEAzgLtAoXD/h4M
ClPZa6GNUKvK/rMXG0niMxQagt6o2QA=
=Qzf0
-----END PGP SIGNATURE-----

--RU8k2+weiVsy+tlv--
