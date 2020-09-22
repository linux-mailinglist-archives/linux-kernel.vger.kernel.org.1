Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D559C273923
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgIVDNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgIVDNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:13:24 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B086DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 20:13:24 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id q26so5012002uaa.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 20:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFMWy0TRjIuMfOEPE0XT0KNNvOm8aVUOxVBKGmuUKbw=;
        b=W1WRIrLPqLnp6CjLgvKqgHghVJxxeicps2XFZcbG1tXUzsLokxq7rvQKkooEMr7Vc/
         peDqq3v0xHy4huXzFWt2mi1fgby26ip5LhDMOQvq2D0KiWLdn1vnaYSm7bIBA7s07KKW
         KTQw7Dyc8gZG4Vo4S805LglYGx8t5vf31MoeMbMfG0YXhuYmmjdef5Jt0h0LMaVx7xvf
         3YeqhDdQ1xvK4GgYlTA47CpULnOedAjkLDgJWUbL1jMN9ccwpGRmKae4TxVfIhqDojrq
         NSXsDAcWTQL0HRpQTJZzdYYxwZy6tvjRvgr06NL8dZKU2SXhXhhcIGC7H6HIpkfN/E/6
         ODsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFMWy0TRjIuMfOEPE0XT0KNNvOm8aVUOxVBKGmuUKbw=;
        b=rN+FspTnTsNpfESm+7eRxrOKcNUb60DLCLfiWmnrAyzyKuimuOeAiscXRWXa29ftOW
         UKVPLGnefWr/bYPU4y0XnUIg+ykAnYeqsg49uQrsjn40vLT3p3GkTa1J5gcilvoxagZD
         VpIu4ndCww0kkuTmDfxQP6fg4hn4VGZ1RZQ4rZReLytRyvL0+skCtetgm9lZsMiFq/jX
         7MmKwozmn4LrObFg8XHpYMMqyKuAr6Dqx/CQrJ4vxiFn5Xe766s9P0mrDjaGzrlVnm32
         57J3rjgWGE6hJVwykWvyxzddl1hADywfUAjavVQ4wEUswIZzSVRODp7nUG9YpTwSOlX7
         AXzQ==
X-Gm-Message-State: AOAM5327KupB38NIeq8/D9wV38J/KhX8uwAoir/EL4o4xJBMBO7c9KNA
        VAi/rBOF1UcT4sOrojzRnuDH4Y2xpVGFzW+lLi0=
X-Google-Smtp-Source: ABdhPJzVypldxJ6BIN3SBUDXkEaYfjGoVIrSl1VylNV3wji6wwJReFPu4ykIaChZkWafX5PjzAvP+mgV+k9viSXRXFY=
X-Received: by 2002:ab0:130a:: with SMTP id g10mr2102187uae.100.1600744403807;
 Mon, 21 Sep 2020 20:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200922020148.3261797-1-riel@surriel.com> <20200922020148.3261797-3-riel@surriel.com>
In-Reply-To: <20200922020148.3261797-3-riel@surriel.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Tue, 22 Sep 2020 11:13:12 +0800
Message-ID: <CAC=cRTP3Em2C7tRpbFyHztnjAvUMFn-9t1yqFCb=yc3MavpUcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm,swap: skip swap readahead if page was obtained instantaneously
To:     Rik van Riel <riel@surriel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, niketa@fb.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:02 AM Rik van Riel <riel@surriel.com> wrote:
>
> Check whether a swap page was obtained instantaneously, for example
> because it is in zswap, or on a very fast IO device which uses busy
> waiting, and we did not wait on IO to swap in this page.
> If no IO was needed to get the swap page we want, kicking off readahead
> on surrounding swap pages is likely to be counterproductive, because the
> extra loads will cause additional latency, use up extra memory, and chances
> are the surrounding pages in swap are just as fast to load as this one,
> making readahead pointless.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  mm/swap_state.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index aacb9ba53f63..6919f9d5fe88 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -637,6 +637,7 @@ static struct page *swap_cluster_read_one(swp_entry_t entry,
>  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>                                 struct vm_fault *vmf)

Why not do this for swap_vma_readahead() too?  swap_cluster_read_one()
can be used in swap_vma_readahead() too.

>  {
> +       struct page *page;
>         unsigned long entry_offset = swp_offset(entry);
>         unsigned long offset = entry_offset;
>         unsigned long start_offset, end_offset;
> @@ -668,11 +669,18 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>                 end_offset = si->max - 1;
>
>         blk_start_plug(&plug);
> +       /* If we read the page without waiting on IO, skip readahead. */
> +       page = swap_cluster_read_one(entry, offset, gfp_mask, vma, addr, false);
> +       if (page && PageUptodate(page))
> +               goto skip_unplug;
> +
> +       /* Ok, do the async read-ahead now. */
>         for (offset = start_offset; offset <= end_offset ; offset++) {
> -               /* Ok, do the async read-ahead now */
> -               swap_cluster_read_one(entry, offset, gfp_mask, vma, addr,
> -                                     offset != entry_offset);
> +               if (offset == entry_offset)
> +                       continue;
> +               swap_cluster_read_one(entry, offset, gfp_mask, vma, addr, true);
>         }
> +skip_unplug:
>         blk_finish_plug(&plug);
>
>         lru_add_drain();        /* Push any new pages onto the LRU now */

Best Regards,
Huang, Ying
