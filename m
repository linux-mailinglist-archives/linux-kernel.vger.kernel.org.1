Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA832C9187
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgK3WvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgK3WvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:51:00 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:50:14 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id x15so708592otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rKuUVtY+nsEmxatsHCyM6yC2Us5rTCT/D5PB3lOTf/Y=;
        b=nbk+q9n0acq44mOtB0AsrG9jstQSzfq9oA/QRV01odGxA9h0TFaHO3GVTOgKtJ5R/m
         NHngmJ/TA3646IOEbrHie3PxRzTaDmKsND0w99UYsM8NNyHR99LPQLlkMpa4bl2Ny9en
         C36PHi+dDWmmDe4qUuF+qp/gVyEosm5GdlbY7EnqqJopOLVjDAnB+8d4uoIMQyByAXGP
         Ma8totA2gMtv4qQtGzxJOxNeBr+5Ep6hoHb1SAWhiPSFBSmfSfAkK3Su3/zpJmwxdI4h
         j0BZoh3EReIUpQlhewEQuYmFJjAfJhesQ39THfJOi3UuUWfiw8CRPVGMeV7FYJenYlNp
         gVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rKuUVtY+nsEmxatsHCyM6yC2Us5rTCT/D5PB3lOTf/Y=;
        b=RUDQACQ2ze5bpfob/Jx6+DcON0EVGqe6hwVireMrCNt26gQKnchU7qs5QcBlp/4FsB
         BczP4a1oWW/92rN3KninHLmKD1g6qURzQzx9GlqvSwmTurajRqj5L44PUPoWwTDAGZf6
         CsZ8V30UBgcugXREPvoLdDyA/qTRzDJ69Xy711CSzuYxVrqQVl5zxXhsc2+wO9MpJnnz
         B142Ah1/zK1HAbUQmPcSv+5Nx6Y/5LP94VjLvJ+3FUjiMSoWi7ZUkeeaxhz8oyn1r4mM
         1lX/TUibnnwCNix72TaxY9ewczhi4HGqp3fghWThtmoY2iiPiZ06zOWYts149lGrc6Bm
         Unxg==
X-Gm-Message-State: AOAM530be9ntihRXMtMKf6waBlkvEqbxTAmxJ/EwW5znQPxCb2NRyUaI
        6l6qzlRCqBNU0kaTtNUlj8YIArBqz1nSl3f33/UURyeY
X-Google-Smtp-Source: ABdhPJyTTVDUFd5wXUYpYb7VcwfQyhGUKOFwV7lJzfFshdU4qOoyVX1kRz8foAvK6OGSFTs4z4xGOiCbwkx2PYhIyqI=
X-Received: by 2002:a05:6830:22e4:: with SMTP id t4mr19083678otc.23.1606776613855;
 Mon, 30 Nov 2020 14:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-35-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-35-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:50:02 -0500
Message-ID: <CADnq5_MKtkHNbZ0cn5D2Ju+QcGah1WgNCf+W9WqTrmw--zWsgQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] drm/amd/amdgpu/amdgpu_acp: Fix doc-rot issues
 pertaining to a couple of 'handle' params
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 2:45 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:183: warning: Function parameter=
 or member 'handle' not described in 'acp_hw_init'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:183: warning: Excess function pa=
rameter 'adev' description in 'acp_hw_init'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:412: warning: Function parameter=
 or member 'handle' not described in 'acp_hw_fini'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:412: warning: Excess function pa=
rameter 'adev' description in 'acp_hw_fini'
>
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_acp.c
> index 1400957034a12..b8655ff73a658 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -176,7 +176,7 @@ static struct device *get_mfd_cell_dev(const char *de=
vice_name, int r)
>  /**
>   * acp_hw_init - start and test ACP block
>   *
> - * @adev: amdgpu_device pointer
> + * @handle: handle used to pass amdgpu_device pointer
>   *
>   */
>  static int acp_hw_init(void *handle)
> @@ -405,7 +405,7 @@ static int acp_hw_init(void *handle)
>  /**
>   * acp_hw_fini - stop the hardware block
>   *
> - * @adev: amdgpu_device pointer
> + * @handle: handle used to pass amdgpu_device pointer
>   *
>   */
>  static int acp_hw_fini(void *handle)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
