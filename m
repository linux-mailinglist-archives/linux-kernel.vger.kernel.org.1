Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF46F2EB57D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbhAEWmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAEWmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:42:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E347C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 14:41:29 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a188so567932pfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 14:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tz20fpnIVG9WuLtemliZ+3BCfhLfj6nGFFWIiw2VXg0=;
        b=G1K3xhfZGnnzSY8ZeAqVZkFyB1sF2ktvxgEq0KacphvnPpjYTRzIYyu67IlELPVTVB
         93FL5FBg93COyUAWqaDpV+VBBUbub3bKKs/iyzhnH3V0jQCwMpck0ZI5Bm2ERTsQJ7QE
         QNkjm9sO+JJDpLzHrOdsYeoZ5pE9q8ZJrnQm8XmARZ8ei0eSPHdSmVsb6L9gsdvL34nR
         fvNJizqGoxkM2Zp3ReezYb2QBPTnpLAyVGpH7eWWqi57Yw4jSzp3fcSd/Dk8AesyveuM
         7KVD0GF3gy9kKEkv6N2FS/yf3Set73X35TSSD9l7Pc/ntYEDsbA1/2DYAfiT2cwXPrZn
         23ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tz20fpnIVG9WuLtemliZ+3BCfhLfj6nGFFWIiw2VXg0=;
        b=jn6uJKGiawHTwgjQ7Pv04o3yYi3d6Jzd8duHiTPtyMU2+/+HPKb/qPOl02uOPJbxfw
         gU8BLLOh5EqVWgTgiTSYGO5fdCRh+lhvOuZkUeSiHSdsfEO2LiRgaOzCEWyX4mh/35UH
         R7avfI2x7C6p+OlTohiOyp3dn1gkFPBlAJjCK5aBjGO5QlZ1uqXtG175GpcSrRbGIJNn
         VmPIahuiQ1UtFuxgUitfLq1Q7zulJjCblpazzM5EOjxtwquAaqjY2tnt4vPsxCU1bQWk
         A3WPK9SLGO8Qz+XF6atNl4T7iobttl4pYmq28mAPMm67sAl4Zi3W6vJSvhmblWEu2v7l
         Ik4w==
X-Gm-Message-State: AOAM532krGZF0+RfUfGHRJ+eOjT2AGuNg0Cw7Na7V4KkfygOmSQvZ12D
        SKVVMCGwKf4dd1lmAEA6IOWQSg==
X-Google-Smtp-Source: ABdhPJwrrEqFVJ+aQ/eqZzw6G8GqWoH4U7rAhATW3CYHJOIhC05uAi26CbAv6wbMh71ti29lkfjcNQ==
X-Received: by 2002:a63:1524:: with SMTP id v36mr1308744pgl.383.1609886488630;
        Tue, 05 Jan 2021 14:41:28 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id n195sm345474pfd.169.2021.01.05.14.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:41:27 -0800 (PST)
Date:   Tue, 5 Jan 2021 14:41:22 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        rajmohan.mani@intel.com, gwendal@chromium.org
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Send mux
 configuration acknowledgment to EC
Message-ID: <X/TrEgQf5l8yHKrx@google.com>
References: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
 <20201210060903.2205-3-utkarsh.h.patel@intel.com>
 <X+FBsu+VNsEJlgBp@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VIrzktiWRp/YXkuU"
Content-Disposition: inline
In-Reply-To: <X+FBsu+VNsEJlgBp@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VIrzktiWRp/YXkuU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant and Utkarash,

On Mon, Dec 21, 2020 at 04:45:38PM -0800, Prashant Malani wrote:
> Hi Utkarsh,
>=20
> On Wed, Dec 09, 2020 at 10:09:03PM -0800, Utkarsh Patel wrote:
> > In some corner cases downgrade of the superspeed typec device(e.g. Dell
> > typec Dock, apple dongle) was seen because before the SOC mux configura=
tion
> > finishes, EC starts configuring the next mux state.
> >=20
> > With this change, once the SOC mux is configured, kernel will send an
> > acknowledgment to EC via Host command EC_CMD_USB_PD_MUX_ACK [1].
> > After sending the host event EC will wait for the acknowledgment from
> > kernel before starting the PD negotiation for the next mux state. This
> > helps to have a framework to build better error handling along with the
> > synchronization of timing sensitive mux states.
> >=20
> > This change also brings in corresponding EC header updates from the EC =
code
> > base [1].
> >=20
> > [1]:
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/m=
aster/include/ec_commands.h
> >=20
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
>=20
> I'm not sure what the maintainers' preference is for the header (same
> patch or separate patch). FWIW:
>=20
> Reviewed-by: Prashant Malani <pmalani@chromium.org>

I asked Gwendal to look over this change. It looks good to him, so I've gone
ahead and merged it.

At some point we have to completely sync ec_commands.h, but the change here
is well contained, so it minimally adds to the delta between the EC codebas=
e's
header and the kernel's.

Thanks,
Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--VIrzktiWRp/YXkuU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX/TrEgAKCRBzbaomhzOw
wkWGAQCYV3oXFdaXYJ6sx+y9ZhPZDkUiYLgOVKc1u/5uyAANCwEA1RbY5KhJAhvg
+rSbzzIM64Ia+DVtmvQVI9IZafWCjgE=
=5hU0
-----END PGP SIGNATURE-----

--VIrzktiWRp/YXkuU--
