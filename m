Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2212C90BB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgK3WMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbgK3WMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:12:10 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB61AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:11:29 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 11so12874916oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ETFvsz7DPdLzPT7VlFuUB/Fkyqm4Ejp9KpTAnp1NCwQ=;
        b=ndXitIrz54miGNcQSrozcAEwWCdIJKXgWMZk62ZLI2HkixdmOHzTQM+TZwhUgswJ4n
         EjtZGRieJtB+0N/H5SeXKdDjNiF3NU0v3Gvn6b2lIrHOCoEcaPTBsPt3oP5j+1g02XNZ
         ZJkr3nA+Zsdc/ZMJP20Amy8Zs4N9o/TNrBEFB1OSzfr0Ls7aVKdz7n9ZDyQy7JdVoddS
         Ax8ALMpE96jLs3MGl1xTeVQa0ig64u9ryjgZgwhsujSftvi1u6jb7RyaQO/48nVF2mX8
         sXTjXQvr7v9PW3qT5IW1n5Z1fMBOZMDgexlhM4Oxo82n6ZXYW+IB4JBrmh6Z/RW3XxWD
         gZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ETFvsz7DPdLzPT7VlFuUB/Fkyqm4Ejp9KpTAnp1NCwQ=;
        b=HagEksn8RZv7w+ve62aM9epL2ig1BbveEhNjJ4vfQBnLmb75x2AayXndFbh4E6jRg8
         rfeu/V5yeH1/7WkHoE2LZIwWQ7iFHV/MnPuhIU0oDdqeqZBcNAmUTZo3LQ5FoFrWtlHl
         eMXynzy+/1GKw9Y80vtfXQbuqXfqToif3PCtRXZkmyPCwZ8cgXsDScLT2sZx4E+QSR0F
         lvRoEXuF2607PvTQ/huGwMf7a1a3cukG4xqrzML5fKkp+COi7PqQzFZlEIAgnTibwccH
         4ePl+2gcfb99PzocJDYE9Mpx/gJ5gHXHjPqI3QMU8bGY1l6QqBEbCXNkFzis94Q2Pvhd
         X1Xg==
X-Gm-Message-State: AOAM532jY9IUETkSwY1jNXd4PIG7uc52Lnm/eDn0mTFKEAOJceoXBdUQ
        SYlKcDVVNClgq3wXrzAt+ctJTxUKsmsOCgCKJPU=
X-Google-Smtp-Source: ABdhPJwhOON7aAvHf5vEQnbPq+Zn1bRIyLJ221qqr9kjhkdxurNXiMOF4uiyqatAIebwHcYfxEj/y1hCzwWzyz0SJjM=
X-Received: by 2002:a05:6830:22e4:: with SMTP id t4mr18967658otc.23.1606774289360;
 Mon, 30 Nov 2020 14:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-12-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-12-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:11:18 -0500
Message-ID: <CADnq5_Oev8Kfxa1HGR=NRBktOMUe9N_11WKBYDzgi8MfB3BOtQ@mail.gmail.com>
Subject: Re: [PATCH 11/40] drm/amd/amdgpu/psp_v11_0: Make local function
 'psp_v11_0_wait_for_bootloader()' static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 2:45 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c:223:5: warning: no previous proto=
type for =E2=80=98psp_v11_0_wait_for_bootloader=E2=80=99 [-Wmissing-prototy=
pes]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v11_0.c
> index edd2d6bd1d86a..bd4248c93c49f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -220,7 +220,7 @@ static int psp_v11_0_init_microcode(struct psp_contex=
t *psp)
>         return err;
>  }
>
> -int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
> +static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
>  {
>         struct amdgpu_device *adev =3D psp->adev;
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
