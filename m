Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4504E259D5F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgIARj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 13:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgIARjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:39:51 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075FC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:39:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so1555830qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dTH+bNJOVXEV4YAgVROsUKTRXuusFobQPV2qEAjExjo=;
        b=L8WxnfzL7AjVEPVEFFYMhuzTTkiy3cDiPoU3L2Qm/DwRsWLOONreXcS5pbwCFBPy9t
         l232tfTWNlOovA89iItN4WS+KqrH0dkAPc/ZO4mxd/XN254aNdNQLahXJlNSOMc37OPD
         WzZyBgEjJQpR+gbV2KOho/F5+Ds+Z7jQ78iQ4zuk+DLkN1NEqTh1F1XYK6DKzRLr/Dri
         7MjcbfodXNLn+OzaCxbc3YSERJyn8DPM+441qKvnU1o41Ciq/g1tOxewxljvDIGwcv0J
         OoLWUzaG1JE0NXtgbP2a6sUJb+y9FVosAAK2oFkPrgQ2tmt7Oj6rK9+feBIwDxqL+fHm
         NbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dTH+bNJOVXEV4YAgVROsUKTRXuusFobQPV2qEAjExjo=;
        b=U/c10/gYN9BPmp8++cxqKF63JLTHCYKLjo8bcH3SdvRMwBbk9al+m1Q5vvn5OCzuPO
         xxzUYyA3GIrvV2VWYhNH1k2qK5HOhetXo2lzsQ2KZOM7mbTLpB+ln/NN+wDAW+BSO2y3
         iYnGtei1fFOya0PhQt5ZUD1mqrQ8sKmWfAHUC8Q1aL54yXEaIddW0QCu4rg8UswmPaHJ
         gVBqpx2f7KMZ0dRGnJRKh48/sDO5KU3Qa0QinWrDYTi/annsafA2Lw/Li1Yd20T8dCRU
         fdZY1JQH0t/R7eQanLmdFyi47XCAAvHS+8HqbBgUBi5YqRe2QlzTCvWTevr/oMuSl9m0
         39/A==
X-Gm-Message-State: AOAM533Jyv4ZQbke+0Al2Oy1MNXlbfkgB7dxUbLJgMkfVm1QZKxU8pnh
        OABXryKtjJbjj8tkVWq/n1xE5Q==
X-Google-Smtp-Source: ABdhPJzvQHBl6Chcsv/zF6psJYIrXB7fxj1CAXvQqzy+08HzZ3fbAc7sQwPmZbAF4Qmn+KshYyci5w==
X-Received: by 2002:aed:26a7:: with SMTP id q36mr2892127qtd.57.1598981989480;
        Tue, 01 Sep 2020 10:39:49 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g14sm2323619qkk.38.2020.09.01.10.39.46
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2020 10:39:47 -0700 (PDT)
Date:   Tue, 1 Sep 2020 10:39:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Kuo-Hsin Yang <vovoy@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/5] shmem: shmem_writepage() split unlikely i915 THP
In-Reply-To: <CAHbLzko5xAyzJ7s31B55uXJPXT+2dzun+XcGPJngTwJ6mE=ETg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2009011033080.2984@eggly.anvils>
References: <alpine.LSU.2.11.2008301401390.5954@eggly.anvils> <CAHbLzko5xAyzJ7s31B55uXJPXT+2dzun+XcGPJngTwJ6mE=ETg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020, Yang Shi wrote:
> On Sun, Aug 30, 2020 at 2:04 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > drivers/gpu/drm/i915/gem/i915_gem_shmem.c contains a shmem_writeback()
> > which calls shmem_writepage() from a shrinker: that usually works well
> > enough; but if /sys/kernel/mm/transparent_hugepage/shmem_enabled has
> > been set to "force" (documented as "Force the huge option on for all -
> > very useful for testing"), shmem_writepage() is surprised to be called
> > with a huge page, and crashes on the VM_BUG_ON_PAGE(PageCompound) (I
> > did not find out where the crash happens when CONFIG_DEBUG_VM is off).
> >
> > LRU page reclaim always splits the shmem huge page first: I'd prefer not
> > to demand that of i915, so check and split compound in shmem_writepage().
> >
> > Fixes: 2d6692e642e7 ("drm/i915: Start writeback from the shrinker")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: stable@vger.kernel.org # v5.3+
> > ---
> > I've marked this for stable just for the info, but the number of users
> > affected is very probably 1, so please feel free to delete that marking.
> >
> >  mm/shmem.c |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > --- 5.9-rc2/mm/shmem.c  2020-08-16 17:32:50.693507198 -0700
> > +++ linux/mm/shmem.c    2020-08-28 17:35:08.326024349 -0700
> > @@ -1362,7 +1362,15 @@ static int shmem_writepage(struct page *
> >         swp_entry_t swap;
> >         pgoff_t index;
> >
> > -       VM_BUG_ON_PAGE(PageCompound(page), page);
> > +       /*
> > +        * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "force",
> > +        * then drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
> > +        * and its shmem_writeback() needs them to be split when swapping.
> > +        */
> > +       if (PageTransCompound(page))
> > +               if (split_huge_page(page) < 0)
> > +                       goto redirty;
> 
> The change looks good to me. Acked-by: Yang Shi <shy828301@gmail.com>

Thanks.

> 
> Just a nit: it may be better to move the spilte after the !PageLocked
> assertion? Split needs page locked too.

I hadn't considered that, but I think it's best left as is:
split_huge_page_to_list() has its own 
	VM_BUG_ON_PAGE(!PageLocked(head), head);
to enforce its needs: think of the old BUG_ON(!PageLocked(page))
below as enforcing shmem's needs, checking that split_huge_page()
did not unlock it :)

> 
> > +
> >         BUG_ON(!PageLocked(page));
> >         mapping = page->mapping;
> >         index = page->index;
> >
