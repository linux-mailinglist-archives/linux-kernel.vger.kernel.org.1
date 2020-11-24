Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C042C2C23
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbgKXP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgKXP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:59:03 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60138C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:59:01 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so22793464wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/BiN8OT888OLJPg+YNWbzwo9aTZyP0IkPs+7Sg97asw=;
        b=hYOZpfPVbkqDoGMp6U/sPZXhFcaEBvhDzUQJ3Dyz3jbwVvLywBLxuEcIedhekOmiWI
         poHZbyjL5wv06c3hU64MBR7AXKAZ3yUCujzfE5A5kgEhiOU9BL2RaECb81DQKYB+QdGU
         2IwoXBcKvq4+Eyb022bd2Xm1DeVBmL7ZLoutkMy8MKTqAkI5XIuNJ4hwW4hNAvPozig0
         LBUfAgBnEhq96wgNKNVNWMuckqfiDdv5xFQui9SfmuuNDaNn1x0uzFK681MWML/REzWj
         ZZw7ZAGGjXowwa9IyEYfs6nNbsepBI+quAbrLIIUE4gEg7xOVWczZUpRJfA1CothHY+k
         +xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/BiN8OT888OLJPg+YNWbzwo9aTZyP0IkPs+7Sg97asw=;
        b=jePoT6c0GCnbSOfMbsIJy2akkCkboS7BWqISVKaRE0WH0gS9VLI/eNLaRqBlbkkYa8
         DsG+iWL12AirPUMU+dy2nbDv21hulPCxdCOOlCzhP2MKDMVDTh8qhzxx2+bghDRNsBI+
         +ToyhmyUf+uPdIFMohtOYD1X5Mr7jakAqJafYspliiCGhhpkn29XwwE+GZObK1UaFsxL
         8Gf0KHU3it185OlTWeGZvGRgPgF7rUkyO7QUBIa8Of5KKltcixoer4tH7GzPewPNfqlO
         xFAtRpTGKTfXDKs0rNiha3irWkUo2hfuOMOxkQnu3J/Zt+VgHDI6nSQWHS11EhG6SDnk
         9IzQ==
X-Gm-Message-State: AOAM533H83v3bQzc9NwRMBivXNUBbP17AkchnQGR304L9Or/hVXLkVzW
        5Xf0wVCSXGDsbPoZ2sDzNwy0zCmoGDdfb/YnWts=
X-Google-Smtp-Source: ABdhPJyAuBi4CQChFDAhRroxOQD1DQcxn8wckwkoKfnt9jBRoWEepCzTHlhFxxDon6M6KjjRFC1SeLyWMUgmQROPEOM=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr6225217wrn.124.1606233540191;
 Tue, 24 Nov 2020 07:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-7-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 10:58:48 -0500
Message-ID: <CADnq5_Mv5ViAiYPP1h3xbda0OWKjmLPVnUi6ApNNWabBatuKZQ@mail.gmail.com>
Subject: Re: [PATCH 06/40] drm/amd/amdgpu/uvd_v4_2: Fix some kernel-doc misdemeanours
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

On Mon, Nov 23, 2020 at 6:19 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:157: warning: Function parameter o=
r member 'handle' not described in 'uvd_v4_2_hw_init'
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:157: warning: Excess function para=
meter 'adev' description in 'uvd_v4_2_hw_init'
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:212: warning: Function parameter o=
r member 'handle' not described in 'uvd_v4_2_hw_fini'
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:212: warning: Excess function para=
meter 'adev' description in 'uvd_v4_2_hw_fini'
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:446: warning: Function parameter o=
r member 'addr' not described in 'uvd_v4_2_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:446: warning: Function parameter o=
r member 'seq' not described in 'uvd_v4_2_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:446: warning: Function parameter o=
r member 'flags' not described in 'uvd_v4_2_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:446: warning: Excess function para=
meter 'fence' description in 'uvd_v4_2_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:513: warning: Function parameter o=
r member 'job' not described in 'uvd_v4_2_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:513: warning: Function parameter o=
r member 'flags' not described in 'uvd_v4_2_ring_emit_ib'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor modifications.

Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v4_2.c
> index b0c0c438fc93c..2c8c35c3bca52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -149,7 +149,7 @@ static void uvd_v4_2_enable_mgcg(struct amdgpu_device=
 *adev,
>  /**
>   * uvd_v4_2_hw_init - start and test UVD block
>   *
> - * @adev: amdgpu_device pointer
> + * @handle: handle used to pass amdgpu_device pointer
>   *
>   * Initialize the hardware, boot up the VCPU and do some testing
>   */
> @@ -204,7 +204,7 @@ static int uvd_v4_2_hw_init(void *handle)
>  /**
>   * uvd_v4_2_hw_fini - stop the hardware block
>   *
> - * @adev: amdgpu_device pointer
> + * @handle: handle used to pass amdgpu_device pointer
>   *
>   * Stop the UVD block, mark ring as not ready any more
>   */
> @@ -437,6 +437,8 @@ static void uvd_v4_2_stop(struct amdgpu_device *adev)
>   * uvd_v4_2_ring_emit_fence - emit an fence & trap command
>   *
>   * @ring: amdgpu_ring pointer
> + * @addr: address
> + * @seq: sequence number
>   * @fence: fence to emit
>   *
>   * Write a fence and a trap command to the ring.
> @@ -502,7 +504,9 @@ static int uvd_v4_2_ring_test_ring(struct amdgpu_ring=
 *ring)
>   * uvd_v4_2_ring_emit_ib - execute indirect buffer
>   *
>   * @ring: amdgpu_ring pointer
> + * @job: unused
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
