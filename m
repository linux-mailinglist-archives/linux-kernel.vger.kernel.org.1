Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16862F57A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbhANCDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbhAMWio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:38:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A059C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:38:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o13so5175643lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAIWjOtXPXk3f6XGXvlQDMsqqk/Jc2w4tbFamd1OcrM=;
        b=K/eirvkv5kcBKYbbEyvX7Zv/UJQNaPzp/XrxS/sGEZXeaoXL6+zJxS1r8PZw/FU00U
         g5iIEhcguSXVlJLsHNhOgpMldxjLP2XQAXQSHPs5kpn7fifZzsWJc3ICDApAhaCRKJWf
         Ubzk6w+ulrIdDenC5gCem8VvNQCmG4jtjWxf+xMXvLNYkyk9uaqTbNW5WIXoTuSszrPE
         lv8Mf7vWlMmHcoH3hDLJE5N2XVmtTYrEeKjbA4ZDnXE9UuOz++bZwy5WfMAzmPIzNEXB
         UmWoAkytH6FipvksxcU+3cajHH3qWhFRHH8MX9eB0t88lKnUSPNrudc1F37KmgjnN7j5
         0KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAIWjOtXPXk3f6XGXvlQDMsqqk/Jc2w4tbFamd1OcrM=;
        b=NBhaOFCwFFVxGVs8PVbgt/jIoP+dO+6z5ylSLcYTaE55hNKRy0rHF0qriWBKk+ErU5
         fFWPxweglyIRSbijZrryudBxNbSQd0C4pDB0RGExl8dse5lGEZ5d4roJzKLaFiKsB7zx
         8bPhw0djyTce6+AEr5MOpCmoB1m5zbHuh0+VOiYOXIJso66kYxfVE6OfzjAWY9hGZIL8
         1PQBQHw1UEyiKllRK7iqZ/O7p5ym3Ij0qzhWClAURa6eTN4rmN4Xf40HzFg/5IARt3j/
         FBu9PX469VlH5ILJDbmKaJANSAyxNfCioNAklqT5p9If9gvWFZn2FkBTMHQ4KrtEltd2
         giCg==
X-Gm-Message-State: AOAM531a50aq5abu3aW+Vuyy66Oj9DmUahZlqNzGw7ATO7ivewDN7kR8
        2tpK+w9CzSe6qDhBGn9tnuzUTTY6X+siwrYKEJrHpg==
X-Google-Smtp-Source: ABdhPJz9YfxCg3PiKUM6Bq9lL0bPJH5jphc+Sky7zSJAZ6PbIhqNiXSN6mcBEDtWNThpsM+kIKuRxP4W7TM1oY2UuJk=
X-Received: by 2002:a19:8210:: with SMTP id e16mr1657132lfd.69.1610577480744;
 Wed, 13 Jan 2021 14:38:00 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
 <2f0f46e8-2535-410a-1859-e9cfa4e57c18@suse.cz>
In-Reply-To: <2f0f46e8-2535-410a-1859-e9cfa4e57c18@suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 13 Jan 2021 23:37:34 +0100
Message-ID: <CAG48ez2-DzC4qf_vzqj+VoGu4nM7275WmyxiPMT7dAp+MHDtOg@mail.gmail.com>
Subject: Re: SLUB: percpu partial object count is highly inaccurate, causing
 some memory wastage and maybe also worse tail latencies?
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 8:14 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> On 1/12/21 12:12 AM, Jann Horn wrote:
> It doesn't help that slabinfo (global or per-memcg) is also
> inaccurate as it cannot count free objects on per-cpu partial slabs and thus
> reports them as active.

Maybe SLUB could be taught to track how many objects are in the percpu
machinery, and then print that number separately so that you can at
least know how much data you're missing without having to collect data
with IPIs...

> > It might be a good idea to figure out whether it is possible to
> > efficiently keep track of a more accurate count of the free objects on
>
> As long as there are some inuse objects, it shouldn't matter much if the slab is
> sitting on per-cpu partial list or per-node list, as it can't be freed anyway.
> It becomes a real problem only after the slab become fully free. If we detected
> that in __slab_free() also for already-frozen slabs, we would need to know which
> CPU this slab belongs to (currently that's not tracked afaik),

Yeah, but at least on 64-bit systems we still have 32 completely
unused bits in the counter field that's updated via cmpxchg_double on
struct page. (On 32-bit systems the bitfields are also wider than they
strictly need to be, I think, at least if the system has 4K page
size.) So at least on 64-bit systems, we could squeeze a CPU number in
there, and then you'd know to which CPU the page belonged at the time
the object was freed.

> and send it an
> IPI to do some light version of unfreeze_partials() that would only remove empty
> slabs. The trick would be not to cause too many IPI's by this, obviously :/

Some brainstorming:

Maybe you could have an atomic counter in kmem_cache_cpu that tracks
the number of empty frozen pages that are associated with a specific
CPU? So the freeing slowpath would do its cmpxchg_double, and if the
new state after a successful cmpxchg_double is "inuse==0 && frozen ==
1" with a valid CPU number, you afterwards do
"atomic_long_inc(&per_cpu_ptr(cache->cpu_slab,
cpu)->empty_partial_pages)". I think it should be possible to
implement that such that the empty_partial_pages count, while not
immediately completely accurate, would be eventually consistent; and
readers on the CPU owning the kmem_cache_cpu should never see a number
that is too large, only one that is too small.

You could additionally have a plain percpu counter, not tied to the
kmem_cache, and increment it by 1<<page_order - then that would track
the amount of memory you could reclaim by sending an IPI to a given
CPU core. Then that threshold could help decide whether it's worth
sending IPIs from SLUB and/or the shrinker?
