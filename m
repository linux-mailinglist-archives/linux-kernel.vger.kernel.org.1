Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0564D2C2C01
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389909AbgKXPxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388568AbgKXPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:53:03 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8BFC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:53:03 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so22870542wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e/uBfFXAMjcZC180lRAsitZyODteJLLmWugwCCe/rOk=;
        b=Tg/D0QFI8FoO/Oi1rP7/jSZv0PzxjsGEczQgKbSNO5QOsZ2MfiWZ9sCtw9gF+k5CFK
         x9IAq2cFc5TTMAgjfzYHeyQHMsU3AmKtkD2Jct59H0IAKoGbPZXbUS3QGO05j+4iTy4b
         d1ZBSA6p0XP166C77JclggsGtxujDGBux7vE0+t0S2AVuUl1OX5OEAZSKyYQ+vf5gsrk
         opDSYzgOXllW7iQ9MoKGnehs7cukOwFEeFhGqqQf+o587KAo+MlORmmwALa2y/yC2qts
         W226YjlrYMHEEissKs8vsAPxJlewUIDsWNbewWQ2wMph32Th2aTDk4/NyOO3mhZE2Mbs
         I89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e/uBfFXAMjcZC180lRAsitZyODteJLLmWugwCCe/rOk=;
        b=Ecq7P8eGEB6oCo7iQgRFLkAd5yQj4OBuU9+g0gbblFX4z6gO297o3HI3pcqNjko4Bp
         5BYwl+NdcYEs8HSNWczj3eAdvv6ObkrWLs+NfwM1D/yzlkBiEknk89hvtAXlzXU662Em
         EqrG8qoU7M3WCpeWf9JYBJSC3Fr1WT7O5I7T2ZggsiTLCU5rs9WSPQdBRz6MeUpccZI/
         61KSpgIcAtEKxCQl1KYaSCkCSW27ByCUWHknoGnNFr0+dastB3hh3YoLrlYVwYMrhIof
         NaQzLDvUh33ZEWycphfUCveXdNZfeKdGHAVEcrycFNs5foXqUmMsfxcUZav2NhteAhG3
         6CWQ==
X-Gm-Message-State: AOAM532jqzzcrzHvWeB75f9mxsbXD3mAEwJVHzVg+aS9Xlkgszwg8jMD
        BIpA92of5FL/4VxJUxy/BZ0XByY7rNucpbwIF7Q=
X-Google-Smtp-Source: ABdhPJzJFXGmRvr1DtlCO9sTWvJOkjgpjEZVdOyoAJY7UadTwqlaU91cCJHyJC13q0d5NM1aVYU3+FgZD4KgDmGSm94=
X-Received: by 2002:adf:8028:: with SMTP id 37mr6040018wrk.111.1606233181859;
 Tue, 24 Nov 2020 07:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-2-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-2-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 10:52:50 -0500
Message-ID: <CADnq5_PaFeyNAc3a8e0MmZRKzPxPQCxGyhD_7TP+jcuPvRt9NQ@mail.gmail.com>
Subject: Re: [PATCH 01/40] drm/radeon/radeon_device: Consume our own header
 where the prototypes are located
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

On Mon, Nov 23, 2020 at 6:19 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_device.c:637:6: warning: no previous proto=
type for =E2=80=98radeon_device_is_virtual=E2=80=99 [-Wmissing-prototypes]
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
>  drivers/gpu/drm/radeon/radeon_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/rad=
eon/radeon_device.c
> index 7f384ffe848a7..ad572f965190b 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -42,6 +42,7 @@
>  #include <drm/drm_probe_helper.h>
>  #include <drm/radeon_drm.h>
>
> +#include "radeon_device.h"
>  #include "radeon_reg.h"
>  #include "radeon.h"
>  #include "atom.h"
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
