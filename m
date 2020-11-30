Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125512C9111
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgK3W2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbgK3W2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:28:41 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EAC0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:28:00 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f48so4434528otf.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xuRtX6/QiaNBrOSJvmHFpdILv2m6h3ItAI8etLSug9U=;
        b=Mo2J2scHtsnoTZFWYGhE2uXgYqBTvm9E3lZMPEU0ZVHhNVT0CrkmVWj66h4usWZ0Nc
         z1npRNGi4I4TtXoo1vAwFLj5NUCOI0EW9T+g/RtOlH3pzFj1E4e+E6O+sjvcmljF7uXf
         JFhPMsOWUFvVdWG3DYYS2ocMiS7uuWNjcYmsgyDU2AEyay6wtOze/XdTymR9YxfIi//8
         gCFAADaQlvpmzXHAn+m5WaLE4Bd0LIbVWFBxa66vgWtfO3AfDqKYgvHhDYTdOI/w9IEL
         Ej666kK4WSD7J1XxYBLgryYUnc5nQYRkZjB54xTbTrlvaYU+njufh77czUen2hiW7EPH
         S2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xuRtX6/QiaNBrOSJvmHFpdILv2m6h3ItAI8etLSug9U=;
        b=cUEkKZpBY8/FaNxWV30Bo2P43pFVKDhGWOlEt/pxeCovPE347sfDIQ/fII8Sm+9kBH
         55ZI1vPyRbzVnh9I+jprXnognO+CB6XgTs1pQdJm2/H90AHI4eqvNUjAuQP2we3pqG79
         ocgQjHA7WBE79JwrLxr3CkUrcyIurkvkvYGSAso9X6unXYVFMTrWba4gh+cwQZiW87oP
         OkgAni9eywFwgz9ZOBSuyCOkiEixH1PUCOafzlz1Zb/F/srnyBy4Usx84yP42BNMbQrE
         z8J075ACnV7YJaZNPNMo+B/vHBcUtgsiGBRlE/FP+60uIJnfUSt9BIpZIL8BAyiHQlTv
         MZ6Q==
X-Gm-Message-State: AOAM5312QKMXGbMwGki9QkgMc36W8eg8vIbokgB2HFWo1HluUkUEfAlm
        EMj4dfdV8ZkjgeX5Z4j/6oCYZqe8xfQwOJb7dKS8w5yv
X-Google-Smtp-Source: ABdhPJy0KwDsxXP6JRVNfDVpAEFaTtaZkp9jq6qZhHXUijRsOTzPSOs6EA+yOy2zvn/Vm7oqTG3k8RZxDzhYX2QgcHg=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18762365otg.311.1606775278931;
 Mon, 30 Nov 2020 14:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-21-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-21-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:27:47 -0500
Message-ID: <CADnq5_PFn-H0qEp60sBA2mUQufGnhn5awYrLRi7hfT58sJdE0w@mail.gmail.com>
Subject: Re: [PATCH 20/40] drm/amd/amdgpu/uvd_v5_0: Fix a bunch of kernel-doc
 function documentation issues
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 2:44 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:153: warning: Function parameter o=
r member 'handle' not described in 'uvd_v5_0_hw_init'
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:153: warning: Excess function para=
meter 'adev' description in 'uvd_v5_0_hw_init'
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:210: warning: Function parameter o=
r member 'handle' not described in 'uvd_v5_0_hw_fini'
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:210: warning: Excess function para=
meter 'adev' description in 'uvd_v5_0_hw_fini'
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:463: warning: Function parameter o=
r member 'addr' not described in 'uvd_v5_0_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:463: warning: Function parameter o=
r member 'seq' not described in 'uvd_v5_0_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:463: warning: Function parameter o=
r member 'flags' not described in 'uvd_v5_0_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:463: warning: Excess function para=
meter 'fence' description in 'uvd_v5_0_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:529: warning: Function parameter o=
r member 'job' not described in 'uvd_v5_0_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:529: warning: Function parameter o=
r member 'flags' not described in 'uvd_v5_0_ring_emit_ib'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Nirmoy Das <nirmoy.das@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor fixes.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v5_0.c
> index 6e57001f6d0ac..3a748ec58bec5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -145,7 +145,7 @@ static int uvd_v5_0_sw_fini(void *handle)
>  /**
>   * uvd_v5_0_hw_init - start and test UVD block
>   *
> - * @adev: amdgpu_device pointer
> + * @handle: handle used to pass amdgpu_device pointer
>   *
>   * Initialize the hardware, boot up the VCPU and do some testing
>   */
> @@ -202,7 +202,7 @@ static int uvd_v5_0_hw_init(void *handle)
>  /**
>   * uvd_v5_0_hw_fini - stop the hardware block
>   *
> - * @adev: amdgpu_device pointer
> + * @handle: handle used to pass amdgpu_device pointer
>   *
>   * Stop the UVD block, mark ring as not ready any more
>   */
> @@ -454,7 +454,9 @@ static void uvd_v5_0_stop(struct amdgpu_device *adev)
>   * uvd_v5_0_ring_emit_fence - emit an fence & trap command
>   *
>   * @ring: amdgpu_ring pointer
> - * @fence: fence to emit
> + * @addr: address
> + * @seq: sequence number
> + * @flags: fence related flags
>   *
>   * Write a fence and a trap command to the ring.
>   */
> @@ -518,7 +520,9 @@ static int uvd_v5_0_ring_test_ring(struct amdgpu_ring=
 *ring)
>   * uvd_v5_0_ring_emit_ib - execute indirect buffer
>   *
>   * @ring: amdgpu_ring pointer
> + * @job: job to retrive vmid from
>   * @ib: indirect buffer to execute
> + * @flags: unused
>   *
>   * Write ring commands to execute the indirect buffer
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
