Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0FA2923EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgJSIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbgJSIvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 04:51:05 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B427AC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 01:51:05 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l16so9574233ilt.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZHXXo/zRDSa5W/wDcmU0oac1TbitdWk5wxigpAEozI=;
        b=rHd0eRUjtIvPakMZjsqHfMqY8hnKX470Uqg8DV6DxPOX7fxcSKyV2cVfJjwlSQfn7w
         CWw9L2gTmwFUNC81J5lHxlbLifS4ifsUZqvKTObScRmj9YV+v5WNAGaVIUjDQEB8DOGG
         fGh+76EMLWywluZ0Hxc3gZinaA/o0EGmy/uEZP2JhuH9+Zutr6p097A3KwqgUyjkDDpG
         WN55t/wxpsJsqjPMi2YP/jop9XB5GmYknPZ7GhdxJWJ4xjAI7ApA8pPiLttuo5YPc0tH
         PAQwCazSvUFeHQawB/awhMbyvQmtuD7BzqDaPkYNAjbkIGqC+Jq+e7JPOP1mCxoo54lS
         KEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZHXXo/zRDSa5W/wDcmU0oac1TbitdWk5wxigpAEozI=;
        b=Uk10fmT4v3vi9CYiP5JXoxpYoE/eh/09ZlNttKvwvwMHz2QFRbEMCGTGbtYp1uIJQn
         bRKFtz5uUYotHFIcaSKA5gy8hrKaf9kDZTdXyMdBxmdiNFad6rzbNDyo100bo5y4i6IH
         /mSSvRdI67b0NGHKn50NxOujMjvZ8CTvQkmHFRh8n8E4RaTUx+/3ir5u/u+by7DLQs23
         kGLKXXXEeAM2hR0jRrcJto+geJp0lhR6NlY7YpmFGKgaUUA3iD0oX5hEesAD8ek6mpPG
         fd3gT05F5z8ya1rwON6TQ9eQPns7yy7LYOq6imx5Rs+WV1Zsu4OI1qy/4/NVz7tExwK8
         +iLA==
X-Gm-Message-State: AOAM531r1vyQ+FmxbGDsBD6/4sy6IJORhLmi0xOeiqgqHzMaT4FrVJ96
        4HKIpzL/oiFC2m/gUahlK0O9va21YulMrRiEU84=
X-Google-Smtp-Source: ABdhPJyv93wvD5l9Hv1GjIuxBVEuypdf7WdVOWzxSgV3fwgswcIYfQMH3cq1mjhZxy4O8IOiow3VgjjcZasvGI8ilnA=
X-Received: by 2002:a92:874a:: with SMTP id d10mr10218202ilm.163.1603097464967;
 Mon, 19 Oct 2020 01:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201019083632.25417-1-yanfei.xu@windriver.com>
In-Reply-To: <20201019083632.25417-1-yanfei.xu@windriver.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 19 Oct 2020 10:50:53 +0200
Message-ID: <CAM9Jb+iz3r3JeERmgvFeQfZ4vY7=TKtoXNEaDvmRPVAmhcyHnw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/compaction: Rename 'start_pfn' to
 'iteration_start_pfn' in compact_zone()
To:     yanfei.xu@windriver.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Yanfei Xu <yanfei.xu@windriver.com>
>
> There are two 'start_pfn' declared in compact_zone() which have
> different meaning. Rename the second one to 'iteration_start_pfn'
> to prevent trace_mm_compaction_end() from tracing an undesirable
> value.
>
> BTW, remove an useless semicolon.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
> v1->v2:
> Rename 'start_pfn' to 'iteration_start_pfn' and change commit messages.
>
>  mm/compaction.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 176dcded298e..ccd27c739fd6 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2272,7 +2272,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>
>         while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
>                 int err;
> -               unsigned long start_pfn = cc->migrate_pfn;
> +               unsigned long iteration_start_pfn = cc->migrate_pfn;
>
>                 /*
>                  * Avoid multiple rescans which can happen if a page cannot be
> @@ -2284,7 +2284,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>                  */
>                 cc->rescan = false;
>                 if (pageblock_start_pfn(last_migrated_pfn) ==
> -                   pageblock_start_pfn(start_pfn)) {
> +                   pageblock_start_pfn(iteration_start_pfn)) {
>                         cc->rescan = true;
>                 }
>
> @@ -2308,8 +2308,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>                         goto check_drain;
>                 case ISOLATE_SUCCESS:
>                         update_cached = false;
> -                       last_migrated_pfn = start_pfn;
> -                       ;
> +                       last_migrated_pfn = iteration_start_pfn;
>                 }
>
>                 err = migrate_pages(&cc->migratepages, compaction_alloc,

Improves readability.
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
