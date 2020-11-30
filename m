Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC02C90B0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgK3WLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgK3WLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:11:14 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BCAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:10:34 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id h3so15948141oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vJY62m11fNx0biVgO+0Uojl+dKN/jvXwDwURTEPj28A=;
        b=kdTYLAxgun3E681j9RVwnUtqSpFRq5P0vDsNFXcd1IkzZOektSTtGxGVrUcju2Yt8m
         YaXGOfbRyuoEB7D8ok/WslEHhEzyNyBl0mhn4TLdvSinrsvPgbrCJU0DUHbXJ2frADTm
         JDPpGdTSavfQdZI/dHXItbBCEylDKIF8BBLoeuV+I65VdOflPezHj90AWMRuSNQhoBdB
         UhJ+9ovq+6zn89EuqqJwEr8lloTwSdezhWWlsmnAk5p7AxoaAmcdXoV3cTuaSGD6jR0Q
         SjAxWLuIVCuSaJGCtzJX/SgxTyUPZQqaZ9zZPhpdv5G7cM3uzq7KWUUFqoxJFL0AylWl
         EUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vJY62m11fNx0biVgO+0Uojl+dKN/jvXwDwURTEPj28A=;
        b=fzfygAn24exw0PxLTNuUtQwTo44JojBZaL9vvKUZ6yltL+ute40BVr1uCxtvS0IOlQ
         fCKEq+krC7ZT4bKdcMCrwRz9dGOh2PtvFdWqDGaSYSQYeqgVMlaADiFu37bGKjUTMBnX
         prxyPxkXbuzEWSZA50gpnrjx1setPGKsxuol+d/xN24yxtH128LVeKEmgx0jCVaIqVuL
         Pg2GPwd/5G91YiejjCHVc0pwZqqcwCtnLO175eY4x+zTh6R7mwh6MeiZ/0ZpeGq1bw0P
         wp5bAEsF0Qj7PyXJz+F3WzOvzN467uILn46nWAQUIY0jiEG2VsbxM7of2G6oj1z1z76E
         GIng==
X-Gm-Message-State: AOAM5330B1yXK86Kfjh6woe0cVN0Me6n0ZBiA/qlxA8J/nyPF1g2YAHY
        zLPze6KIglDP2XXf2VhqOykiJB2n/OMHcsvcYfI=
X-Google-Smtp-Source: ABdhPJyd4RBfIDAqV7a0TfYBN0SJql76kTKY0jwuQk0MbMXfW5h136xLI1qqnmW8QihH1T6JtxN1AuYr/CpIjQKZE10=
X-Received: by 2002:a54:4608:: with SMTP id p8mr876026oip.5.1606774234019;
 Mon, 30 Nov 2020 14:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-11-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-11-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:10:22 -0500
Message-ID: <CADnq5_O0rrqyKV-Q+hZUbnocnFg+3+=miWc+dh0xiLh3ONNQJA@mail.gmail.com>
Subject: Re: [PATCH 10/40] drm/amd/amdgpu/navi10_ih: Add descriptions for 'ih'
 and 'entry'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alex Sierra <alex.sierra@amd.com>, David Airlie <airlied@linux.ie>,
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
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c:453: warning: Function parameter =
or member 'ih' not described in 'navi10_ih_get_wptr'
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c:512: warning: Function parameter =
or member 'ih' not described in 'navi10_ih_decode_iv'
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c:512: warning: Function parameter =
or member 'entry' not described in 'navi10_ih_decode_iv'
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c:552: warning: Function parameter =
or member 'ih' not described in 'navi10_ih_irq_rearm'
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c:585: warning: Function parameter =
or member 'ih' not described in 'navi10_ih_set_rptr'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Alex Sierra <alex.sierra@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd=
/amdgpu/navi10_ih.c
> index 837769fcb35b7..3338052b080b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -442,6 +442,7 @@ static void navi10_ih_irq_disable(struct amdgpu_devic=
e *adev)
>   * navi10_ih_get_wptr - get the IH ring buffer wptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to fetch wptr
>   *
>   * Get the IH ring buffer wptr from either the register
>   * or the writeback memory buffer (NAVI10).  Also check for
> @@ -502,6 +503,8 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *a=
dev,
>   * navi10_ih_decode_iv - decode an interrupt vector
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to decode
> + * @entry: IV entry to place decoded information into
>   *
>   * Decodes the interrupt vector at the current rptr
>   * position and also advance the position.
> @@ -545,6 +548,7 @@ static void navi10_ih_decode_iv(struct amdgpu_device =
*adev,
>   * navi10_ih_irq_rearm - rearm IRQ if lost
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring to match
>   *
>   */
>  static void navi10_ih_irq_rearm(struct amdgpu_device *adev,
> @@ -578,6 +582,7 @@ static void navi10_ih_irq_rearm(struct amdgpu_device =
*adev,
>   *
>   * @adev: amdgpu_device pointer
>   *
> + * @ih: IH ring buffer to set rptr
>   * Set the IH ring buffer rptr.
>   */
>  static void navi10_ih_set_rptr(struct amdgpu_device *adev,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
