Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336632D8021
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403778AbgLKUnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389233AbgLKUmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:42:15 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C3CC061793
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:41:35 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id g20so14169578ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6ZVINXPsdzUvTi8y4F5dCQAcZ1z+AuX7onsYghdXXU=;
        b=QWWiLxi3n5qfdFyONIr2q2ssLsNW2+Y/Fm1gJOa6KJ7O8TwqDxIC5alcqwk19dNRU1
         PR3OJwLyy5Jl5QhBlZHCjStP2IOafpHAz3NLC8JC9kPe7FpNLPfNUCDlYPIiXTISHk/6
         RVXF0IoaSYhxySEwGA8a9hR7gkHaIBXb5cajEi8huBPeKDeLIjiPB/lPsn4vYoO8833X
         2fTjd4tRTNVBdPAItaDY7n8FmYGNK1mCyevS45WNvav8qR0fI5a8Hirkg3gHPlFy6puK
         X3++oIucgL1it8TgHK8uRisl6iSIAIBh+gx/ewyDkrAbZwOt91TUqQd+wmIvPOxitsXT
         FX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6ZVINXPsdzUvTi8y4F5dCQAcZ1z+AuX7onsYghdXXU=;
        b=qSLwvtkj2KPMsBfc3Q/QXjwj2Uqw+q+xFc5Zi9z6pvHuhBQUNR7CfqhUMNUp6ytEEV
         jp/k0S9kp4YznAT4636wIpY6+IkQ/AZ0Quo7YMlqHYBboUFmUjXuT4Y1pGnSovHfLxjP
         W+3EXyYvViZpIlgl4DVk7BrsWn7wuKpDQ+ytha77hYQ9JOM8ERt26DR8FY51TfJMvoSZ
         waTZ2lHCc4pbOJDbVzOrVDRgaSSq70+P/IqRDOeogN5gq05OsC2qC9YFvYe1dBEkEddN
         KUhpkTHV/McKTbcJpbJR/ECdmiUm53UQhodLjY+PH9Is5hikUg7jCZU5L2lNoChxqYoF
         V3YA==
X-Gm-Message-State: AOAM532nF1kTBvDjS0b6fWu5gZ2HgieXzqnK/8WWc1AYM1f8kvGhTr57
        tUVVLrCLYJ7PgGzBdS5wmsWKRQvAOHOiboYVEEji3Q==
X-Google-Smtp-Source: ABdhPJwhZ3hcnDKpQaKtFRHwNLn5KQ58koBxmqgOXsc76EHMbiiKHOf39MDRAkuqekpT9xaF9RD78X1VcWZej0Q1Mww=
X-Received: by 2002:a17:906:5213:: with SMTP id g19mr8813843ejm.383.1607719293747;
 Fri, 11 Dec 2020 12:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-6-pasha.tatashin@soleen.com> <20201211202354.GA2225686@ziepe.ca>
In-Reply-To: <20201211202354.GA2225686@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 11 Dec 2020 15:40:57 -0500
Message-ID: <CA+CK2bDPR8vH+H6cqBn=RTXRCp5kv3ExNPD8DHB09vVWLc3YmA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
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
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 3:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Dec 11, 2020 at 03:21:39PM -0500, Pavel Tatashin wrote:
> > @@ -1593,7 +1592,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
> >                               }
> >
> >                               if (!isolate_lru_page(head)) {
> > -                                     list_add_tail(&head->lru, &cma_page_list);
> > +                                     list_add_tail(&head->lru, &movable_page_list);
> >                                       mod_node_page_state(page_pgdat(head),
> >                                                           NR_ISOLATED_ANON +
> >                                                           page_is_file_lru(head),
> > @@ -1605,7 +1604,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
> >               i += step;
> >       }
> >
> > -     if (!list_empty(&cma_page_list)) {
> > +     if (!list_empty(&movable_page_list)) {
>
> You didn't answer my earlier question, is it OK that ZONE_MOVABLE
> pages leak out here if ioslate_lru_page() fails but the
> moval_page_list is empty?
>
> I think the answer is no, right?
In my opinion it is OK. We are doing our best to not pin movable
pages, but if isolate_lru_page() fails because pages are currently
locked by someone else, we will end up long-term pinning them.
See comment in this patch:
+        * 1. Pinned pages: (long-term) pinning of movable pages is avoided
+        *    when pages are pinned and faulted, but it is still possible that
+        *    address space already has pages in ZONE_MOVABLE at the time when
+        *    pages are pinned (i.e. user has touches that memory before
+        *    pinning). In such case we try to migrate them to a different zone,
+        *    but if migration fails the pages can still end-up pinned in
+        *    ZONE_MOVABLE. In such case, memory offlining might retry a long
+        *    time and will only succeed once user application unpins pages.


>
> Jason
