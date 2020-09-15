Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2081D26AB79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgIOSGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgIOSDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:03:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E74C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:03:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v196so2427015pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhPPje+UUTBY8kYUEvCGJHYilZbBe703Z6BQl0hi82o=;
        b=znz6kYk2M1HfniaapdTD5ndtoDBHFcJW8m8WFdFuJRD4CHnMx3DVnNgZbGlkGcfQyY
         /4/c6GGgxz1i1ALrxb0wjC/itd3L9/KDfk32rpsOmyXzHIf75v2j8TpIGouU0IfRo0A4
         hNrCHJ1HpCS84uJ8dU70fbB0EthZ+75cxB3hrWAgn2YAiDkXlwel6axWVgtX+SH0iVzV
         IiTWNsM7oRf3tuTa3LzvDQNw4zskrFBDebDPRIme32GBauJ3YzgwqMTKmEAngzw6nxtU
         plv5nAAPRqeytkF/yTH5+YyooJJ2tzFWevNGTmDPPZq/scJ0B7wyCnHC+ZI+OUqMHVp9
         olBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhPPje+UUTBY8kYUEvCGJHYilZbBe703Z6BQl0hi82o=;
        b=lsfsrUaDq7R/v+J1l5VshcXHgY81zZphLmPZy4B21awuKg8zOzgA25rEA0aD8ySTc8
         mpu16JVx0Q8oce7hEyZJdVkWs81EE5N6XgKb+5wv6mThHXJuSAfPPvOIK1yJ0nN82J/M
         lOOi/fQsKDuA8Q2sjRl3wKIQUasdSOXip+Z7OzougFrEZr6UrQqxB1V9Vt6iIGrE1Zbv
         is6BhE/U65k6okwLn1o4kTUELNm0Yi2Z6zwDYHIeDBnVimfojOSOq73/bRNrNrenHnS0
         k4oDQSyplF8FdRDCEFGoZAuZMLk8dAAnGYNtxhqvr7PZDZMADFH8TimxWWPRAAT2rTCH
         3N1A==
X-Gm-Message-State: AOAM531J2kkKQ11dKesQXEAdQr+MgSFn6X4J6JheFYjHKRy0hAjvJQaz
        fhTL6EBS1NsuncuoFJZHaH1uYpJEixyiO+bERcggMQ==
X-Google-Smtp-Source: ABdhPJxm8mfbd1RkNg+nNZEp7K1x8W811B13DkAefYfGlQ8VvBcsuWI2MpSoCr5ODfRzGBd9GbAXzfHNNbAMFtRvCl4=
X-Received: by 2002:a62:e40c:0:b029:13f:d777:f70e with SMTP id
 r12-20020a62e40c0000b029013fd777f70emr12683616pfh.2.1600193031738; Tue, 15
 Sep 2020 11:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915143241.GH5449@casper.infradead.org> <CAMZfGtW0PqU6SLihLABA8rU+FuBqm8NksDW=EkLXy1RZfYeDGA@mail.gmail.com>
 <20200915154213.GI5449@casper.infradead.org> <CAMZfGtVTjopGgFv4xCDcF1+iGeRva_ypH4EQWcDUFBdsfqhQbA@mail.gmail.com>
 <20200915173948.GK5449@casper.infradead.org>
In-Reply-To: <20200915173948.GK5449@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Sep 2020 02:03:15 +0800
Message-ID: <CAMZfGtW3S8kGJwff6oH14QWPXKTuQEAGdYwcLRUZxuJ7q8s7sA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 00/24] mm/hugetlb: Free some vmemmap
 pages of hugetlb page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de, almasrymina@google.com,
        David Rientjes <rientjes@google.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 1:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Sep 16, 2020 at 01:32:46AM +0800, Muchun Song wrote:
> > On Tue, Sep 15, 2020 at 11:42 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Sep 15, 2020 at 11:28:01PM +0800, Muchun Song wrote:
> > > > On Tue, Sep 15, 2020 at 10:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Tue, Sep 15, 2020 at 08:59:23PM +0800, Muchun Song wrote:
> > > > > > This patch series will free some vmemmap pages(struct page structures)
> > > > > > associated with each hugetlbpage when preallocated to save memory.
> > > > >
> > > > > It would be lovely to be able to do this.  Unfortunately, it's completely
> > > > > impossible right now.  Consider, for example, get_user_pages() called
> > > > > on the fifth page of a hugetlb page.
> > > >
> > > > Can you elaborate on the problem? Thanks so much.
> > >
> > > OK, let's say you want to do a 2kB I/O to offset 0x5000 of a 2MB page
> > > on a 4kB base page system.  Today, that results in a bio_vec containing
> > > {head+5, 0, 0x800}.  Then we call page_to_phys() on that (head+5) struct
> > > page to get the physical address of the I/O, and we turn it into a struct
> > > scatterlist, which similarly has a reference to the page (head+5).
> >
> > As I know, in this case, the get_user_pages() will get a reference
> > to the head page (head+0) before returning such that the hugetlb
> > page can not be freed. Although get_user_pages() returns the
> > page (head+5) and the scatterlist has a reference to the page
> > (head+5), this patch series can handle this situation. I can not
> > figure out where the problem is. What I missed? Thanks.
>
> You freed pages 4-511 from the vmemmap so they could be used for
> something else.  Page 5 isn't there any more.  So if you return head+5,
> then when we complete the I/O, we'll look for the compound_head() of
> head+5 and we won't find head.
>

We do not free pages 4-511 from the vmemmap. Actually, we only
free pages 128-511 from the vmemmap.

The 512 struct pages occupy 8 pages of physical memory. We only
free 6 physical page frames to the buddy. But we will create a new
mapping just like below. The virtual address of the freed pages will
remap to the second page frame. So the second page frame is
reused.

When a hugetlbpage is preallocated, we can change the mapping to
bellow.

   hugetlbpage                   struct page(8 pages)          page
frame(8 pages)
  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  |           |                     |     0     | -------------> |     0     |
  |           |                     |     1     | -------------> |     1     |
  |           |                     |     2     | -------------> +-----------+
  |           |                     |     3     | -----------------^ ^ ^ ^ ^
  |           |                     |     4     | -------------------+ | | |
  |     2M    |                     |     5     | ---------------------+ | |
  |           |                     |     6     | -----------------------+ |
  |           |                     |     7     | -------------------------+
  |           |                     +-----------+
  |           |
  |           |
  +-----------+

As you can see, we reuse the first tail page.

-- 
Yours,
Muchun
