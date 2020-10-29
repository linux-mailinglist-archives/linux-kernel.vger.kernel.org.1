Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2461129F6B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgJ2VOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJ2VOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:14:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD54C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 14:14:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k3so5731528ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ns7Do31zu+WAaODzf+zkTDRFUp0x2smNF88wKpHakF8=;
        b=nERaiAC/yKHy4l59kMbmue2TP0eYV07yG8tRzyOe5ZSnrN+PZZ6lzQgUmergpp9Xvx
         OKLBUMuWsUZMLgyvU+m2/FAwJYXVtlBY4O4vLyi9jywLdI8btYCMvDdbDZDSKXqOyO+K
         nxeWQS1wamoq+xyWm3t7T+01TULg7W5gT+ZfuFkpLZG+4pJeuaHSiN6VPvAZ9US6mauR
         K/N5rPkAh/s1N/VlE9l7cykIutOB9GflFSCa90fZHYkwTXTyTqjXbIl+KINljecetX//
         D+2uq96Rus5UzxNBCvF7sIHvnnD37AL3805RKrB/oq0uiMH7f74ViGybSA82WdrkHIqk
         eK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ns7Do31zu+WAaODzf+zkTDRFUp0x2smNF88wKpHakF8=;
        b=eB5Fy7kmMWgOQ/HQ46BZrWXS/PINpr6DFqZCUULmJDspnDJtim5wv+Iqnv4Y9CvjPH
         0zIBYBXYELTPS8dokSU1Cdi6pA3lqjTGSWW4dslvBmGFADsZ4164bTIQNtfHq8KUHkIg
         fY+TjjLC4Aq3asOgMymGlbNXr4f77M5UgN86/blgtS7TV12fuKFR52u2N7O6TXWmbzOz
         iBXgDKzqgTz3jxgMuNHUrfP2xcjO7VmRPkQdttgwjJNK4pDfzOvxkZMfwTYZXV2MzqNk
         FuQxvc7EcHmMi3r0dOLwO8bAX+PYtqgmXVMbdeEEGGLnCpdGRxsUMqiuVETMnim7lJp1
         Wf/g==
X-Gm-Message-State: AOAM5304SLgwfrxq3nKPbolldTgLdaVGLUkT6mChwyTWhwQw7+P58pJZ
        EpcVf7pL7tJZBrEZh4dH42F1MDngKmnzl63d/Ec=
X-Google-Smtp-Source: ABdhPJxIZF0tNTvtC3V38dLAnOEjKCTAGoMaYCM6ci0TKD+GrrwgFW4yHGsswzIXzMRRHIeMPT/ymA5kFT9Qw3/5V60=
X-Received: by 2002:a17:906:68a:: with SMTP id u10mr5865435ejb.507.1604006058250;
 Thu, 29 Oct 2020 14:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201029200435.3386066-1-zi.yan@sent.com>
In-Reply-To: <20201029200435.3386066-1-zi.yan@sent.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 29 Oct 2020 14:14:05 -0700
Message-ID: <CAHbLzkpka7s1DFeXO5dxfGvxZFcTYb9KH0AE_AXuxeFO4q_rtg@mail.gmail.com>
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page isolation.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Rik van Riel <riel@surriel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 1:04 PM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> In isolate_migratepages_block, when cc->alloc_contig is true, we are
> able to isolate compound pages, nr_migratepages and nr_isolated did not
> count compound pages correctly, causing us to isolate more pages than we
> thought. Use thp_nr_pages to count pages. Otherwise, we might be trapped
> in too_many_isolated while loop, since the actual isolated pages can go
> up to COMPACT_CLUSTER_MAX*512=16384, where COMPACT_CLUSTER_MAX is 32,

Is it that easy to run into? 16384 doesn't seem like too many pages, just 64MB.

> since we stop isolation after cc->nr_migratepages reaches to
> COMPACT_CLUSTER_MAX.
>
> In addition, after we fix the issue above, cc->nr_migratepages could
> never be equal to COMPACT_CLUSTER_MAX if compound pages are isolated,
> thus page isolation could not stop as we intended. Change the isolation
> stop condition to >=.

The fix looks sane to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

Shall you add Fixes tag to commit
1da2f328fa643bd72197dfed0c655148af31e4eb? And may cc stable.

>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/compaction.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index ee1f8439369e..0683a4999581 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>
>  isolate_success:
>                 list_add(&page->lru, &cc->migratepages);
> -               cc->nr_migratepages++;
> -               nr_isolated++;
> +               cc->nr_migratepages += thp_nr_pages(page);
> +               nr_isolated += thp_nr_pages(page);
>
>                 /*
>                  * Avoid isolating too much unless this block is being
> @@ -1021,7 +1021,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>                  * or a lock is contended. For contention, isolate quickly to
>                  * potentially remove one source of contention.
>                  */
> -               if (cc->nr_migratepages == COMPACT_CLUSTER_MAX &&
> +               if (cc->nr_migratepages >= COMPACT_CLUSTER_MAX &&
>                     !cc->rescan && !cc->contended) {
>                         ++low_pfn;
>                         break;
> @@ -1132,7 +1132,7 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
>                 if (!pfn)
>                         break;
>
> -               if (cc->nr_migratepages == COMPACT_CLUSTER_MAX)
> +               if (cc->nr_migratepages >= COMPACT_CLUSTER_MAX)
>                         break;
>         }
>
> --
> 2.28.0
>
>
