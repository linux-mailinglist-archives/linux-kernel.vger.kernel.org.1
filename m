Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28D12D5907
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389379AbgLJLNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389313AbgLJLMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:12:37 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65079C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:11:57 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id o5so3892393pgm.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toUTo+ySXpS7pwb/7sjwWZ96dVr2pgQN6Yp4zKtbI18=;
        b=gsElE5i/SESaaJBRBBM6Fq1YbgbvDrPLr8lSX+3J3tHCBRX4mt6Yx40XqMH1+TRhu0
         USTJmHCrsOdAO91tQ1jFeR0glBUhTMydCVEXLhrrjDEOLrfUJxvkXfhxgNCILQ/93NOB
         egUHBpYxVyTIiFxYBn8me3XEJ9C7muGEJbFn8fpEv4MTlySEQ2nvAE/Plkf2nNv0tmN/
         /fZBZ5H8yOrwF1HY7NOm73CJo0yreVKeDLGlMS3uWRfAq6J7l6rTxYyBWOIpRPv0VyR/
         Tm0SEDpS5c/qET4+mWxFJZPPQa5AmX0+5+4eSVVe8/jRYQkflcxYJH7Zh6CYF7S7f+M/
         seYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toUTo+ySXpS7pwb/7sjwWZ96dVr2pgQN6Yp4zKtbI18=;
        b=kmAHwOafbCZoV89sPI2TS7gm0GwGTUM38jTrLH6i/oFXY9/oppKW6kan/TEXvrHA7+
         f20UV1KCxq7J3hLQM282W4QZRr9/MAhYuAykHaGUcfS8CsaqUjcpNnPxgBlNouJhJthk
         j5Pyeb3RMLWuAddWdoq6y0QPNLnKslxx17XdaH1N/zVGZiVvFIGmNiV437rUP0ZksyKC
         AS2lih0ogxH8GbRWQf9Y+a0ycMm8AxD4ENovTjmOehpSpWpTKwEbFGRoa25UbbI/rCo4
         HWHKpSHl2xgjgzmTovXF21EYHSJnmlcdakLO47MXvOifVqB9kM3d5CbJYf1kFfefEzry
         rlpw==
X-Gm-Message-State: AOAM532fi73Tc4Xj8FcBb6CFbgb5UV6sQfSrT79Tc4fGOvdv40NA6M6Z
        i929RSeMWFbax7TGi17bTPgXQnT2qTF5j7tF6X+iXg==
X-Google-Smtp-Source: ABdhPJw7AOn+643GfwIOTgmZBys/IqTqxKhs72rJGIyik1pe/QrVTeSUw+qQTfJQoJioQPBqgw5RxLU9GRgMc0xFADo=
X-Received: by 2002:a63:cd14:: with SMTP id i20mr6177612pgg.31.1607598716845;
 Thu, 10 Dec 2020 03:11:56 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com> <20201210035526.38938-8-songmuchun@bytedance.com>
In-Reply-To: <20201210035526.38938-8-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Dec 2020 19:11:19 +0800
Message-ID: <CAMZfGtUrmkm7N5r+vBjhiKNFksNG+eTKvTQL9FLcnj_3JHm5mA@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] mm/hugetlb: Set the PageHWPoison to the raw
 error page
To:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:58 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Because we reuse the first tail vmemmap page frame and remap it
> with read-only, we cannot set the PageHWPosion on a tail page.
> So we can use the head[4].mapping to record the real error page
                              ^^^
                             private

A typo. Will update the next version. Thanks.

> index and set the raw error page PageHWPoison later.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 44 insertions(+), 8 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 542e6cb81321..06157df08d8e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1347,6 +1347,47 @@ static inline void __update_and_free_page(struct hstate *h, struct page *page)
>                 schedule_work(&hpage_update_work);
>  }
>
> +static inline void subpage_hwpoison_deliver(struct hstate *h, struct page *head)
> +{
> +       struct page *page = head;
> +
> +       if (!free_vmemmap_pages_per_hpage(h))
> +               return;
> +
> +       if (PageHWPoison(head))
> +               page = head + page_private(head + 4);
> +
> +       /*
> +        * Move PageHWPoison flag from head page to the raw error page,
> +        * which makes any subpages rather than the error page reusable.
> +        */
> +       if (page != head) {
> +               SetPageHWPoison(page);
> +               ClearPageHWPoison(head);
> +       }
> +}
> +
> +static inline void set_subpage_hwpoison(struct hstate *h, struct page *head,
> +                                       struct page *page)
> +{
> +       if (!PageHWPoison(head))
> +               return;
> +
> +       if (free_vmemmap_pages_per_hpage(h)) {
> +               set_page_private(head + 4, page - head);
> +               return;
> +       }
> +
> +       /*
> +        * Move PageHWPoison flag from head page to the raw error page,
> +        * which makes any subpages rather than the error page reusable.
> +        */
> +       if (page != head) {
> +               SetPageHWPoison(page);
> +               ClearPageHWPoison(head);
> +       }
> +}
> +
>  static void update_and_free_page(struct hstate *h, struct page *page)
>  {
>         if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> @@ -1363,6 +1404,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
>         int i;
>
>         alloc_huge_page_vmemmap(h, page);
> +       subpage_hwpoison_deliver(h, page);
>
>         for (i = 0; i < pages_per_huge_page(h); i++) {
>                 page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
> @@ -1840,14 +1882,8 @@ int dissolve_free_huge_page(struct page *page)
>                 int nid = page_to_nid(head);
>                 if (h->free_huge_pages - h->resv_huge_pages == 0)
>                         goto out;
> -               /*
> -                * Move PageHWPoison flag from head page to the raw error page,
> -                * which makes any subpages rather than the error page reusable.
> -                */
> -               if (PageHWPoison(head) && page != head) {
> -                       SetPageHWPoison(page);
> -                       ClearPageHWPoison(head);
> -               }
> +
> +               set_subpage_hwpoison(h, head, page);
>                 list_del(&head->lru);
>                 h->free_huge_pages--;
>                 h->free_huge_pages_node[nid]--;
> --
> 2.11.0
>


-- 
Yours,
Muchun
