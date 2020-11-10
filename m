Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63C92AE292
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbgKJWIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgKJWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:08:55 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCBDC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:08:54 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so2886597wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W/G1cCKiChHWAMYc3JRK1M6ntm3rFjLembXKLShlhjI=;
        b=jEHvWPHultoa+XlSxa6GFBJtx/Qp4byqG0fkbQf03ZlkKLmHTauy1n04ojprn0LjD7
         AqjVJD9NAWrabIVHV0GXdLKuJp92lPRC5srbI2D4E/7e1FRBXoKrhpZAVjHn21ZvdPgS
         fOzCj45HiC2oJV9hrDcVbrF7B9PZxeFuDC2MY/orooI08UpqBYBv3XE6b9HwI6ReKWuN
         JpqUGDY3BZZRDwa9/eHdDZz11aNpCO/oHrBatIPLHGiAQ2rLJVZ3LbtZIKhXVTw1tDEX
         AdOQrOx33vTKFSB9ixCB51OYBUhmkkxUu+lFBmgVQrkdbV1Ovi9J3KW2CmoGJfHuMKsX
         Hz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W/G1cCKiChHWAMYc3JRK1M6ntm3rFjLembXKLShlhjI=;
        b=BLczGrinDbXQ+Zddfa2saGL9/kbn2JGgErPojO2hlzOovk8kP2XxySia0qXoOwG6cU
         qG7YsvtvvKxoAZwEk9WudWhce+lMJopLwDyIwp7mbGTEIzmAnYMdt7KaOAsQikVaxAst
         VE36jSsGMieTJllk67OYdnFZPD/T3Ks9mGr+ywbJFaJ0vr2Q4rh6rayaLiAA/n4FUuqT
         yEhncAXhSJ0Uw90Ydo3B7/l+2Ke+QzuCwGt5M8ORi99n8jkRlZjGNhEx71RVH4/FW1R5
         WeJGahNmaPlrP3EExWH2GEt6DICZVP3NNOcwt1H8x78qkRa3kPcx+rJRmT4Em4+NV2M2
         HuKw==
X-Gm-Message-State: AOAM531LejjBCRD/JGI7pIv0HxwkiJLvUaon5eiFDN+ivJ+wo9DeQ8U2
        +vRyJ2iA1/jIteTTOMJLBLgWaPf1TB56CjAyf4o=
X-Google-Smtp-Source: ABdhPJx34oGTHXB74qraONACHcaotZfbZfG/di5YV/g/5I4xjs1LA59YzHGShOOwna0bWMj0j+kNFCziDgNUvDa0Zn0=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr273459wmb.56.1605046132845;
 Tue, 10 Nov 2020 14:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20201109211855.3340030-1-lee.jones@linaro.org> <20201109211855.3340030-7-lee.jones@linaro.org>
In-Reply-To: <20201109211855.3340030-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 17:08:41 -0500
Message-ID: <CADnq5_Oo6Y3M-dVewXFxKRYooYfpDPLhxHQhXrWt9y759uXjsg@mail.gmail.com>
Subject: Re: [PATCH 06/20] drm/radeon/radeon_connectors: Strip out set but
 unused variable 'ret'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 4:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_connectors.c: In function =E2=80=98radeon_=
setup_mst_connector=E2=80=99:
>  drivers/gpu/drm/radeon/radeon_connectors.c:2574:7: warning: variable =E2=
=80=98ret=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm=
/radeon/radeon_connectors.c
> index e308344344425..607ad5620bd99 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -2571,13 +2571,11 @@ void radeon_setup_mst_connector(struct drm_device=
 *dev)
>                 return;
>
>         list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> -               int ret;
> -
>                 radeon_connector =3D to_radeon_connector(connector);
>
>                 if (connector->connector_type !=3D DRM_MODE_CONNECTOR_Dis=
playPort)
>                         continue;
>
> -               ret =3D radeon_dp_mst_init(radeon_connector);
> +               radeon_dp_mst_init(radeon_connector);
>         }
>  }
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
