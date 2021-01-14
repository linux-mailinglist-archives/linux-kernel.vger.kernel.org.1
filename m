Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6792F5CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbhANJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:05:14 -0500
Received: from gentwo.org ([3.19.106.255]:51046 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbhANJFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:05:12 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 594BA42153; Thu, 14 Jan 2021 09:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 56AF342151;
        Thu, 14 Jan 2021 09:04:26 +0000 (UTC)
Date:   Thu, 14 Jan 2021 09:04:26 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Jann Horn <jannh@google.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: SLUB: percpu partial object count is highly inaccurate, causing
 some memory wastage and maybe also worse tail latencies?
In-Reply-To: <CAG48ez2-DzC4qf_vzqj+VoGu4nM7275WmyxiPMT7dAp+MHDtOg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2101140902210.38517@www.lameter.com>
References: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com> <2f0f46e8-2535-410a-1859-e9cfa4e57c18@suse.cz> <CAG48ez2-DzC4qf_vzqj+VoGu4nM7275WmyxiPMT7dAp+MHDtOg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021, Jann Horn wrote:

> Some brainstorming:
>
> Maybe you could have an atomic counter in kmem_cache_cpu that tracks
> the number of empty frozen pages that are associated with a specific
> CPU? So the freeing slowpath would do its cmpxchg_double, and if the


The latencies of these functions are so low that any additional counter
will have significant performance impacts. An atomic counter would be waay
out there.

> You could additionally have a plain percpu counter, not tied to the

The performance critical counters are already all per cpu. I enhanced the
percpu subsystem specifically to support latency critical operations in
the fast path of the slab allocators.
