Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E422EA792
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbhAEJbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:31:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728566AbhAEJbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609838998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+tuu9jZl4ygMZucY8oUdrOoGRv8r43O0YhW/HHyjwp4=;
        b=CI7FlylPrLHNVN1I3lpeNj9jizC6y+RwN7HXfMyZbi1LHRNGJVq2/SdCnFryoaRVFnLfTp
        +ZsBRGY8r92j8lhJHeFVHJdRR2W80oHvfZ8vrnm4xGR49u3Gt4Az6BKLeqii2hHRyJ8w7q
        vPk3zxXD6Bq1DwA5jZUs7qlmFaEX2bY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-G9p_NeVKNDeNlGFrnBl8nA-1; Tue, 05 Jan 2021 04:29:55 -0500
X-MC-Unique: G9p_NeVKNDeNlGFrnBl8nA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C564107ACE3;
        Tue,  5 Jan 2021 09:29:53 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C45531002382;
        Tue,  5 Jan 2021 09:29:46 +0000 (UTC)
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
To:     Michal Hocko <mhocko@suse.com>, Dave Hansen <dave.hansen@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
 <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
 <6bfcc500-7c11-f66a-26ea-e8b8bcc79e28@intel.com>
 <20210105092037.GY13207@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <71953119-06ff-0bb8-1879-09e24bf80446@redhat.com>
Date:   Tue, 5 Jan 2021 10:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105092037.GY13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 10:20, Michal Hocko wrote:
> On Mon 04-01-21 15:00:31, Dave Hansen wrote:
>> On 1/4/21 12:11 PM, David Hildenbrand wrote:
>>>> Yeah, it certainly can't be the default, but it *is* useful for
>>>> thing where we know that there are no cache benefits to zeroing
>>>> close to where the memory is allocated.
>>>>
>>>> The trick is opting into it somehow, either in a process or a VMA.
>>>>
>>> The patch set is mostly trying to optimize starting a new process. So
>>> process/vma doesn‘t really work.
>>
>> Let's say you have a system-wide tunable that says: pre-zero pages and
>> keep 10GB of them around.  Then, you opt-in a process to being allowed
>> to dip into that pool with a process-wide flag or an madvise() call.
>> You could even have the flag be inherited across execve() if you wanted
>> to have helper apps be able to set the policy and access the pool like
>> how numactl works.
> 
> While possible, it sounds quite heavy weight to me. Page allocator would
> have to somehow maintain those pre-zeroed pages. This pool will also
> become a very scarce resource very soon because everybody just want to
> run faster. So this would open many more interesting questions.

Agreed.

> 
> A global knob with all or nothing sounds like an easier to use and
> maintain solution to me.

I mean, that brings me back to my original suggestion: just use
hugetlbfs and implement some sort of pre-zeroing there (worker thread,
whatsoever). Most vfio users should already be better of using hugepages.

It's a "pool of pages" already. Selected users use it. I really don't
see a need to extend the buddy with something like that.

-- 
Thanks,

David / dhildenb

