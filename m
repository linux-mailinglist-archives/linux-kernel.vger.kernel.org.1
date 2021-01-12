Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05A62F3E19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393845AbhALWD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbhALWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:03:24 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751D0C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:02:44 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s2so4027663oij.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dQg8a7px4gZR/qy/5yROX2E3vzwuloy80ww+ooRg+oY=;
        b=V7MK5RWBjVPhkzQI5Ciohny7aSt5wuWIMAAdlUUAxUTdpdXE84xltsebu9uePExYVs
         Sh0kSGjpmpOg0/RXJf5Lf5LIbM88Y7eUDVp6U97Aa2IMUcw1JJt09uCkJbTaXQYTPnfp
         5rE5R3mY4yU/VQInfxYJzMANn07IIDE8vL1be0STAbzmEjyMtfOErw8IYjlAfimVZEhE
         S8X+35i8kSmcJ6MsEIpU0tbO/nV2NR2WcTqSgY3qn6H/puQXpwr0t60uw+sjGeC56UJS
         4G7gAPdST3PASQoWGEi2LJMXsXS44k+QSVfZSq0Hy98yWgpiQjo17TOAovzqUXzuBtHS
         GstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dQg8a7px4gZR/qy/5yROX2E3vzwuloy80ww+ooRg+oY=;
        b=IzfRSnT2Y0efx7yGEIpINW+E9wg7JGE+cBpsWx/BjHLTEO0vj5OgmPukBQXALB71ao
         sl2ZWsfX048UQLIetUHTEpIruSlNe786DlWMySUNDFcgL9I7aSAdRemDMmP1DPPak97P
         hHkTdxH9ysVaapBJhfh44HVOolA1YfO1aZwTiywNRYKxpGdVrWN9seK+CikRuGXdFWtO
         CA96vSaW2RizHbwPApF7uF/bEJKaDabbS6O8Mpmn0oseZVEinsR3UWGKGJRCp/Bqd5KB
         VMJcEVP3L/nS4wwA3Sgi0KiJXfgCo/yvcC1XSkoyAsZslHMP7mWPuefTRpOD+n06/OvU
         9AsQ==
X-Gm-Message-State: AOAM532BKQuhgIYo8k+Ui5GLrapGCJaDuLcV+OEZS8yL1wtPlpRzFVJm
        Ta//Y8zTnuYR7zTl5etzrsHY0DnNDEbcBC60+e0=
X-Google-Smtp-Source: ABdhPJww3KSAQqBOT3L9pjJDFilmrp/0IWHhhvANV0yloyuHZIb//XmTUxkQdJt4V8X3WGRRvr++pagt9iZf6RpnxMY=
X-Received: by 2002:aca:6202:: with SMTP id w2mr737362oib.5.1610488963899;
 Tue, 12 Jan 2021 14:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-8-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-8-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:02:33 -0500
Message-ID: <CADnq5_OAU8-hzqV3iEg7ees3vRv6Uh1tYaA+FJQE3TDK_ZL4Eg@mail.gmail.com>
Subject: Re: [PATCH 07/40] drm/amd/display/dc/irq/irq_service: Make local
 function static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/irq/irq_service.c:82:31: warnin=
g: no previous prototype for =E2=80=98find_irq_source_info=E2=80=99 [-Wmiss=
ing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/irq/irq_service.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/g=
pu/drm/amd/display/dc/irq/irq_service.c
> index 6bf27bde87240..5f245bde54ff7 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> @@ -79,7 +79,7 @@ void dal_irq_service_destroy(struct irq_service **irq_s=
ervice)
>         *irq_service =3D NULL;
>  }
>
> -const struct irq_source_info *find_irq_source_info(
> +static const struct irq_source_info *find_irq_source_info(
>         struct irq_service *irq_service,
>         enum dc_irq_source source)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
