Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15843297770
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbgJWTDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbgJWTDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:03:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA15AC0613CE;
        Fri, 23 Oct 2020 12:02:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q5so3062358wmq.0;
        Fri, 23 Oct 2020 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOB0JzHjbA9wQ5NG9BGjyGSWpxAlxpb+jyv90TmNGmA=;
        b=mNySan2I0jTCmPSKxF10PPz3YaNEMZPIjR6UuFiFlr4d83tPvQyAzrHwDDGwpnznFl
         X3PWCkQScWhaxcr8U/hvO+k5yNeTD/fRrbyCDG/5xoZlrRScwoQfjRGVCHcPr3zkpHYX
         EVIJSiN9s5mLhwQE//jCLwxO6/R34O7azXq2csdt+WnT/ItPoKsGbaq8a9gWfbdhGbF3
         WayMvL3jXbQeXUz3J0BPhTFlunoMXJVkPSWgYMXnCcNRJmaTbc0VlF5KMMm3M95mU+g9
         6c3VUI4DpQIpDTfTlJrnS9BNJdP05g31Kb5WO8HwKUK2lHILEEpzUjUqjqJuD1YKk+0g
         nc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOB0JzHjbA9wQ5NG9BGjyGSWpxAlxpb+jyv90TmNGmA=;
        b=OF90ZBVhyeV1m3fU/N/zWDjP5XFtpnfu4kAyczvNNzPw0kmuUcnU04rDofsfsJjiP6
         rvkMKBWmDWB05kFtyF0DCPoGMheARB5ZytiJn3NixzAGA9t8yrBSkJ73O4ErG9mrF+jx
         J6wleHLyDRRDC5I2V0/NoJezUCZS+a3HXqczbH6pHExBayDc13Vidp9P4KCSuY9dx0d/
         YgVQ5UclC6yqZS8CWQAXhPka6z5WNgzV/GAc0QtQO13V0V+hcs1bWHJXHCg0go5eYG3Y
         YH/fXJeUeZ7ZcWyF+veZFBELoq1fN+TrO6bYw7mACrDr3uuRly/NvxMm6xpbKmShI0Od
         bObA==
X-Gm-Message-State: AOAM530hIG3WvOPkNyqJ1rMEJA0xayMwhTW+tAsHGVCoxPRz2urkoe/4
        mj3rzC38lVTkua+y7XTfKv5Swx9kHZ9Bi/Zj5x8=
X-Google-Smtp-Source: ABdhPJyBs9rLm8WQ/JdNSYi4YpeykUC3qTYLy1NXVB+RxZLjYHvbVJpKhrpymA1DrvebkV7cRe6NsL6PANeL342Hh38=
X-Received: by 2002:a1c:e4c1:: with SMTP id b184mr3037167wmh.73.1603479778669;
 Fri, 23 Oct 2020 12:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603469755.git.mchehab+huawei@kernel.org> <31341a0175f0aa4ec160d10b27a91703bdd9a036.1603469755.git.mchehab+huawei@kernel.org>
In-Reply-To: <31341a0175f0aa4ec160d10b27a91703bdd9a036.1603469755.git.mchehab+huawei@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 23 Oct 2020 15:02:47 -0400
Message-ID: <CADnq5_MjP1_YPFYYuaO+z9KTpMd+Gk6mtB74P1LjbFrOUt70pg@mail.gmail.com>
Subject: Re: [PATCH v3 02/56] drm: amdgpu_dm: fix a typo
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Stylon Wang <stylon.wang@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@linux.ie>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Oct 23, 2020 at 12:33 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
>         dm_comressor_info -> dm_compressor_info
>
> The kernel-doc markup is right, but the struct itself
> and their references contain a typo.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bb1bc7f5d149..48ec0535d92f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -583,7 +583,7 @@ static void amdgpu_dm_fbc_init(struct drm_connector *connector)
>  {
>         struct drm_device *dev = connector->dev;
>         struct amdgpu_device *adev = drm_to_adev(dev);
> -       struct dm_comressor_info *compressor = &adev->dm.compressor;
> +       struct dm_compressor_info *compressor = &adev->dm.compressor;
>         struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(connector);
>         struct drm_display_mode *mode;
>         unsigned long max_size = 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 34f6369bf51f..a8a0e8cb1a11 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -86,7 +86,7 @@ struct irq_list_head {
>   * @bo_ptr: Pointer to the buffer object
>   * @gpu_addr: MMIO gpu addr
>   */
> -struct dm_comressor_info {
> +struct dm_compressor_info {
>         void *cpu_addr;
>         struct amdgpu_bo *bo_ptr;
>         uint64_t gpu_addr;
> @@ -148,7 +148,7 @@ struct amdgpu_dm_backlight_caps {
>   * @soc_bounding_box: SOC bounding box values provided by gpu_info FW
>   * @cached_state: Caches device atomic state for suspend/resume
>   * @cached_dc_state: Cached state of content streams
> - * @compressor: Frame buffer compression buffer. See &struct dm_comressor_info
> + * @compressor: Frame buffer compression buffer. See &struct dm_compressor_info
>   * @force_timing_sync: set via debugfs. When set, indicates that all connected
>   *                    displays will be forced to synchronize.
>   */
> @@ -324,7 +324,7 @@ struct amdgpu_display_manager {
>         struct drm_atomic_state *cached_state;
>         struct dc_state *cached_dc_state;
>
> -       struct dm_comressor_info compressor;
> +       struct dm_compressor_info compressor;
>
>         const struct firmware *fw_dmcu;
>         uint32_t dmcu_fw_version;
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
