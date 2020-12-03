Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE96A2CD5F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgLCMto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbgLCMtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:49:43 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DEBC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:49:02 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id o9so1200233pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPYnhrsvsymVgI4dIOwlvS+ALlvDhFJqcsBpBX3jCVU=;
        b=HTLpbfuxAQHsAyHafUIKQayYnjNANpaMeGVFMD/TI2oS7/FkoQ2Wm6b++lxo2kl06Q
         9fsUEzQBcCHEjVrDh9x7dWTa8zlwimms3T7U60gD1F6gDHCimICp2X+I5gajiJtB7anO
         RrTHh450L6Ozzk13ygR/ygO/lJgeiGsIu4IutqqpoXV4iTAsvyYPWyc0Kvr+Az/oigEb
         14+gUzfA83aNhvJ/doRJvrwp3+DX1gwEOurCHa51Xydd6htX5jmnyzMarkkr7mC7uEmt
         W32hFKEq24KGhgA8hVe1mQvruWpjNe8jcOdWELT1Lc3cYrkiyzsXqoNPWkMeLi8Ju+fs
         w9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPYnhrsvsymVgI4dIOwlvS+ALlvDhFJqcsBpBX3jCVU=;
        b=TgKN7+oJNZvY3XKuhhCw78J+x60hP4rci6oyNasAclIwX4LlcMyos67BFfopobl7gZ
         dFqmzJLrTbR0LhmGszJyrEtanvLYVGIeA9S8z7LzmRCgI2LLcRjmMjPMQR4p0k10AJBO
         bZXo9ma98iISzZbyIk8iHR9XQQWhR0cl4LNFzWCaOoTkf0OWeC83gD1R/LYPSnh4RAks
         67X61mOyHGxcsm+5Fbj/6J4bJb914wB/BJeWakCclCF80jfnUa7LhHQ5/lMjaQLDP4mx
         0sICYkxbqOXBOu4jvlJB8zcSWGDmmKcLLpER0HT2QTW8zOSHsBd5VL4y9heMWGr3znAF
         3R5Q==
X-Gm-Message-State: AOAM531GsAbRnpwnWAe8Lb4QdNlEq0oZd/CSM9gP+sppt5U18zQTTuEd
        fBzgGXGw/lW01mQkadIGMhWeJS6pe84aS8/9l2/fnw==
X-Google-Smtp-Source: ABdhPJzbQsp200jdS8zI0+yDTBzSIOfZFhwYGDqCR1ZPqyj3n1jak2ybII3aJ4i+vRLqN/cdXLBKuk+wX893vr1HF2E=
X-Received: by 2002:a63:f919:: with SMTP id h25mr2918514pgi.440.1606999742261;
 Thu, 03 Dec 2020 04:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20201203195247.498b7ac1@canb.auug.org.au>
In-Reply-To: <20201203195247.498b7ac1@canb.auug.org.au>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 3 Dec 2020 13:48:51 +0100
Message-ID: <CAAeHK+xborghfQ_TQ3qDFwy+Xr4QXK_x3M=aoeyCjvMSTeg+Ww@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 9:52 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> mm/kasan/quarantine.c: In function 'quarantine_put':
> mm/kasan/quarantine.c:197:15: error: 'info' undeclared (first use in this function)
>   197 |   qlink_free(&info->quarantine_link, cache);
>       |               ^~~~
> mm/kasan/quarantine.c:197:15: note: each undeclared identifier is reported only once for each function it appears in
> mm/kasan/quarantine.c:199:3: error: 'return' with no value, in function returning non-void [-Werror=return-type]
>   199 |   return;
>       |   ^~~~~~
> mm/kasan/quarantine.c:171:6: note: declared here
>   171 | bool quarantine_put(struct kmem_cache *cache, void *object)
>       |      ^~~~~~~~~~~~~~
>
> Caused by patches
>
>   "kasan: rename get_alloc/free_info"
>   "kasan: sanitize objects when metadata doesn't fit"

Yeah, this is conflict with the "kasan: fix object remain in offline
per-cpu quarantine" patch.

> I have applied the following fix patch:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 3 Dec 2020 19:41:49 +1100
> Subject: [PATCH] kasan-rename-get_alloc-free_info-fix
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  mm/kasan/quarantine.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index feae26ea5cbb..d98b516f372f 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -194,9 +194,9 @@ bool quarantine_put(struct kmem_cache *cache, void *object)
>
>         q = this_cpu_ptr(&cpu_quarantine);
>         if (q->offline) {
> -               qlink_free(&info->quarantine_link, cache);
> +               qlink_free(&meta->quarantine_link, cache);
>                 local_irq_restore(flags);
> -               return;
> +               return false;
>         }
>         qlist_put(q, &meta->quarantine_link, cache->size);
>         if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
> --
> 2.29.2
>
> --
> Cheers,
> Stephen Rothwell

This fixup looks good to me. Thanks!
