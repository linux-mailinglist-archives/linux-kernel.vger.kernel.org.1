Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE922FB750
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404336AbhASKew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:34:52 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:62109 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390430AbhASKXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:23:08 -0500
Date:   Tue, 19 Jan 2021 10:22:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1611051746;
        bh=vtNRLA5CE3I6wcgKrfTHuSBUc+uTmwDqtUGt5ElNsPU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=fCKI5HfShsUoM4GF9DEiDYOMlZ/uRKpa98tcc4F3MwCi5CAGkUrK3Q2lsKW/HyolT
         DOF8mTyfFwjtWD/Pl+P7U2SIZbp5Z3d5avlBC1ys6SNWhOluCVb+Q3SHhM3g361gBm
         xc1AkQwNuMa1ELxxffG3eZ9oN7LdqZuR9dq1/0gydrrCLPXMQgJHwZxU8TVplS+9VA
         U6UCoO6izgl5Rt4Hb4rweU8cbOXfdzP2ljcem/VV9ajDuwSRrX+hxMax1UIgGr08Y5
         xBVM56MRCWj+OGAZ/cxm2/4BCRVgowBiaxmYgMaRI0ZAbnT6SYAolFVhvCSxd0IZkF
         g9rPT9hQzAq3Q==
To:     Lyude Paul <lyude@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     nouveau@lists.freedesktop.org, Martin Peres <martin.peres@free.fr>,
        Jeremy Cline <jcline@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 2/3] drm/nouveau/kms/nv50-: Report max cursor size to userspace
Message-ID: <iyiRYoTlFNd1Crgc673rDXnfqahsfhKFP89rA0kKYEFUpLGwsFtYL-x-Jwh1ZAo7vJerbikydEDSUFtAoewsGkh3WSYeykScJdKC2PVrKQs=@emersion.fr>
In-Reply-To: <20210119015415.2511028-2-lyude@redhat.com>
References: <20210119015415.2511028-1-lyude@redhat.com> <20210119015415.2511028-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 19th, 2021 at 2:54 AM, Lyude Paul <lyude@redhat.com> wr=
ote:

> Cc: Martin Peres <martin.peres@free.fr>
> Cc: Jeremy Cline <jcline@redhat.com>
> Cc: Simon Ser <contact@emersion.fr>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index c6367035970e..5f4f09a601d4 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -2663,6 +2663,14 @@ nv50_display_create(struct drm_device *dev)
>  =09else
>  =09=09nouveau_display(dev)->format_modifiers =3D disp50xx_modifiers;
>
> +=09if (disp->disp->object.oclass >=3D GK104_DISP) {

I can confirm this works fine on GK208B. Tested with wlroots. I don't
have older cards to test, though.

Tested-by: Simon Ser <contact@emersion.fr>

> +=09=09dev->mode_config.cursor_width =3D 256;
> +=09=09dev->mode_config.cursor_height =3D 256;
> +=09} else {
> +=09=09dev->mode_config.cursor_width =3D 64;
> +=09=09dev->mode_config.cursor_height =3D 64;
> +=09}
> +
>  =09/* create crtc objects to represent the hw heads */
>  =09if (disp->disp->object.oclass >=3D GV100_DISP)
>  =09=09crtcs =3D nvif_rd32(&device->object, 0x610060) & 0xff;
> --
> 2.29.2

