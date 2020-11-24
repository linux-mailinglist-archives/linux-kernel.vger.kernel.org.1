Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34632C2CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390447AbgKXQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgKXQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:26:44 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C67DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:26:44 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so3463827wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L5yh124+35fWpY6C/RYa1tV5+Q4siwUnEg7czGfCdgc=;
        b=p3Nh4Wd0lncqnmu/1NyYehIOHHW/Aht1QF850QehyuLuUDo8QGXLlyQ6/fwOeexD8G
         cuhC8L9soyjdFfQVPlc/1OjYSYQ7HYxr1zSUD05FzKREYNlFrQB4/JPzKdhQQr2m65nG
         zSY3GZj4gqozYTe0NuItOa+kiG5QxG9eDdTdqQrGIwUOBWX5fUsYzZewxABxkAGsbFti
         NingY2nL4VrqYFSoOOtxDmdEEvAcgImnLcpQDPan8MVkOBwVFPVUmf2rN2JjZUA95wqT
         TWPAnET2gt2fi43V9qt32JM1FdC+iDJW+yWr8W54NQOxMzH7dSIoTcAPT/bX2v9z7giH
         CjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L5yh124+35fWpY6C/RYa1tV5+Q4siwUnEg7czGfCdgc=;
        b=hPJnMpcperi7YrdJPL9JsUhsmFG5traWH1rnhtAOR5RKFLJKx6zOVBdmcbySo+GNvm
         9J/WrEDmFjwQ7UIeZHj2HvqTf9Ulfn2LnO6GSAABMz0R8GAOik2IyC3hd6DLrc3htu38
         TP0mcM3iSR+nsWOQhyGtoLu4kAiHawg/NyyxJ2wD5HJW5LQOtYrNSQjH8EB3ccOasm2p
         94GaYk5Po7Sd79pF+ySy+ZGBtYsNhvMhqnhJQuQC1t++BtVbzrCpIVRdFdnRUOHXftJ7
         jGl9NyYVOdhDZFYxQTPhLGsAr8kRSE19t3CGqikR20ZfvAgkcPytQcCJcM9Wsae7EIVo
         Poiw==
X-Gm-Message-State: AOAM531QFtnNg7GeTw/dJODZtYXQ/zMBX1d6VhsCk9j1RuHK0tgseuUE
        SJuLXPmf/pxc+SK35Qp18wx+RpiDkZzJEg//xWA=
X-Google-Smtp-Source: ABdhPJx14x2qfyZKiQ4i/fQGiHmWJzAtD6CHBdmhGOpi8h8GQsXZjLaETc3PeWibouLypsxDwfPrbDeg3KFO42FI2tE=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr5325311wmi.70.1606235203423;
 Tue, 24 Nov 2020 08:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-38-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-38-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:26:32 -0500
Message-ID: <CADnq5_MEwCJJxdsTzLQu3cjx0w2_ww0mYKHbenD2Pn=9Mxq2tQ@mail.gmail.com>
Subject: Re: [PATCH 37/40] drm/amd/amdgpu/gmc_v8_0: Fix more issues attributed
 to copy/paste
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

On Mon, Nov 23, 2020 at 6:21 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:618: warning: Function parameter o=
r member 'flush_type' not described in 'gmc_v8_0_flush_gpu_tlb_pasid'
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:618: warning: Function parameter o=
r member 'all_hub' not described in 'gmc_v8_0_flush_gpu_tlb_pasid'
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:657: warning: Function parameter o=
r member 'vmhub' not described in 'gmc_v8_0_flush_gpu_tlb'
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:657: warning: Function parameter o=
r member 'flush_type' not described in 'gmc_v8_0_flush_gpu_tlb'
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:998: warning: Function parameter o=
r member 'pasid' not described in 'gmc_v8_0_vm_decode_fault'
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
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 0f32a8002c3d7..41c1d8e812b88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -609,6 +609,8 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *ade=
v)
>   *
>   * @adev: amdgpu_device pointer
>   * @pasid: pasid to be flush
> + * @flush_type: unused
> + * @all_hub: unused
>   *
>   * Flush the TLB for the requested pasid.
>   */
> @@ -649,6 +651,8 @@ static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
>   *
>   * @adev: amdgpu_device pointer
>   * @vmid: vm instance to flush
> + * @vmhub: unused
> + * @flush_type: unused
>   *
>   * Flush the TLB for the requested page table (VI).
>   */
> @@ -990,6 +994,7 @@ static void gmc_v8_0_gart_disable(struct amdgpu_devic=
e *adev)
>   * @status: VM_CONTEXT1_PROTECTION_FAULT_STATUS register value
>   * @addr: VM_CONTEXT1_PROTECTION_FAULT_ADDR register value
>   * @mc_client: VM_CONTEXT1_PROTECTION_FAULT_MCCLIENT register value
> + * @pasid: debug logging only - no functional use
>   *
>   * Print human readable fault information (VI).
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
