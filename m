Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315592EB586
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbhAEWvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAEWvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:51:23 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1F7C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 14:50:42 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x12so533555plr.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 14:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jja6PGE5iwBpw1zqSo7xw/kvad9lr78jIVWxbJrx/30=;
        b=REnWvtpsMjKjED+bZTapLRSuEuQztkNpcx2eiAa6TLISjOIkxFuVhCZuMP9Nls3I5j
         +mwFUa8wfAJukwm+FiJn7evgt033UzSFH43wdAqLUUTo4UnmMXATDlb7cNgzbGhqCXhZ
         2I/ONtGitmNKyMV8l3KmENqc6aEdteT1ih3WfAgChbz6EBQGZVJ07QHQCpL9eTwCModS
         pqD+MdIyCCqOVW4wJ71lCIDuVZs3hAMqyESzdA2naIYKi3m3cGliaaU+0qlVKMmd/bGh
         pQ7xXTXYMQhXvrvmCZ443IWWp6J4yUzo+yuMC9KjSFNz8gJVG+sprYsFIplKJxFKxnFj
         wsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jja6PGE5iwBpw1zqSo7xw/kvad9lr78jIVWxbJrx/30=;
        b=BVtKM+SSIBJaOuVuDPA1Qlmt4MRhNSOSC6QI85f/L8hkI59wXh1aosASJOkRy0sV4H
         PdGS2MOEEWEXSG+oHWDGSFddf0HE5tddZBZl6aNDZN+ceiWa1PXapnYw8As0li+pbzBs
         HMjo20pFr+/125kqq7j0r6lCKvUJLerIix1+7uYMM0Y6M1n+NUw+dAVqR5rrwJUsINwQ
         D9B29zrJiQJMSz7AbXT+Hgmif1GkAsMcQZzWYVhP0XLu3DWVDyQEQCuVr3X4Pm40TgDs
         HygufZnBw2X69y+mhh6BB8mbcQR0JiKU6a2sJKYzsFt+Kn7+jJM6GCcCnmQAbcbcEvbP
         v+kw==
X-Gm-Message-State: AOAM532gvZCfErLztZccRp8smqSeVqSL5sr0HUqzL/5CkGUKtghF5a7Z
        jHvy2esE3/Ls24tEYe+DJ7CRsg==
X-Google-Smtp-Source: ABdhPJzPHusybky4jtjW5ghWRcVp++iKus2QtHrORCfwKKTGkWMoqvVEm8Qi0vgkltEnbmA7wB+dyA==
X-Received: by 2002:a17:90b:1811:: with SMTP id lw17mr1337881pjb.105.1609887041345;
        Tue, 05 Jan 2021 14:50:41 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id x22sm395236pfc.19.2021.01.05.14.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:50:40 -0800 (PST)
Date:   Tue, 5 Jan 2021 14:50:35 -0800
From:   Benson Leung <bleung@google.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        pmalani@chromium.org, bleung@chromium.org,
        heikki.krogerus@linux.intel.com, rajmohan.mani@intel.com
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Send mux
 configuration acknowledgment to EC
Message-ID: <X/TtO/HbYAKhznhg@google.com>
References: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
 <20201210060903.2205-3-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/IjDMK6mAXs7fzYe"
Content-Disposition: inline
In-Reply-To: <20201210060903.2205-3-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/IjDMK6mAXs7fzYe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Utkarsh,

On Wed, Dec 09, 2020 at 10:09:03PM -0800, Utkarsh Patel wrote:
> In some corner cases downgrade of the superspeed typec device(e.g. Dell
> typec Dock, apple dongle) was seen because before the SOC mux configurati=
on
> finishes, EC starts configuring the next mux state.
>=20
> With this change, once the SOC mux is configured, kernel will send an
> acknowledgment to EC via Host command EC_CMD_USB_PD_MUX_ACK [1].
> After sending the host event EC will wait for the acknowledgment from
> kernel before starting the PD negotiation for the next mux state. This
> helps to have a framework to build better error handling along with the
> synchronization of timing sensitive mux states.
>=20
> This change also brings in corresponding EC header updates from the EC co=
de
> base [1].
>=20
> [1]:
> https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/mas=
ter/include/ec_commands.h
>=20
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> ---
>  drivers/platform/chrome/cros_ec_typec.c        | 16 ++++++++++++++++
>  include/linux/platform_data/cros_ec_commands.h | 17 +++++++++++++++++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index 650aa5332055..e6abe205890c 100644

I went ahead and staged this commit, but just for your information, applying
this patch was problematic because the sha1 used here didn't match anything
in the upstream kernel.

