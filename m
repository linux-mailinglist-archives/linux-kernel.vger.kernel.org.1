Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18EE2C915D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgK3WoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388549AbgK3WoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:44:07 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78193C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:43:27 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id x16so250125oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WWSmCbuMYCfSEh/XtQKC06ZLvB/BO8GNX46533df02s=;
        b=bZwuRONmsmYRDY/qpQnkjxh/+CLUjT/GqCSdrg62y6M2BR9eWy/VZqg4Xn4mo1eb0D
         4AHmdE/uK1xrxkNwKFMXxJdAIfgY7nBVieqSXg7Svj4JlO0va8Z2WLEbxnjoaG/7YLFK
         kB6heZk++frlYd9KL6FWb/iG3V9NPaKbB4baRg6YdSyKNwqGim6W1ZWmsonfkOSLcvup
         rV051tKmimTGyzzV9l/saJkrlynALSu7x8JUdSpZeQH/QONYqUTONKxC7nJd7u6XPIrT
         vnVCFo/eipt6Favt6NSRQdsfdr27yW6uzywPaLkf2Qc3KLAPEadoLJygxeli2O5mRILs
         7BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WWSmCbuMYCfSEh/XtQKC06ZLvB/BO8GNX46533df02s=;
        b=puiUu5llpY+FiSb/nbOfKFflnJ1XE5t6QvbqjjFxkyIHjdmWs/O8Nw9QlvMOuEKRXB
         DwQVGe82yOeKaG1Mff0jnigPYQwqF+HC6vjGAk5QSnM9ssYNojtlj1s4wQShLe7qivTn
         gl6JgQEeif9sbAQOUmSe7RMgIU3bFWd70ooWmkfUW/pLHbjr3Udxb/rSFUeWeyfG0mlV
         CWJL3W4T2jYWmPLOvCZTyYeGqNjQeQMdEOE/IvLjliJWkOuEMGdNIjCSr2+GyCRYnyal
         uqPozZ1vIsM4eKw4yQ30J+y5raxK9hgEcGmOykVsCetQjizpbz3TIggniGmNod/j9LWB
         IvAQ==
X-Gm-Message-State: AOAM53325lNH4PMknoU2BMSGdOqrVlusb/vPEVdEnFhu37gIU9bcyx8a
        g58VQDz+07UjUUrrniGL8llf2JFnQuIXGTT5fKPkPBGa
X-Google-Smtp-Source: ABdhPJxTc5vWNKZcOnmhkPpo9Icy58gCWMvjZUp7rBRqZYxEovDI41prcZbXuCkIS0jEWf4HPrKeITpsAE6kju/9C6k=
X-Received: by 2002:a54:4608:: with SMTP id p8mr11503oip.5.1606776206944; Mon,
 30 Nov 2020 14:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-31-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-31-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:43:15 -0500
Message-ID: <CADnq5_Mp1G0YcNy5PyQoYZ7DmKo8OmMpBvoAqz-wPL9_neb_YQ@mail.gmail.com>
Subject: Re: [PATCH 30/40] drm/amd/amdgpu/jpeg_v1_0: Add some missing function
 param descriptions
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Veerabadhran G <vegopala@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
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
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:219: warning: Function parameter =
or member 'addr' not described in 'jpeg_v1_0_decode_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:219: warning: Function parameter =
or member 'seq' not described in 'jpeg_v1_0_decode_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:219: warning: Function parameter =
or member 'flags' not described in 'jpeg_v1_0_decode_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:219: warning: Excess function par=
ameter 'fence' description in 'jpeg_v1_0_decode_ring_emit_fence'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:293: warning: Function parameter =
or member 'job' not described in 'jpeg_v1_0_decode_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:293: warning: Function parameter =
or member 'flags' not described in 'jpeg_v1_0_decode_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c:518: warning: Function parameter =
or member 'mode' not described in 'jpeg_v1_0_start'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Veerabadhran G <vegopala@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor fixes.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v1_0.c
> index c600b61b5f45d..c87102b238e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -210,7 +210,9 @@ static void jpeg_v1_0_decode_ring_insert_end(struct a=
mdgpu_ring *ring)
>   * jpeg_v1_0_decode_ring_emit_fence - emit an fence & trap command
>   *
>   * @ring: amdgpu_ring pointer
> - * @fence: fence to emit
> + * @addr: address
> + * @seq: sequence number
> + * @flags: fence related flags
>   *
>   * Write a fence and a trap command to the ring.
>   */
> @@ -282,7 +284,9 @@ static void jpeg_v1_0_decode_ring_emit_fence(struct a=
mdgpu_ring *ring, u64 addr,
>   * jpeg_v1_0_decode_ring_emit_ib - execute indirect buffer
>   *
>   * @ring: amdgpu_ring pointer
> + * @job: job to retrive vmid from
>   * @ib: indirect buffer to execute
> + * @flags: unused
>   *
>   * Write ring commands to execute the indirect buffer.
>   */
> @@ -511,6 +515,7 @@ void jpeg_v1_0_sw_fini(void *handle)
>   * jpeg_v1_0_start - start JPEG block
>   *
>   * @adev: amdgpu_device pointer
> + * @mode: SPG or DPG mode
>   *
>   * Setup and start the JPEG block
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
