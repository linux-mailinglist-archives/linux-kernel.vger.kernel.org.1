Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6AE2C9095
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgK3WGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgK3WGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:06:47 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6100C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:06:06 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id t18so4433165otk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N/BIAB+3qaydOQmoAXD2gYvBOx6Hxgrc3oXWqX3KTcg=;
        b=K4GFcuyqiqNLgzZn1T9c7dVwGqRrf81Ejc8vwiv/XeZebx0GQvClkwaz0pSsH7xlZf
         47gpRlsceR9ApLRbAdEPX5Pfx07iWxJu5s+k9+RMyfkvWW2eO/dWLxtlsyuexPDMRo3O
         7exviW3VDrMCTO/BpOw0y9HgY38LxwIdnG0jUIVNxPoeuvgmjXZ8SnL7Q8IOgeHNsCZ0
         +0w5p4Rog9XdO/cLLtqaaqmEHy+R1ioyfZ8o5+mhyADABfSKdvKRbeyukgA4MC+FYrvt
         FZrtwYVoFiECHmQUbQK6U0cn6xO7PuJUZbKfF3qn/qPI6Ee9jJ29V7vhGVVHv7/r14Zs
         Bkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N/BIAB+3qaydOQmoAXD2gYvBOx6Hxgrc3oXWqX3KTcg=;
        b=C+bgf7pM3SGulT7s8JRv+B1qv57gTpUA7e/ByZPcAIb6VbMZOWNoA8mcvl6YTHa+x7
         JigOf2A2zlJu33nRRNavKz9taWQ5OL2xIcug7x3RtOm0rGWhSzQ7OSFeqL40UnjazLYV
         GIHSZKDcPVzrIDgEckVKoSee38j4eBmTaVJ46vcqghruIqadz4t1NHPnYvxwF1ZBonfq
         lJ+6BtnMJwBt+70qdbrW2ntrGbhSRakBX3+H8DDs65xAThIM5R2sI98uSoKymir2WE+B
         NbvWENk1Ye2nAMtI86wqIb91IPplwW8XHi4ilztSfOow6SRpCIzCxSl0ZMugR2ZYXWWl
         szSQ==
X-Gm-Message-State: AOAM530kPwnhx4FCxJOKbWm1OtEH22HxKfQIiMs+jBx/lcLGgxNniYuk
        HlGpr53SXQ0bMP6qgpOi4QjAdXUR6ys+r+PAEJw=
X-Google-Smtp-Source: ABdhPJwuPIsDL9DXJHpXHCnbIsXVARz81MaHdcJyq4L4DNNB9V7lwiXnANIWQAHVF826sQiE5wIib6N8gYCeaM/LcjE=
X-Received: by 2002:a05:6830:22e4:: with SMTP id t4mr18947140otc.23.1606773966389;
 Mon, 30 Nov 2020 14:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-5-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:05:54 -0500
Message-ID: <CADnq5_MW7y7XZJMYni-sU1hEKfvS+XVMFLWT88xbKwEQWsL2jQ@mail.gmail.com>
Subject: Re: [PATCH 04/40] drm/amd/amdgpu/iceland_ih: Add missing function
 param descriptions for 'ih' and 'entry'
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
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c:191: warning: Function parameter=
 or member 'ih' not described in 'iceland_ih_get_wptr'
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c:223: warning: Function parameter=
 or member 'ih' not described in 'iceland_ih_decode_iv'
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c:223: warning: Function parameter=
 or member 'entry' not described in 'iceland_ih_decode_iv'
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c:253: warning: Function parameter=
 or member 'ih' not described in 'iceland_ih_set_rptr'
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
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/am=
d/amdgpu/iceland_ih.c
> index a13dd9a51149a..37d8b6ca4dab8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -179,6 +179,7 @@ static void iceland_ih_irq_disable(struct amdgpu_devi=
ce *adev)
>   * iceland_ih_get_wptr - get the IH ring buffer wptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to fetch wptr
>   *
>   * Get the IH ring buffer wptr from either the register
>   * or the writeback memory buffer (VI).  Also check for
> @@ -213,6 +214,8 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *=
adev,
>   * iceland_ih_decode_iv - decode an interrupt vector
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to decode
> + * @entry: IV entry to place decoded information into
>   *
>   * Decodes the interrupt vector at the current rptr
>   * position and also advance the position.
> @@ -245,6 +248,7 @@ static void iceland_ih_decode_iv(struct amdgpu_device=
 *adev,
>   * iceland_ih_set_rptr - set the IH ring buffer rptr
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
