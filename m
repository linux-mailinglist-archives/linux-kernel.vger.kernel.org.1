Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E322C90A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgK3WJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgK3WJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:09:19 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:08:38 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id t143so15927638oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ssyqQ2x40VAnf0UDyd8qZKVfCQ7SYisnmPz80Ctkr5M=;
        b=lNQNT/G89FX7MORQv72Kihj8aB6o11cRXtumYVih0fD/zmR5D5VUabJ85F0lfwBmeT
         Vck90Q0VuKPcNJr2T538Zxu3BKAhdmw8fwJ7sVS2zLocgCrtYUahL041bt0TJXTGCNDY
         ZM7mGdlVfV7a83KmyUki3nx8UBjhp7CcNK2QIAsTNHXNpUWJjSCS5Se9EMZ4cZwMumet
         gkFXDObYXUrJ0bLc9p/ncPbdLlwZ1fGV2HSEfMDJx9H8WezbKEjjHVpLq1eyu0RziQLX
         xnPn2Cdee4OyHW6GOk7JKnKcqAgW96V52xmfq81OAmrWOMLErF3bBZMZ2kfzg/4B29dx
         07ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ssyqQ2x40VAnf0UDyd8qZKVfCQ7SYisnmPz80Ctkr5M=;
        b=QfWbPLr5fd9WGmrcQTNKB4UWa+iMEruiiEq0sAc8e0mjB3ezss6I6/CTxwY4vIWC/a
         kKGucjCEQVHWB4M2u8gpNUzXj/gfpci0jssqqMGd+fuRZJtKXIRx4b+QXjIBZ6FOno34
         47rm972KWUjNu4CUQTOAw9X24DbGaxRh8GROiMpzQ21sJJ2DFiDlSIZv/n+P960e97i1
         I41rH184bi85rP61c4GtNbncKrdc08Y9zUQCJ7f08zs7piwagWMpb6Sb/CJv9/g6ZvLS
         CSiIMOvU24IGQsonIc7nqa8onvuSY+6PsZq6wqkrc29n+GjpzlgExdjsLbMT3dUmOCsE
         Znyw==
X-Gm-Message-State: AOAM533HJXTEFM317aoDxSMq/UScF0DxVMh1lDDr4eldj0EWHQKhQmbQ
        jt/V78vmnmwKR0YXNHqSC0X9ib7O9RN0gLQKvQ4=
X-Google-Smtp-Source: ABdhPJxkJQSRLE5/CDB9aem/VoismXvItysaV/3WGZBcRXw0L5l8NmMixzvvFAYQRBuERyV61DGKO227yDgI5UCbOis=
X-Received: by 2002:a54:4608:: with SMTP id p8mr869110oip.5.1606774118366;
 Mon, 30 Nov 2020 14:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-7-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:08:26 -0500
Message-ID: <CADnq5_MY8=jZ2eSJdbSi27YT5-ZT4RAfzFaMA2HQQSPaNvJYvA@mail.gmail.com>
Subject: Re: [PATCH 06/40] drm/amd/amdgpu/cz_ih: Add missing function param
 descriptions for 'ih' and 'entry'
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

On Tue, Nov 24, 2020 at 2:44 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c:191: warning: Function parameter or m=
ember 'ih' not described in 'cz_ih_get_wptr'
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c:223: warning: Function parameter or m=
ember 'ih' not described in 'cz_ih_decode_iv'
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c:223: warning: Function parameter or m=
ember 'entry' not described in 'cz_ih_decode_iv'
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c:253: warning: Function parameter or m=
ember 'ih' not described in 'cz_ih_set_rptr'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amd=
gpu/cz_ih.c
> index 1dca0cabc326a..da37f8a900afb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -179,6 +179,7 @@ static void cz_ih_irq_disable(struct amdgpu_device *a=
dev)
>   * cz_ih_get_wptr - get the IH ring buffer wptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to fetch wptr
>   *
>   * Get the IH ring buffer wptr from either the register
>   * or the writeback memory buffer (VI).  Also check for
> @@ -213,6 +214,8 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
>   * cz_ih_decode_iv - decode an interrupt vector
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to decode
> + * @entry: IV entry to place decoded information into
>   *
>   * Decodes the interrupt vector at the current rptr
>   * position and also advance the position.
> @@ -245,6 +248,7 @@ static void cz_ih_decode_iv(struct amdgpu_device *ade=
v,
>   * cz_ih_set_rptr - set the IH ring buffer rptr
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
