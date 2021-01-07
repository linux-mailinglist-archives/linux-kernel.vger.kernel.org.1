Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABC2ED34D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbhAGPMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbhAGPMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:12:44 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02595C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 07:12:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id iq13so1636892pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 07:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVVuKMwBLp35Zjoy/hDGPZMYyWkdzkzM51SZ3v96jnw=;
        b=ILsldbIqwlllQ4VkIHLULTm8hQ0INhmQtedDAea27Pa2QePxMuTtU4ORuU/U7NJfk0
         XyBn72kFbN9CUC7ew9smMNRy7KEVBdd9l4djrr/6+RTGdyNoU6vLvRK+gyKsSCFC6kbI
         lFjzyHbPx6RyIWzjYUjwze0u/4oSexBsDAPvIBprjOBtgm5njXnFfmqbEcdDITqmEx/x
         3y0Uq8oH56XfyGooCWDKdK6FEzdZn8TZa9BmTHJNWz5mGicEBfKTvUNkAknk2Db1ntNz
         O9tDqZkz+T2QXaCGU59eGRyRAuNOHP5BgAqbnvtmhDkqLpFWBbWlmByM39RPuB/SeHWh
         Op7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVVuKMwBLp35Zjoy/hDGPZMYyWkdzkzM51SZ3v96jnw=;
        b=tFtXGI6GmGApzBVofVwZUj77bblXC/iu1ve3tUZvpH9YyYwDLrqxn5FkmZVGNY1I5l
         qWCT5GezYAR3HI8WBppKMku81eRghWp4wMewf4g887M4M5ibpTJaIO19LsbPgFEr5BZQ
         1kNzjuri23IkOKD6AaruwuLOlYUB3iBxverbAIUgb6TVhHLZSIAKzw2YkZQoQvoAou39
         o0KaeLDZNo2SoEkiAU8uyrO0kUdO2MBu0GJA8wrNwUiMrBN5gMKHv30Nl12vJWvoZDfx
         O2uxHbIwYiPq2W0uvljmzStdp7CME0mvQqQ0PL6e3b+19ZUO2Wosgc8xITSkHba7ok78
         WK9w==
X-Gm-Message-State: AOAM5309ds4QQRVVeHF2o26UEYKroHhtG7p/4I7Q+bqo0Y1+HJI4AFKR
        X6g7Wz+Y4qjLOOl+jYhlSym0iVPsXM1WPp9/IqrY+Q==
X-Google-Smtp-Source: ABdhPJwdyc4MrmWg0vRU59Ioo7HG8Y4csrZ3c+BQ65igdHWwIQIa6L3GYWXIbrimUR9koCuXBhRildaDHHwEZM74C3g=
X-Received: by 2002:a17:902:8503:b029:dc:44f:62d8 with SMTP id
 bj3-20020a1709028503b02900dc044f62d8mr9677281plb.34.1610032323382; Thu, 07
 Jan 2021 07:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com> <20210106165632.GT13207@dhcp22.suse.cz>
 <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com>
 <20210107084146.GD13207@dhcp22.suse.cz> <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
 <20210107111827.GG13207@dhcp22.suse.cz> <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
 <20210107123854.GJ13207@dhcp22.suse.cz> <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
 <20210107141130.GL13207@dhcp22.suse.cz>
In-Reply-To: <20210107141130.GL13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 23:11:22 +0800
Message-ID: <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
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

On Thu, Jan 7, 2021 at 10:11 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 07-01-21 20:59:33, Muchun Song wrote:
> > On Thu, Jan 7, 2021 at 8:38 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > Right. Can we simply back off in the dissolving path when ref count is
> > > 0 && PageHuge() if list_empty(page->lru)? Is there any other scenario
> > > when the all above is true and the page is not being freed?
> >
> > The list_empty(&page->lru) may always return false.
> > The page before freeing is on the active list
> > (hstate->hugepage_activelist).Then it is on the free list
> > after freeing. So list_empty(&page->lru) is always false.
>
> The point I was trying to make is that the page has to be enqueued when
> it is dissolved and freed. If the page is not enqueued then something
> racing. But then I have realized that this is not a great check to
> detect the race because pages are going to be released to buddy
> allocator and that will reuse page->lru again. So scratch that and sorry
> for the detour.
>
> But that made me think some more and one way to reliably detect the race
> should be PageHuge() check in the freeing path. This is what dissolve
> path does already. PageHuge becomes false during update_and_free_page()
> while holding the hugetlb_lock. So can we use that?

It may make the thing complex. Apart from freeing it to the
buddy allocator, free_huge_page also does something else for
us. If we detect the race in the freeing path, if it is not a HugeTLB
page, the freeing path just returns. We also should move those
things to the dissolve path. Right?

But I find a tricky problem to solve. See free_huge_page().
If we are in non-task context, we should schedule a work
to free the page. We reuse the page->mapping. If the page
is already freed by the dissolve path. We should not touch
the page->mapping. So we need to check PageHuge().
The check and llist_add() should be protected by
hugetlb_lock. But we cannot do that. Right? If dissolve
happens after it is linked to the list. We also should
remove it from the list (hpage_freelist). It seems to make
the thing more complex.

> --
> Michal Hocko
> SUSE Labs
