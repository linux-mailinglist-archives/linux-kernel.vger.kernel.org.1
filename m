Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173612FF1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbhAURWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:22:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:43294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388036AbhAURWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:22:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78005ABD6;
        Thu, 21 Jan 2021 17:21:19 +0000 (UTC)
Subject: Re: SLUB: percpu partial object count is highly inaccurate, causing
 some memory wastage and maybe also worse tail latencies?
To:     Jann Horn <jannh@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
References: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <aa02cf86-3a83-2e55-3bb6-3ec1c0f71b11@suse.cz>
Date:   Thu, 21 Jan 2021 18:21:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 12:12 AM, Jann Horn wrote:
> At first I thought that this wasn't a significant issue because SLUB
> has a reclaim path that can trim the percpu partial lists; but as it
> turns out, that reclaim path is not actually wired up to the page
> allocator's reclaim logic. The SLUB reclaim stuff is only triggered by
> (very rare) subsystem-specific calls into SLUB for specific slabs and
> by sysfs entries. So in userland processes will OOM even if SLUB still
> has megabytes of entirely unused pages lying around.
> 
> It might be a good idea to figure out whether it is possible to
> efficiently keep track of a more accurate count of the free objects on
> percpu partial lists; and if not, maybe change the accounting to
> explicitly track the number of partial pages, and use limits that are
> more appropriate for that? And perhaps the page allocator reclaim path
> should also occasionally rip unused pages out of the percpu partial
> lists?

I'm gonna send a RFC that adds a proper shrinker and thus connects this
shrinking to page reclaim, as a reply to this e-mail.
