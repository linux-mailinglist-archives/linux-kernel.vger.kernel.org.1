Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F49A2D48BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbgLISQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732900AbgLISQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:16:18 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45493C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:15:38 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y22so3488938ljn.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KluCAXOoeTByOW4lbF1nsTzKouIPlFqCCzlWQb43QOg=;
        b=G1DWLyDpSMpgCLWxke7kh+OuNepikj8P4XS/mbzBAYlG01dvOyMfqZPnbeX75tqdPS
         rA7X9Q7otSrrcbsP4jK3fBD2ZFjV6oEzUjHS8u6ebS2/aJBNVPGkIoA9myOR9SxGflxD
         gsSjbHG8/8IjiKaKQ4Opa0NNUtJanvAX6pObWjcnFsH8uxumt8qOhtMTu7BFi81O2FOB
         174ye8QXtiFhF7PIcxA4KC1X4D/7CR9JCKDwHuqXxOJ1vJmktzhHxyX79uVABxGrdCDc
         3DAVdRUxxz8IG2MwQqGDf+aIa5BnVgBRtrWAyZ6JC6JHIubX33hxb0cx/mz6NRHmutEN
         IWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KluCAXOoeTByOW4lbF1nsTzKouIPlFqCCzlWQb43QOg=;
        b=dx35okqQGS6wEz0WPZAg+NuwdlUs3bHpaKdCw2lK4j/wSAiAFKbgQ7NEmFPcSIfkw0
         JHnhRuRdZqC+lPhz+KiT+Na1PoNL3Zdx7zvga9i/17lKDRofry7U/UENAzVMfwHDaqg4
         2qo/Vl/i5NMzXoZzStoLxF5e3V5GrnYA5a8UM6pA8L4kbVX4p04ZwEMRmOOWAzPm8dGX
         tyjg/22PbVbI+BVrFLQne1p1F11ZYuQQgaoL2MirEBiT9n72eq2syHYqvbmkZoWuiPEn
         D6RaWXdo68e90E6ge4ELJfP0X7rMa+tMK06jyy2EiBaytHmhc3ZRhL+aii26pq73XzOs
         9ZAA==
X-Gm-Message-State: AOAM530tu+E3W1/G4ICJ2JBu5R3RDHDvcWXqBriSkuGWc4nsONjKr8ei
        swlfoPCsfkVP6Yo0FsuZyK4ZewbfcsFkJo4nsE7IWg==
X-Google-Smtp-Source: ABdhPJwytoCPwmwAMxFotUSDq6urZ308NhRwONKnwMRqCKVi1Qfyo/IQNkR8v/jXrjQhxtgu3/SrVUzfGE68GQnAZ70=
X-Received: by 2002:a2e:975a:: with SMTP id f26mr1576542ljj.81.1607537736484;
 Wed, 09 Dec 2020 10:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20201207142204.GA18516@rlk> <CALvZod45tRyx+7VagQQ=9SqabNR5Y=f0U0T0AFtOFWdzUgJbxQ@mail.gmail.com>
 <20201208060747.GA56968@rlk> <CALvZod56cWta66q4w4ndiPmgfVGkViAFfivh8L8eUBPqJRWFCg@mail.gmail.com>
 <20201209162935.GD26090@dhcp22.suse.cz>
In-Reply-To: <20201209162935.GD26090@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 9 Dec 2020 10:15:25 -0800
Message-ID: <CALvZod6Z8S4BDD23kwhhF+EYciA6iu8bbac1UJZKwO2T-+96XA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: simplify kmem cgroup charge/uncharge code
To:     Michal Hocko <mhocko@suse.com>
Cc:     Hui Su <sh_def@163.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 8:29 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 08-12-20 09:12:23, Shakeel Butt wrote:
> > +Michal Hocko
> >
> > Message starts at https://lkml.kernel.org/r/20201207142204.GA18516@rlk
> >
> > On Mon, Dec 7, 2020 at 10:08 PM Hui Su <sh_def@163.com> wrote:
> > >
> > > On Mon, Dec 07, 2020 at 09:28:46AM -0800, Shakeel Butt wrote:
> > > > On Mon, Dec 7, 2020 at 6:22 AM Hui Su <sh_def@163.com> wrote:
> > > >
> > > > The reason to keep __memcg_kmem_[un]charge_page functions is that they
> > > > were called in the very hot path. Can you please check the performance
> > > > impact of your change and if the generated code is actually same or
> > > > different.
> > >
> > > Hi, Shakeel:
> > >
> > > I objdump the mm/page_alloc.o and comapre them, it change the assemble code
> > > indeed. In fact, it change some code order, which i personally think won't have
> > > impact on performance. And i ran the ltp mm and conatiner test, it seems nothing
> > > abnormal.
> >
> > Did you run the tests in a memcg? The change is behind a static key of
> > kmem accounting which is enabled for subcontainers.
> >
> > >
> > > BUT i still want to check whether this change will have negative impact on
> > > perforance due to this change code was called in the very hot path like you
> > > said, AND saddly i did not find a way to quantify the impact on performance.
> > > Can you give me some suggestion about how to quantify the performance or some
> > > tool?
> > >
> >
> > At least I think we can try with a simple page allocation in a loop
> > i.e. alloc_page(GFP_KERNEL_ACCOUNT). I will think of any existing
> > benchmark which exercises this code path.
> >
> > Michal, do you have any suggestions?
>
> I have to say I do not see any big benefit from the patch and it alters
> a real hot path to check for the flag even in cases where kmem
> accounting is not enabled, unless I am misreading the code.
>

Yes you are right unless the super intelligent compiler re-arranges
the checks and puts the static key check at front to optimize the
non-kmem-accounting mode.
