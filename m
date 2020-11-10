Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2832AE428
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbgKJXgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731996AbgKJXgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:36:37 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC34BC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:36:36 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so110160wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1vhq0fZC4oEpfVvFOkQj37w7y2qw+vzKtXNkn44TpOc=;
        b=dE1NeymRsVp6PprpoWlKUxsLKgt9KHMj3DSrY7/9mxq/9tBx/o6SchkxmgNNX3FjP3
         WAMd5d5WTS4ydXIZU/8bA5RrqfD5geVHcPH9QjnfIv066iZDAIMu4hSKmkTNRCMDvG6Z
         S2wQt2cEfWNHbgfuIEQd3aZeErRaGW+MIbc43/OCb1OE3jgx1Le1RU9nnU0KjFS+Laxd
         j8q+nVFJ/muYQ1BNoGfx135NcsTdca+I7X64HqpXD690lM32eyJ5qfSALQKLv7ZJHQqw
         NVR52iiEXXTaD0bWXHpmBOACc9X3DJAElzKOicyuw3F0wACK5Z95Ix6sv5crAM58alrE
         Ir0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1vhq0fZC4oEpfVvFOkQj37w7y2qw+vzKtXNkn44TpOc=;
        b=j/Po1fJ9NV5F6ZvrUSKX7YE8Vf5rJZd9GJp4es2IlyKeHeTwC49nv2HZaC+Y/oMvIb
         rp6dWtv+nNch8Cf7ULGLgCErM2tG//kOGEwHG+sLbFnnTBDBUegJ1ciGZVSnLE1JBBOc
         3yeRjSyfueIIcc2omvhO+zRIbINqngLnpCjh2DvEHWFQMGjnKbURrEHAO/DLM3cd7oWo
         16/1gJ2SRdmE12Gep4GP603k+tuE3wSHQGvnahzitUC1/lMF+zhh0W0PfXrCx2tzSt21
         3/HvfgI1Uzi3I14qEYtHkAJnzyQyUcCjnmDzjTVk/UYE5Ol3xVLOTkSKcc89OSelo3S9
         QKIg==
X-Gm-Message-State: AOAM533YJGoZgBOot1rNYGYiWXxjFinGwV4nrLJMaA7dMgUssQvu+xlN
        ZFyUzalCQRv8I7f2zGqVsJGltYUrda694wj+qprlCOei
X-Google-Smtp-Source: ABdhPJylcwzZPYC4LfKGtFEWuOFSx7dJ0oAZ1VColKd/icnq0WCIEhmrYrBYFhb/k7UalrAXcnog0wJMOKpqljLhKFc=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr532569wmb.39.1605051395550;
 Tue, 10 Nov 2020 15:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-10-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-10-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 18:36:24 -0500
Message-ID: <CADnq5_N2tjAn458re5Cj+ZY8p3NoXZH9HM=_4k+v_SaVgxo-Eg@mail.gmail.com>
Subject: Re: [PATCH 09/30] drm/radeon/radeon_vm: Fix some function parameter documentation
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

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_vm.c:131: warning: Function parameter or m=
ember 'rdev' not described in 'radeon_vm_get_bos'
>  drivers/gpu/drm/radeon/radeon_vm.c:643: warning: Excess function paramet=
er 'start' description in 'radeon_vm_update_page_directory'
>  drivers/gpu/drm/radeon/radeon_vm.c:643: warning: Excess function paramet=
er 'end' description in 'radeon_vm_update_page_directory'
>  drivers/gpu/drm/radeon/radeon_vm.c:819: warning: Function parameter or m=
ember 'ib' not described in 'radeon_vm_update_ptes'
>  drivers/gpu/drm/radeon/radeon_vm.c:915: warning: Function parameter or m=
ember 'bo_va' not described in 'radeon_vm_bo_update'
>  drivers/gpu/drm/radeon/radeon_vm.c:915: warning: Excess function paramet=
er 'vm' description in 'radeon_vm_bo_update'
>  drivers/gpu/drm/radeon/radeon_vm.c:915: warning: Excess function paramet=
er 'bo' description in 'radeon_vm_bo_update'
>  drivers/gpu/drm/radeon/radeon_vm.c:1155: warning: Excess function parame=
ter 'vm' description in 'radeon_vm_bo_invalidate'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with a small fixup.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_vm.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/=
radeon_vm.c
> index 27b14eff532cb..71f2edcac6ea0 100644
> --- a/drivers/gpu/drm/radeon/radeon_vm.c
> +++ b/drivers/gpu/drm/radeon/radeon_vm.c
> @@ -119,6 +119,7 @@ void radeon_vm_manager_fini(struct radeon_device *rde=
v)
>  /**
>   * radeon_vm_get_bos - add the vm BOs to a validation list
>   *
> + * @rdev: radeon_device pointer
>   * @vm: vm providing the BOs
>   * @head: head of validation list
>   *
> @@ -629,8 +630,6 @@ static uint32_t radeon_vm_page_flags(uint32_t flags)
>   *
>   * @rdev: radeon_device pointer
>   * @vm: requested vm
> - * @start: start of GPU address range
> - * @end: end of GPU address range
>   *
>   * Allocates new page tables if necessary
>   * and updates the page directory (cayman+).
> @@ -802,6 +801,7 @@ static void radeon_vm_frag_ptes(struct radeon_device =
*rdev,
>   *
>   * @rdev: radeon_device pointer
>   * @vm: requested vm
> + * @ib: indirect buffer to use for the update
>   * @start: start of GPU address range
>   * @end: end of GPU address range
>   * @dst: destination address to map to
> @@ -900,8 +900,7 @@ static void radeon_vm_fence_pts(struct radeon_vm *vm,
>   * radeon_vm_bo_update - map a bo into the vm page table
>   *
>   * @rdev: radeon_device pointer
> - * @vm: requested vm
> - * @bo: radeon buffer object
> + * @bo_va: radeon buffer object
>   * @mem: ttm mem
>   *
>   * Fill in the page table entries for @bo (cayman+).
> @@ -1145,7 +1144,6 @@ void radeon_vm_bo_rmv(struct radeon_device *rdev,
>   * radeon_vm_bo_invalidate - mark the bo as invalid
>   *
>   * @rdev: radeon_device pointer
> - * @vm: requested vm
>   * @bo: radeon buffer object
>   *
>   * Mark @bo as invalid (cayman+).
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
