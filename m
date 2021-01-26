Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B9E303C85
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392378AbhAZMHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:07:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:59832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391345AbhAZMHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:07:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47318B92F;
        Tue, 26 Jan 2021 12:06:36 +0000 (UTC)
To:     Roman Gushchin <guro@fb.com>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de, cl@linux.com,
        hannes@cmpxchg.org, iamjoonsoo.kim@lge.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, minchan@kernel.org, penberg@kernel.org,
        rientjes@google.com, shakeelb@google.com, surenb@google.com,
        tglx@linutronix.de
References: <aa02cf86-3a83-2e55-3bb6-3ec1c0f71b11@suse.cz>
 <20210121172154.27580-1-vbabka@suse.cz>
 <20210121172154.27580-2-vbabka@suse.cz>
 <20210122004847.GA25567@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC 2/2] mm, slub: add shrinker to reclaim cached slabs
Message-ID: <51de513a-9c4e-35fa-fd04-977480ac50a0@suse.cz>
Date:   Tue, 26 Jan 2021 13:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122004847.GA25567@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 1:48 AM, Roman Gushchin wrote:
> On Thu, Jan 21, 2021 at 06:21:54PM +0100, Vlastimil Babka wrote:
> 
> Hi Vlastimil!
> 
> This makes a lot of sense, however it looks a bit as an overkill to me (on 5.9+).
> Isn't limiting a number of pages (instead of number of objects) sufficient on 5.9+?

It would help, but fundamentally there can still be a lot of memory locked up
with e.g. many CPU's. We should have a way to flush this automatically, like for
other cached things.

> If not, maybe we can limit the shrinking to the pre-OOM condition?
> Do we really need to trip it constantly?

The priority could be reduced, pre-OOM might be too extreme. Why reclaim e.g.
actually used LRU pages instead of unused slab pages?
IMHO a frequently reclaiming system probably doesn't benefit from SLUB's peak
performance at that point anyway...

> Thanks!
> 

