Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7252732D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgIUT3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUT3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:29:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1591FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:29:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d4so588703wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hqqQe3Z1bSL8x51h6GBHQbFdilb167mWc10MCGnF5c=;
        b=awcQqHvs87YwD+ow2dgUZXP6lXUYnudx4TPkva6t6ODq69HufSrILLkzTf/cGeZMwy
         XDYRW4nF4fmc1TtllS2BZenWcjam7kVhVjZn7O94fcqqQLOly1hHwzc78T9f+woPNfSt
         YNna5r5MWscpXrPV2CfPZWbVnEjKBV9OH1ZCh6QL4tibHPFivBwdgaNlOtUHg/RulgRT
         zahDW3MrSMegAvX/e7etlTq4dw0IYA8Tm5cEu96i+9Ukj5UIPRYL5uGj+POGi7dZJznD
         hVUAnK62/ZPdGYe00nLBTMZfhj5BvUB67QzbfDPtNH4fcyVsJtS+xO3n9msneFizL2uP
         bGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hqqQe3Z1bSL8x51h6GBHQbFdilb167mWc10MCGnF5c=;
        b=P9yFsG7Q3gdc47iCA8MDpNkEtaaa6HCtdpQviuFzHrWRt7c7dTW7YfRdGrCxI5H6+U
         GTsAt10XUgkVtXx2MYQ7EPZ6RrSIis7e3iIhzQhJ33IbJd0VVZBbqwsaR/0AG9iC5RkW
         BkS2G8AG8HwWRvQRODwTjjR/STkL73f/b1fIbTvp7mLLHTAom19bkUsSGWkvDOUWWdZP
         BzUI8nvrprX5OHuPcE+jqD9nYrVLELOD2gda62nHot/CB4Ua1L42LYCnjXr4E0kogM6y
         OhC5Qg9D2U0wmehxvFqE0f6TwSZUMYE5bJ/aYUxLowmUEQDGOeac/SKm0cYdNyF7cbXT
         dERg==
X-Gm-Message-State: AOAM530YPwe0SQADnQ0T3Hk7g+lwRN5lg9vG5evLcqKm3VvHzqgaa7fJ
        Nup/a16vyqRQgO7aLxZbaPA/sUIrv8ia6BmgdlY=
X-Google-Smtp-Source: ABdhPJyiPDkPv35QAwXXlQGTvpYQSkCM0PP/Pd9TLrVlrzcA5LNYIx2sbt9USWQg6GODTcnOOUPJhSQ5fjU7hWXQ9vA=
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr834581wmc.73.1600716576679;
 Mon, 21 Sep 2020 12:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200921131013.91326-1-miaoqinglang@huawei.com>
In-Reply-To: <20200921131013.91326-1-miaoqinglang@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Sep 2020 15:29:25 -0400
Message-ID: <CADnq5_N8J-w7oLUvZXXFg=c=OK7vFkkvGL2BDE+ydSov2ya1pA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: simplify the return expression
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Sep 21, 2020 at 9:14 AM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> Simplify the return expression.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c   |  7 +------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++--------
>  2 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> index 401c99f0b..db953e95f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -316,14 +316,9 @@ static int cik_ih_sw_fini(void *handle)
>
>  static int cik_ih_hw_init(void *handle)
>  {
> -       int r;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       r = cik_ih_irq_init(adev);
> -       if (r)
> -               return r;
> -
> -       return 0;
> +       return cik_ih_irq_init(adev);
>  }
>
>  static int cik_ih_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 20d8a03ca..56ed108b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2198,7 +2198,6 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
>  static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>                                       int mec, int pipe, int queue)
>  {
> -       int r;
>         unsigned irq_type;
>         struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
>         unsigned int hw_prio;
> @@ -2223,13 +2222,8 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>         hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
>                         AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
>         /* type-2 packets are deprecated on MEC, use type-3 instead */
> -       r = amdgpu_ring_init(adev, ring, 1024,
> -                            &adev->gfx.eop_irq, irq_type, hw_prio);
> -       if (r)
> -               return r;
> -
> -
> -       return 0;
> +       return amdgpu_ring_init(adev, ring, 1024,
> +                               &adev->gfx.eop_irq, irq_type, hw_prio);
>  }
>
>  static int gfx_v9_0_sw_init(void *handle)
> --
> 2.23.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
