Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B945024351D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMHmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 03:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHMHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:42:41 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D08C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:42:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 140so2536092lfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=P04R74Xbuv3cjdfHATnoRpjk3qHslmzAs9Kz3QNkQfc=;
        b=oJLPTTsGxz6PnYmSrTJva2uVysQlnxV9bp3OQUJKGqPQ1gMXfxSew4bgkYa1Drn+2x
         SfvkM9bonbTUWPkibOQVvSlbcpC2WlV8XlUeZ3vcqPGcIPPtIn1nueL2T6P18F9tKsMn
         g0gGu4+ykbU4iUs3u6LXFo95K3g3erlC77e8KGyze7XXEoIwDKWagbsXVHjvWB0CpVhz
         HLlzU+n8PW7cbV1cSU4hTUNUNfvaymmYLy0E9Y8Mmekqg2cUkOKzg4vYOpS/BtRCyTtT
         5Ynen2DYuRpFVieJN3FIT8jNy7xHNYcv5n7gFIghbDkHpwc+V9N8jQmqoU4zDy93eyjD
         u0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=P04R74Xbuv3cjdfHATnoRpjk3qHslmzAs9Kz3QNkQfc=;
        b=OnM5iS3FejvwX3FjAo6Xn6IHfe0A5dNOAB28m574ychoVEjlr+9z0rvPi6G+LAuFjs
         QTKIZTrdwZHDf3tVEmQTUx3jTEXIVKK3DFqAOLRA0UDBxwiRutXK379wm8qj/dHsBgbQ
         kfom/jRdo7T75gt/nuiTH/Yg+qE6Wgfx8tc9H+iEcwySR30odMLYoK0emuy60giNcwJC
         kef93MxwGz+KRkBJ8Ce4EHryymZwUv2kVMDIvlyG7d8RbAAuem54A61FNate4esE8/Cp
         GkeEw5cdIUD+IVLP0MUTeg+50ZLfIwToY8XFnginH/i8iMugebyE0WXg4OsSS/VfR9aA
         RhYA==
X-Gm-Message-State: AOAM5315oK6285K/2kpNLQ2/bZui6yVKp/5DERJZi8xIPvX+JaSss4Cb
        lHpdXUisamh4/W+V8Cs4Yfs=
X-Google-Smtp-Source: ABdhPJzkuy63Zsi7uwX6mtGwERx8H1BUWVdZaS3r4t8+xoqlBet6sAex+uApJPa7nzeYe/6nmRK5+Q==
X-Received: by 2002:a05:6512:3317:: with SMTP id k23mr1577737lfe.111.1597304559520;
        Thu, 13 Aug 2020 00:42:39 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id h13sm801102lji.134.2020.08.13.00.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:42:38 -0700 (PDT)
Date:   Thu, 13 Aug 2020 10:42:28 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     crj <algea.cao@rock-chips.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jernej.skrabec@siol.net, laurent.pinchart+renesas@ideasonboard.com,
        jonas@kwiboo.se, airlied@linux.ie, kuankuan.y@gmail.com,
        narmstrong@baylibre.com, hjc@rock-chips.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        a.hajda@samsung.com, tzimmermann@suse.de, jbrunet@baylibre.com,
        linux-rockchip@lists.infradead.org, darekm@google.com,
        sam@ravnborg.org, linux-arm-kernel@lists.infradead.org,
        cychiang@chromium.org
