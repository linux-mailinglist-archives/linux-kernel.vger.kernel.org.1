Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76E62AE301
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbgKJWN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbgKJWN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:13:57 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0D6C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:13:56 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 19so3196660wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xT6tM+gk4HWRrKa6KAYYWDmgkvtKHBouJiXVkJogMyY=;
        b=nrUzDrXPj6FL98r9ZOB0jMR+yPNdfIgxOXvxEcZUFaLuatcB4IR088eynT6CkasFQi
         +8AhSr99IRAZZLtZ1+eyyyhI1g700ZZxv1LOd6m8tExnGslznwl0DxbEsiR3hybdgvdm
         jOZtueBelhP3bV/0bOWYoAIrwefJc08EXjV6OOQY+qB6xKI8XcqkjphoPTsjO6iaBsmx
         ubsicWALSk1xCFgiRRK/BF1IWGMPryElz1hsAMQowCmATSQBdgUsA7oUchpvsKfrE2b+
         es2DlivbP6mucg9hW/h6fURkgDokypNiXBysSmHeApbxrgE47rHXMWMHOHef5Jdee6ej
         KkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xT6tM+gk4HWRrKa6KAYYWDmgkvtKHBouJiXVkJogMyY=;
        b=N99gNi3p2aznc16IYPAazRfTfQt4zPY98oIlLdCSXBGzrbI3qemiTCsWMZro5U57Pg
         htmtf+yzq686GGFiX4/JG8mOaFFXXsREb0ytUSOpOVcZ55KeA5qrkWyfilADp1OgjHrF
         y+BcKIDnzUzqN0ICMQhvfxRCYfDhuZS686EHWPycoRT5LOse4BADPCnAphdVxDWF/ieV
         y4PTZQOTi/ah39q1v1PgBvfENhCoF4cCV0alADChAEXHe3n/CnuhhaGFDMJCHn4CmooP
         c/FLHJCNUq28XvF1eIjNfAZbC6cFExY1HsLKfCf8iGIknCzfPv+2nw88FfRZietomdOI
         +9yQ==
X-Gm-Message-State: AOAM531LDxHVGmh1hgRY7Zpv/1C9CSQpVS7CtqPn44hAv2KtMXbJN75h
        Y14BrZ6zkN0Y+Sn12flJQM6eqseFkWw513xvYvU=
X-Google-Smtp-Source: ABdhPJwozkwJCQ+Wga7e+74HHRTVPMXaLdO9viRHZ3LonxLmlXppLHNHt/2QbxPhMU6KK/xnwLhGCct1Bjg3rAofqAo=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr247045wma.79.1605046435639;
 Tue, 10 Nov 2020 14:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20201109211855.3340030-1-lee.jones@linaro.org> <20201109211855.3340030-10-lee.jones@linaro.org>
In-Reply-To: <20201109211855.3340030-10-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 17:13:44 -0500
Message-ID: <CADnq5_NnJ8y9Eq1bHgA81YyY+UZQG3K+G2mvtPFZCm4hOZdXVg@mail.gmail.com>
Subject: Re: [PATCH 09/20] drm/radeon/radeon_irq_kms: Demote non-conformant
 kernel-doc fix another
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

On Mon, Nov 9, 2020 at 4:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_irq_kms.c:56: warning: Function parameter =
or member 'irq' not described in 'radeon_driver_irq_handler_kms'
>  drivers/gpu/drm/radeon/radeon_irq_kms.c:56: warning: Function parameter =
or member 'arg' not described in 'radeon_driver_irq_handler_kms'
>  drivers/gpu/drm/radeon/radeon_irq_kms.c:571: warning: Function parameter=
 or member 'n' not described in 'radeon_irq_kms_set_irq_n_enabled'
>  drivers/gpu/drm/radeon/radeon_irq_kms.c:571: warning: Excess function pa=
rameter 'num' description in 'radeon_irq_kms_set_irq_n_enabled'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/radeon/radeon_irq_kms.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/ra=
deon/radeon_irq_kms.c
> index b86bc88ad4308..3521084030d24 100644
> --- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> @@ -43,11 +43,9 @@
>
>  #define RADEON_WAIT_IDLE_TIMEOUT 200
>
> -/**
> +/*
>   * radeon_driver_irq_handler_kms - irq handler for KMS
>   *
> - * @int irq, void *arg: args
> - *
>   * This is the irq handler for the radeon KMS driver (all asics).
>   * radeon_irq_process is a macro that points to the per-asic
>   * irq handler callback.
> @@ -556,7 +554,7 @@ void radeon_irq_kms_disable_hpd(struct radeon_device =
*rdev, unsigned hpd_mask)
>   * @mask: the mask that enables the interrupts
>   * @enable: whether to enable or disable the interrupt register
>   * @name: the name of the interrupt register to print to the kernel log
> - * @num: the number of the interrupt register to print to the kernel log
> + * @n: the number of the interrupt register to print to the kernel log
>   *
>   * Helper for updating the enable state of interrupt registers. Checks w=
hether
>   * or not the interrupt matches the enable state we want. If it doesn't,=
 then

The function name in the comment doesn't match the function name it is
documenting.  Care to fix that up too?

Alex

> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