Here's the error when I try to apply this using git am:
Applying: platform/chrome: cros_ec_typec: Send mux configuration acknowledg=
ment to EC
error: sha1 information is lacking or useless (drivers/platform/chrome/cros=
_ec_typec.c).
error: could not build fake ancestor
Patch failed at 0001 platform/chrome: cros_ec_typec: Send mux configuration=
 acknowledgment to EC


Please double check when you run git-format-patch that the branch you are
working on comes from publicly available git repos, ideally, based on linus=
's
tagged releases. This will ensure things apply cleanly on my side.

I've gone ahead and staged this, but could you please sanity check that the
result is as intended?

https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/c=
ommit/?h=3Dcros-ec-typec-for-5.12&id=3D8553a979fcd03448a4096c7d431b7ee1a52b=
fca3

Thank you,
Benson

> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -74,6 +74,7 @@ struct cros_typec_data {
>  	struct notifier_block nb;
>  	struct work_struct port_work;
>  	bool typec_cmd_supported;
> +	bool needs_mux_ack;
>  };
> =20
>  static int cros_typec_parse_port_props(struct typec_capability *cap,
> @@ -503,6 +504,7 @@ static int cros_typec_configure_mux(struct cros_typec=
_data *typec, int port_num,
>  				struct ec_response_usb_pd_control_v2 *pd_ctrl)
>  {
>  	struct cros_typec_port *port =3D typec->ports[port_num];
> +	struct ec_params_usb_pd_mux_ack mux_ack;
>  	enum typec_orientation orientation;
>  	int ret;
> =20
> @@ -543,6 +545,18 @@ static int cros_typec_configure_mux(struct cros_type=
c_data *typec, int port_num,
>  		ret =3D -ENOTSUPP;
>  	}
> =20
> +	if (!typec->needs_mux_ack)
> +		return ret;
> +
> +	/* Sending Acknowledgment to EC */
> +	mux_ack.port =3D port_num;
> +
> +	if (cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_MUX_ACK, &mux_ack,
> +				  sizeof(mux_ack), NULL, 0) < 0)
> +		dev_warn(typec->dev,
> +			 "Failed to send Mux ACK to EC for port: %d\n",
> +			 port_num);
> +
>  	return ret;
>  }
> =20
> @@ -908,6 +922,8 @@ static int cros_typec_probe(struct platform_device *p=
dev)
> =20
>  	typec->typec_cmd_supported =3D !!cros_typec_feature_supported(typec,
>  					EC_FEATURE_TYPEC_CMD);
> +	typec->needs_mux_ack =3D !!cros_typec_feature_supported(typec,
> +					EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
> =20
>  	ret =3D cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
>  				    &resp, sizeof(resp));
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/lin=
ux/platform_data/cros_ec_commands.h
> index 7f54fdcdd8cb..3b53e45cb5a0 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -1286,6 +1286,16 @@ enum ec_feature_code {
>  	EC_FEATURE_ISH =3D 40,
>  	/* New TCPMv2 TYPEC_ prefaced commands supported */
>  	EC_FEATURE_TYPEC_CMD =3D 41,
> +	/*
> +	 * The EC will wait for direction from the AP to enter Type-C alternate
> +	 * modes or USB4.
> +	 */
> +	EC_FEATURE_TYPEC_REQUIRE_AP_MODE_ENTRY =3D 42,
> +	/*
> +	 * The EC will wait for an acknowledge from the AP after setting the
> +	 * mux.
> +	 */
> +	EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK =3D 43,
>  };
> =20
>  #define EC_FEATURE_MASK_0(event_code) BIT(event_code % 32)
> @@ -6054,6 +6064,13 @@ struct ec_params_charger_control {
>  	uint8_t allow_charging;
>  } __ec_align_size1;
> =20
> +/* Get ACK from the USB-C SS muxes */
> +#define EC_CMD_USB_PD_MUX_ACK 0x0603
> +
> +struct ec_params_usb_pd_mux_ack {
> +	uint8_t port; /* USB-C port number */
> +} __ec_align1;
> +
>  /***********************************************************************=
******/
>  /*
>   * Reserve a range of host commands for board-specific, experimental, or
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

--/IjDMK6mAXs7fzYe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX/TtOwAKCRBzbaomhzOw
wnJTAQDtYmCUms19MJacR7vPU5uukzu3eG8uUGBKVEsITpt6egD/Q9fA7uzcinLn
mJbnxWZ5WRELYs5CW0vK9SgBdTCM3A8=
=havA
-----END PGP SIGNATURE-----

--/IjDMK6mAXs7fzYe--
