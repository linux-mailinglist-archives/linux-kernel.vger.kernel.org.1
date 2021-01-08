Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E43D2EF074
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbhAHKKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbhAHKKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:10:16 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2437FC0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 02:09:36 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n10so7348139pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 02:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxBxmBs8fMYMIca2A29vy77BSWo76sDthhhEV0f2l40=;
        b=U7xIOEzOJHEbpaStAALRTWL/4LQl3vVyN295Pv9lgnMKByxJgJ3e0l1HA1xRKDZxJo
         zEgxZ5Dxra2np48BibHXkl1OoePEeJWFDe3t4xYtztx5AEpzgdyHirrizSQWRaImlYYw
         8r9X2/exvcylj2szVQWKxrnBPaTCScdQy2nx/8vSAX62q5U5iybw+mb34M/yMvbESFD5
         i87v1xCkNcT/vRBqyXwpl5+w4srPdufRjiVtLuuPgiejuHaSfVPBnhSThDUpLJLqnDs5
         lMyV3o0Qz4u6wUnPgu3o/kWIlIdPfjcvAEDcLopakBNTKN3hZfgoR71oPKZ7XYn21C3N
         TAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxBxmBs8fMYMIca2A29vy77BSWo76sDthhhEV0f2l40=;
        b=Qwq0m7S25y7npRqxRLLJMZpFrXbTXBDZH+MfV4uTTkKXvqIuFStAvxJOD6e7izFpWe
         1eljHPyZOD0JpFpnx/6ZiD4q/qIAa7Ed0jx+X20sF9lRf+IA/3aoVd2W4SrysqSwaZgH
         SroBafWO7pXvy8ahUL77O4B2Q0vFtDq3sNCf9M1Y6HX27ATpljjDuFr4QDHpV4Dv6pzd
         1LW0RDmpcrv6VXwDS4mFQVAb9NS29yvf6lPNSjbU99WYTXrXhCU/E4RVW48Nuj/KdW+I
         ehZHKu3pmoUkVYz9hDd0fagZWCrlia7RHTvnTDlobAa6elO4fPXxk/ZA4ezbKT0L+cj3
         DwEw==
X-Gm-Message-State: AOAM5335TnZjK9Apva3aP4aJ0bac2GxMaPJoZ8UKM32IKZ1kp6/xNObw
        Ml7Xp3soB6eMYJoR3IpDtvyqkz0jv67DmsNojWSzsDc2b2qcWjwC/Fs=
X-Google-Smtp-Source: ABdhPJzINUIAUuzfr9rwth5LMHR0iF7mo8xQp9/UO7OVzEZTtkHOV8K4XtkpNLfPF/XkJsTxJ1qbOpZncY0yIxH4U+M=
X-Received: by 2002:a63:480f:: with SMTP id v15mr6252552pga.341.1610100575749;
 Fri, 08 Jan 2021 02:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20210107084146.GD13207@dhcp22.suse.cz> <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
 <20210107111827.GG13207@dhcp22.suse.cz> <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
 <20210107123854.GJ13207@dhcp22.suse.cz> <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
 <20210107141130.GL13207@dhcp22.suse.cz> <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
 <20210108084330.GW13207@dhcp22.suse.cz> <CAMZfGtUy740SbsCW_h1NaP5O=ahSZniezkC+62pxZ5bW+vZpBg@mail.gmail.com>
 <20210108093136.GY13207@dhcp22.suse.cz>
In-Reply-To: <20210108093136.GY13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 8 Jan 2021 18:08:57 +0800
Message-ID: <CAMZfGtXhMDjw=C8XBUwsQLD7ZLv5osoLWy+RJzqY11WFm07GwQ@mail.gmail.com>
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

On Fri, Jan 8, 2021 at 5:31 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 08-01-21 17:01:03, Muchun Song wrote:
> > On Fri, Jan 8, 2021 at 4:43 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 07-01-21 23:11:22, Muchun Song wrote:
> [..]
> > > > But I find a tricky problem to solve. See free_huge_page().
> > > > If we are in non-task context, we should schedule a work
> > > > to free the page. We reuse the page->mapping. If the page
> > > > is already freed by the dissolve path. We should not touch
> > > > the page->mapping. So we need to check PageHuge().
> > > > The check and llist_add() should be protected by
> > > > hugetlb_lock. But we cannot do that. Right? If dissolve
> > > > happens after it is linked to the list. We also should
> > > > remove it from the list (hpage_freelist). It seems to make
> > > > the thing more complex.
> > >
> > > I am not sure I follow you here but yes PageHuge under hugetlb_lock
> > > should be the reliable way to check for the race. I am not sure why we
> > > really need to care about mapping or other state.
> >
> > CPU0:                               CPU1:
> > free_huge_page(page)
> >   if (PageHuge(page))
> >                                     dissolve_free_huge_page(page)
> >                                       spin_lock(&hugetlb_lock)
> >                                       update_and_free_page(page)
> >                                       spin_unlock(&hugetlb_lock)
> >     llist_add(page->mapping)
> >     // the mapping is corrupted
> >
> > The PageHuge(page) and llist_add() should be protected by
> > hugetlb_lock. Right? If so, we cannot hold hugetlb_lock
> > in free_huge_page() path.
>
> OK, I see. I completely forgot about this snowflake. I thought that
> free_huge_page was a typo missing initial __. Anyway you are right that
> this path needs a check as well. But I don't see why we couldn't use the
> lock here. The lock can be held only inside the !in_task branch.

Because we hold the hugetlb_lock without disable irq. So if an interrupt
occurs after we hold the lock. And we also free a HugeTLB page. Then
it leads to deadlock.

task context:                             interrupt context:

put_page(page)
  spin_lock(&hugetlb_lock)

                                                put_page(page)
                                                  spin_lock(&hugetlb_lock)
                                                  // deadlock

  spin_unlock(&hugetlb_lock)

> Although it would be much more nicer if the lock was held at this layer
> rather than both free_huge_page and __free_huge_page. But that clean up
> can be done on top.
>
> --
> Michal Hocko
> SUSE Labs
