Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1102B9960
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgKSRgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgKSRgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:36:09 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE39C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:36:08 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so9428574lfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AMEfcRZyDbM50viNn70TO3tAhFtDRzkX2NtxBHmPeO4=;
        b=X8ry30GXNTORZXNY+OjXb0UPQ8k82UKFXpWbqvK6BW+4LqLaJVUgflFnnJNrz9JSDi
         rw1j9ax4aZ2PpaOK/5Xt/CP5ONOJ842KQQNmLcrj5acb3VbSnBW1pirriQUL4v8gEhg4
         gr6VI7NiD98OvXD/dWOoO5PfnGG1rmi77oPzGSZPRreu7Fg2juO//sqabOdRZh1tp2RC
         rcxOynBTfieqRPJnV7+KhjG+eckKwq8xPZgiAMTgl2dZDUdkmya3BPaNZqXWXxAxY7iz
         kc2GgFYSvvNJV9tQ4d2T5helECw9my7HrZXrSwcWGxgtpj0nSKpuzRjVdcwzWjVDyXdW
         VLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AMEfcRZyDbM50viNn70TO3tAhFtDRzkX2NtxBHmPeO4=;
        b=pdXcu4a74c416P+MY5VlYjA32AIv7Af4daxCwrmqEg5kwSaWQK78yFktDgXcerO+rB
         mVcC947P/BfT59vu4lwjh639mjrCA511voJQH3Mza44DvEVxXp3zqTvAS+hKhOqVY3xg
         9jecY7TFbX4AFpBkHn67dfLp9wVbs0gmFo8t6BtSh0PJKe8AkHzKXQ4VcxOO2nwFo/8j
         HsSbs0wRwSlHGrfV8Lu/P9AITsMcTIHHEuOb+lF5H1vS6b5vt3+Gdf45CsHu0H0KUqHg
         p2yCcaHDrWtFG+wYo4DiqHzaxS8JHUKcn4LCXcl8pGMTMEUGG0DayND0xD6eqiPyeTe4
         A3Vw==
X-Gm-Message-State: AOAM530tvjXoGJOMj4ci0F2nrtuBS4ZCy69I+Xrf/l3PLoj59ecswmru
        GWNniINhbnpbMv81PZHagi0=
X-Google-Smtp-Source: ABdhPJzRC11aJaTcuVHdEgeBTCumt/WsKoq0korwAsDLZ9gmgzgMR5LnI2hq4i0mrQ/FAiAiZCiGQQ==
X-Received: by 2002:a19:c1c5:: with SMTP id r188mr6821458lff.354.1605807367020;
        Thu, 19 Nov 2020 09:36:07 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id q13sm29732lfk.147.2020.11.19.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 09:36:06 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 19 Nov 2020 18:36:04 +0100
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/vmalloc: rework the drain logic
Message-ID: <20201119173604.GA991@pc636>
References: <20201116220033.1837-1-urezki@gmail.com>
 <20201116220033.1837-2-urezki@gmail.com>
 <CAC=cRTN77LAn-9-6rGukc2aUZQzx7oP9eKt_hJeb=wbnhGqObQ@mail.gmail.com>
 <20201117130434.GA10769@pc636>
 <CAC=cRTN-JyZKyFkRgC0BrBjnu4mMTJ_hXBYszJ9HLXaLqeMfgQ@mail.gmail.com>
 <20201118161623.GA21171@pc636>
 <87mtzeunsi.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtzeunsi.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:40:29AM +0800, Huang, Ying wrote:
