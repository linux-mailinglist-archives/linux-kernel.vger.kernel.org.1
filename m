Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B63B2AF7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKKSAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:00:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbgKKSAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605117600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8xfs94NnyMJClh1BOZT8JsRuv0OOa40sFS9VpKsYwg=;
        b=FWxvl3S8oEAFG6ImA+BuKYMzkbxqIThXriBttnE15g+VnmTQk0ZBBuesyRGkp5N0bn/fxB
        gNV2CQ5GWcmLsbUxgymV1PH47Rqej4SlAJeMRwOVW7sYCKFfyEpH4EnCeTlX6PdWSS6ffj
        IhkNYVH7IR3SYo3PhCjGxnKzlwJlG50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-56ub6ghkOQuJmGQcS-LWCg-1; Wed, 11 Nov 2020 12:59:57 -0500
X-MC-Unique: 56ub6ghkOQuJmGQcS-LWCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 627AD1084D7C;
        Wed, 11 Nov 2020 17:59:41 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A3CC5DA6A;
        Wed, 11 Nov 2020 17:59:39 +0000 (UTC)
Subject: Re: [PATCH v3 7/7] mm, page_alloc: disable pcplists during memory
 offline
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
References: <20201111092812.11329-1-vbabka@suse.cz>
 <20201111092812.11329-8-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3317cf76-458c-8873-0e1a-4129745f0fda@redhat.com>
Date:   Wed, 11 Nov 2020 18:59:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201111092812.11329-8-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.20 10:28, Vlastimil Babka wrote:
> Memory offlining relies on page isolation to guarantee a forward
> progress because pages cannot be reused while they are isolated. But the
> page isolation itself doesn't prevent from races while freed pages are
> stored on pcp lists and thus can be reused.  This can be worked around by
> repeated draining of pcplists, as done by commit 968318261221
> ("mm/memory_hotplug: drain per-cpu pages again during memory offline").
> 
> David and Michal would prefer that this race was closed in a way that callers
> of page isolation who need stronger guarantees don't need to repeatedly drain.
> David suggested disabling pcplists usage completely during page isolation,
> instead of repeatedly draining them.
> 
> To achieve this without adding special cases in alloc/free fastpath, we can use
> the same approach as boot pagesets - when pcp->high is 0, any pcplist addition
> will be immediately flushed.
> 
> The race can thus be closed by setting pcp->high to 0 and draining pcplists
> once, before calling start_isolate_page_range(). The draining will serialize
> after processes that already disabled interrupts and read the old value of
> pcp->high in free_unref_page_commit(), and processes that have not yet disabled
> interrupts, will observe pcp->high == 0 when they are rescheduled, and skip
> pcplists. This guarantees no stray pages on pcplists in zones where isolation
> happens.
> 
> This patch thus adds zone_pcp_disable() and zone_pcp_enable() functions that
> page isolation users can call before start_isolate_page_range() and after
> unisolating (or offlining) the isolated pages.
> 
> Also, drain_all_pages() is optimized to only execute on cpus where pcplists are
> not empty. The check can however race with a free to pcplist that has not yet
> increased the pcp->count from 0 to 1. Thus make the drain optionally skip the
> racy check and drain on all cpus, and use this option in zone_pcp_disable().

^ there it is, can you move that comment into the code? People (e.g., me 
:) ) staring at that will be confused otherwise.

-- 
Thanks,

David / dhildenb

