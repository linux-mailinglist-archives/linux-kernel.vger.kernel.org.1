Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D12732DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgIUTby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUTbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:31:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F54C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:31:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e17so622368wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YH5llJy+UZ7IF1xl6CJ1Evb+uKpkOIo3lUNcZYyahmE=;
        b=sywkcLG2yw+k66v57gAmah0RShts+EYALdBeuGD6MBvpHrwmpmwm1OOL9QFjZoEB20
         +/D+/pNVMA1cz3xdYCTVtC93YYPovdOZaNWW66pMtghWhgxgIQG92LtzGPRAO/2FKZ89
         4yyMRHhmaRgcVXFSrBW4SMlNYEUoTrRakDDryjwUDfyGyHQmrCAgcxnj6xf4TZcgUVe+
         szuq+jU3g6/3jql+Y3nemZjnvPJ1opW4WgzndIImu87rQBmoOSDEJIcNlJI6kBOJWIzc
         KcvOe6i7DKCLcZbmDT3UbfcMY6jmChbsFUWSzlhUQCog0uvBMMkRAm9rikrnyBSwgCbU
         wTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YH5llJy+UZ7IF1xl6CJ1Evb+uKpkOIo3lUNcZYyahmE=;
        b=COtxdpMUycVfuXRBIrS4pMbWn3hXm7RO8PYsbwA3KPqe5ZGzZ4IrTDcoUJfmcNe6CZ
         erjZ6YMcDXiDBPO6+AxPJjOnRIMt4YmzPU4BMwfg/+vUnx3XPtfi7TMl/A3QeuZuFrmi
         IxCuTsGtEzhFh4HpzZp8BvkdbQHw4XjhL1HSkopDRghSWFdTFy6bqHKsgQwp9Mv2+Cjq
         o1RcVx6L0zivRp80kJ4wOHfnlPOyfBykVs+ODeAlEeiiKoN+mlOe/FY1svZJjiGPKEmj
         7Nbj6jz8BJXutRxKRoBzaX46qp6HDaFVnAieAq3JQMsbwthvOWPsCd2LwnMYkH/U7Sry
         yqmg==
X-Gm-Message-State: AOAM531D+xg5r8Tl2GGkAJghQxgbFWtnfOxYuzpyF98/j+/dbwF8UFMf
        5FIxGsA14qGOg4W3sBsGAG5gWyz303Iti/AgAes=
X-Google-Smtp-Source: ABdhPJyHFBMoD3EpjZNZZ67IKqNfRPYMlYOLKow9z5LjsfUknWco2H/F7WWqQdd3jCNeg+8YA8Ej8P+WVQ1rMYxGizc=
X-Received: by 2002:a7b:c090:: with SMTP id r16mr912217wmh.56.1600716711938;
 Mon, 21 Sep 2020 12:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200921082429.2591146-1-liushixin2@huawei.com>
In-Reply-To: <20200921082429.2591146-1-liushixin2@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Sep 2020 15:31:41 -0400
Message-ID: <CADnq5_O5y+5xp6JsQt=zXQ4wQOt7iVGiaHTvEV-V9SEW1U5-Zw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu/gmc9: simplify the return expression of gmc_v9_0_suspend
To:     Liu Shixin <liushixin2@huawei.com>
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

On Mon, Sep 21, 2020 at 9:14 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Simplify the return expression.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 5400cac02087..cb9e9e5afa5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1683,14 +1683,9 @@ static int gmc_v9_0_hw_fini(void *handle)
>
>  static int gmc_v9_0_suspend(void *handle)
>  {
> -       int r;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       r = gmc_v9_0_hw_fini(adev);
> -       if (r)
> -               return r;
> -
> -       return 0;
> +       return gmc_v9_0_hw_fini(adev);
>  }
>
>  static int gmc_v9_0_resume(void *handle)
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
