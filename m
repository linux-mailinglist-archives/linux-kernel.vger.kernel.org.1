Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402B62B5134
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgKPTcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKPTcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:32:17 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8015C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:32:16 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so12831516wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6u9glXg4zFrqO3lr0/xH7tuiEEcDV6G1EbJU8peXnog=;
        b=l6awfJflMImqdSyvTdK7VUZ+M3PyAYjnu39cw6cDWUpMQSZCasiABE3hB3UYadQllM
         349Ek5y/JhP/1gfWuzJFmDy7PM51yle94njMSqlfJiv7HT6Vrh0o3sRvrOdFY0icFQEn
         adi2b5rZaQEtO28jhRgmEmX6a2F9X5B7g9iMoAooWVqC8iZm4bHildAg072vTnlmZG27
         lwyg/cxWMAbqkWH6QpUPGMleR+X90XcPE1a7/oi5xgeHt3Rjh+pFcs3pZVLJXI0jlO9+
         JHswZLSx/7EVbxXf8fIQTgIOkmd3S802N4+hRzT9HhkO6E+oR9yWNFc6jEPXBTdRmnxv
         GZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6u9glXg4zFrqO3lr0/xH7tuiEEcDV6G1EbJU8peXnog=;
        b=UR4zx44h/VsQeqTD+UH24skN9Eb/N3O+VXV9laxP3ubZRx6uJYCUjCVHfb7L5/82uj
         0Y8Xq2WMYvAok8IAs70qdu7bDYMcu22vg2gxL6Kz7l8XX0NvP5LjDwnsRjaAJBh2sTVF
         VO3IPk30fbNQvrwT9DMxSOgS7d20DMuV5bXJfYOM7B17/FJoYlssvTScfTEpMMP8hEuS
         56BjwwhQHcpd0w1OGDRUCikXxhWxjLolCJQezr0mGVDyTH6aLoB0fmoym1MZGZz4w6GM
         o+KHDLCNkK+2sYJ9kgSRtSgivFyzXxFmxcTWS39dJK9wzwGwxqfTi7Cg8Ny6RSnZnfnm
         +dQw==
X-Gm-Message-State: AOAM531WosJ5oxzkx9JW9bt4lLnM43Abgq11A73Hy4hRr1XOV5xdOHlf
        z4m2B2vtmkaEar7ihZOeTs9o4dxV+kdEUa8rwt+QbIMM
X-Google-Smtp-Source: ABdhPJzBknI7uYfz2n9Qs2E2TcVmhlWZgbpKBGPFh7Il9hQIPB+ckfHn0EJY+HZFLCjHC+X2DZ7uFNogtHD02Xa+TkU=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr20887475wru.362.1605555135478;
 Mon, 16 Nov 2020 11:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20201116173005.1825880-1-lee.jones@linaro.org> <20201116173005.1825880-5-lee.jones@linaro.org>
In-Reply-To: <20201116173005.1825880-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 14:32:04 -0500
Message-ID: <CADnq5_OQa=Pr8dnAFZ3uLNrY16nohckncDLLdJgdshdNc+NPBQ@mail.gmail.com>
Subject: Re: [PATCH 04/43] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
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

On Mon, Nov 16, 2020 at 12:30 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Function parameter or =
member 'dev' not described in 'radeon_info_ioctl'
>  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Excess function parame=
ter 'rdev' description in 'radeon_info_ioctl'
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
>  drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon=
/radeon_kms.c
> index 001940bca90a6..50cee4880bb46 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -214,7 +214,7 @@ static void radeon_set_filp_rights(struct drm_device =
*dev,
>  /**
>   * radeon_info_ioctl - answer a device specific request.
>   *
> - * @rdev: radeon device pointer
> + * @dev: drm device pointer
>   * @data: request object
>   * @filp: drm filp
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
