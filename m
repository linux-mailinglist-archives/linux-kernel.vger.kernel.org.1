Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306F22C6C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 21:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgK0UCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 15:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbgK0T6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:58:01 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D36CC061A48
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:29:56 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id m16so3050314vsl.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPrYA8SBxOnDPyxFWgz0jFt0AY1VDfwj6eq7kEmSXHU=;
        b=Yg3hXJwbh3tGrVRU8sLrnOrJtjQBQk/wk4EmzcfxIsTMOK9dfyLhTk/JOlKvaw85+J
         B4NLUjn5w6ktG6bKMkip1sLQHfk1q3LkBDFTvYftTB5pBfdk88uD3cRpQYSfsSnnIkG9
         V+pLTitUQnUebHfl142tFfBFozMlBAgpODKqgPi3uTEJg4VAueVTedB/N2TsaiH30wxM
         pYHo67SqH65qmv2BOGZ0Jj6Ccp1MJ01RYAFLWbPTgHwHxNc1MfkkEwO0XfaL/FTT3JGC
         vsgfTJkWgrbl5TjdU3wghHqPKO/js/i1YK+8jJH9F3g/urtjAyRh6zaoUl0W7BDDvYEG
         a+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPrYA8SBxOnDPyxFWgz0jFt0AY1VDfwj6eq7kEmSXHU=;
        b=mHJK08lQx02IeZ6NjbV+/lFu9lKyPQhGHRUf7T68P8lRVjhpo/IJf9THQRmi0r5vkA
         gNItb5SdtwDS08OAfnkFWyviZxCGEHvbQGEAHlWeb4SGZ3e5eI7Ts2yFgQgqGeR+z/7V
         Fm1zbX3O5PYvuaBm0Dg0kNstu0aYwvbq7wcsRO2VJxqvFaYvyTjeXwCQYlGYpJhk2rYZ
         sO6iCdcqUsWksuEE27TOpyWhDbch4Tbanj8n5QOOlq1d9NX6utN2nNlw6QASH8wYEE7j
         rhbcm5edh04jdD4j1c1dCVnBSyYfpNTd6b6ZqLZ12ezolUXNL2jpRLyR9zbadt5uSFvo
         ZZyg==
X-Gm-Message-State: AOAM5328bKNyWDCl8dkoOlm166OkhwwFhEPVZ60MNUqDgL6PhJu1cv+q
        y5boZsGgPStyLn+UnChmr/PG9OzLnTgGq5cxfZ8=
X-Google-Smtp-Source: ABdhPJwqvo4S0sElff72q48JHch4PU6XVMJO+9UHWqDGtb/ijXLDmTsHYZVW6ehY0qy/kzxEdqIkwB63ZoATUbypooE=
X-Received: by 2002:a67:8e04:: with SMTP id q4mr7472043vsd.9.1606505395590;
 Fri, 27 Nov 2020 11:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20201127011747.86005-1-shihaitao1@huawei.com>
In-Reply-To: <20201127011747.86005-1-shihaitao1@huawei.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 28 Nov 2020 00:59:58 +0530
Message-ID: <CAFqt6zajpBA5nwPq+7rzYwUWU8TJGNw7x5fDt6kCpHtVGtkM7w@mail.gmail.com>
Subject: Re: [PATCH] mm: fix some spelling mistakes in comments
To:     Haitao Shi <shihaitao1@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, rppt@kernel.org,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        wangle6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 6:50 AM Haitao Shi <shihaitao1@huawei.com> wrote:
>
> Fix some spelling mistakes in comments:
>         udpate ==> update
>         succesful ==> successful
>         exmaple ==> example
>         unneccessary ==> unnecessary
>         stoping ==> stopping
>         uknown ==> unknown
>
> Signed-off-by: Haitao Shi <shihaitao1@huawei.com>

Reviewed-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/filemap.c     | 2 +-
>  mm/huge_memory.c | 2 +-
>  mm/khugepaged.c  | 2 +-
>  mm/memblock.c    | 2 +-
>  mm/migrate.c     | 2 +-
>  mm/page_ext.c    | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3ebbe64..8826c48 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1359,7 +1359,7 @@ static int __wait_on_page_locked_async(struct page *page,
>         else
>                 ret = PageLocked(page);
>         /*
> -        * If we were succesful now, we know we're still on the
> +        * If we were successful now, we know we're still on the
>          * waitqueue as we're still under the lock. This means it's
>          * safe to remove and return success, we know the callback
>          * isn't going to trigger.
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ec2bb93..0fea0c2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2356,7 +2356,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>          * Clone page flags before unfreezing refcount.
>          *
>          * After successful get_page_unless_zero() might follow flags change,
> -        * for exmaple lock_page() which set PG_waiters.
> +        * for example lock_page() which set PG_waiters.
>          */
>         page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>         page_tail->flags |= (head->flags &
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4e3dff1..d6f7ede 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1273,7 +1273,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>                          * PTEs are armed with uffd write protection.
>                          * Here we can also mark the new huge pmd as
>                          * write protected if any of the small ones is
> -                        * marked but that could bring uknown
> +                        * marked but that could bring unknown
>                          * userfault messages that falls outside of
>                          * the registered range.  So, just be simple.
>                          */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b68ee86..086662a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -871,7 +871,7 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
>   * @base: base address of the region
>   * @size: size of the region
>   * @set: set or clear the flag
> - * @flag: the flag to udpate
> + * @flag: the flag to update
>   *
>   * This function isolates region [@base, @base + @size), and sets/clears flag
>   *
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5795cb8..8a3580c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2548,7 +2548,7 @@ static bool migrate_vma_check_page(struct page *page)
>                  * will bump the page reference count. Sadly there is no way to
>                  * differentiate a regular pin from migration wait. Hence to
>                  * avoid 2 racing thread trying to migrate back to CPU to enter
> -                * infinite loop (one stoping migration because the other is
> +                * infinite loop (one stopping migration because the other is
>                  * waiting on pte migration entry). We always return true here.
>                  *
>                  * FIXME proper solution is to rework migration_entry_wait() so
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index a3616f7..cf931eb 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -34,7 +34,7 @@
>   *
>   * The need callback is used to decide whether extended memory allocation is
>   * needed or not. Sometimes users want to deactivate some features in this
> - * boot and extra memory would be unneccessary. In this case, to avoid
> + * boot and extra memory would be unnecessary. In this case, to avoid
>   * allocating huge chunk of memory, each clients represent their need of
>   * extra memory through the need callback. If one of the need callbacks
>   * returns true, it means that someone needs extra memory so that
> --
> 2.10.1
>
>
