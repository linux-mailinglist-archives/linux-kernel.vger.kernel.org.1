Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801752C93AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbgLAAIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgLAAIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:08:40 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B7DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:07:59 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 79so13142609otc.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ojzw4xN3z1NHS/JOfvKKkvXoTTW/H9rPegUeJQAjVt4=;
        b=pWDEP0JZ4NsbcnuXYudpYTF8qNyQj9Eb7+ZzmVDYucX2LKe4UE6e3sHosTDI1JTKXW
         Q5uXunDPRGE/pyyaDTvlb/hvNqjx+YTRH2aKDaTdwDZFun9MoVa0OVZaM1N1XJkcwVSq
         TfvqLafMDH2Wj3Hv0T+CC4IWTiUlLmDIDhY9MLa604Vc76tTFlISpLAIHPR7jstELi/n
         HJeFHiuNyC9Cz7R09ukeiRLoQLUrHQvOpfAMnfpZowD/NGDmRa/VmgtlusN2DBYgyOUQ
         kG9nbDHsf1Xco0C2NcXKrZfgyKGswyeUMtYzpp4H0a9p252fflQ21pZ9wklJbvWh0b9v
         VbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ojzw4xN3z1NHS/JOfvKKkvXoTTW/H9rPegUeJQAjVt4=;
        b=AmQGK/tPz9WVk2o0gwSoK6amC/9NaqjbErBl3IPr9ZOliaP8UV69BmE4YEWpYcHGcq
         GCcIadluARONFYOWSFqw3e1RkeI49itNnph7V/h6gz5efvVPyyu+T/+Rr1nLijr2BN/c
         OBj0s5pe+D6EuO3SH+e+Jh/3OagDf0dY5i9IGvKc1lPDW4L/YaW1yE7cwdAf8/OZSzDC
         k8aPSCxvIVxjd5ZsgSn2n6mskgSHjK9sC/GpJMmeqiksxttNGAjdwEAJ6LS7ruXv7ddJ
         ciMOnj9wDh7ZU6opM+cO4so5kNoZCIyQPMyBsVl0mM5omlqvwv0wDkMo1Nj6vb7deTUU
         b28g==
X-Gm-Message-State: AOAM5314r2KWo6x49ZpkBYas9Xd/lm771HzTN97Jbd8ps/5d6hEVfMdx
        QRS8yx8seAd4OxHghhQNkjW0bb/m0I37fupg2BM=
X-Google-Smtp-Source: ABdhPJzb/gQaeen1+FWj7OPjgqLdHzxWmmarrQNQCKZLj6PwepiGrb0+6NyKKpzZQPBY6jSebkv0UOHBf+YWAym5ONg=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr19501543otf.132.1606781277532;
 Mon, 30 Nov 2020 16:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-41-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-41-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 19:07:46 -0500
Message-ID: <CADnq5_MeaHtEKC_c8Va8jN3Le15oWqdPket6WWTTG+1DB5G8hQ@mail.gmail.com>
Subject: Re: [PATCH 40/40] drm/amd/display/dc/basics/vector: Make local
 function 'dal_vector_presized_costruct' static
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

On Thu, Nov 26, 2020 at 8:44 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/vector.c:55:6: warning: =
no previous prototype for =E2=80=98dal_vector_presized_costruct=E2=80=99 [-=
Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
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
>  drivers/gpu/drm/amd/display/dc/basics/vector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/vector.c b/drivers/gpu=
/drm/amd/display/dc/basics/vector.c
> index 8f93d25f91ee2..706c803c4d3b0 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
> @@ -52,7 +52,7 @@ bool dal_vector_construct(
>         return true;
>  }
>
> -bool dal_vector_presized_costruct(
> +static bool dal_vector_presized_costruct(
>         struct vector *vector,
>         struct dc_context *ctx,
>         uint32_t count,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
