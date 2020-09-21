Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB482732D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgIUTa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:30:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE0C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:30:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so14025163wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MG5GeuWsQTyPF2iATQLYUVJQWCXYJxETCbv2BxD/ONg=;
        b=P6yLcsoz2LpsjDOE8gTegsB2wajcD/ezKZ+8GmFofaTZyH7j7FJvN3PoFSLwbIIuf8
         x9YW0gOnctd2n/AlxOe8gcT3uOnoSu4KEyFL4fiTDUHcn1HEXrKDsvcoa+39QaVJ+LvL
         beXnLt7QYRHHlhgx9JZkOjQYHKiu7k6xfVKJ5KnixMs1D96DTLtaXlAcYWW23HAm8O+1
         rX0W9GTHZcL8x/7LfspOIjmD3+s6fJlpV8RYwPmrV0ShQLnXNY7XxgpUITNxEe1vaLDU
         lAStgGa9vWH19vvqFrwa7HHWEYrLKW9xqjFYQM63tXyz7/6SWqvkD1iTNdJXGFeneJdo
         adKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MG5GeuWsQTyPF2iATQLYUVJQWCXYJxETCbv2BxD/ONg=;
        b=uScAVzcYEVhmlQnTUTZlnWi5KXOFXzChJHp4ZStOIeU2mMGM2KBByxhH+64OP51Y42
         36C81bmhViL07lOTX2aUaTehHsgCmhF34xMtAOs1c6IciueP+mO/dsTk9fGR8G0bE62k
         /LQDY30jCVj6PaAJXHL+6mo/JtBuGm0Z18FVHsJPz58XDUA0CEuYZ1r9dRvjhRq94nvm
         +rIh4ZsqP7ZbRxe9ErVtQdo2T+zUhl53OpO6U8A55/hXlBiNC7ZLxB0qwc5kNde97zf7
         CzTcxyee3S1lyPJRfwzYXhEl6gpgzdneZNlo4MVwY7y4M5vpsVn/1Xljq8M/4h18Yw89
         1RrA==
X-Gm-Message-State: AOAM530WvSKEjKIixEfNDydbJxK5Sbf+Jnp/w1/p8GgrGFdforSxubRo
        8dec3dvJBjKtJxXSmek8sYIyhCB12eccsTxaePc=
X-Google-Smtp-Source: ABdhPJzpMRT+ByT30Axa4Ty74Ac4xlaFFz/Ka6NEYDah9H69c7vzyyTUyCQgjosQ+WdgTYc+fKmhSZ/tZqIjOCt5mKs=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr1391164wru.374.1600716655805;
 Mon, 21 Sep 2020 12:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200921082430.2591201-1-liushixin2@huawei.com>
In-Reply-To: <20200921082430.2591201-1-liushixin2@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Sep 2020 15:30:44 -0400
Message-ID: <CADnq5_MjgpEeZgv3FL9f1TvQCuEvfi_xhV9=Lu5A+Q_yLBuYdQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/pm: simplify the return expression of smu_hw_fini
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
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 5c4b74f964fc..3612841d40dc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1214,7 +1214,6 @@ static int smu_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         struct smu_context *smu = &adev->smu;
> -       int ret = 0;
>
>         if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
>                 return 0;
> @@ -1230,11 +1229,7 @@ static int smu_hw_fini(void *handle)
>
>         adev->pm.dpm_enabled = false;
>
> -       ret = smu_smc_hw_cleanup(smu);
> -       if (ret)
> -               return ret;
> -
> -       return 0;
> +       return smu_smc_hw_cleanup(smu);
>  }
>
>  int smu_reset(struct smu_context *smu)
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
