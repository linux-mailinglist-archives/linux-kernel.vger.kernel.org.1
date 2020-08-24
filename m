Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795CD250110
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 17:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHXP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgHXPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:06:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E8FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:55:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c19so6316849wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhgjcGDiszmemLXRD4pV8iiEXCU7SaZcnWn1+uyj7dA=;
        b=u4nFtsVYYLdNR+pErZEZECWTnFSvE3O3DCzrqMuh8reuj9NQ/nCMZAkjiFnFFpRr/o
         7FvO+w2VmWyHOAxj5aNO+F34jF7R+zheD7iHJu+zUHnl6rYJdIqyDePWlgXUNmFr3UWs
         xqNY3r9yO1as69MM2n9kWCCp1OCVoxZBnqiBShqcVYTkpTt2iakcOH2ennn0fyMU4tsc
         Pvfx1qO4ZRMMKMdSWQRJ1Y4xyr7rLFmGO60h5j6UA7XA2X62enGHooY2rCHXPI413AFA
         WtnSpK0waO1zvPf5swCYTTDL94erIKmbKTuEhGduVrrDXiKasgtqKUR+OC08HqX4mH6G
         i43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhgjcGDiszmemLXRD4pV8iiEXCU7SaZcnWn1+uyj7dA=;
        b=ah4y6NBMY3w2bznFT6Ht095xtifn66giuN4TDb/7he5ffm/pJ8YqKXnBaZs+ynjFQt
         cd8zuQ9HmW90oyURwcfuHEQObRR8LpI876WxYxMkA8xqfbStKxTy01ODPnmPSEvdE9SK
         joYntHNSALIXopSrI2l8wgKRqxeU43+bh8ZQzpAWNhlBEh1ATcrPPV7yoyeyMf2PiohZ
         bqE/0z5w8j+d8DaoulcyPUlP8j79NmCEp9hI2SyP5pZoAbtnMRvBks/H0YMShY+rahEF
         o2+RYXRfWhhNjvHu+DsT2r0Vznx4vJE4Vmi0E5VT98YWOORRx+f2X1HDABFG1TKj3rkr
         v6qA==
X-Gm-Message-State: AOAM532R0B/3Lteljlz74otbt+ZT0/atMbO1FRVC9iygH075K7DpoIcz
        S2nq9Mi9LV44y9kIEBUBRQo5Hq3P/dCIBSykKqpzmM2T
X-Google-Smtp-Source: ABdhPJy+o0pSEX67YJFDALr/uKsAz7GjoWM/46FnxnObEN6n0CVfQB0jnjTYCfcivpI2EUL4og7c2zcHY7f127ZJddQ=
X-Received: by 2002:a1c:bc85:: with SMTP id m127mr5905233wmf.70.1598280909545;
 Mon, 24 Aug 2020 07:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <1598084843-32270-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1598084843-32270-1-git-send-email-tangyouling@loongson.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Aug 2020 10:54:58 -0400
Message-ID: <CADnq5_MUkcTk1Mzh+22MRBoYEZnHDzhNkWNBD1XHZaPhYyXOHQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: amd: Remove duplicate semicolons at the end of line
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 5:02 AM Youling Tang <tangyouling@loongson.cn> wrote:
>
> Remove duplicate semicolons at the end of line.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                 | 2 +-
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index e99bef6..8603a26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1108,7 +1108,7 @@ static int vcn_v2_5_mmsch_start(struct amdgpu_device *adev,
>  {
>         uint32_t data = 0, loop = 0, size = 0;
>         uint64_t addr = table->gpu_addr;
> -       struct mmsch_v1_1_init_header *header = NULL;;
> +       struct mmsch_v1_1_init_header *header = NULL;
>
>         header = (struct mmsch_v1_1_init_header *)table->cpu_addr;
>         size = header->total_size;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> index afdd4f0..b320931 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> @@ -467,7 +467,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
>                 mode_lib->vba.AudioSampleLayout[mode_lib->vba.NumberOfActivePlanes] =
>                         1;
>                 mode_lib->vba.DRAMClockChangeLatencyOverride = 0.0;
> -               mode_lib->vba.DSCEnabled[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;;
> +               mode_lib->vba.DSCEnabled[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;
>                 mode_lib->vba.DSCEnable[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;
>                 mode_lib->vba.NumberOfDSCSlices[mode_lib->vba.NumberOfActivePlanes] =
>                                 dout->dsc_slices;
> --
> 2.1.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
