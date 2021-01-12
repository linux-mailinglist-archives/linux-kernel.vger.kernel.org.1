Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68D72F3FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436609AbhALWfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405342AbhALWfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:35:17 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA92C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:34:37 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id d189so17839oig.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uWV9ceqZFVv/wAByH++CvwhWZufrTBFrlInqOCZZ3L0=;
        b=IRFlsM7In+J88xzxIo6EfAP+qdV43Z98KaGEJCXm4bM3L3HsrZ857Vmxfy4MFMXUkC
         5KyhZVQzjHXFkY4Sbr4GrlQcTPbPsyd84LlfE786B3EDvEvOXpg1Zlwc5OlytTSwuIAQ
         DvU8GNlkw+s9O90esE5RhALzBkw1/Uiov+m4cQnwf9cpz0rmZ5XKYPVSgah6tYCDcBOu
         i0Jnc2AoFcrjKG5b/srqQoNcyiVNPE0W4Hs0Qw5JNxDGiFxQ94x47WevExkij/t6VIEs
         7PNhOxbXAwhsJxs8HV2HhE5cE/QZewmJlE/06bT39szk5749dgp2YsEDLAQRxkV5BLOO
         9Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uWV9ceqZFVv/wAByH++CvwhWZufrTBFrlInqOCZZ3L0=;
        b=UvF8vXW6QZW/I3hcXmBfcWK3KMH7sOyjXz/9hPZk2hj5it3nmx82plJAHDOvXJ1DQi
         rKrRV83IYpVcjqs4LrWRX20OR57EW/hd0b4ZEXn75C7xNv/h+3l8RiZkE0FiIHPvjU3j
         8gS6hZHLRsvutpFFhgeQv0l5vTHEeQCm6QAZ/6kJpc0Jiq18EbzQ1GwjmqI/WIo38CZr
         xkStS2xdkXR9+WYIHJKM5mzMyhYWdFZbT4spCgun9wBXHCaHW0X9t5NW00DEfl1GBbaf
         i/7h+tGIAEvwhnDTT/kZdQc64EM3zLfe7fnlj6SoId6dMnmoZrvVVZlhRISjvKoVx4r5
         gxrA==
X-Gm-Message-State: AOAM532UqsqAZ83TWh6U3m5u9oCQJ6UuEkZxuAtTSuSGDJIAgshnu81e
        zu0CjuJQPMCGl3d6BYHaLjcFDlN2jd02klF+pEI=
X-Google-Smtp-Source: ABdhPJz3936rIaftzr3hfmlwXHzQq9qFMfV8P5SSAADDlVlFzMl8vsY/z9JXkerRylQuSkGKDDnyx8CDbPRzWRkY6lM=
X-Received: by 2002:aca:6202:: with SMTP id w2mr795855oib.5.1610490876691;
 Tue, 12 Jan 2021 14:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-32-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-32-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:34:22 -0500
Message-ID: <CADnq5_OyFORY9gibkiNmfTLNMDQOd_Y=cO1cWo1UWM6m2qtMyA@mail.gmail.com>
Subject: Re: [PATCH 31/40] drm/amd/display/dc/dce110/dce110_mem_input_v:
 Include our own header, containing prototypes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:103=
4:6: warning: no previous prototype for =E2=80=98dce110_mem_input_v_constru=
ct=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b=
/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> index 19b1976139b69..8bbb499067f74 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> @@ -34,6 +34,7 @@
>  #include "inc/dce_calcs.h"
>
>  #include "dce/dce_mem_input.h"
> +#include "dce110_mem_input_v.h"
>
>  static void set_flip_control(
>         struct dce_mem_input *mem_input110,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
