Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79D2EF93E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbhAHUcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbhAHUce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:32:34 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5BAC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:31:53 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id p5so12760914oif.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WOWvGccuA9CfphlY28N4bX1uXEPqXzSI/PRFbkID3nU=;
        b=DaiussA/9wHvPipkNTC0AFsJjBQp/JDFSjazIpukka2pKxkkWTZllNnMNgTPceeXje
         hKnl9Kgz3EMVYRAueTqv3uC/OBi3W6PhfY/XAK1R6XI0BXrlKOpsfqAF2ZdBsWvm4UUk
         f8udo/1e/hFlb5P/j4NvcNgufZeK0o4fSRVw+gGBvd22t55A+bOvmCtTj0A8qQbRf9wZ
         Ry7UM8Rtk/rNw2iFPYATox94gB9KUBm8F7nkkWz6uP9WdkthwE0LZQPp9jTSXqmCROA5
         hvPswPCO2/Wa6O+qyvarEA6IVcKuKBLxBJ6wrl6ck3Yl+01dZ4ij1uRwjS/Ot3VtT3Xb
         pwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WOWvGccuA9CfphlY28N4bX1uXEPqXzSI/PRFbkID3nU=;
        b=bjsxIquBFeMeYsLmxIZCQleIVXz023ClRtvzCTwZLdwwu6g9uEmf6yhwUFMBD4IRX5
         ktslx/eSvAiq4BbOLGQg8hqRXHGCACYjibgGGhGEgDjXMC8lyJ2cbgV+cD0ZHAHgRDRF
         mVDPJWtQMTqKVWNv9c3Ap+3ZLkcDp4NPrqHcQ6IziuYtyV4dvpjRYXjV6qipiIfW0zAC
         c3b6Vf5ieBq3BO6JNShVDCNet6nN+cr2n+Q0ekm15ySZ+qOR++R7+IEWEGAnEK9JejGi
         /GmSdLq3loBz/gPBnPjeI2bavPnen7arMoa5oBd9RTTshG0e49aUTFgeEJagBL8alH5F
         JnZA==
X-Gm-Message-State: AOAM531TmzceK0VYevFs3aB14rZzKl5Swi4/yv+CH9XOhYYJpLz1kENB
        5wtI4Z0T4rdvrs9JCi8jEdpGHConpOUEppgy2Uw=
X-Google-Smtp-Source: ABdhPJyD9/zbc4Uufjw1vw5XaOQE/ALgK3ZSZ4xRYX0adlNEEVoHhBHo5HKaAAYVKb5sI7A0VRrZB57WwsEm2b20HNs=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3402827oii.120.1610137913376;
 Fri, 08 Jan 2021 12:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-6-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-6-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:31:42 -0500
Message-ID: <CADnq5_M91oJ4sOJCWs1s390mRAMMd=mpOZKowvDAupzrqPZORg@mail.gmail.com>
Subject: Re: [PATCH 05/40] drm/amd/amdgpu/vega20_ih: Add missing descriptions
 for 'ih' and fix spelling error
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Feifei Xu <Feifei.Xu@amd.com>,
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

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c:378: warning: Function parameter =
or member 'ih' not described in 'vega20_ih_get_wptr'
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c:421: warning: Function parameter =
or member 'ih' not described in 'vega20_ih_irq_rearm'
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c:447: warning: Function parameter =
or member 'ih' not described in 'vega20_ih_set_rptr'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Feifei Xu <Feifei.Xu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega20_ih.c
> index 42032ca380ccf..5a3c867d58811 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -88,7 +88,7 @@ static void vega20_ih_init_register_offset(struct amdgp=
u_device *adev)
>   * vega20_ih_toggle_ring_interrupts - toggle the interrupt ring buffer
>   *
>   * @adev: amdgpu_device pointer
> - * @ih: amdgpu_ih_ring pointet
> + * @ih: amdgpu_ih_ring pointer
>   * @enable: true - enable the interrupts, false - disable the interrupts
>   *
>   * Toggle the interrupt ring buffer (VEGA20)
> @@ -367,6 +367,7 @@ static void vega20_ih_irq_disable(struct amdgpu_devic=
e *adev)
>   * vega20_ih_get_wptr - get the IH ring buffer wptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
>   *
>   * Get the IH ring buffer wptr from either the register
>   * or the writeback memory buffer (VEGA20).  Also check for
> @@ -414,6 +415,7 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *a=
dev,
>   * vega20_ih_irq_rearm - rearm IRQ if lost
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
>   *
>   */
>  static void vega20_ih_irq_rearm(struct amdgpu_device *adev,
> @@ -439,6 +441,7 @@ static void vega20_ih_irq_rearm(struct amdgpu_device =
*adev,
>   * vega20_ih_set_rptr - set the IH ring buffer rptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
>   *
>   * Set the IH ring buffer rptr.
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