Subject: Re: [PATCH 4/6] drm/rockchip: dw_hdmi: Add vendor hdmi properties
Message-ID: <20200813104228.096179e7@eldfell>
In-Reply-To: <20200812133017.GJ6057@pendragon.ideasonboard.com>
References: <20200812083120.743-1-algea.cao@rock-chips.com>
        <20200812083543.4231-1-algea.cao@rock-chips.com>
        <20200812093315.GE6057@pendragon.ideasonboard.com>
        <52cca26d-b2b3-22b2-f371-a8086f2e6336@rock-chips.com>
        <20200812133017.GJ6057@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=OONQgpVWkCqhFkncTg66Ye"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=OONQgpVWkCqhFkncTg66Ye
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Aug 2020 16:30:17 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Algea,
>=20
> On Wed, Aug 12, 2020 at 07:08:10PM +0800, crj wrote:
> > =E5=9C=A8 2020/8/12 17:33, Laurent Pinchart =E5=86=99=E9=81=93: =20
> > > On Wed, Aug 12, 2020 at 04:35:43PM +0800, Algea Cao wrote: =20
> > >> Introduce struct dw_hdmi_property_ops in plat_data to support
> > >> vendor hdmi property.
> > >>
> > >> Implement hdmi vendor properties color_depth_property and
> > >> hdmi_output_property to config hdmi output color depth and
> > >> color format.
> > >>
> > >> The property "hdmi_output_format", the possible value
> > >> could be:
> > >>           - RGB
> > >>           - YCBCR 444
> > >>           - YCBCR 422
> > >>           - YCBCR 420
> > >>
> > >> Default value of the property is set to 0 =3D RGB, so no changes if =
you
> > >> don't set the property.
> > >>
> > >> The property "hdmi_output_depth" possible value could be
> > >>           - Automatic
> > >>             This indicates prefer highest color depth, it is
> > >>             30bit on rockcip platform.
> > >>           - 24bit
> > >>           - 30bit
> > >> The default value of property is 24bit.
> > >>
> > >> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> > >> ---
> > >>
> > >>   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 174 ++++++++++++++++=
++++
> > >>   include/drm/bridge/dw_hdmi.h                |  22 +++
> > >>   2 files changed, 196 insertions(+)
> > >>
> > >> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/g=
pu/drm/rockchip/dw_hdmi-rockchip.c
> > >> index 23de359a1dec..8f22d9a566db 100644
> > >> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > >> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > >> @@ -52,6 +52,27 @@
> > >>  =20
> > >>   #define HIWORD_UPDATE(val, mask)	(val | (mask) << 16)
> > >>  =20
> > >> +/* HDMI output pixel format */
> > >> +enum drm_hdmi_output_type {
> > >> +	DRM_HDMI_OUTPUT_DEFAULT_RGB, /* default RGB */
> > >> +	DRM_HDMI_OUTPUT_YCBCR444, /* YCBCR 444 */
> > >> +	DRM_HDMI_OUTPUT_YCBCR422, /* YCBCR 422 */
> > >> +	DRM_HDMI_OUTPUT_YCBCR420, /* YCBCR 420 */
> > >> +	DRM_HDMI_OUTPUT_YCBCR_HQ, /* Highest subsampled YUV */
> > >> +	DRM_HDMI_OUTPUT_YCBCR_LQ, /* Lowest subsampled YUV */
> > >> +	DRM_HDMI_OUTPUT_INVALID, /* Guess what ? */
> > >> +}; =20
> > >
> > > Vendor-specific properties shouldn't use names starting with drm_ or
> > > DRM_, that's for the DRM core. But this doesn't seem specific to
> > > Rockchip at all, it should be a standard property. Additionally, new
> > > properties need to come with a userspace implementation showing their
> > > usage, in X.org, Weston, the Android DRM/KMS HW composer, or another
> > > relevant upstream project (a test tool is usually not enough). =20
> >=20
> > We use these properties only in Android HW composer, But we can't upstr=
eam
> >=20
> > our HW composer code right now.=C2=A0 Can we use this properties as pri=
vate=20
> > property
> >=20
> > and do not upstream HW composer for the time being? =20
>=20
> It's not my decision, it's a policy of the DRM subsystem to require an
> open implementation in userspace to validate all API additions.

Also read
https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-usersp=
ace-requirements
very carefully: it calls for a FOSS userspace project's proper upstream
to have reviewed and accepted the patches to use the new UAPI, but
those patches must NOT be MERGED at that time yet.


Thanks,
pq

--Sig_/=OONQgpVWkCqhFkncTg66Ye
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl807uQACgkQI1/ltBGq
qqd/Qg/5AYqVDsoWf/fmcGp7z7OgfKXZM7+iILaEYS5vRXwgTYMG5BWpKlR+fOAn
Umgvjqhnc6GGFaB5S3vZALd7cCMYBoLdaNJ4oR566IjDpXbFl8bagZW3fD8Aaqix
9PzC80muZLPEEKy9zTqLSq2zfiZX41J7lMGTNMSQBpnGfB3YWxKqnKKlVMYtG8sL
mpMq4KfdNLh443IMiu+s4ZkVAPQxj++Bu1BeJnz5Puy1iKY4Wup76tipgNXNHNiG
eHj2hkHrzcXMjPF4JCrPra9OBHhiiv6IxP3fyF0dvfaou+mGzIOeJF5fV3Msna9J
4mYVcEE516sDuUZ8xmUOzwMMPPxqhOqZ/0DQSpU0NP3uevMVJQmcmitNFZMzDFtO
6jXTz7k554GJxrJo9XfSx/QKZPNtCIbQsxW6TKU2ShOCJFs55fO+seOCojaHnr5R
Z0zUzapzyYbmiG1UHjjnyzOVIrQb2Bj2+6NxkQdAdXltKQym1GhdWHE3D/LzhS4R
PZnFJxSU+MMrienr6daNiMfdfSl2vHgfd83qOCeQRXfYlJdzkKktsZfD2YUH0SY3
rq1pHw+5srdW0rKjct15/euFyiH3SUHF88rHYa4MzEC/3z+VASRUwWZ/ThWrRhjb
fajX3c1qqlldIcxv+TknqkFrVuOUV8O9mxP18N4EL4uYCmTlDIc=
=7IHY
-----END PGP SIGNATURE-----

--Sig_/=OONQgpVWkCqhFkncTg66Ye--