> Uladzislau Rezki <urezki@gmail.com> writes:
> 
> > On Wed, Nov 18, 2020 at 10:44:13AM +0800, huang ying wrote:
> >> On Tue, Nov 17, 2020 at 9:04 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >> >
> >> > On Tue, Nov 17, 2020 at 10:37:34AM +0800, huang ying wrote:
> >> > > On Tue, Nov 17, 2020 at 6:00 AM Uladzislau Rezki (Sony)
> >> > > <urezki@gmail.com> wrote:
> >> > > >
> >> > > > A current "lazy drain" model suffers from at least two issues.
> >> > > >
> >> > > > First one is related to the unsorted list of vmap areas, thus
> >> > > > in order to identify the [min:max] range of areas to be drained,
> >> > > > it requires a full list scan. What is a time consuming if the
> >> > > > list is too long.
> >> > > >
> >> > > > Second one and as a next step is about merging all fragments
> >> > > > with a free space. What is also a time consuming because it
> >> > > > has to iterate over entire list which holds outstanding lazy
> >> > > > areas.
> >> > > >
> >> > > > See below the "preemptirqsoff" tracer that illustrates a high
> >> > > > latency. It is ~24 676us. Our workloads like audio and video
> >> > > > are effected by such long latency:
> >> > >
> >> > > This seems like a real problem.  But I found there's long latency
> >> > > avoidance mechanism in the loop in __purge_vmap_area_lazy() as
> >> > > follows,
> >> > >
> >> > >         if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> >> > >             cond_resched_lock(&free_vmap_area_lock);
> >> > >
> >> > I have added that "resched threshold" because of on my tests i could
> >> > simply hit out of memory, due to the fact that a drain work is not up
> >> > to speed to process such long outstanding list of vmap areas.
> >> 
> >> OK.  Now I think I understand the problem.  For free area purging,
> >> there are multiple "producers" but one "consumer", and it lacks enough
> >> mechanism to slow down the "producers" if "consumer" can not catch up.
> >> And your patch tries to resolve the problem via accelerating the
> >> "consumer".
> >>
> > Seems, correct. But just in case one more time:
> >
> > the cond_resched_lock was added once upon a time to get rid of long
> > preemption off time. Due to dropping the lock, "producers" can start
> > generate further vmap area, so "consumer" can not catch up. Seems
> 
> Yes.  And in theory there are vfree() storm, that is, thousands vfree()
> can be called in short time.  But I don't think that's practical use
> case.
> 
> > Later on, a resched threshold was added. It is just a simple protection
> > threshold, passing which, a freeing is prioritized back over allocation,
> > so we guarantee that we do not hit out of memory.
> 
> Yes.  That can accelerate freeing if necessary.
> 
> >>
> >> That isn't perfect, but I think we may have quite some opportunities
> >> to merge the free areas, so it should just work.
> >> 
> > Yes, merging opportunity should do the work. But of course there are
> > exceptions.
> >
> >> And I found the long latency avoidance logic in
> >> __purge_vmap_area_lazy() appears problematic,
> >> 
> >>          if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> >>              cond_resched_lock(&free_vmap_area_lock);
> >> 
> >> Shouldn't it be something as follows?
> >> 
> >>          if (i >= BATCH && atomic_long_read(&vmap_lazy_nr) <
> >> resched_threshold) {
> >>              cond_resched_lock(&free_vmap_area_lock);
> >>              i = 0;
> >>          } else
> >>              i++;
> >> 
> >> This will accelerate the purging via batching and slow down vmalloc()
> >> via holding free_vmap_area_lock.  If it makes sense, can we try this?
> >> 
> > Probably we can switch to just using "batch" methodology:
> >
> > <snip>
> >     if (!(i++ % batch_threshold))
> >         cond_resched_lock(&free_vmap_area_lock);
> > <snip>
> 
> That's the typical long latency avoidance method.
> 
> > The question is, which value we should use as a batch_threshold: 100, 1000, etc.
> 
> I think we can do some measurement to determine it?
> 
Hmm.. looking at it one more time i do not see what batching solves.
Anyway we need to have some threshold(what we do have), that regulates
a priority between vmalloc()/vfree().

What we can do more with it are:

- purging should be just performed asynchronously in workqueue context.
Giving the fact, that now we also do a merge of outstanding areas, the
data structure(rb-tree) will not be so fragmented.

- lazy_max_pages() can slightly be decreased. If there are existing
workloads which suffer from such long value. It would be good to get
real complains and evidence.

> > Apart of it and in regard to CONFIG_KASAN_VMALLOC, it seems that we are not
> > allowed to drop the free_vmap_area_lock at all. Because any simultaneous
> > allocations are not allowed within a drain region, so it should occur in
> > disjoint regions. But i need to double check it.
> >
> >>
> >> And, can we reduce lazy_max_pages() to control the length of the
> >> purging list?  It could be > 8K if the vmalloc/vfree size is small.
> >>
> > We can adjust it for sure. But it will influence on number of global
> > TLB flushes that must be performed.
> 
> Em...  For example, if we set it to 100, then the number of the TLB
> flushes can be reduced to 1% of the un-optimized implementation
> already.  Do you think so?
> 
If we set lazy_max_pages() to vague value such as 100, the performance
will be just destroyed.

Thanks!

--
Vlad Rezki
