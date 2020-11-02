Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62F02A3382
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgKBTA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgKBTA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:00:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B7C0617A6;
        Mon,  2 Nov 2020 11:00:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c16so10528101wmd.2;
        Mon, 02 Nov 2020 11:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F52hESqbsB1MPJOrdkRKIslrWAc4TnNYL/WsFrJgJKw=;
        b=toR2HRVdMm7mruxLONthC9XCLQ2NZM7kvv76jNtete8uCBDGb7+45cxZPdkRDrH59n
         mn2jusHu9DC1CUcCHVwWrwrx9yQo08XLXrLovUsOY5/VwQ6fZZt1KTBDX5NmBVMIkDJ/
         EqzMvk5nkdMc/DdJ3rJLd0EEbCXCRxhE6F4DpSADFhnaACYbCq0Hnc2XlDtBEEdM65eK
         mEBe1NZXRRvstr8m9KiSpO7zQoHflmYdRbRXgRC4upO1zH0T0LlMuSyVJXcvmbZwW+F8
         OFSAa6P+DaJTq+YT2/qF24jsGzErQR+Di5uTo15pZT5amGCHl13xKVdMKuoS8iWJur+C
         ptag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F52hESqbsB1MPJOrdkRKIslrWAc4TnNYL/WsFrJgJKw=;
        b=RRFw0cSFoJdbTYdkjdl/EwQBiGhJjf1Kp00gIdklUFHF9KcQC2ekBW3djHCbPfLLkP
         R6t/fFHHeToqHRJEd0LEepOf4W7QPzxDZEE2lLL0tQ+J9UxA2XAQzvkzJyXWHx5cwxE1
         PaQ8QjW4OKr61CDA/IKK+3juLjXfK+vA0SY56rDkSNtZpOoFq60n09RAf4Z1NTcU4L1/
         c054qVqMP6/u6PAx5FGbP3Yrq7Kn+/tY0la5EA9ya+h8wG5aB5Pnu10Q08eguqRwWDqm
         ySB0v6DomAcr1AjT6diUIZCoivUI3UR9BpHFjwIURnpVlimElR2UaxbpPosQ0SEUxkx+
         vQ9w==
X-Gm-Message-State: AOAM533p0xoO8VoloapGu+Su5URh90rF6XDS3Fs+2mOgwEdqD9FWYCtO
        0oUladVqscw3ANWAzWp76WsFKFxyQcJTR4DkQ3/qrghE
X-Google-Smtp-Source: ABdhPJytQUYMUMSyXdcmVlTI70Lb9uFFEdcAtoiyeavU7SDPkzfzLliepONejZLqlw/MJVxGDHVXT7e6qiW+8huN4SQ=
X-Received: by 2002:a05:600c:25a:: with SMTP id 26mr19186350wmj.39.1604343625759;
 Mon, 02 Nov 2020 11:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20201102141654.699468-1-colin.king@canonical.com>
In-Reply-To: <20201102141654.699468-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Nov 2020 14:00:14 -0500
Message-ID: <CADnq5_NJ=X1A+R5rHCvLZAXWpAL-3YiN_ksrzY8Kjuaoj1ybeg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix spelling mistake: "Successed" -> "Succeeded"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Nov 2, 2020 at 9:17 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a deb_dbg message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 28a5c0d21b71..c99c2180785f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -296,7 +296,7 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
>                 if (drm_mm_reserve_node(mm, &rsv->mm_node))
>                         continue;
>
> -               dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Successed\n",
> +               dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
>                         rsv->mm_node.start, rsv->mm_node.size);
>
>                 vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
