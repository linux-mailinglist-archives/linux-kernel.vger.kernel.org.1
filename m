Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90ED2A9CBD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgKFSxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgKFSw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:52:57 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A82C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:52:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r10so1618127pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GK9vvnW6ctWymDB59jo0SDWre4XXCtpqcBQ/nZPVTOA=;
        b=LxvYFg1u31Vpjj4/md21kaLYCS8Ph/9tI5k76rK+eC6s9CK9D5MIw6Ol316LNm4uCm
         XlgPn2z/VaTyoUrY1FSp15mSk42OQzI9dDIabEoNHdsgmqIFB5L5ANKRF+qFw2cvveb4
         OKlxw97GiVEvqWzpqFMkkYuxsaCjD+i2GomJqP8IkdAGmtBCXKrvNfzKrrY44ruBtnV1
         15KKiYqYo8FlMP5Rz0550zUesAElvk2Xrk/1WWEDN+SVO2JpzYnOg7hwkRlEWr/1mJMk
         uKXhEBR+8F1k8peFnZoRL7LlrZLqstWEJOcPcb5ywR1ezzODM4IMIc/iRWYrq5JRKPIq
         AOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GK9vvnW6ctWymDB59jo0SDWre4XXCtpqcBQ/nZPVTOA=;
        b=Ks+InZm9a6UnV2yq8eLphXiaDWdz0cqA7x7SbFi4Drrq27mnpTrgBZT99YGVg/HuJv
         sNwt6rPm5IARqcKh0ahEOdSJQ/mP6UjkGwENo2T0dvnH2o63jAljxH5n5XYf2ZB/PLq7
         BGKGziNvcV0k1JO6xsN8P+378V8tD4Ro2sW5wyN2LRJed4X7nPPFjXuE355pJdSBreXp
         i/unt6DDcNI7S4D6TjoGSahxkbCgcyVu3n4Ogl9rPY4uBoHha+Hgxi4N0pyELldLVr3s
         0R+yZMRmbmeoxzBU2DbMulmTX1B6M+rqTyhIbskfU7dGq1TBOlZ9CAVz50Lp41xCWLTS
         pQ1A==
X-Gm-Message-State: AOAM532VMKQ91uZj11vM4UUcyCxlRm/srITva+/FawIpqlymkjYoxQIb
        2QZkfyOqmUR1q09ate4PB6ntDA==
X-Google-Smtp-Source: ABdhPJzqijE9T9MXSXdPB4kmRbd7XOjJpFEhyA53mMYC8jWzlPd/gYuGuENillbwWW9PmWWz2izebQ==
X-Received: by 2002:a17:90a:5204:: with SMTP id v4mr927972pjh.188.1604688776289;
        Fri, 06 Nov 2020 10:52:56 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4a0f:cfff:fe66:e92e])
        by smtp.gmail.com with ESMTPSA id k12sm3457989pjf.22.2020.11.06.10.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:52:54 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:52:49 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 5/6] usb: pd: Add captive Type C cable type
Message-ID: <20201106185249.GA2874493@google.com>
References: <20201106184104.939284-1-pmalani@chromium.org>
 <20201106184104.939284-6-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20201106184104.939284-6-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,


On Fri, Nov 06, 2020 at 10:41:08AM -0800, Prashant Malani wrote:
> The USB Power Delivery Specification R3.0 adds a captive cable type
> to the "USB Type-C plug to USB Type-C/Captive" field (Bits 19-18,
> Passive/Active Cable VDO, Table 6-38 & 6-39).
>=20
> Add the corresponding definition to the Cable VDO header. Also add a
> helper macro to get the Type C cable connector type, when provided
> the cable VDO.
>=20
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

Looks good, to modify the Cable VDO decoding to bring it up to date to PD 3=
=2E0.

I should also note that the ID Header VDO also has a new field (that I adde=
d to
the PD spec) that marks whether or not SOP/SOP' is a captive plug versus a
receptacle as well. Nothing depends on it yet, but we should keep this in
mind for future changes to the connector class.

Thanks,
Benson

> ---
>=20
> Changes in v2:
> - No changes.
>=20
>  include/linux/usb/pd_vdo.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> index 68bdc4e2f5a9..8c5cb5830754 100644
> --- a/include/linux/usb/pd_vdo.h
> +++ b/include/linux/usb/pd_vdo.h
> @@ -177,7 +177,7 @@
>   * <31:28> :: Cable HW version
>   * <27:24> :: Cable FW version
>   * <23:20> :: Reserved, Shall be set to zero
> - * <19:18> :: type-C to Type-A/B/C (00b =3D=3D A, 01 =3D=3D B, 10 =3D=3D=
 C)
> + * <19:18> :: type-C to Type-A/B/C/Captive (00b =3D=3D A, 01 =3D=3D B, 1=
0 =3D=3D C, 11 =3D=3D Captive)
>   * <17>    :: Type-C to Plug/Receptacle (0b =3D=3D plug, 1b =3D=3D recep=
tacle)
>   * <16:13> :: cable latency (0001 =3D=3D <10ns(~1m length))
>   * <12:11> :: cable termination type (11b =3D=3D both ends active VCONN =
req)
> @@ -193,6 +193,7 @@
>  #define CABLE_ATYPE		0
>  #define CABLE_BTYPE		1
>  #define CABLE_CTYPE		2
> +#define CABLE_CAPTIVE		3
>  #define CABLE_PLUG		0
>  #define CABLE_RECEPTACLE	1
>  #define CABLE_CURR_1A5		0
> @@ -208,6 +209,7 @@
>  	 | (tx1d) << 10 | (tx2d) << 9 | (rx1d) << 8 | (rx2d) << 7	\
>  	 | ((cur) & 0x3) << 5 | (vps) << 4 | (sopp) << 3		\
>  	 | ((usbss) & 0x7))
> +#define VDO_TYPEC_CABLE_TYPE(vdo)	(((vdo) >> 18) & 0x3)
> =20
>  /*
>   * AMA VDO
> --=20
> 2.29.1.341.ge80a0c044ae-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX6WbgQAKCRBzbaomhzOw
wgdNAP4jo7I9B+HMxTp+v/kdlGdx9a7piPiHEAvxKAB1LbNDiwD/e7ht6IzRwNGn
7VBEc/u1jWd14MUBfJ+louWVjyFUFgc=
=SsxY
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
