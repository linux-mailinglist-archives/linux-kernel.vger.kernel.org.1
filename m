Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B95226ABD1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgIOS1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgIOSXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:23:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C1C061353
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:23:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gr14so6495933ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ShJFz3O2UoFV/lQCaUWLOKhWZytgwFxTiuG7a5D3cE=;
        b=n6trtHxTcQjtJZGdvYFQ6qKRCrutxbVnecrpqzmMhwzyuU9Ny4ZkfwWLVyc0r7w4EX
         /PcgXTQasrpTvLF3ZXFmI6iAzuNbTobxASgARI/RpwPhiJdjDGweUSirtgJNA68Ucoq3
         rY93Xyt9CayLfEeNYHBtTJnUYT5iR7AopYfUv1Zfcw4DmtpNZD1ALyfUdMdeoWiKNCSe
         LnahvlfCADtUOlcSBHdf8hguPwQ8BlodxxBE+b5gVEzKcvHRRTHruRTGSIs02JmpVsMe
         RzKlHD+XrhPX3Ree5CXvO+wSLpFZd4/7YZzt19+PXyaVp5pjRg3lFCqVardeSzR2lOlJ
         Orsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ShJFz3O2UoFV/lQCaUWLOKhWZytgwFxTiuG7a5D3cE=;
        b=gdZqIpZZtvfUhwJX9g0OKhvQOJxS2iPQqUfGkTjf5eDGQauJr3eWf2X/LmQIh1iaCw
         L9GVfyx2VbarW/63WmLWkMltj+12VlVqCMylj1AkLu3WOJ4pC7M64mWloTvNnlx4OjtL
         uOXeaeYL8Xs++qRg1rz6dnjzxy/73Wh6AmcMKgoRr+taNIWRZHQ/xAtNqgRCwQqnIpsW
         6NUZUTfMf/HBgt/fZvbS1QGDCKhlGb8MClN7Vqo+XY8axmoXk3GcYYU8zSJRM53yLOzd
         e1Pabhx7qYAY96pTvOkbxuPvDJQRpXRBtF6CUJRFEcVqhP0yVgr17JkYOma7yF69KZlD
         3qdQ==
X-Gm-Message-State: AOAM530FTaimLJ9KoqaLo2op2jSq/JYwSWfgXIE3cMcduW3kNfC2rore
        3lLtxpHD+2e887YxOtyvVcGWwovkvlZGo9lM0zg6XQ==
X-Google-Smtp-Source: ABdhPJwBbFBFr4upujk6kdCs5w48PheDKBveXyCTE/m3QQ3iQ9gA73rCQViLh2tmbEj4nRfNkfvHNwh1ROEwpwIF9RQ=
X-Received: by 2002:a17:906:d787:: with SMTP id pj7mr20596675ejb.340.1600194189281;
 Tue, 15 Sep 2020 11:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
In-Reply-To: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 15 Sep 2020 14:22:33 -0400
Message-ID: <CA+CK2bAyV5h_MWRmho7sXQvqzhS5kOXR5UKXbOMXgMXP5fgmXg@mail.gmail.com>
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Allen Pais <apais@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 4:47 PM Vijay Balakrishna
<vijayb@linux.microsoft.com> wrote:
>
> When memory is hotplug added or removed the min_free_kbytes must be
> recalculated based on what is expected by khugepaged.  Currently
> after hotplug, min_free_kbytes will be set to a lower default and higher
> default set when THP enabled is lost. This leaves the system with small
> min_free_kbytes which isn't suitable for systems especially with network
> intensive loads.  Typical failure symptoms include HW WATCHDOG reset,
> soft lockup hang notices, NETDEVICE WATCHDOG timeouts, and OOM process
> kills.
>
> Fixes: f000565adb77 ("thp: set recommended min free kbytes")
>
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/khugepaged.h |  5 +++++
>  mm/khugepaged.c            | 13 +++++++++++--
>  mm/memory_hotplug.c        |  3 +++
>  3 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index bc45ea1efbf7..c941b7377321 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -15,6 +15,7 @@ extern int __khugepaged_enter(struct mm_struct *mm);
>  extern void __khugepaged_exit(struct mm_struct *mm);
>  extern int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>                                       unsigned long vm_flags);
> +extern void khugepaged_min_free_kbytes_update(void);
>  #ifdef CONFIG_SHMEM
>  extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
>  #else
> @@ -85,6 +86,10 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
>                                            unsigned long addr)
>  {
>  }
> +
> +static inline void khugepaged_min_free_kbytes_update(void)
> +{
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  #endif /* _LINUX_KHUGEPAGED_H */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cfa0dba5fd3b..4f7107476a6f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -56,6 +56,9 @@ enum scan_result {
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/huge_memory.h>
>
> +static struct task_struct *khugepaged_thread __read_mostly;
> +static DEFINE_MUTEX(khugepaged_mutex);
> +
>  /* default scan 8*512 pte (or vmas) every 30 second */
>  static unsigned int khugepaged_pages_to_scan __read_mostly;
>  static unsigned int khugepaged_pages_collapsed;
> @@ -2292,8 +2295,6 @@ static void set_recommended_min_free_kbytes(void)
>
>  int start_stop_khugepaged(void)
>  {
> -       static struct task_struct *khugepaged_thread __read_mostly;
> -       static DEFINE_MUTEX(khugepaged_mutex);
>         int err = 0;
>
>         mutex_lock(&khugepaged_mutex);
> @@ -2320,3 +2321,11 @@ int start_stop_khugepaged(void)
>         mutex_unlock(&khugepaged_mutex);
>         return err;
>  }
> +
> +void khugepaged_min_free_kbytes_update(void)
> +{
> +       mutex_lock(&khugepaged_mutex);
> +       if (khugepaged_enabled() && khugepaged_thread)
> +               set_recommended_min_free_kbytes();
> +       mutex_unlock(&khugepaged_mutex);
> +}
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e9d5ab5d3ca0..3e19272c1fad 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -36,6 +36,7 @@
>  #include <linux/memblock.h>
>  #include <linux/compaction.h>
>  #include <linux/rmap.h>
> +#include <linux/khugepaged.h>
>
>  #include <asm/tlbflush.h>
>
> @@ -857,6 +858,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>         zone_pcp_update(zone);
>
>         init_per_zone_wmark_min();
> +       khugepaged_min_free_kbytes_update();
>
>         kswapd_run(nid);
>         kcompactd_run(nid);
> @@ -1600,6 +1602,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>         pgdat_resize_unlock(zone->zone_pgdat, &flags);
>
>         init_per_zone_wmark_min();
> +       khugepaged_min_free_kbytes_update();

The bug makes sense that min_free_kbytes should be consistent after
reboot or after hot-add, hence
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
