Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE962A870E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbgKETZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731984AbgKETZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:25:24 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A5BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 11:25:23 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id gn41so4293111ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 11:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9OwZ2JsmCSkMKjAN1GFjRMTzrmgufxcuqIpH+OrOIOI=;
        b=0W65vgENvrNSGrqthq2T7Ype2HAJWjbYFQSGwd3qd71+udUCou0GWfY3/4Uq3OroVo
         /n03vB0eGQoDmgnjQavMzz/bvXNvDsYOZw4QP0A/mTrdN+eSZVKkuiO9hfliZxr46bKn
         J8wI5ax2F+9MuJpgGwBWCtHWT21XQxj1WfnsOtAKBjaBBKO/71Tyo01mYi6hB9JqPtVp
         CrzN5A0dUtcVYXZ60FQNEgFPH/sWupNADoX4WcGmBuoYowZn81BynWLpJ1l14pzTskEC
         BWm2CVU9tsUUuCMeJRAx6aQ9CTni8TcIZkhrM+GuRn1r1KigyTrCBSdKXwG+vIWA3zHv
         RXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9OwZ2JsmCSkMKjAN1GFjRMTzrmgufxcuqIpH+OrOIOI=;
        b=cxLcq3soTwxeBDW5+8Jbq2+C2iicQXLh6svypK/krtrkuQAB/xJmi4ffRwSJ/EVvG8
         YawOLniJWDKT1aylItx7FfnJ1RG5Ouu6LPZdg3JB9PjnMImZOMoXJkKYqM2/l4JR83Qv
         5fAQ95WHpxtmu1WL7RS1Ng4+UPsfc3FPkYvSMtyhkDkGJPrq5hE7C+PgJRS6P3VxKtj0
         vr7z8V0XxYWV9ekyZP5UIOtaDDoaTkiwlRCNWUCwFWsHxhBh+/ivx/+wLp0SGTyKr1Xu
         5p7NiUp8KLRqVeLRwJSjTMjA1fxSDQFtJdIJ9y8wDmBjnoo+Mrewd5ySKrBPQTzsu+kH
         bYRg==
X-Gm-Message-State: AOAM530AiDpRmG0GLuZUa2CKVW4V5A5Zbx7sRLjM7kd7b60lk9yXokoX
        R1Crbrj/Af0IPI6p1l0Ex7hXhHEoDJGCcVFuGqftWusJzUE=
X-Google-Smtp-Source: ABdhPJzSFC7kYLWoVFEIQkU3bshpXWTc39sJVr22lchV4Hz+pC/99bCAaKFgEDSQe1h1j9QNs6Ruix54aAhWhfIC5z4=
X-Received: by 2002:a17:906:1a0b:: with SMTP id i11mr4041808ejf.404.1604604322422;
 Thu, 05 Nov 2020 11:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20201105181613.GA42968@localhost>
In-Reply-To: <20201105181613.GA42968@localhost>
From:   Eric Anholt <eric@anholt.net>
Date:   Thu, 5 Nov 2020 11:25:11 -0800
Message-ID: <CADaigPWV+x=6x_vso1Eb7ZEdmevpjgdGWO-epq-S6gJ3J1-sSA@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: replace idr_init() by idr_init_base()
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 10:25 AM Deepak R Varma <mh12gx2825@gmail.com> wrote:
>
> idr_init() uses base 0 which is an invalid identifier for this driver.
> The idr_alloc for this driver uses VC4_PERFMONID_MIN as start value for
> ID range and it is #defined to 1. The new function idr_init_base allows
> IDR to set the ID lookup from base 1. This avoids all lookups that
> otherwise starts from 0 since 0 is always unused / available.
>
> References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
>
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
>  drivers/gpu/drm/vc4/vc4_perfmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
> index f4aa75efd16b..7d40f421d922 100644
> --- a/drivers/gpu/drm/vc4/vc4_perfmon.c
> +++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
> @@ -77,7 +77,7 @@ struct vc4_perfmon *vc4_perfmon_find(struct vc4_file *vc4file, int id)
>  void vc4_perfmon_open_file(struct vc4_file *vc4file)
>  {
>         mutex_init(&vc4file->perfmon.lock);
> -       idr_init(&vc4file->perfmon.idr);
> +       idr_init_base(&vc4file->perfmon.idr, 1);
>  }

Sounds like you should use VC4_PERFMONID_MIN instead of a magic 1 here.
