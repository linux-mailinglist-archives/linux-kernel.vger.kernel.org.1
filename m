Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5109D2D64B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392868AbgLJSPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgLJRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:07:14 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200BDC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:06:34 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so4778506pge.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfRhTAas1NcetqsYHCdhKdRkmhDx/6FtHvtSU75aAas=;
        b=Mb7SoDls4nifj95yys/nowAqBSY/LC+BoX0EAbTxa/y37i1DCYf4rw1bYQJ4mH4vYL
         /1ttdgE5mTdf5ZZpBvmUxqILY8drb6/plJX6BwO2W8VE3YlkIQfaf51ZC2x1kQT0g3KR
         CIcHoj27fgpFrnmV3MYI9byhT8ZNtQzXErfG0CToemZtuHzIKA8WsjG+A5ykxbFi2KnZ
         yeCY2mGPMAlz+HrKB3/d/fc5YUhKBSIF4Yxg1cn0R7pweYEYK1VMPizYW8ntZY9wTL4Q
         3UU9CuW31tWbcEDJ3/7Br6bxpfYVuEwjWp3JbOBj+6c/hfa3Fo4hoT+tfeHOuOoUXtyT
         mpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfRhTAas1NcetqsYHCdhKdRkmhDx/6FtHvtSU75aAas=;
        b=mcJIvUcWtckdF+/qJ9HX9Kdz6+qgCLZlq8LZW+LHMlJS/wgrQe5b1NwclHgpmFgLx6
         bn35/4gHSI3cJXiEz+fmpg+vl4xWLnBHq6dItWLWlRLOLTZZbCVUUOkVmoOj1f57Plxr
         f4us3iCLdqoK/2Bo/bU57CajoudOP1jht/zCqegu5OoKRJ4IZ3mScaWxCJQ6xVazibg2
         3vuLI38dMsvadC7y230Unl2tXH+iuv6lQ9VuPuCzRrzCHUO4B56ion27Ee76gBA3o0Bj
         la6s4WNby0n+LZ8em/a3XoHtpT0Gf0GSADPVn/EiKQdgimv1/Va7XZq0n59/m1lD6tqj
         Jl7g==
X-Gm-Message-State: AOAM532k/VWe2Q9zbKw/7IPSuZBbxx5N7uPL3af735FlCgcgADYvJMP6
        Z3rL0QGFqDw0TPFrZGQtLi0v2UhEAYMaGV/FyTWiJg==
X-Google-Smtp-Source: ABdhPJwzwDINb3ns3Cp832HhOjuUTFM1ozT9iHLW2N0EKRAzFHGslaUcpij+yIP4IAk6go9O4lzqaBQwKLO9C1yk9vE=
X-Received: by 2002:aa7:8105:0:b029:18e:c8d9:2c24 with SMTP id
 b5-20020aa781050000b029018ec8d92c24mr7623323pfi.49.1607619993694; Thu, 10 Dec
 2020 09:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201206101451.14706-3-songmuchun@bytedance.com> <20201210161029.GI264602@cmpxchg.org>
In-Reply-To: <20201210161029.GI264602@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Dec 2020 01:05:57 +0800
Message-ID: <CAMZfGtWBqR=__CLL_nsXUAOirT8mrgCjh8BTipNH_H2qUijixA@mail.gmail.com>
Subject: Re: [External] Re: [RESEND PATCH v2 02/12] mm: memcontrol: convert
 NR_ANON_THPS account to pages
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 12:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Sun, Dec 06, 2020 at 06:14:41PM +0800, Muchun Song wrote:
> > @@ -1144,7 +1144,8 @@ void do_page_add_anon_rmap(struct page *page,
> >                * disabled.
> >                */
> >               if (compound)
> > -                     __inc_lruvec_page_state(page, NR_ANON_THPS);
> > +                     __mod_lruvec_page_state(page, NR_ANON_THPS,
> > +                                             HPAGE_PMD_NR);
> >               __mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
>
> What I mistakenly wrote about the previous patch applies to this and
> the following patches, though:
>
> /proc/vmstat currently prints number of anon, file and shmem THPs; you
> are changing it to print number of 4k pages in those THPs.
>
> That's an ABI change we cannot really do.

Agree. Sorry. I forgot to fix the /proc/vmstat. Thanks for your
reminder.


-- 
Yours,
Muchun
