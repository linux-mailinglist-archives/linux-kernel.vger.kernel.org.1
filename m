Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAED2EC8FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbhAGDNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbhAGDM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:12:59 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3541C0612F1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 19:12:19 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j1so2742359pld.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 19:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFaQSU6zAPh4XFUMfv4Im/acDbmbkFA05vZT/8+GY7s=;
        b=ireGTiKbcsC3M6ko83iv9eDXH6Wr2YSly3Ds/y0S5G++26mBju5yYZ1WKJaHDfFCC9
         +jbAKKr2SoqFkQjXUwiUm0AjaqPS6khLSqyJDAWAmQ6QZPG4SLO7uYml8uC0sIJR71/M
         EKe0j5yNudWGT+qWLzrgs2mdDS3rvlvk4UgIhOWpQSOLuyHnEjNalq7b+EnsheNc+6+j
         0K7VQto+e7/jDiLEBwV+X0XGbTU8JEh4FhWefpP6h8wP41AI5n+DwawRPJ9YR1drdQP1
         Gj87sAY/O7UnXuULKOF5YnvAxa11BJyeLwwC4TraM/c84aFOF79MRWsKwz8e1JWxxa88
         LcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFaQSU6zAPh4XFUMfv4Im/acDbmbkFA05vZT/8+GY7s=;
        b=tfId3stCU/qa+cJb+T3agIbXcMBkJVq1Y7S278QdAOck0gdynlQnBuoTFlhQbWuXoP
         nkFJkFil8YjNlz0/+7cRwTY+b9MK+C9ars5Dva1+0ImOmndH0vQ1HA3jImZJ3eor/cqD
         fnRy5wp7PumJ03ldbvAm8ZXGB7NriTIKzfx9gy8zI4UEfhmsCFHXjSI0nsvDLjBYFwfU
         K7FbCeuGPFEWcG1HwopEV3L6qxPxq3EZ/zyGICGfCwvV8hb2dwF0V0D9n0QoslsVLbTf
         Zowu2fy21EBiTA/Q2jfCwDsmZfWQbylBBj6gcXKsT79jS8fu2c9PNc8qgi7jAHtLK7wh
         BcBg==
X-Gm-Message-State: AOAM5326N5/pm+0Cj18UOI3irlZP6U5XwmofeDX/9j/6nz52icctAPs9
        gQZxbacKkvlODVG5AvCJJxBETW2FaOAqpd7LaAhIY+0Ni/Bz2Gg6x8U=
X-Google-Smtp-Source: ABdhPJwqyiEy1UwHz4mlEsLelbauSmVFuTl8jJOx4KxXEQjC6QLSOQd15b9MS5kSSgziVXrcoc0a2Ber03b6EI983pE=
X-Received: by 2002:a17:902:8503:b029:dc:44f:62d8 with SMTP id
 bj3-20020a1709028503b02900dc044f62d8mr7387757plb.34.1609989139255; Wed, 06
 Jan 2021 19:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-5-songmuchun@bytedance.com> <20210106170754.GU13207@dhcp22.suse.cz>
In-Reply-To: <20210106170754.GU13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 11:11:41 +0800
Message-ID: <CAMZfGtWg0J5syATXMpP8RYOz=w0gJNYz_=UrT3ueMspQjNY7BQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 1:07 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 06-01-21 16:47:37, Muchun Song wrote:
> > When dissolve_free_huge_page() races with __free_huge_page(), we can
> > do a retry. Because the race window is small.
>
> Is this a bug fix or mere optimization. I have hard time to tell from
> the description.

It is optimization. Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> [...]
> > @@ -1825,6 +1828,14 @@ int dissolve_free_huge_page(struct page *page)
> >       }
> >  out:
> >       spin_unlock(&hugetlb_lock);
> > +
> > +     /*
> > +      * If the freeing of the HugeTLB page is put on a work queue, we should
> > +      * flush the work before retrying.
> > +      */
> > +     if (unlikely(rc == -EAGAIN))
> > +             flush_work(&free_hpage_work);
>
> Is it safe to wait for the work to finish from this context?

Yes. It is safe.

>
> --
> Michal Hocko
> SUSE Labs
