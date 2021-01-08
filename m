Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A82EF1AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbhAHLyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbhAHLyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:54:15 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D5C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:53:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v1so3518321pjr.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GW5q2722koIbZXnDnSvwWdTVIWeItYho+2jBeLd21CQ=;
        b=H2kYfvBdyX/hs0s4f/V4SVCbXiBDZvNV7nHlCFFj9Hivaz3hVXYb6c8D9A7NkS4+a+
         GVrJmBTOwgLbI1Dyd1b+ixHcAiZoJbl8/4V/Y+WQ47gAK7ji8aAReFpnMhKOa2bbZ8z5
         M4V5a1k0MGdrkeRXhOrauoTX82PlcHg0kQ3hxOIr0gjvakcNfBcfOcC3fO9TKGxyGn7r
         yrPasq5bmubbz5KbAWqFIO/6SdGbEajkp4+MCkaTxs6Cu7rKj3BA/bhTz++qqtLkrixF
         8oWV72jWjyE3dPvd+Pw/hCd2sXD3mJGm4QkSE4M38cqIkLPnEpQZgmFSfAVd3dVfA2Eg
         i2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GW5q2722koIbZXnDnSvwWdTVIWeItYho+2jBeLd21CQ=;
        b=nPVs9v2SJQTsZldHglCjnMAJZ3gJGJBiRWojTEzDftu4H32JZ+EcnQOUjOUu4DHAaQ
         nCCnaVYTdUlzGPqwdGeWl9fXad39YcWGfw4WRJJc/oOissxENxo13mtnlnh4v6IZrReP
         J4l6fTP79OqTcR2ssfju654eJXwcW7LbA3bFDMO/AUp/RcLsChuZMJcTNwPrk5xEHeRC
         CscknnYrEWsR/VQSc0twLqlZS1u6wyNKYrFdgS0ln5xxg/4Sxya4aXm8/oODL3ImrP59
         DW+JmRftOFoewvqiEeKmlfhSTHhEqPWP83825dTVPChtKcmktncWyWZoalfsqYlt8jK4
         fMjA==
X-Gm-Message-State: AOAM533Y69OJmr0rMrv/8c+toP8JlcSv7gSg5KABpUl9PnCVpNovdPil
        uaRJlr+lOno4tDgA7kTkN8LyQrkMdfLt0xvQ+EuEzaeTRV5LDGuzfC0=
X-Google-Smtp-Source: ABdhPJyYEuk6apHjhRQbzXazmjDwQQiU+D+mGB6hMBDpiuuuIqjPZIey46A90m26h64vrzoVndUSWOOV0CgSG4xhypI=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr3456077pjh.13.1610106814984;
 Fri, 08 Jan 2021 03:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20210107111827.GG13207@dhcp22.suse.cz> <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
 <20210107123854.GJ13207@dhcp22.suse.cz> <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
 <20210107141130.GL13207@dhcp22.suse.cz> <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
 <20210108084330.GW13207@dhcp22.suse.cz> <CAMZfGtUy740SbsCW_h1NaP5O=ahSZniezkC+62pxZ5bW+vZpBg@mail.gmail.com>
 <20210108093136.GY13207@dhcp22.suse.cz> <CAMZfGtXhMDjw=C8XBUwsQLD7ZLv5osoLWy+RJzqY11WFm07GwQ@mail.gmail.com>
 <20210108114411.GZ13207@dhcp22.suse.cz>
In-Reply-To: <20210108114411.GZ13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 8 Jan 2021 19:52:54 +0800
Message-ID: <CAMZfGtVc5dAYY_sPywi=BzfA92erqNn6O0X=0_k7sX2Xh1NC=w@mail.gmail.com>
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

On Fri, Jan 8, 2021 at 7:44 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 08-01-21 18:08:57, Muchun Song wrote:
> > On Fri, Jan 8, 2021 at 5:31 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 08-01-21 17:01:03, Muchun Song wrote:
> > > > On Fri, Jan 8, 2021 at 4:43 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 07-01-21 23:11:22, Muchun Song wrote:
> > > [..]
> > > > > > But I find a tricky problem to solve. See free_huge_page().
> > > > > > If we are in non-task context, we should schedule a work
> > > > > > to free the page. We reuse the page->mapping. If the page
> > > > > > is already freed by the dissolve path. We should not touch
> > > > > > the page->mapping. So we need to check PageHuge().
> > > > > > The check and llist_add() should be protected by
> > > > > > hugetlb_lock. But we cannot do that. Right? If dissolve
> > > > > > happens after it is linked to the list. We also should
> > > > > > remove it from the list (hpage_freelist). It seems to make
> > > > > > the thing more complex.
> > > > >
> > > > > I am not sure I follow you here but yes PageHuge under hugetlb_lock
> > > > > should be the reliable way to check for the race. I am not sure why we
> > > > > really need to care about mapping or other state.
> > > >
> > > > CPU0:                               CPU1:
> > > > free_huge_page(page)
> > > >   if (PageHuge(page))
> > > >                                     dissolve_free_huge_page(page)
> > > >                                       spin_lock(&hugetlb_lock)
> > > >                                       update_and_free_page(page)
> > > >                                       spin_unlock(&hugetlb_lock)
> > > >     llist_add(page->mapping)
> > > >     // the mapping is corrupted
> > > >
> > > > The PageHuge(page) and llist_add() should be protected by
> > > > hugetlb_lock. Right? If so, we cannot hold hugetlb_lock
> > > > in free_huge_page() path.
> > >
> > > OK, I see. I completely forgot about this snowflake. I thought that
> > > free_huge_page was a typo missing initial __. Anyway you are right that
> > > this path needs a check as well. But I don't see why we couldn't use the
> > > lock here. The lock can be held only inside the !in_task branch.
> >
> > Because we hold the hugetlb_lock without disable irq. So if an interrupt
> > occurs after we hold the lock. And we also free a HugeTLB page. Then
> > it leads to deadlock.
>
> There is nothing really to prevent making hugetlb_lock irq safe, isn't
> it?

Yeah. We can make the hugetlb_lock irq safe. But why have we not
done this? Maybe the commit changelog can provide more information.

See https://github.com/torvalds/linux/commit/c77c0a8ac4c522638a8242fcb9de9496e3cdbb2d

> --
> Michal Hocko
> SUSE Labs
