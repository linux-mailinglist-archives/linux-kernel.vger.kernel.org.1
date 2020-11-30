Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D102C909E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgK3WHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbgK3WHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:07:37 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B5CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:06:51 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id x16so147205oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7EQnpqvC3hpfizVx7WNlc1o2wLOwLDyI4iu7zgo9UUQ=;
        b=FTc0NENMaLnXl0QJAv4V0k6/vQCM6vWq8NN5M6M8Ua6+HS/J9rRkOZs22P69ICi0fZ
         IY4kYzeJ6o2eh5RfOghvkt8xOhVFYdyErsvejxIAVBcCa0ihUsNPGCRFZgesYl8gvKQf
         HguB4SkoogQRWnJ5NB/nayVUVgmEFbEuNH0HyNE4plg4QBfImH8ucLbDKOgAL3sHeMsi
         q3kV9LSgcFz2nFxvB/IaTslZ7TLT9Xvm0FbClgZYLtsWOGdNso8xcC9IssYceekkeecf
         k75H2JohzSulJCJR0F0ITgJMoey6nbp4D8rgIoP24uPJxwL2a/uL2K3ijq4Jzlccz0Gs
         vC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7EQnpqvC3hpfizVx7WNlc1o2wLOwLDyI4iu7zgo9UUQ=;
        b=fhArG9RF0N4b2y/x5OTToDTUmi69z175ZEX19ev8Dl/qChxLQphKD1jajlLj0jAR4o
         CyTd5664HRPGDW4E4sYyAAYclvekdsPrkiiDcWxq2g/LYJr6CY7a7AtMZ/YD87mVGzwR
         M27ffyhSbHNPC/hXlUCwJSDTEENXRW8tlBi+NsBdSSM/xsUSI8nNba+QqvcH2NsTmA/A
         NILEOByVx0yGIoIcrzRrsVP99qqGCsmRHAaEEIcAhtb2YK3gRiH30Y0Tg2KqKKcQzyIL
         4EEfPkCYJw0mWGimMd54umbE+HbppoT6EVm9DXwyqT7d8j0WrfG2o9YFklbHIF0DRCdQ
         J+LQ==
X-Gm-Message-State: AOAM533DUrvpZ2pr18YYL/qSdGQiVpi+kN1n6LSO/qopEKhtWb5rFYnY
        zpRXJCQ0ayW16cXTH871WZeQKeJ1JKPJ48BJooo=
X-Google-Smtp-Source: ABdhPJwKoCehpgjsxEwJ4YPyYu6p17CzQDio4KhNKbgLv/OTlanCBhDMSTalMQDfqfvwcoBDYCfkncF7qqNR1RZAOko=
X-Received: by 2002:a54:4608:: with SMTP id p8mr862273oip.5.1606774011073;
 Mon, 30 Nov 2020 14:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-6-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-6-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:06:39 -0500
Message-ID: <CADnq5_Mzf=BBzvqsyBLCSsmWZK29kCKK4BgOy9exEjq=F4t+4A@mail.gmail.com>
Subject: Re: [PATCH 05/40] drm/amd/amdgpu/tonga_ih: Provide some missing
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
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c:193: warning: Function parameter o=
r member 'ih' not described in 'tonga_ih_get_wptr'
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c:225: warning: Function parameter o=
r member 'ih' not described in 'tonga_ih_decode_iv'
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c:225: warning: Function parameter o=
r member 'entry' not described in 'tonga_ih_decode_iv'
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c:255: warning: Function parameter o=
r member 'ih' not described in 'tonga_ih_set_rptr'
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
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/=
amdgpu/tonga_ih.c
> index e40140bf6699c..ce3319993b4bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -181,6 +181,7 @@ static void tonga_ih_irq_disable(struct amdgpu_device=
 *adev)
>   * tonga_ih_get_wptr - get the IH ring buffer wptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to fetch wptr
>   *
>   * Get the IH ring buffer wptr from either the register
>   * or the writeback memory buffer (VI).  Also check for
> @@ -215,6 +216,8 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *ad=
ev,
>   * tonga_ih_decode_iv - decode an interrupt vector
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to decode
> + * @entry: IV entry to place decoded information into
>   *
>   * Decodes the interrupt vector at the current rptr
>   * position and also advance the position.
> @@ -247,6 +250,7 @@ static void tonga_ih_decode_iv(struct amdgpu_device *=
adev,
>   * tonga_ih_set_rptr - set the IH ring buffer rptr
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
