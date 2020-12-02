Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41F22CC4E3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbgLBSQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgLBSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:16:27 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E28C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:15:41 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id ga15so5826777ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+HneXQ+K+FQ2kOksuqItS+SrV08BiKc6Yp1aQiOWGk=;
        b=Q1n1tktW/Xuci3T/uoeI5pZjQ7yIspPk1A0Vwm79WQQ6gxvDwCOvzpHxlKmaDEUWHB
         lkN+TX6bp51fD/gl3RGyiC/qLKyO6i5YA8s5OJv62qpgVFNlcK4QVWduOwiydW16/Zwo
         t+AOIRePGWHMXkZrMdhd+dI2mnxOL0IkhBpSlSPuGlX3eBHVKDhv23qXPejGofEG4qYb
         Ahat4dC0PoERbd2oN6KCNb56u5ERBJCnp1Egy0+3pWpEGtHWT5+u1q/B3ME3RfO7Z+3x
         yJVLL3W/kEUKyQb60U5+firuiUCJJ588U4hi+fn7+tpdjVe2NY3JqHdTu+tbyaoOHt1N
         ZglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+HneXQ+K+FQ2kOksuqItS+SrV08BiKc6Yp1aQiOWGk=;
        b=jal23kc5PxrW6qZJ50Cex1Ew51xXw4DnIo5rw8lElgs5VZ7lEM2LR3m99ZlEAoCXv5
         pA5ycYFQIYj3xmZNAl7EPud2lChLB1vGGWhH+5j7n3w2Y1VO8Hj4bazH7ibK6exTaUXV
         ysG0aTU1hqyVZCqZYhTMEAxaLpxx9YF3MsYD13rDGdXB9PMYhF2Oc6uKc3loPeGZHvxk
         txYku1LF6pW+cmY0UspuXEND0Wu4YWY+ess7GwMBulIAJLWi25+3NpZuCoS4aIXB+P3C
         t2KWXKhwmLfTH2Rt18v5vkQ1zrJMfYf1SgFlbpGYJuS7qRN0JkA5YoejFW42dvkYl3k9
         mQvQ==
X-Gm-Message-State: AOAM531tjJxKRshx6vLdzr89jXpVgsJej38MtAHVTqQexKxIOBKCx9q9
        m06xgLpXZeJycK2u81lbalFkaVjFcYlnXe01dEXzHQ==
X-Google-Smtp-Source: ABdhPJzrX97q0CcIki5KKrZLz2XPX0PY2i+j3Vj3CT7Six7BEXBrkYvQd23KSf0TDBBYAtDHpX7+y08m1Brx+D5aK1s=
X-Received: by 2002:a17:906:1458:: with SMTP id q24mr988243ejc.541.1606932940227;
 Wed, 02 Dec 2020 10:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-2-pasha.tatashin@soleen.com> <20201202162215.GS1161629@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201202162215.GS1161629@iweiny-DESK2.sc.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Dec 2020 13:15:04 -0500
Message-ID: <CA+CK2bCncQiCK+DrCTQRd7MhygfLwAWSAdx+C-DX+OByg+FJ2w@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm/gup: perform check_dax_vmas only when FS_DAX is enabled
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 11:22 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Wed, Dec 02, 2020 at 12:23:25AM -0500, Pavel Tatashin wrote:
> > There is no need to check_dax_vmas() and run through the npage loop of
> > pinned pages if FS_DAX is not enabled.
> >
> > Add a stub check_dax_vmas() function for no-FS_DAX case.
>
> This looks like a good idea.
>
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  mm/gup.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 98eb8e6d2609..cdb8b9eeb016 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1568,6 +1568,7 @@ struct page *get_dump_page(unsigned long addr)
> >  #endif /* CONFIG_ELF_CORE */
> >
> >  #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
>
> In addition, I think it would make a lot of sense to clean up this config as
> well like this:
>
> 08:20:10 > git di
> diff --git a/mm/gup.c b/mm/gup.c
> index 102877ed77a4..92cfda220aeb 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1567,7 +1567,7 @@ struct page *get_dump_page(unsigned long addr)
>  }
>  #endif /* CONFIG_ELF_CORE */
>
> -#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
> +#ifdef CONFIG_FS_DAX
>  static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>  {
>         long i;
> @@ -1586,6 +1586,12 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>         }
>         return false;
>  }
> +#else
> +static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
> +{
> +       return false;
> +}
> +#endif /* CONFIG_FS_DAX */
>
>  #ifdef CONFIG_CMA
>  static long check_and_migrate_cma_pages(struct mm_struct *mm,
> @@ -1691,6 +1697,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>  }
>  #endif /* CONFIG_CMA */
>
> +#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
>  /*
>   * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
>   * allows us to process the FOLL_LONGTERM flag.
>
>
> That makes it more clear what is going on with __gup_longterm_locked() and
> places both CMA and FS_DAX code within their own blocks.

Hi Ira,

Thank you for your comments. I think the end result of what you are
suggesting is the same for this series when __gup_longterm_locked is
made common. " #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)"
mess is removed in that patch.

Pasha
