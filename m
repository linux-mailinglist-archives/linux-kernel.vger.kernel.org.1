Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D769303B83
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392299AbhAZLXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:23:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:38046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390527AbhAZIxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:53:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611651167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAwcZaaALzsM4ZhpVy8/22ZJ6aCFgMiw425G+gf8mFY=;
        b=UfJY4QRP0UQwryv2Z3vPNZ5WTKsvVz4kDKv/IvWNLWMDXOZMdLYfvVsENYAb4DgsdIBcYp
        Uv0LClvObYF0xlidjzvSrj95GdJSdj4RT7jibXBG7EfN3TJ18rcTdpxCTR/SdJHUUChhmf
        ulD8FK4v6noJdjRbH9LaD6IM3wyc5bY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49AF9AC4F;
        Tue, 26 Jan 2021 08:52:47 +0000 (UTC)
Date:   Tue, 26 Jan 2021 09:52:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        shakeelb@google.com, Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <20210126085243.GE827@dhcp22.suse.cz>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-01-21 19:19:21, Vlastimil Babka wrote:
[...]
> We could also start questioning the very assumption that number of cpus should
> affect slab page size in the first place. Should it? After all, each CPU will
> have one or more slab pages privately cached, as we discuss in the other
> thread... So why make the slab pages also larger?

I do agree. What is the acutal justification for this scaling?
        /*
         * Attempt to find best configuration for a slab. This
         * works by first attempting to generate a layout with
         * the best configuration and backing off gradually.
         *
         * First we increase the acceptable waste in a slab. Then
         * we reduce the minimum objects required in a slab.
         */

doesn't speak about CPUs.  9b2cd506e5f2 ("slub: Calculate min_objects
based on number of processors.") does talk about hackbench "This has
been shown to address the performance issues in hackbench on 16p etc."
but it doesn't give any more details to tell actually _why_ that works.

This thread shows that this is still somehow related to performance but
the real reason is not clear. I believe we should be focusing on the
actual reasons for the performance impact than playing with some fancy
math and tuning for a benchmark on a particular machine which doesn't
work for others due to subtle initialization timing issues.

Fundamentally why should higher number of CPUs imply the size of slab in
the first place?
-- 
Michal Hocko
SUSE Labs
