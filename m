Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A32F3EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394150AbhALWEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393964AbhALWEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:04:12 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D909BC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:03:31 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id x13so4020502oic.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/H028Wwjfvv9ucACM/DZ/rVBlomdfpbrk8WUZizz2Vs=;
        b=aHzNGV51B70g68q+osW4guQZlA2SPBmfpEfOkq7fZkXQoakwzlr6xu6YhmCMjJnjkM
         VtqaetZFw7ntjVk3o8watdpn0CN9ObBziXNCLskyRTcv3ylwFfov+alT8XTKxCsbdm7k
         30NfnkHx0zYv8zD2AIpj0jLPRkt4W9Wor2BAIbgaPWwRMWHsh4xit369viFPJ9GYuRcM
         0cd5LBcwNAYsQt5AFcp4xqa87LhvbXLukxjkG3nXDUAGYQicqCUo/J9aZy4KsUrH5g8x
         WlGyqSIaUV9liOnpvvUzHrW3WtEDSor/Re56fdaUbgg0fRWxgsHhqBfaW0j5NB9ivZ19
         6uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/H028Wwjfvv9ucACM/DZ/rVBlomdfpbrk8WUZizz2Vs=;
        b=cYsaWycAtEsLRPpKfQ0dqGeEBtfnx3c93t3OhyIQ2bzFTU2sG0v9VAQGQAWRH77HkI
         YUbQVcA4CwpTSI9RE6PwKoI5kdtn6sUdE/TzOyoU7/VOk5EJuALKeJqmNexEU50x5rdd
         FG1xs7TUeCkWgMsMBFO2NktuiMo0EkYOT5DxIhQeUQilJJQQByUWdAsQpJHi6Ylpi1HW
         uewbO8EZm+4Wa+HqyI4EPlvfUWQz9xUPOU/UmbTpxWs5EowkV858LewsC32XicoWoRN6
         F68upmZO+xUbRPdWCIzGA6pQdnuSEEsWrfIT74Nd8ZoXno9AEh7D5yNDKLctEnIaWw0q
         qqiA==
X-Gm-Message-State: AOAM531E3VJ8n+0u677QQnsVsyiY48MGC2ZgWvFyqwUtCjNhkDFzqjoP
        yV6aqI0xPY7yJIHXGSY9RikbVtkn5h9vP4Rscfs=
X-Google-Smtp-Source: ABdhPJwKnqQekjYfdmWGfwn2owS4YfLiNSbIsA3whxDogbBuG2uZywR7fQBh87ZLY3GC3QoavsICftjeeyBcrFoVQo0=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr760461oib.123.1610489011339;
 Tue, 12 Jan 2021 14:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-9-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-9-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:03:20 -0500
Message-ID: <CADnq5_PD_eocbg8-bfdrrF_GDOSeakZfj6dc4JGU+D9puo_beQ@mail.gmail.com>
Subject: Re: [PATCH 08/40] drm/amd/display/dc/gpio/diagnostics/hw_factory_diag:
 Fix struct declared inside parameter list error
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 2:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_dia=
g.h:30:43: warning: =E2=80=98struct hw_factory=E2=80=99 declared inside par=
ameter list will not be visible outside of this definition or declaration
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_dia=
g.h:30:6: note: previous declaration of =E2=80=98dal_hw_factory_diag_fpga_i=
nit=E2=80=99 was here
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_dia=
g.h:30:43: warning: =E2=80=98struct hw_factory=E2=80=99 declared inside par=
ameter list will not be visible outside of this definition or declaration
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_dia=
g.h:30:6: note: previous declaration of =E2=80=98dal_hw_factory_diag_fpga_i=
nit=E2=80=99 was here
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_dia=
g.h:30:43: warning: =E2=80=98struct hw_factory=E2=80=99 declared inside par=
ameter list will not be visible outside of this definition or declaration
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_dia=
g.h:30:6: note: previous declaration of =E2=80=98dal_hw_factory_diag_fpga_i=
nit=E2=80=99 was here
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
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
>  .../gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h   | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_d=
iag.h b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h
> index 8a74f6adb8eee..bf68eb1d9a1d2 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h
> @@ -26,6 +26,8 @@
>  #ifndef __DAL_HW_FACTORY_DIAG_FPGA_H__
>  #define __DAL_HW_FACTORY_DIAG_FPGA_H__
>
> +struct hw_factory;
> +
>  /* Initialize HW factory function pointers and pin info */
>  void dal_hw_factory_diag_fpga_init(struct hw_factory *factory);
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
