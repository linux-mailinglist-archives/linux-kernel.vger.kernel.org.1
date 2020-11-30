Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6452C90AD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgK3WKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgK3WKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:10:33 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFE9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:09:53 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id y74so15930399oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sPlomFmiOATP5cy+/4gpZg1TKtOtldAuJ6wnb9I5pMM=;
        b=Q4AF5f3/ekxxAWG9G7L7o+NUb6iuhCzY2f7My8hBAiKN2sWZ1MrJNHNFbY4oVba4hz
         7wcRa2wM0kiZwXBVeVP/IMA7+raGMMGzebLNDbcqMj2kWUI6r8ujix+ZRhj/SzLXTUch
         nBX++UpSMkxMT/RAg+F7Pt7phEa8QDc7C75yDs+21p34kYIU7qfkkbQzmn4WheTQim+E
         5zp37rdiQGqvDceGr2V1hrFBJGY9HLBMHVvKtIGN9GHBA3/ZrGUA56eh8Qo25zSPS1fk
         W5B+7T8ATK6lYmMzvy/Z2bVEW31jM1JaYsievwW3I/zAmu/qoCt/rbzbvlutcCdQbIaN
         ggNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sPlomFmiOATP5cy+/4gpZg1TKtOtldAuJ6wnb9I5pMM=;
        b=kSK0QkEtdvaPoENJhnwOLONxNebJ3vjgaohZ49rr5ACeaoYT6Y29jipmoARFq6OYWL
         k4mlNBKs6nLuz11JkdR8t5KWC93CJEt8aExl2LDDSlagHHDlP2WAWTw3gz/s3ego3baz
         ITaB+i23yVO9SWuzNX9iW16BUiU9Ji5z/L/QAZCtZ/r6BnKRpWHtSL1MKR21xTYZZ0ie
         j6B8HhxWfm1jjA0p1ipwPCSb82D+LgzzalJRMOJbKQ7rY6gTDHHBuaWjpBZwDz8z4i0v
         rKIw7FhvQcxRUFPDPcK86K197cyKvl0DMxh3kWa5IP6ahRII2lgNauVGrGf/OeDXxhMb
         VktQ==
X-Gm-Message-State: AOAM53217A6LZOUnBGDjaQ3H9oJtFQrq6R4kWLrrNTQ712Oj3ZeGh/pH
        D6ow+KEweijEvr43ceYoSfRYE3GwMreCPP2JKwU=
X-Google-Smtp-Source: ABdhPJyuQtT71IW1/NsolB/Nd/3lQC+Ope96JDXvoJUEYTFh3PY1cr5E/dwfiLtr+UeHOyNabWY1HM+9JcyLGYfJtdM=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr833840oih.123.1606774192588;
 Mon, 30 Nov 2020 14:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-10-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-10-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:09:41 -0500
Message-ID: <CADnq5_O7TXO+zB7BG3OhD7gbWQ8t09U0JKwNyJPWZ4hHjZxKMg@mail.gmail.com>
Subject: Re: [PATCH 09/40] drm/amd/amdgpu/vega10_ih: Add descriptions for 'ih'
 and 'entry'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Zhigang Luo <zhigang.luo@amd.com>, David Airlie <airlied@linux.ie>,
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

On Tue, Nov 24, 2020 at 2:44 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c:377: warning: Function parameter =
or member 'ih' not described in 'vega10_ih_get_wptr'
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c:440: warning: Function parameter =
or member 'ih' not described in 'vega10_ih_decode_iv'
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c:440: warning: Function parameter =
or member 'entry' not described in 'vega10_ih_decode_iv'
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c:480: warning: Function parameter =
or member 'ih' not described in 'vega10_ih_irq_rearm'
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c:513: warning: Function parameter =
or member 'ih' not described in 'vega10_ih_set_rptr'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Zhigang Luo <zhigang.luo@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega10_ih.c
> index 407c6093c2ec0..578fdee5b9758 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -366,6 +366,7 @@ static void vega10_ih_irq_disable(struct amdgpu_devic=
e *adev)
>   * vega10_ih_get_wptr - get the IH ring buffer wptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to fetch wptr
>   *
>   * Get the IH ring buffer wptr from either the register
>   * or the writeback memory buffer (VEGA10).  Also check for
> @@ -430,6 +431,8 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *a=
dev,
>   * vega10_ih_decode_iv - decode an interrupt vector
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to decode
> + * @entry: IV entry to place decoded information into
>   *
>   * Decodes the interrupt vector at the current rptr
>   * position and also advance the position.
> @@ -473,6 +476,7 @@ static void vega10_ih_decode_iv(struct amdgpu_device =
*adev,
>   * vega10_ih_irq_rearm - rearm IRQ if lost
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring to match
>   *
>   */
>  static void vega10_ih_irq_rearm(struct amdgpu_device *adev,
> @@ -505,6 +509,7 @@ static void vega10_ih_irq_rearm(struct amdgpu_device =
*adev,
>   * vega10_ih_set_rptr - set the IH ring buffer rptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to set rptr
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
