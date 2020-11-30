Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87A52C8FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbgK3VNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388399AbgK3VNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:13:34 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:13:18 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f24so20256701ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3KWtTbyu910cgBxnHje89Hi5Pdj67SfhYeBysSLt7k=;
        b=XKUoVsy05kCrVvddDePtP1hpa3frBZCDGjBpVl7lJPZTEaWp141MdeEkgWFXE2hMtZ
         Jg80YRM8bwYP283gjRBtADdNaKGlvkz/bJu5fQm/Ckd7P+G5/SbnNroKAddGj1XgbO3v
         PmRGS6aWjrAm44AlOHzhtyU+0r7PM3uciizC0Kq0ccOPUEqEqTFHvW/2BWQe/ceFeaS0
         IHC+QLIsEs+SbquUOpbBHRlotQCu62+8vY6/MwuByvi2FhnrITWx+tJftLqlJH7ZJmKH
         7Q8/QfqkKtI3fe5mJrlzsMGz2THKrM5iGkIAdTfeZ1ToA9oF4x+0TafKFFJ3JdZjCBq0
         E1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3KWtTbyu910cgBxnHje89Hi5Pdj67SfhYeBysSLt7k=;
        b=aXtrf13e+Tw7YGy0Iqs3kBIGgJ9lyQEWEPQsuJkq+bUydJ/66tP01q0Ldj9qhpIr8G
         DjY/p77R4n762iSjsuevW3jZnopPkgamxz06ibqIpIIfjjcfDp2HNgxra+igcp13KgiG
         4ELurj9OGwsXkx99j/a5XygH+9O2myLjY3NufsfinebqxH4b+W05er25+jzdOfhWeCTY
         0h7V8LaJers/6CSAwe6UeEVn2r/ZyXhudClHaoo7ffOmeUSQ7neSRRRdiT5WWC3fHmbc
         WB9Db4z3gmZ2GX7BKNnfpvbk8Tb8rOKkXOSrSJUFgMTdsZiR7ey9SGvTqySsPQfZClG3
         PFqQ==
X-Gm-Message-State: AOAM532TgC5aDXVLHUeZwMNHdIM+LYO/Q2QmgPBeo5C8l8QVdN2Vaz7y
        WCGv45RGVWtcixGfl1BmBR8LLUX8E3REH1yRDEJGKw==
X-Google-Smtp-Source: ABdhPJxPhOUEdXtkkQNUJiSzYLzLvwVafq/DEqFzMlodHcjTU8K1Kz2KqSKdPFiog2fz99yGTWDMpFJ1kGKHxWe+NY8=
X-Received: by 2002:a2e:b16a:: with SMTP id a10mr11561573ljm.446.1606770797208;
 Mon, 30 Nov 2020 13:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20201126005603.1293012-1-shakeelb@google.com> <20201130203425.GA1360286@carbon.DHCP.thefacebook.com>
 <CALvZod4qiFuiByjh0+fwRoVw_EYVzqADNsiThf42-zDiXyYvpg@mail.gmail.com> <20201130211050.GB1360286@carbon.DHCP.thefacebook.com>
In-Reply-To: <20201130211050.GB1360286@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 30 Nov 2020 13:13:06 -0800
Message-ID: <CALvZod6YVEcHRc7DHu5RrXSeSGW+Vqo_skSWmVsHNJHERQ-c6Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] memcg: add pagetable comsumption to memory.stat
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 1:10 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Nov 30, 2020 at 01:01:18PM -0800, Shakeel Butt wrote:
> > On Mon, Nov 30, 2020 at 12:34 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Wed, Nov 25, 2020 at 04:56:01PM -0800, Shakeel Butt wrote:
> > > > Many workloads consumes significant amount of memory in pagetables. This
> > > > patch series exposes the pagetable comsumption for each memory cgroup.
> > >
> > > Hi Shakeel!
> > >
> > > The code looks good to me. However I'm not sure I understand what's the
> > > use case for the new statistics? Can you, please, elaborate a bit more here?
> > >
> > > From a very first glance, the size of pagetables should be _roughly_ equal
> > > to the size_of(pte)/PAGE_SIZE*(size of a cgroup) and should not exceed 1%
> > > of the cgroup size. So for all but very large cgroups the value will be
> > > in the noise of per-cpu counters. Perhaps I'm missing some important cases?
> > >
> >
> > I think this is in general a good metric to have but one specific
> > use-case we have is the user space network driver which mmaps the
> > memory of the applications for zero copy data transfers. This driver
> > can consume a large amount of memory in page tables. So, this metric
> > becomes really useful here.
>
> Got it, thank you for the explanation!
> Would you mind to add this text to the cover letter as an example?

Sure.

>
> Acked-by: Roman Gushchin <guro@fb.com>
> for the series.

Thanks for the review.
