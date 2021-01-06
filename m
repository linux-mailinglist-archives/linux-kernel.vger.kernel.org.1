Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6EF2EC19B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbhAFQ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbhAFQ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:59:57 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F7C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 08:59:16 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e7so3841467ile.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 08:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3EmfUTuYnuTvPsdC4hdIk2/vIKZRsbh5sYgRQoKisdc=;
        b=kBn4N4cJQY1i+4o8/OjUAlYWOoo4zZhtiRIw2uz9KnHglVk+6VWWFzkj8sI7zU+85G
         PhR6dzXAwWuVGiDXkHkXqG9lLgitcz8TlgzkJvMxp1i4rUCgyqFXE9Ipu0kstODAcX0g
         mpayT3d4Uwaaw6k6mNhrite1jm4Oq9cQntsaW1Y/NDC1s0fslrfPs+8GY7jR0km7SESU
         HOndvPqqmkmf8ZhRmj4NZAy6zeYOCS+QTUb2iHWxdUDKZ43BTgQl8IJqXx/tpCi4BmjM
         0tRgZ3kA4x4S2356P19eTh3+DsEr5Fw3USj0OCBf3WQTQIiMZNtObrhY2i+GzQtpW8Z2
         w4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EmfUTuYnuTvPsdC4hdIk2/vIKZRsbh5sYgRQoKisdc=;
        b=Qxf3h9JDUGN9l0eDfGhx+yAkVrZbPF2WrEtIdKSjQGecIBzw3fjHsY33+pz/O9Xtxx
         OjzjBfVsoEpJhkFCkJcvajFfJRPXykiSyobV2GeswR/MviVurdHw2rhhQUr1B8Jl3RhW
         hK5ENqYUKZNYMOIPdxDqJjxqhiqze3ACYbDWcO1jzC5pjFO4IUZ0urSmMOStc2S2xCbx
         oSXYzAwUoO+JGgeJmECe4R2dN7QPs2bYLdjTm7SHgohy5SkvcNgJ4a2OxWFWp8vPRGQM
         y7XDvxGxmgizEJ9UH5H/YROvbr/z0snCxPk2pMjXUYlo7xs2cYMqtfUcKIijA8rIXZa6
         Z0hw==
X-Gm-Message-State: AOAM530y/JBLfnK3hog+1EgBNqOq4wpWiJaGHrwDTgZwMUYuqP+3fgPa
        sBbJOKfMvcrZZeCI37EH0R1DJBln1kxn9S2JRJg=
X-Google-Smtp-Source: ABdhPJzjwgaxVsHtTZws6cL84ADauyumJ8mJ0Jvu4/J1N8I/u89+8vWMx+nTn/GdpCCaz5MlKXGT+g3VPF3uG37FwtE=
X-Received: by 2002:a92:d8cc:: with SMTP id l12mr4972019ilo.64.1609952354762;
 Wed, 06 Jan 2021 08:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20210106034715.GA1138@open-light-1.localdomain>
In-Reply-To: <20210106034715.GA1138@open-light-1.localdomain>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 6 Jan 2021 08:59:03 -0800
Message-ID: <CAKgT0Uf=iQ-vzk7woNBsgAOvVD2RS41x9dRC-Y06TCGwykHzSw@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: Add batch size for free page reporting
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Cc:     Liang Li <liliang324@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 7:47 PM Liang Li <liliang324@gmail.com> wrote:
>
> Use the page order as the only threshold for page reporting
> is not flexible and has some flaws. Because scan a long free
> list is not cheap, it's better to wake up the page reporting
> worker when there are more pages, wake it up for a sigle page
> may not worth.
> This patch add a batch size as another threshold to control the
> waking up of reporting worker.
>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Liang Li <liliang324@gmail.com>
> Signed-off-by: Liang Li <liliangleo@didiglobal.com>

So you are going to need a lot more explanation for this. Page
reporting already had the concept of batching as you could only scan
once every 2 seconds as I recall. Thus the "PAGE_REPORTING_DELAY". The
change you are making doesn't make any sense without additional
context.

> ---
>  mm/page_reporting.c |  1 +
>  mm/page_reporting.h | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index cd8e13d41df4..694df981ddd2 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -12,6 +12,7 @@
>
>  #define PAGE_REPORTING_DELAY   (2 * HZ)
>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
> +unsigned long page_report_batch_size  __read_mostly = 16 * 1024 * 1024UL;
>
>  enum {
>         PAGE_REPORTING_IDLE = 0,
> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> index 2c385dd4ddbd..b8fb3bbb345f 100644
> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -12,6 +12,8 @@
>
>  #define PAGE_REPORTING_MIN_ORDER       pageblock_order
>
> +extern unsigned long page_report_batch_size;
> +
>  #ifdef CONFIG_PAGE_REPORTING
>  DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
>  void __page_reporting_notify(void);
> @@ -33,6 +35,8 @@ static inline bool page_reported(struct page *page)
>   */
>  static inline void page_reporting_notify_free(unsigned int order)
>  {
> +       static long batch_size;
> +

I'm not sure this makes a tone of sense to place the value in an
inline function. It might make more sense to put this new code in
__page_reporting_notify so that all callers would be referring to the
same batch_size value and you don't have to bother with the export of
the page_report_batch_size value.

>         /* Called from hot path in __free_one_page() */
>         if (!static_branch_unlikely(&page_reporting_enabled))
>                 return;
> @@ -41,8 +45,12 @@ static inline void page_reporting_notify_free(unsigned int order)
>         if (order < PAGE_REPORTING_MIN_ORDER)
>                 return;
>
> -       /* This will add a few cycles, but should be called infrequently */
> -       __page_reporting_notify();
> +       batch_size += (1 << order) << PAGE_SHIFT;
> +       if (batch_size >= page_report_batch_size) {
> +               batch_size = 0;

I would probably run this in the opposite direction. Rather than
running batch_size to zero I would look at adding a "batch_remaining"
and then when it is < 0 you could then reset it back to
page_report_batch_size. Doing that you only have to read one variable
most of the time instead of doing a comparison against two.

> +               /* This add a few cycles, but should be called infrequently */
> +               __page_reporting_notify();
> +       }
>  }
>  #else /* CONFIG_PAGE_REPORTING */
>  #define page_reported(_page)   false
> --
> 2.18.2
>
>
