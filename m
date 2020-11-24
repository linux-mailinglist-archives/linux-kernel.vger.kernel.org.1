Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB042C2CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390351AbgKXQYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387694AbgKXQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:24:30 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115B6C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:24:30 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so22935489wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X095HGxsg/FK0cpRrtl/LIevnbVNe2Cktr5g6/t5Gpc=;
        b=L91ucRMOIoDHfs4JVe0ty8ZwzN6C3Fl7EZZiJTY6aEMH/nB6R7depultMmivEfJ9en
         e5eYyFeaut5YF0AMSI9VvcppDRBg0FnLTXvhBF4koHX6MLMVRje6GLq177ToL/cQyYYj
         U77/OaBKwfWfbkpuZZjbn+VufWBpcXvETUvWSLrwb4VOFOqcFX/SdeXIHnPxbUl1Ok69
         vbNRyFA6m7lWgfyIJIiquehhbvk7WyvsObblC4ERdQXjSNADorjfqOvYKn1kWIOMctOm
         z64mspfRm+2s/Osrybf8jBgoOtvQZwU4BhfniMjoyTG9FZGTnynSrGyZg3IU9GiWbFgD
         ozbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X095HGxsg/FK0cpRrtl/LIevnbVNe2Cktr5g6/t5Gpc=;
        b=LazjEtZ8ucDJjKgaoFKwvpnSilvPxWb14YeDLAv88Tt9DNtsyjOBeBoCeFkku5uRmy
         r2N+lHZADeIjaP3ocd2nNYRV2fjDw5lzt1U64172DY2A3fwavT4kQnz+SVHlIhAiEeGP
         VKpjQhh0lu+mmvvb2kDYg5oTqN5y1XdRy41HivGMnB8fiW2zhEiJSBcXtT5bsYxJWLfd
         VbE+aStE9CaSdHTZsXoejMoaQhurO+EMU3dpK64AsJ5WHHNJptJgG/9BMnl9omlTSVKT
         ATVekyxm/zRKdOtyh2AS/OuDYRowrbxp5peFSf1t0XUeiF/uDJvI4L6vcsLyDnmL9DAF
         In2A==
X-Gm-Message-State: AOAM531Gvt/dpPeDJTwjpUlh8XTdCLY3CBWfbzMI02mQoVEuQhRhAlU/
        6aN9lzHZ8lqiUW8krMZ5G1HbUWfsyynAP2R+jRw=
X-Google-Smtp-Source: ABdhPJxlqbz+4amkKgjU9MfO2vrBQQ5BjIgXtB/jK1q7skulld0vqN9Z/VhUciUBsSKxW2qQzc+JnlQ/JZVFcxUrw0M=
X-Received: by 2002:adf:9144:: with SMTP id j62mr6232738wrj.419.1606235068792;
 Tue, 24 Nov 2020 08:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-37-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-37-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:24:17 -0500
Message-ID: <CADnq5_PEvjBvNtd7Xgcu6jv9GG04MqmC5KT9-zy5hg-MM3Q8Nw@mail.gmail.com>
Subject: Re: [PATCH 36/40] drm/amd/amdgpu/gmc_v7_0: Add some missing
 kernel-doc descriptions
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

On Mon, Nov 23, 2020 at 6:20 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:433: warning: Function parameter o=
r member 'flush_type' not described in 'gmc_v7_0_flush_gpu_tlb_pasid'
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:433: warning: Function parameter o=
r member 'all_hub' not described in 'gmc_v7_0_flush_gpu_tlb_pasid'
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:471: warning: Function parameter o=
r member 'vmhub' not described in 'gmc_v7_0_flush_gpu_tlb'
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:471: warning: Function parameter o=
r member 'flush_type' not described in 'gmc_v7_0_flush_gpu_tlb'
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:771: warning: Function parameter o=
r member 'pasid' not described in 'gmc_v7_0_vm_decode_fault'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor changes.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index 80c146df338aa..fe71c89ecd26f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -424,6 +424,8 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *ade=
v)
>   *
>   * @adev: amdgpu_device pointer
>   * @pasid: pasid to be flush
> + * @flush_type: unused
> + * @all_hub: unused
>   *
>   * Flush the TLB for the requested pasid.
>   */
> @@ -463,7 +465,9 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
>   *
>   * @adev: amdgpu_device pointer
>   * @vmid: vm instance to flush
> - *
> + * @vmhub: unused
> + * @flush_type: unused
> + * *
>   * Flush the TLB for the requested page table (CIK).
>   */
>  static void gmc_v7_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t =
vmid,
> @@ -763,6 +767,7 @@ static void gmc_v7_0_gart_disable(struct amdgpu_devic=
e *adev)
>   * @status: VM_CONTEXT1_PROTECTION_FAULT_STATUS register value
>   * @addr: VM_CONTEXT1_PROTECTION_FAULT_ADDR register value
>   * @mc_client: VM_CONTEXT1_PROTECTION_FAULT_MCCLIENT register value
> + * @pasid: debug logging only - no functional use
>   *
>   * Print human readable fault information (CIK).
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
