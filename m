Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84C2A88E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbgKEVY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKEVY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:24:27 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56816C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 13:24:26 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id gn41so4740519ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 13:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/CmC9JRSxb82iC3NFWklCniKS4R8CJ6nnXYdYjWbKG4=;
        b=Gu7+TyJ688oibw+cHrS74PBGNS0GtLy+PisuwisCbxkYaseX4DZlsdutLz7W8K5SS2
         in4GFolf+Iy/yjdJ3fECM8Hm8BklJQrL0pME2i0mNXsmESjCW9YqRpfStnTGsvKMK9Rk
         2z85IrNT4fQH1hM8VBalwiVtlpvYXu2MYDHtvjoKL4txAqGIDPrTsgyJu100+Y1+kcv8
         PQfNaHkx5Fxr9CoQ1ZdGYyzZ1lJ/aEXSwP+AafRkrHzgvfhZI9LkI+SeYrCKYPHTr8Iq
         fwBUh6SIrR0GNB8g4ipjd3bFZ9WoStoUoszM3Np69V+PmgGrO6qU3Dyh3Eo2xb5Z2R+X
         e0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CmC9JRSxb82iC3NFWklCniKS4R8CJ6nnXYdYjWbKG4=;
        b=e97Kmm1YXqr4RAZoEUaDOT6tC6C79dGSOBkdDnotdDlll7GFeiHv5vNiagSuUWQCCJ
         23BqN7QAfQvRaPnVMtULIgIhc8pdUOJIfYFSLh7WJb0M5IEMbix0jMKZL3/HZVHBpjr7
         lH5oEW2S7vFA1UH2OzAC//Zb4Qap1Y8Fj9JZk9nP6AC6KNFNGU4JeHt9kcDAa0KuzM6m
         1O/W5C8C4J/trMEKi6F/7JV9qqVXRS2NJNBg/t/S8Kec8151MTTRoxPbj8zTERHmSbsE
         6Syn/C9FngVSjc2Uy6Wwt71KLXhzZwrGfpjhuXaYSIvv+MjoYqbj13qRlbQ7BmfxzCL1
         kw+Q==
X-Gm-Message-State: AOAM5314HKM9JtT53jS4uSyWeEi4pU9XJL69F+b+2c8KkLDbqsxZO7e8
        BElsQIDjMHDTweMGpZlZL20C5it/LemDXeJT0LxZN6zBQZc=
X-Google-Smtp-Source: ABdhPJx0DFrV0/mwAVfKrG+W1lq3sodrLoxq3Xxf3TvVGR/66t+GtgFx0Gvb8DhweojXV1j9SqxoNacoODMAJnEaCZc=
X-Received: by 2002:a17:906:c186:: with SMTP id g6mr4058283ejz.465.1604611465021;
 Thu, 05 Nov 2020 13:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20201105202135.GA145111@localhost>
In-Reply-To: <20201105202135.GA145111@localhost>
From:   Eric Anholt <eric@anholt.net>
Date:   Thu, 5 Nov 2020 13:24:14 -0800
Message-ID: <CADaigPXM8NAZFAydXwcZt7ie_aK1aO8C=jqssA375sCMgU_gHw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/vc4: replace idr_init() by idr_init_base()
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 12:21 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
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
> Changes since v1:
>    - Change suggested by Eric Anholt
>      1. Use VC4_PERFMONID_MIN instead of magic number 1
>
>  drivers/gpu/drm/vc4/vc4_perfmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
> index f4aa75efd16b..18abc06335c1 100644
> --- a/drivers/gpu/drm/vc4/vc4_perfmon.c
> +++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
> @@ -77,7 +77,7 @@ struct vc4_perfmon *vc4_perfmon_find(struct vc4_file *vc4file, int id)
>  void vc4_perfmon_open_file(struct vc4_file *vc4file)
>  {
>         mutex_init(&vc4file->perfmon.lock);
> -       idr_init(&vc4file->perfmon.idr);
> +       idr_init_base(&vc4file->perfmon.idr, VC4_PERFMONID_MIN);
>  }
>
>  static int vc4_perfmon_idr_del(int id, void *elem, void *data)
> --
> 2.25.1

Reviewed-by: Eric Anholt <eric@anholt.net>

hopefully Maxime can apply it.
