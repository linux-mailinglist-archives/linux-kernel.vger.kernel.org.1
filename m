Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C6A2F0BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbhAKEmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbhAKEmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:42:39 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03237C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:41:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o19so35962086lfo.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4dO/ZLr0ZIE4Ng1itVD5IzqiR/Cecvu81AcHLMbTek=;
        b=HMplX0lMqcUFUOxW4HCbUvqChmvav3l7jLVJtDZu27s6/KkVZBH1fv4B3IBwQU6sEJ
         +tf9G88binXZG1goF8xBvgMkYphk3hww2vhFEFZD6L2mdfrkFEYlvj6GzthC6LQ7G7ap
         sDbVmbS0b/+CuvYsKTePVZMAcgTOufIayaorZjWs4zZ9A+DH6BmuwTMTpzwi6u78C2iS
         R7IntfdHLsz7zar7SioPoymT7bNpVDQTqKvtqtDVFYOqnkvZMPyQWk7ys71UJ48m+J1x
         TXbutsYZ+POZtwfFI7E7Elsy+OSUV3YL7WOBJmWcOaqLo8jAzDsOmZqkbiHCsqPNY5N2
         ztKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4dO/ZLr0ZIE4Ng1itVD5IzqiR/Cecvu81AcHLMbTek=;
        b=CvsGd5rz/Oo9vOmVAd40qTtKs3BIROz0mEKXcX6gPrKJPJGUjHavcVrCDOoBHkO3aN
         S498orAya6Z/n+clSGYn5nh5dN3hN2/Vftaji4wibO6keisIjFdVEZbOfPVbaZ7Yjakh
         KTTp6fSEhp9EYbeOiogqr8e7+Jece1JvloAUBeuWTSxzLvVUkzN3S9Hyo+to0z1VWOkQ
         Rq+y8eFLt7vn29Wm7hcKvDzCvttF/tvjNWQ+FOxDn1scEZs9+JDhW7wTJ5wVjSKU+X0t
         8BtUv1H2ryIGcx/yI4Nz21jUz8vjMqYrBFHTYpINnKpJ2wNPRw/B1QltQAAFOTF6mE5e
         bZTQ==
X-Gm-Message-State: AOAM532yXboFgwTGqmXrxd574dv28Vx6Div8X8U2jY+6KnlNvgYNUasI
        1BMF/lJqUMTadbcxjKTx8Aa91NPUc5WydakkZRY=
X-Google-Smtp-Source: ABdhPJwjy92psIeBV49XVRBM/CKbUrrSFhMq8aLlgfiOS2u3eSxgMGJp+6rJAvbKFSfvMRB99s1qWH9mkSMWYEtxN9M=
X-Received: by 2002:a19:804a:: with SMTP id b71mr6132913lfd.504.1610340116091;
 Sun, 10 Jan 2021 20:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20210106035027.GA1160@open-light-1.localdomain>
 <CAKgT0Ue=hXEarqjW-h2G1fODA5UiSjHsKz3FpcyTcaTtQR4iMw@mail.gmail.com>
 <CA+2MQi9MxE_DWW3BHLJbvYDsOppCmfL6AHkdRwtHX0gBDpDebA@mail.gmail.com> <CAKgT0UfQUgZvsw6iQOFuFCGSt1SoU5ij4nC7tsUwbvf4C_0fnA@mail.gmail.com>
In-Reply-To: <CAKgT0UfQUgZvsw6iQOFuFCGSt1SoU5ij4nC7tsUwbvf4C_0fnA@mail.gmail.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Mon, 11 Jan 2021 12:41:40 +0800
Message-ID: <CA+2MQi8b2HnoxL573FmQb0rFE-y2LHKD9fv7cizAYgYvEOL+Zg@mail.gmail.com>
Subject: Re: [PATCH 4/6] hugetlb: avoid allocation failed when page reporting
 is on going
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Please don't use this email address for me anymore. Either use
> > > alexander.duyck@gmail.com or alexanderduyck@fb.com. I am getting
> > > bounces when I reply to this thread because of the old address.
> >
> > No problem.
> >
> > > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > > index eb533995cb49..0fccd5f96954 100644
> > > > --- a/mm/hugetlb.c
> > > > +++ b/mm/hugetlb.c
> > > > @@ -2320,6 +2320,12 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
> > > >                 goto out_uncharge_cgroup_reservation;
> > > >
> > > >         spin_lock(&hugetlb_lock);
> > > > +       while (h->free_huge_pages <= 1 && h->isolated_huge_pages) {
> > > > +               spin_unlock(&hugetlb_lock);
> > > > +               mutex_lock(&h->mtx_prezero);
> > > > +               mutex_unlock(&h->mtx_prezero);
> > > > +               spin_lock(&hugetlb_lock);
> > > > +       }
> > >
> > > This seems like a bad idea. It kind of defeats the whole point of
> > > doing the page zeroing outside of the hugetlb_lock. Also it is
> > > operating on the assumption that the only way you might get a page is
> > > from the page zeroing logic.
> > >
> > > With the page reporting code we wouldn't drop the count to zero. We
> > > had checks that were going through and monitoring the watermarks and
> > > if we started to hit the low watermark we would stop page reporting
> > > and just assume there aren't enough pages to report. You might need to
> > > look at doing something similar here so that you can avoid colliding
> > > with the allocator.
> >
> > For hugetlb, things are a little different, Just like Mike points out:
> >      "On some systems, hugetlb pages are a precious resource and
> >       the sysadmin carefully configures the number needed by
> >       applications.  Removing a hugetlb page (even for a very short
> >       period of time) could cause serious application failure."
> >
> > Just keeping some pages in the freelist is not enough to prevent that from
> > happening, because these pages may be allocated while zero out is on
> > going, and application may still run into a situation for not available free
> > pages.
>
> I get what you are saying. However I don't know if it is acceptable
> for the allocating thread to be put to sleep in this situation. There
> are two scenarios where I can see this being problematic.
>
> One is a setup where you put the page allocator to sleep and while it
> is sleeping another thread is then freeing a page and your thread
> cannot respond to that newly freed page and is stuck waiting on the
> zeroed page.
>
> The second issue is that users may want a different option of just
> breaking up the request into smaller pages rather than waiting on the
> page zeroing, or to do something else while waiting on the page. So
> instead of sitting on the request and waiting it might make more sense
> to return an error pointer like EAGAIN or EBUSY to indicate that there
> is a page there, but it is momentarily tied up.

It seems returning EAGAIN or EBUSY will still change the application's
behavior,  I am not sure if it's acceptable.

Thanks
Liang
