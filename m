Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763472C2C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390158AbgKXQKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389951AbgKXQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:09:59 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516B0C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:09:59 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so2872901wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iqJIUuS7KLmh98YT0QjvcVlwofszfzY1+e6fUQMyvJs=;
        b=vJvfNmZLFqmZkMHGHQMmh0eF45ktE6rrwLGwpO1yzxqbmOHZGQIh2NnkXYcZYFMLLd
         Hrwv22x4DJ0LD3sdDpwYTPqkoRC7OvGMoWg7BjCLCLz7ScEKY9pKOilMgC0BSkxAa8oB
         uKO7GMz4rNW6PMC4gI9j6aExVbzoCM+ap9vTYOkcIxhRXPpih5wfkSnSiKkpFqTHiYg6
         C1zXEwHf5rprO/+fFMSRsa3H8sGIYOkhwxRpIPyxP6SQbBx7HCGpfeJf8XdpHthDjeIF
         fi0bhPtfaO9sMG6lPs4tYxxVtu5xGFDN6aHpl3r5X2BhNme7MSfhqpHw/O+9xKpPvx5k
         1P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iqJIUuS7KLmh98YT0QjvcVlwofszfzY1+e6fUQMyvJs=;
        b=DkaRGmCfjuNvu+DXoc7+DTUQkrIexh51cY3L2bRCSTd+f3iO1KGCU3wGYOZu8pSdmf
         V4xDoT264oHpcmhOARoBln91BIIsntqFlaEsUIs4i4j3axY1ZKD9cSeF3fNiga1qp4Px
         ieO7aWr6wW79BBrJWjqw3ga6ikAiaw2Af5bvh8a8K7TQBJAkFEhCKGcU2nI9F7xzTCMW
         7LC7XDkza4EdOG7cB1LBIDMmhXksxFl/dWIWKNlC9DlEgg4t8A2K2b6neXN5xGQFhvGA
         jGAG37RUbn6XgLRKk1zdLbx755SONkVbm5s9H8cCMBQrYwhPeUnH74LEI0KTBSsC6XJZ
         zWUA==
X-Gm-Message-State: AOAM531w5c51Cgnsh2COuABSzUY9q1rUPo496Wc6kED8cd5xhIaSN98b
        i6XnMNl/B4ctfFAELc+T+zFwBzaXyGRYtlUXWyj5aYem
X-Google-Smtp-Source: ABdhPJwtclsjVrgMUgdPVJ9gY0wSatj9hv2bVNF2NTRqMwQNCf3YV0GlA0Pz3qqykP2n+rrBkrNHjavGpPLNvI5fs9s=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr5086060wmb.39.1606234198121;
 Tue, 24 Nov 2020 08:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-22-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-22-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:09:46 -0500
Message-ID: <CADnq5_Nad-G-n3Wu7E8=Whw9aj=VYpSLWvURvwH4htvj1UCNsA@mail.gmail.com>
Subject: Re: [PATCH 21/40] drm/amd/amdgpu/uvd_v3_1: Fix-up some documentation issues
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Sonny Jiang <sonny.jiang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 6:20 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:91: warning: Function parameter or=
 member 'job' not described in 'uvd_v3_1_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:91: warning: Function parameter or=
 member 'flags' not described in 'uvd_v3_1_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:108: warning: Function parameter o=
r member 'addr' not described in 'uvd_v3_1_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:108: warning: Function parameter o=
r member 'seq' not described in 'uvd_v3_1_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:108: warning: Function parameter o=
r member 'flags' not described in 'uvd_v3_1_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:108: warning: Excess function para=
meter 'fence' description in 'uvd_v3_1_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:625: warning: Function parameter o=
r member 'handle' not described in 'uvd_v3_1_hw_init'
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:625: warning: Excess function para=
meter 'adev' description in 'uvd_v3_1_hw_init'
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:692: warning: Function parameter o=
r member 'handle' not described in 'uvd_v3_1_hw_fini'
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c:692: warning: Excess function para=
meter 'adev' description in 'uvd_v3_1_hw_fini'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sonny Jiang <sonny.jiang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v3_1.c
> index 7cf4b11a65c5c..143ba7a41f41f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -80,7 +80,9 @@ static void uvd_v3_1_ring_set_wptr(struct amdgpu_ring *=
ring)
>   * uvd_v3_1_ring_emit_ib - execute indirect buffer
>   *
>   * @ring: amdgpu_ring pointer
> + * @job: unused
>   * @ib: indirect buffer to execute
> + * @flags: unused
>   *
>   * Write ring commands to execute the indirect buffer
>   */
> @@ -99,7 +101,9 @@ static void uvd_v3_1_ring_emit_ib(struct amdgpu_ring *=
ring,
>   * uvd_v3_1_ring_emit_fence - emit an fence & trap command
>   *
>   * @ring: amdgpu_ring pointer
> - * @fence: fence to emit
> + * @addr: address
> + * @seq: sequence number
> + * @flags: fence related flags
>   *
>   * Write a fence and a trap command to the ring.
>   */
> @@ -617,7 +621,7 @@ static void uvd_v3_1_enable_mgcg(struct amdgpu_device=
 *adev,
>  /**
>   * uvd_v3_1_hw_init - start and test UVD block
>   *
> - * @adev: amdgpu_device pointer
> + * @handle: handle used to pass amdgpu_device pointer
>   *
>   * Initialize the hardware, boot up the VCPU and do some testing
>   */
> @@ -684,7 +688,7 @@ static int uvd_v3_1_hw_init(void *handle)
>  /**
>   * uvd_v3_1_hw_fini - stop the hardware block
>   *
> - * @adev: amdgpu_device pointer
> + * @handle: handle used to pass amdgpu_device pointer
>   *
>   * Stop the UVD block, mark ring as not ready any more
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
