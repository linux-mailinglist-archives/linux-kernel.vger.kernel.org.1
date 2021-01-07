Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DFD2ED052
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbhAGNA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbhAGNAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:00:55 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C988C0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 05:00:15 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id c22so4744050pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 05:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biffWNQNFNPnAS5OxXR8C0hU95gWZz4zkiv6kH4IfyQ=;
        b=uW+09LknRIdDJjyGSlFutTR0R9O4IAwK5KjLGsgUX8fUoQJL859v8FhYDo+zjPV0IK
         Xil6LouHgN74ca7YygLa5VIKQRV1qt4O+PDfCJryKOaIR7yy2LfMRjetcro1reZlIAQI
         GxnaWMug/kpXyB8pyatoBNZzNVo1MNdiUwtdO+P2ty/nCNLRZNMxXlT3WF5rQlB6RqYw
         TVKc5IFdb8A5gW3GJiq2RCPQmj03eATzDqBuaOj5RDQOAIscLNn1XsziSI2w5/qbAIrh
         NnXCVPH+Gfv3fuHCU99+/ewKBj9O/obtAj9NxjZ8pW5UF8Xx/ZFDliYwqvrSbq+3yfj5
         7JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biffWNQNFNPnAS5OxXR8C0hU95gWZz4zkiv6kH4IfyQ=;
        b=J+2VEOY2FqUFCZAMebsS1CWRybaiFQGb9ZrLzmzwOJWSC0agbd4lR+rWrDnqvn85T+
         un+Ue4q1nLPZpd7roMfIQNA91uyvD/KxKYFh02Ou2sRyEuEXMsA17ZO5CNNTBg2zbrMI
         vHy+LSv6mAk3VsXDQMRuOl4ScvOjUGc0c/iuOPYsC8/Rc2dQ+bR1D9gKc25AtQqBGKVS
         1qhtg7GsH90m1pbcR1hTxecexZ5OG32mZY2IonHoUjv+MEaP5a21hMsrQJfbsuKeM+aJ
         zpGAZUL3Pg7IX/G5t2bXTwpjvY2yXPiRieAjE2inO70/YSr8OLoTvNWPndvonCeRVrrb
         P8lw==
X-Gm-Message-State: AOAM531NztGQ+SefRrInu8KhU4TDusKyv9RscXcqtrZ++HnYE/nraNhE
        krP71EdUD2lw20qx1MkYeGixYWWqB7c7TPCaPOC6fCUjxUhckVYnGT4=
X-Google-Smtp-Source: ABdhPJyNGK0J3U+p1T20Uw5syrzrHoJSEk1Qvpuz9DO5hxpZYN98Loq7WdSf63/hBT+jougnLzTt6qXg8LGzcHW/508=
X-Received: by 2002:a62:4e4e:0:b029:19e:aaab:8be with SMTP id
 c75-20020a624e4e0000b029019eaaab08bemr8762101pfb.59.1610024415015; Thu, 07
 Jan 2021 05:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com> <20210106165632.GT13207@dhcp22.suse.cz>
 <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com>
 <20210107084146.GD13207@dhcp22.suse.cz> <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
 <20210107111827.GG13207@dhcp22.suse.cz> <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
 <20210107123854.GJ13207@dhcp22.suse.cz>
In-Reply-To: <20210107123854.GJ13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 20:59:33 +0800
Message-ID: <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
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

On Thu, Jan 7, 2021 at 8:38 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 07-01-21 19:38:00, Muchun Song wrote:
> > On Thu, Jan 7, 2021 at 7:18 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 07-01-21 16:53:13, Muchun Song wrote:
> > > > On Thu, Jan 7, 2021 at 4:41 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 07-01-21 13:39:38, Muchun Song wrote:
> > > > > > On Thu, Jan 7, 2021 at 12:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Wed 06-01-21 16:47:36, Muchun Song wrote:
> > > > > > > > There is a race condition between __free_huge_page()
> > > > > > > > and dissolve_free_huge_page().
> > > > > > > >
> > > > > > > > CPU0:                         CPU1:
> > > > > > > >
> > > > > > > > // page_count(page) == 1
> > > > > > > > put_page(page)
> > > > > > > >   __free_huge_page(page)
> > > > > > > >                               dissolve_free_huge_page(page)
> > > > > > > >                                 spin_lock(&hugetlb_lock)
> > > > > > > >                                 // PageHuge(page) && !page_count(page)
> > > > > > > >                                 update_and_free_page(page)
> > > > > > > >                                 // page is freed to the buddy
> > > > > > > >                                 spin_unlock(&hugetlb_lock)
> > > > > > > >     spin_lock(&hugetlb_lock)
> > > > > > > >     clear_page_huge_active(page)
> > > > > > > >     enqueue_huge_page(page)
> > > > > > > >     // It is wrong, the page is already freed
> > > > > > > >     spin_unlock(&hugetlb_lock)
> > > > > > > >
> > > > > > > > The race windows is between put_page() and spin_lock() which
> > > > > > > > is in the __free_huge_page().
> > > > > > >
> > > > > > > The race window reall is between put_page and dissolve_free_huge_page.
> > > > > > > And the result is that the put_page path would clobber an unrelated page
> > > > > > > (either free or already reused page) which is quite serious.
> > > > > > > Fortunatelly pages are dissolved very rarely. I believe that user would
> > > > > > > require to be privileged to hit this by intention.
> > > > > > >
> > > > > > > > We should make sure that the page is already on the free list
> > > > > > > > when it is dissolved.
> > > > > > >
> > > > > > > Another option would be to check for PageHuge in __free_huge_page. Have
> > > > > > > you considered that rather than add yet another state? The scope of the
> > > > > > > spinlock would have to be extended. If that sounds more tricky then can
> > > > > > > we check the page->lru in the dissolve path? If the page is still
> > > > > > > PageHuge and reference count 0 then there shouldn't be many options
> > > > > > > where it can be queued, right?
> > > > > >
> > > > > > Did you mean that we iterate over the free list to check whether
> > > > > > the page is on the free list?
> > > > >
> > > > > No I meant to check that the page is enqueued which along with ref count
> > > > > = 0 should mean it has been released to the pool unless I am missing
> > > > > something.
> > > >
> > > > The page can be on the free list or active list or empty when it
> > > > is freed to the pool. How to check whether it is on the free list?
> > >
> > > As I've said, I might be missing something here. But if the page is
> > > freed why does it matter whether it is on a active list or free list
> > > from the dissolve operation POV?
> >
> > As you said "check the page->lru". I have a question.
> > How to check the page->lru in the dissolve path?
>
> list_empty?

No.

>
> > BTW, dissolve_free_huge_page aims to free the page
> > to buddy allocator. put_page (for HugeTLB page) aims
> > to free the page to the hugepage pool.
>
> Right. Can we simply back off in the dissolving path when ref count is
> 0 && PageHuge() if list_empty(page->lru)? Is there any other scenario
> when the all above is true and the page is not being freed?

The list_empty(&page->lru) may always return false.
The page before freeing is on the active list
(hstate->hugepage_activelist).Then it is on the free list
after freeing. So list_empty(&page->lru) is always false.

> --
> Michal Hocko
> SUSE Labs
