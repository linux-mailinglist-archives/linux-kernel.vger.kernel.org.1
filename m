Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175C62D53DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 07:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgLJGiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLJGht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:37:49 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B07BC0613D6;
        Wed,  9 Dec 2020 22:37:09 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id i9so4325793ioo.2;
        Wed, 09 Dec 2020 22:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HShWYqj3AYkJnLdHwx5NgTdwZAauQZwAST01WHghFCw=;
        b=IQ31dFe57fhu9rGhuD00c/OfQpSIabk6bgI0gHu40WhQT8qCL+eAD5H88Ks7o+XBsU
         gailQfrvR0zNGmYIbl9rXhoCKFExvAC+vs1EOTQ7c26uu43hKHu9AVH3XZq+Tb0P1+Um
         7jF3+Vdr62F9LPXIQ+5rM1RTWgAlgRLIsSAPCV1SGKYBwV0IFD137d2pMJnfq8PLQcg9
         TH8n4iP4LhXDgSYdPSPoX+wSqNf2sVTdlfIWHRy7pQGtKZdT+uM4O5b2+SLIoFJdu85+
         Mt7K79Qi7pZ6JiNlDYChcZhqk/zKXXt14Sqa63zw2nD1F8Ur6gz0bc2atVDwZC4e7/QQ
         TA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HShWYqj3AYkJnLdHwx5NgTdwZAauQZwAST01WHghFCw=;
        b=oGk0Aw/+yz1VjOBYmbnKoS81tPsnMFiYFm8+nVU4xcdsH8S8Cio2FD+i9zIFfekjnZ
         Km+TBxDLPAxWpmeyjnJlwydGqRD6ywe2MeB2fOIZ6QvZT6p5gnTylCnVYbSErDYBLrEN
         NZlG811o6WeiJwMBrLJDFtkXKGUaCNh9zmSBGlr8/4SqggdV7K2Wa6aeXSyGy/vb8gGQ
         BweXONYxwjevgFOYsrxJlQu+jyu7TZT98oNjdbCoXlf3Yf00B2ZmVPbJ4MVf/3N9tk/P
         GB7RmqKpE1I5kDA9o8DI/TBKfkRaFOFVOkVmtBd7ZpfF9rnqbjA2Xi77XXWICQADtFyt
         4Ruw==
X-Gm-Message-State: AOAM5321KFZn1IgsVQ6dMtzYjK+NNvPNnHLAiUf71AwYScrgy9cGvxlB
        ZmhCzc9m0dGPvEq0qPq36Pq0ev213zyOdpme4p0=
X-Google-Smtp-Source: ABdhPJykPkxnX2Y/fkHHKMJSnlcG1CwqOHr7++Gujfz0sDW66ZNXcKFl1K9MuvhBUWNpIbGruWPU7+8kG11G3O9f4E8=
X-Received: by 2002:a02:4007:: with SMTP id n7mr7722100jaa.99.1607582228088;
 Wed, 09 Dec 2020 22:37:08 -0800 (PST)
MIME-Version: 1.0
References: <20201210004335.64634-1-pasha.tatashin@soleen.com> <20201210004335.64634-2-pasha.tatashin@soleen.com>
In-Reply-To: <20201210004335.64634-2-pasha.tatashin@soleen.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 10 Dec 2020 07:36:56 +0100
Message-ID: <CAM9Jb+g2B+uXH+Vj_FSMAh18j3DAKn4zKyAZNB_t8hSQ90a=mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] mm/gup: perform check_dax_vmas only when FS_DAX is enabled
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>, sashal@kernel.org,
        tyhicks@linux.microsoft.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        mike.kravetz@oracle.com, rostedt@goodmis.org,
        Ingo Molnar <mingo@redhat.com>,
        "Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>, Johannes Thumshirn
        <jthumshirn@suse.de>, Logan Gunthorpe" <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no need to check_dax_vmas() and run through the npage loop of
> pinned pages if FS_DAX is not enabled.
>
> Add a stub check_dax_vmas() function for no-FS_DAX case.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 98eb8e6d2609..cdb8b9eeb016 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1568,6 +1568,7 @@ struct page *get_dump_page(unsigned long addr)
>  #endif /* CONFIG_ELF_CORE */
>
>  #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
> +#ifdef CONFIG_FS_DAX
>  static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>  {
>         long i;
> @@ -1586,6 +1587,12 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>         }
>         return false;
>  }
> +#else
> +static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
> +{
> +       return false;
> +}
> +#endif
>
>  #ifdef CONFIG_CMA
>  static long check_and_migrate_cma_pages(struct mm_struct *mm,

Reviewed-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
