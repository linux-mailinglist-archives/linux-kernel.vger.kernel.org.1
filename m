Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2662FABB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394359AbhARUjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388234AbhARKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610966052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FYgCX2ii5Dwe0bOJKcGHpt92B6A/7eyQ87BmmPFfeTo=;
        b=RY0Pr7670RjM8dl1o16xYmXImUvi5mlcLX9CufrkQPgglcQrStJiqbYm6UJxHC5KForPP9
        e/nDDaJnIklHpMJ0YVZ+Sfr+an9V8SyTPW3rjyAeVuAYf5dFOdZ3efV/iOIXcabBPiELmT
        fIQ/tseE2hMkpjnjYazdXiDScynf0mQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-c5WF3GFfN5qvCXSClrvwHg-1; Mon, 18 Jan 2021 05:34:09 -0500
X-MC-Unique: c5WF3GFfN5qvCXSClrvwHg-1
Received: by mail-wr1-f72.google.com with SMTP id i4so8094593wrm.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYgCX2ii5Dwe0bOJKcGHpt92B6A/7eyQ87BmmPFfeTo=;
        b=b+oLSj4sEUs3fAMpsebjtE00UTsY4Ge/cTm2VvEUpPufvX5Xhwc9icjFW3n6TqBNla
         cJ+To9EURmVRounJ47aErmA9eklQMssAJsVowmCqIlhvKLxaIO4PQIy6nMpqC++tlPgg
         rb5VWy3m8G3l/49fOMq/ULy4XitdzUT2o+47iE+6akaks3qAuPSNgBv047ujv+7k96Q8
         zMgneZJ/NH5Tsi+VAp4PbEhudi6xhSZk2ZHEJmi3kKhMPLcZW35vog+gS2AEd0x7d4y3
         v0yy8Xtkqw4DfCssLR3JC5mOld0pCKFvRvxVLs89mAx+Wb063BHCwItT1fHsvCMd/Swx
         CiSg==
X-Gm-Message-State: AOAM5307nTuTPqu0yNVq6hTADX7cA/fbdGlIQoU0iiTUky36MPyomF4s
        dp54PEXYYsz5WETCDFq2T+/3X7+GgaLyMdOaFiBiKGpeyEEdyeufyLpV4gJkFMWpMpSLVkmnE3+
        Pz03IJbUbfOoYbcPa8Z0lrCFlr320Wrqwr8An2145
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr25298758wri.373.1610966048098;
        Mon, 18 Jan 2021 02:34:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhN7h9yXUe6p7Un37gfh1l909wkVX/yJvjbikxolkUPeB00HrUp7DWinAz6mJJaAmuN4IgACzV2gOW8LmFGaI=
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr25298742wri.373.1610966047962;
 Mon, 18 Jan 2021 02:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20210115153348.131791-1-trix@redhat.com>
In-Reply-To: <20210115153348.131791-1-trix@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 18 Jan 2021 11:33:57 +0100
Message-ID: <CACO55tskaWz07cNdvpUE6wQw-7K2qwS8U1sokAeCtAF5naKuSA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] tracing: remove definition of DEBUG
To:     Tom Rix <trix@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Fri, Jan 15, 2021 at 11:51 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Defining DEBUG should only be done in development.
> So remove DEBUG.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  kernel/trace/trace_mmiotrace.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
> index 84582bf1ed5f..2c3c31791497 100644
> --- a/kernel/trace/trace_mmiotrace.c
> +++ b/kernel/trace/trace_mmiotrace.c
> @@ -5,8 +5,6 @@
>   * Copyright (C) 2008 Pekka Paalanen <pq@iki.fi>
>   */
>
> -#define DEBUG 1
> -
>  #include <linux/kernel.h>
>  #include <linux/mmiotrace.h>
>  #include <linux/pci.h>
> --
> 2.27.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

