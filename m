Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE22B5156
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgKPTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgKPTjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:39:10 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D400C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:39:10 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id m125so394095wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SFDYZjZQAaTG2dP2nDjD2sZBHSX8y4VAO8O1y9JdIt4=;
        b=dn22h72gTUdQINjrVh+u6VcLpUp3feTYDhKbcx/zLTmMMOseqPwzvrqkHK0pN+vkE1
         cJLKPM/pA3TFI+5FVC9Nrn4jfQSjBblzKhG7Aj+kFbRw/q0TokL6votST754daXnhgEc
         bFNC5KBCCG77kbvEeDj107kVr0ArMd0o27K3ejzyFxaqHlN2mCGq8U2QDiQvTMKLzH5z
         PCdpsr6+vLVdIO0Zlh0Cbm5EnGr/ipPOajXOv+faa6r082NZN7UlD7K9iZ6EKpBuFzNQ
         r4v477fBBm9fQlfaXHaIkHj/mR3pebgreXAlYko/J/2lLYCxa6ZyABb/R3BC5Ax2ct8Y
         RrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SFDYZjZQAaTG2dP2nDjD2sZBHSX8y4VAO8O1y9JdIt4=;
        b=J3mzPu2SQgO8gDjqSnjI/1j99ljdRH5r6kzQxvH4Gv+Id84ctDb44v9KdEtsVVvlZ9
         +VyT0L/iF1aajJKolsCV+mqNiSSGNSRQhYHN1sUHAZnqvL7dg/dWTJBDm+Dse5dPlELs
         tC8KOe8J+bRdTwvr5xR+cCaG+lYL1Jay5Y3B+HX5ee5QlI2epZyDRPiDjjl6WetUroJK
         qZfgmybt82BEL6hzjyxm7xLGRIE+gSJFyoHv2MZkXEmCrFHjVyErHcxgd/GDl/vFJbPM
         FcS+JDj0peBB8ZQ9LgnD2rFwwhb43k8iuO+udjo4EUXnBhIRAlp+agZRIHlg154qTW9s
         PVlw==
X-Gm-Message-State: AOAM532FdEc8xvLy/bUHUotW45qGRsqiEbeSl7H1ArCK5cHSyCmZHot5
        /CJCKQF8SnDtalcvn5E0d52LGTFb8EZ70Kk/64k=
X-Google-Smtp-Source: ABdhPJwFpL7kKK3lQzEQOmbpRP4YnvubKEFnUN3DkG5JLPPNtWhPymi8ADkkgzTuFxEMka1t5sTCmS6zK/RSR4B/fyQ=
X-Received: by 2002:a1c:f017:: with SMTP id a23mr521478wmb.56.1605555548926;
 Mon, 16 Nov 2020 11:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20201116173005.1825880-1-lee.jones@linaro.org> <20201116173005.1825880-9-lee.jones@linaro.org>
In-Reply-To: <20201116173005.1825880-9-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 14:38:57 -0500
Message-ID: <CADnq5_PdMNHAx=h02br5-ee27FO4_efdakDFKJsUt0LSHX0=UA@mail.gmail.com>
Subject: Re: [PATCH 08/43] drm/radeon/radeon_irq_kms: Demote non-conformant
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

On Mon, Nov 16, 2020 at 12:30 PM Lee Jones <lee.jones@linaro.org> wrote:
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

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/radeon/radeon_irq_kms.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/ra=
deon/radeon_irq_kms.c
> index b86bc88ad4308..a242b6053d47e 100644
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
> @@ -549,14 +547,14 @@ void radeon_irq_kms_disable_hpd(struct radeon_devic=
e *rdev, unsigned hpd_mask)
>  }
>
>  /**
> - * radeon_irq_kms_update_int_n - helper for updating interrupt enable re=
gisters
> + * radeon_irq_kms_set_irq_n_enabled - helper for updating interrupt enab=
le registers
>   *
>   * @rdev: radeon device pointer
>   * @reg: the register to write to enable/disable interrupts
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
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
