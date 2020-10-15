Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9DB28E9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbgJOBUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbgJOBTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:19:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43840C045705
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:12:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z22so819007wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7A/vYsnX6r+7AO5gfQk7caI7db0kds+FfKedxby9yM=;
        b=BBMnKnlNuVILoOTKj4UL/ioGQxnXg9fTI0B8FODsAWJsreaC1OVGnqc5VKTZNWA1i1
         g9vbCk4BIevgGnvr1bjnRpEel7ZflIsk1N0Sj+hho8t251QjUmvxdupHZGsjWVFjRNSj
         Rh+KhVe9zpKM9CN3V202kQ3f2MtbonZvXV0i2rWajKcS4sOtiVDzm4ahJDco3CaQjZC0
         IYyLJz03ftS92LOpUKuvGftMwVxG94U1WVJ9MbMJ9z5jSZApg3494Dd0Ql798q265XZs
         Ps3e7tWCJwXCkyPC9K9m/DQ6Egt02IRopqtcfFN9qDexqgV3XveaZ+/UYfYUKguQiE5H
         YkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7A/vYsnX6r+7AO5gfQk7caI7db0kds+FfKedxby9yM=;
        b=HFpb97rLlZ6iJ8Hsy/ixbGaX7tamQyXP9YShc1H+2mQMtRQcaFrOG6QJwr7kZnjFy8
         T9W70n1rmYTVZSeDpEVq3rm45xxH/KGeh+WnTQWbP4aamBluTT4XxbzbFfhXjZQhGY+B
         dfxLKopVt/udELphhLn85HV07IfH8muXBc25qNonIo611e+Z3KhejTeT+ftXgYcuSsMt
         nfeDc6ApQnY/6hj6RoWKhdVlORaZLVMK+n6NunSYib38HHVJyjsjGenNlYuZmo8MzXKR
         mQZOueJF1ThMeSqhQLqEe0QnZXNFPPzJ8+rUaPjD6muRP3YHo7jVbPLuKIK95UZWKTl8
         Ndag==
X-Gm-Message-State: AOAM532HZeLpLSQrR+IcBiVOV5BjQIIaNvysoQGNVNT5f7J4Eaa767M8
        9aUYpnHQlMwEhkJCnLBuYIRskOJkhstEBlh60F0=
X-Google-Smtp-Source: ABdhPJyLSETrSo+oPb+19aB+lT2F+Rt9xNwt6EhwO4ctXDSsCbZLOhRujww+UZxJr0CZm/xOX2OEQoSX9qCNnttfJiQ=
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr1345976wmd.79.1602724341351;
 Wed, 14 Oct 2020 18:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201014211806.16282-1-trix@redhat.com>
In-Reply-To: <20201014211806.16282-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 14 Oct 2020 21:12:10 -0400
Message-ID: <CADnq5_MuAJp+m2NqAn6GYK5g_vnObVBz-vbCo2O_gCLjDy73pw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing newline at eof
To:     trix@redhat.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Dennis Li <Dennis.Li@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        "Chen, Guchun" <guchun.chen@amd.com>,
        Sonny Jiang <sonny.jiang@amd.com>,
        Xiaojian Du <xiaojian.du@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 5:18 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Representative checkpatch.pl warning
>
> WARNING: adding a line without newline at end of file
>  30: FILE: drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h:30:
> +#endif
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
> index f26246a600c6..4089cfa081f5 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
> @@ -745,4 +745,4 @@
>  #define RLC_EDC_CNT2__RLC_SPM_SE7_SCRATCH_RAM_SEC_COUNT_MASK                                                  0x30000000L
>  #define RLC_EDC_CNT2__RLC_SPM_SE7_SCRATCH_RAM_DED_COUNT_MASK                                                  0xC0000000L
>
> -#endif
> \ No newline at end of file
> +#endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
> index 29929b360db8..d8696e2274c4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
> @@ -27,4 +27,4 @@
>
>  extern void vangogh_set_ppt_funcs(struct smu_context *smu);
>
> -#endif
> \ No newline at end of file
> +#endif
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
