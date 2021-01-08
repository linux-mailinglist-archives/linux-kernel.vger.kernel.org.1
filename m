Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC6D2EEB64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbhAHCjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbhAHCjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:39:31 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735D0C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 18:38:51 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id r4so4889163pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 18:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zmgQQ/koFoyCFqZqHd/CEfBclNLFL5+ci7EJGrdRVA=;
        b=F8LuEnnlkXA62BJVlXrdGxp+p35rEVAysJ0KXywPGVixsnKoZorWYmTHSbzjyEX1cu
         6JReREQh9aZWC+YPkux2w9e2uZqA1Mi8djI2bKF2/6mZAxXMFQeJVW9Aw+tgo8BjFEPd
         aFksKmnjXlqAF0JkywhAJyuNgkQLXeFYSHIt9ngMAlugUyIcquP5wTTjGKZx7fmEZk5N
         YvBhdV8dEi/eR/cn+15+0raiD4KeFSKOenp75hpfLoMBtNwwXmsMBAP4Kg5CNQp7PHsK
         4GKNpv5yEZafGYiqyCRB7avkZ9mNmtff+ajJ6IN6/IPx0Ux6S3hqyRGieqqUNNyVVEm5
         AEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zmgQQ/koFoyCFqZqHd/CEfBclNLFL5+ci7EJGrdRVA=;
        b=FYnKkcQnmv7Yl+tVCxOhB+vfpnaVdGBFQgoC9vN9DTBJ7UrSwLM6nUzmFIRelEBmZW
         gxznvCp0L88qe9WkeLmEpQrp3GKKD3OC4RIc2eQ7//BnRcexT/e+63LJb4bb3JBBJy9/
         OCFLYkjbgKO0vdm8Z90u9UgF6kLKLlIiK9OSiVrXgX8V015ns7/EAwxR58eGwI1XP+IF
         RZf+oOMdpLobTPYAb8dglCSBr/l0B29IRlUOaZjdCNKaKCdnP799i4XaUnc+4Rcu5qhx
         xvWeXMLNW7LGzc4e9PxRvN9y1p921I8lFHfD14zA1nXb1K9oAEMpGHvEn0rIgLBSE7o4
         Wr7A==
X-Gm-Message-State: AOAM533oBtb7kLoT2dCI0kTJ1kJdH9reJG80NLf3saYLUONiLM0f/xww
        t66j78VlolkFK5G8gao8USkLzQWMUkBN8WmOGdBs2w==
X-Google-Smtp-Source: ABdhPJys/3J9TCNs5W2zE23cKCcRfCrUXDSYSMltBveYwqJe9Yzwi+mY1FkbaxCByDOgONhDCRFnZMzB1Ndm2rNdMbw=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr1414168pjt.147.1610073531034;
 Thu, 07 Jan 2021 18:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com> <20210106165632.GT13207@dhcp22.suse.cz>
 <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com>
 <20210107084146.GD13207@dhcp22.suse.cz> <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
 <20210107111827.GG13207@dhcp22.suse.cz> <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
 <20210107123854.GJ13207@dhcp22.suse.cz> <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
 <20210107141130.GL13207@dhcp22.suse.cz> <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
 <eccfda79-eeb6-7081-4902-1881f8910610@oracle.com>
In-Reply-To: <eccfda79-eeb6-7081-4902-1881f8910610@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 8 Jan 2021 10:38:12 +0800
Message-ID: <CAMZfGtXQSuHmkPSM_8NJKAKeJF9u_wNJTMPfPy7yUMvgZqc=HA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 9:08 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/7/21 7:11 AM, Muchun Song wrote:
> > On Thu, Jan 7, 2021 at 10:11 PM Michal Hocko <mhocko@suse.com> wrote:
> >>
> >> On Thu 07-01-21 20:59:33, Muchun Song wrote:
> >>> On Thu, Jan 7, 2021 at 8:38 PM Michal Hocko <mhocko@suse.com> wrote:
> >> [...]
> >>>> Right. Can we simply back off in the dissolving path when ref count is
> >>>> 0 && PageHuge() if list_empty(page->lru)? Is there any other scenario
> >>>> when the all above is true and the page is not being freed?
> >>>
> >>> The list_empty(&page->lru) may always return false.
> >>> The page before freeing is on the active list
> >>> (hstate->hugepage_activelist).Then it is on the free list
> >>> after freeing. So list_empty(&page->lru) is always false.
> >>
> >> The point I was trying to make is that the page has to be enqueued when
> >> it is dissolved and freed. If the page is not enqueued then something
> >> racing. But then I have realized that this is not a great check to
> >> detect the race because pages are going to be released to buddy
> >> allocator and that will reuse page->lru again. So scratch that and sorry
> >> for the detour.
> >>
> >> But that made me think some more and one way to reliably detect the race
> >> should be PageHuge() check in the freeing path. This is what dissolve
> >> path does already. PageHuge becomes false during update_and_free_page()
> >> while holding the hugetlb_lock. So can we use that?
> >
> > It may make the thing complex. Apart from freeing it to the
> > buddy allocator, free_huge_page also does something else for
> > us. If we detect the race in the freeing path, if it is not a HugeTLB
> > page, the freeing path just returns. We also should move those
> > things to the dissolve path. Right?
> >
> > But I find a tricky problem to solve. See free_huge_page().
> > If we are in non-task context, we should schedule a work
> > to free the page. We reuse the page->mapping. If the page
> > is already freed by the dissolve path. We should not touch
> > the page->mapping. So we need to check PageHuge().
> > The check and llist_add() should be protected by
> > hugetlb_lock. But we cannot do that. Right? If dissolve
> > happens after it is linked to the list. We also should
> > remove it from the list (hpage_freelist). It seems to make
> > the thing more complex.
>
> You are correct.  This is also an issue/potential problem with this
> race.  It seems that adding the state information might be the least
> complex way to address issue.

Yeah, I agree with you. Adding a state is a simple solution.


>
> --
> Mike Kravetz
