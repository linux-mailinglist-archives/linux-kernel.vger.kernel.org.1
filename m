Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D22B8191
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgKRQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgKRQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:16:28 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94398C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:16:27 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r9so3721950lfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dxGJzTPzfGqlw2eREZnl/81tfb5sqRiBYpaj7YA+TgI=;
        b=dOsYA9VE0g4ahGGUcPyY47F9nTBcOmKwvKoS/oErU5qrQCT/81NNjtnzn+BfOl78ae
         R6/4Mm8K+DuU8UsnZSm3CSdA+7dlazyj5PhmJoOuekCnfNgwRVF8Qxjho76GAA4xTLJB
         9lTQwBsNJxtUV63SGXYiHU4g0qybK7BwqI5Em+9Zjq5L55eGy6jgOmutGmeqfrHKuxx+
         flP5TMzGIKenWwZq736eCIwtice8OGlQmYOz9myoX9tqjK0TbJAuI/XhnrJ2mDvNOKLQ
         +9D0X8p2KHFqhb4hi4YXpeGphW9HvpLNARq5pTqsXVq6hQH30dDjs08Y5qSi70vI0uA/
         4YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dxGJzTPzfGqlw2eREZnl/81tfb5sqRiBYpaj7YA+TgI=;
        b=lfIFAL/ki1ry+ksagpsLx1k/ktY5xQSz2e7QmujiWQvYdfK4jTmjjCVy0Q5k0IE1xw
         /zh7Thw62vJIFPjlPAb9hopaw+OQLVlxYJqfnA/c0EiMmshhlgIZFCsX29yukYp478hP
         irW2jm1O2V8T1TSfT764I5PHp4xivVFRjqP2lgsEx8/RokkVWRurt70vXAPAS/h02W/s
         ZlDwKXxzbbwdaH1xzIyqBLezsL6BvtpmW4lnhLUUlAdvDJz8KJb0d3j5YUvMOaTB2RsF
         61RDnMQCGE6K0yisMEhx4W3PpsKkw5P0MCk591sdCcS+pJ+86NLdcQkevsQjBsXGL3vu
         wixA==
X-Gm-Message-State: AOAM5310VxgwjJYIJq4NaTnpr/EFanFXV2gNijzRfUg6Wv6qoGv+xq94
        woie5dcOh+TTuB1UiDePwO9VcW/rXlbWwHpx
X-Google-Smtp-Source: ABdhPJwh8ZZQcru32BvECvUnG9uLIIUaHfDXf2K7dPs+RpVGX3F7Hyy6b5KfhXtyo12NbB4YvfDD8Q==
X-Received: by 2002:a19:d02:: with SMTP id 2mr3858602lfn.294.1605716186014;
        Wed, 18 Nov 2020 08:16:26 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id a26sm1492457ljn.137.2020.11.18.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 08:16:25 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 18 Nov 2020 17:16:23 +0100
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Huang Ying <ying.huang@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/vmalloc: rework the drain logic
Message-ID: <20201118161623.GA21171@pc636>
References: <20201116220033.1837-1-urezki@gmail.com>
 <20201116220033.1837-2-urezki@gmail.com>
 <CAC=cRTN77LAn-9-6rGukc2aUZQzx7oP9eKt_hJeb=wbnhGqObQ@mail.gmail.com>
 <20201117130434.GA10769@pc636>
 <CAC=cRTN-JyZKyFkRgC0BrBjnu4mMTJ_hXBYszJ9HLXaLqeMfgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC=cRTN-JyZKyFkRgC0BrBjnu4mMTJ_hXBYszJ9HLXaLqeMfgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:44:13AM +0800, huang ying wrote:
> On Tue, Nov 17, 2020 at 9:04 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Tue, Nov 17, 2020 at 10:37:34AM +0800, huang ying wrote:
> > > On Tue, Nov 17, 2020 at 6:00 AM Uladzislau Rezki (Sony)
> > > <urezki@gmail.com> wrote:
> > > >
> > > > A current "lazy drain" model suffers from at least two issues.
> > > >
> > > > First one is related to the unsorted list of vmap areas, thus
> > > > in order to identify the [min:max] range of areas to be drained,
> > > > it requires a full list scan. What is a time consuming if the
> > > > list is too long.
> > > >
> > > > Second one and as a next step is about merging all fragments
> > > > with a free space. What is also a time consuming because it
> > > > has to iterate over entire list which holds outstanding lazy
> > > > areas.
> > > >
> > > > See below the "preemptirqsoff" tracer that illustrates a high
> > > > latency. It is ~24 676us. Our workloads like audio and video
> > > > are effected by such long latency:
> > >
> > > This seems like a real problem.  But I found there's long latency
> > > avoidance mechanism in the loop in __purge_vmap_area_lazy() as
> > > follows,
> > >
> > >         if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> > >             cond_resched_lock(&free_vmap_area_lock);
> > >
> > I have added that "resched threshold" because of on my tests i could
> > simply hit out of memory, due to the fact that a drain work is not up
> > to speed to process such long outstanding list of vmap areas.
> 
> OK.  Now I think I understand the problem.  For free area purging,
> there are multiple "producers" but one "consumer", and it lacks enough
> mechanism to slow down the "producers" if "consumer" can not catch up.
> And your patch tries to resolve the problem via accelerating the
> "consumer".
>
Seems, correct. But just in case one more time:

the cond_resched_lock was added once upon a time to get rid of long
preemption off time. Due to dropping the lock, "producers" can start
generate further vmap area, so "consumer" can not catch up. Seems

Later on, a resched threshold was added. It is just a simple protection
threshold, passing which, a freeing is prioritized back over allocation,
so we guarantee that we do not hit out of memory.

>
> That isn't perfect, but I think we may have quite some opportunities
> to merge the free areas, so it should just work.
> 
Yes, merging opportunity should do the work. But of course there are
exceptions.

> And I found the long latency avoidance logic in
> __purge_vmap_area_lazy() appears problematic,
> 
>          if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
>              cond_resched_lock(&free_vmap_area_lock);
> 
> Shouldn't it be something as follows?
> 
>          if (i >= BATCH && atomic_long_read(&vmap_lazy_nr) <
> resched_threshold) {
>              cond_resched_lock(&free_vmap_area_lock);
>              i = 0;
>          } else
>              i++;
> 
> This will accelerate the purging via batching and slow down vmalloc()
> via holding free_vmap_area_lock.  If it makes sense, can we try this?
> 
Probably we can switch to just using "batch" methodology:

<snip>
    if (!(i++ % batch_threshold))
        cond_resched_lock(&free_vmap_area_lock);
<snip>

The question is, which value we should use as a batch_threshold: 100, 1000, etc.

Apart of it and in regard to CONFIG_KASAN_VMALLOC, it seems that we are not
allowed to drop the free_vmap_area_lock at all. Because any simultaneous
allocations are not allowed within a drain region, so it should occur in
disjoint regions. But i need to double check it.

>
> And, can we reduce lazy_max_pages() to control the length of the
> purging list?  It could be > 8K if the vmalloc/vfree size is small.
>
We can adjust it for sure. But it will influence on number of global
TLB flushes that must be performed.

Thanks.

--
Vlad Rezki
