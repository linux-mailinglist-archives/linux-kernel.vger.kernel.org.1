Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7D2732BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgIUTZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUTZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:25:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315FDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:25:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z1so14022842wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLMkI8ryKHY4AVg+9eBO/sbeSRFdzsZAIvzUi2Ima0c=;
        b=a3oWnFxre3X3EVrZqmHZncc2RbsmD3HNqLY6FtIBHhlhC3U8K5EEvFrmduxbZ/Z41s
         c/pQQrYsJ0o9ENHX7JIv9W4y9xay/bu318Uv+ipTX/7m3VJbYzsUWZYGPyQ3v/omDhzk
         8ts/EFNS0wHmlCMbApVOHYms9P3LEmKqAjlkgVj7s5YbToruI88PNYDX0RsXvq8WQYzy
         iJsbHJIHKENAKjKAKj/dCZNOmlMV46Gu/77E57vJZ2U2aKq0kgbG+B7HKfFvjL5touo9
         yuidF0Su6CbUevMGuxwXr8IhnNDs/43X1JawX5TlRvZQCjjrWc14vANuOByHDSpkt10g
         OUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLMkI8ryKHY4AVg+9eBO/sbeSRFdzsZAIvzUi2Ima0c=;
        b=SxdiDCp/c2TP4B/dPR6WJ9+KX2JQSWo+wFT0o2UpSV9lPpWDmX/A6PstM344vKekO2
         BFCPxhRIKQ9TVOa+ZLkTs8mK7nCf3JvRxFanIAPXbLFWuDQ+WUIlbYwElYAQUt1HqH4+
         UKCNCykcUX+0nD42FafX6Fd8o2PwLrjJfJM3PZZl2KZuFmUxvclStiRBbSZBb/U0eafa
         YS/HGafmlmZuproWEjtdmITSmWixbStCNLrghLg07P/1BOTWvEWujQNUaeK+qnVgQLWX
         aaxEamsaQkJqR0cvgdbV+RwIjaY/NvlbBI2soIlSfVqRWijj9d8OuEt1+F2JQFMggG/1
         yw4w==
X-Gm-Message-State: AOAM533zUpPK6Bv1SWbthUdyfgiDkG0tFy7r3C46QtSnnFnp7+v9BJSs
        0kjqY5Ll0Yl9nwdCjRLhJcbwCai0ip7mX85ehW8=
X-Google-Smtp-Source: ABdhPJw0SPwIJWrXygk92hq9BwqUmYd3YQsJNKHUGhEESLuDkxc0IXIJLsN3bgK8SQ811bAsX0tGJLEoqwySs35R478=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr1369776wru.374.1600716327871;
 Mon, 21 Sep 2020 12:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200921131011.91281-1-miaoqinglang@huawei.com>
In-Reply-To: <20200921131011.91281-1-miaoqinglang@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Sep 2020 15:25:16 -0400
Message-ID: <CADnq5_PkRAsFEUtVCP5f5Z9BKfLD9404MrprGv34gSaKMMxO6w@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu/mes: simplify the return expression of mes_v10_1_ring_init
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
>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 4b746584a..1c22d8393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -832,7 +832,6 @@ static int mes_v10_1_queue_init(struct amdgpu_device *adev)
>  static int mes_v10_1_ring_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ring *ring;
> -       int r;
>
>         ring = &adev->mes.ring;
>
> @@ -849,11 +848,7 @@ static int mes_v10_1_ring_init(struct amdgpu_device *adev)
>         ring->no_scheduler = true;
>         sprintf(ring->name, "mes_%d.%d.%d", ring->me, ring->pipe, ring->queue);
>
> -       r = amdgpu_ring_init(adev, ring, 1024, NULL, 0, AMDGPU_RING_PRIO_DEFAULT);
> -       if (r)
> -               return r;
> -
> -       return 0;
> +       return amdgpu_ring_init(adev, ring, 1024, NULL, 0, AMDGPU_RING_PRIO_DEFAULT);
>  }
>
>  static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev)
> --
> 2.23.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
