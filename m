Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC72F53D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbhAMUHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbhAMUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:06:59 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C241C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:06:18 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hs11so2541953ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Atsr5jv8T9ZoJtbPK6SL546tOdJtaCS1oan7zJwQQ90=;
        b=oGlnGhdttfZH9cF4FbW4sCgfSGQ6U3mer6sHR5EOFTWOBqoeG6j+KtZq2twcU7HQ9J
         Nt1hwbL0wlFnzlGS0w028VPAJIMiUNwg+wEqndnRf+hnPIe9yvXiwV+wuTMSKENjUfh4
         MhknEf3Zwn49LELA6GqYdRZOKNdzfAvfjihOR9IUwvoIfyCABq0fSz3LvD/nvTz7LB42
         LpojBCPMJUBK9Cpl2HW4MYyAygvOdjb/FTq9NarqiB1GNz1kYUE0SZHFwduExzCZUmt/
         EJWa2bwDWYTWm4Lsf/nSXzs8l25MC4Dvet1uuwLH0ZGaqgNIJLXkrTuaucVVY4tUMwxD
         9jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Atsr5jv8T9ZoJtbPK6SL546tOdJtaCS1oan7zJwQQ90=;
        b=rBU6muUwbkC7ITheyLz2MpcQN2dQeqgbjK6GLMNhsvESLVceefOoVueyhPtR7DCSva
         BQ2WL8HwwSzIWkezJgV7gC5xhQWdvQMD/Dwuf/nVCBuA5Lg3aKF7xWtCc6c9zsK+ZjAE
         zmNrXwun2jr0XHuXPXk2Ev5u6NBP+WWc5xV5QqF/Wele7RE9DRTe/0QjbsfFwBvMBW1t
         fQlwKhpb+lFefo4Jqpxu4PU3xCfP8OKfl5bi+x36+oXzSPRxYfsYthZIKcI1b5glewRn
         KDpqh3A6MI+TYOydun8FlmvawZlXzS3vipQxMcqtWIilG/fsRVNTV2zH5OxYhsa+u0VX
         60wg==
X-Gm-Message-State: AOAM531/T8c8H9cjBIllnoBHu2uetNx4QTZVSV43B4CEjbjOVEglsI9n
        /rFCebL2RVQkKj3lnoCd5fSd9jVWloGCtMlxp1eeFA==
X-Google-Smtp-Source: ABdhPJzUDzmZWA4lqsW8yXocmHnZp0KlbLU4jdTw5S1s0d7cWUsk+k6/wu+RPxqCYR56z3F8bKI2HBHwXfb+qrUg82Y=
X-Received: by 2002:a17:907:1b27:: with SMTP id mp39mr2546538ejc.519.1610568377144;
 Wed, 13 Jan 2021 12:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-9-pasha.tatashin@soleen.com> <20201217205048.GL5487@ziepe.ca>
 <CA+CK2bA4F+SipkReJzFjCSC-8kZdK4yrwCQZM+TvCTrqV2CGHg@mail.gmail.com>
 <20201218141927.GM5487@ziepe.ca> <CA+CK2bDULopw649ndBybA-ST5EoRMHULwcfQcSQVKT9r8zAtwQ@mail.gmail.com>
 <20210113195528.GD4605@ziepe.ca>
In-Reply-To: <20210113195528.GD4605@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 13 Jan 2021 15:05:41 -0500
Message-ID: <CA+CK2bDDUMOeCH8rQBL7fBdHCAUZBOykyXNL2N=hmxq7xi0giQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] mm/gup: limit number of gup migration failures,
 honor failures
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Oh, that existing logic is wrong too :( Another bug.
> >
> > I do not think there is a bug.
> >
> > > You can't skip pages in the pages[] array under the assumption they
> > > are contiguous. ie the i+=step is wrong.
> >
> > If pages[i] is part of a compound page, the other parts of this page
> > must be sequential in this array for this compound page
>
> That is true only if the PMD points to the page. If the PTE points to
> a tail page then there is no requirement that other PTEs are
> contiguous with the compount page.
>
> At this point we have no idea if the GUP logic got this compound page
> as a head page in a PMD or as a tail page from a PTE, so we can't
> assume a contiguous run of addresses.

I see, I will fix this bug in an upstream as a separate patch in my
series, and keep the fix when my fixes are applied.

>
> Look at split_huge_pmd() - it doesn't break up the compound page it
> just converts the PMD to a PTE array and scatters the tail pages to
> the PTE.

Got it, unfortunately the fix will deoptimize the code by having to
check every page if it is part of a previous compound page or not.

>
> I understand Matt is pushing on this idea more by having compound
> pages in the page cache, but still mapping tail pages when required.
>
> > This is actually standard migration procedure, elsewhere in the kernel
> > we migrate pages in exactly the same fashion: isolate and later
> > migrate. The isolation works for LRU only pages.
>
> But do other places cause a userspace visible random failure when LRU
> isolation fails?

Makes sense, I will remove maximum retries for isolation, and retry
indefinitely, the same as it is done during memory hot-remove. So, we
will fail only when migration fails.

>
> I don't like it at all, what is the user supposed to do?
>
> Jason
