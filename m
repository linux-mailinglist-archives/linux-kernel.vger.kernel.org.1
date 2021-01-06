Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74CE2EBBC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAFJmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbhAFJms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609926082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9CA1AR5nXWGzRi5gkPRl8C2ixPan6lcvaX7CUQMGuI=;
        b=SZZM7f9UOCBnFa/DkD2Q9sh+KD5oZkkvAn6aXRulfnUKLzNdUPvWxS721XBd/n/QC03tdP
        o0Z7ksy28Ro3NcHwcAbL9cBS4ru5bET6sjeUw2ZyH+rwevIjjlJLI2jpIQQ0q24V+DvBhZ
        kKS9Z8/U+VL7zScjHFIPzdF3aVafDOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-yV9DYsxyOcmAP7AkRXFbng-1; Wed, 06 Jan 2021 04:41:18 -0500
X-MC-Unique: yV9DYsxyOcmAP7AkRXFbng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF57800D53;
        Wed,  6 Jan 2021 09:41:15 +0000 (UTC)
Received: from [10.36.112.160] (ovpn-112-160.ams2.redhat.com [10.36.112.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA58F71CA1;
        Wed,  6 Jan 2021 09:41:09 +0000 (UTC)
Subject: Re: [PATCH 0/6] hugetlbfs: support free page reporting
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20210106034623.GA1128@open-light-1.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <effc0673-0452-08d8-819b-70aee14643c5@redhat.com>
Date:   Wed, 6 Jan 2021 10:41:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210106034623.GA1128@open-light-1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.01.21 04:46, Liang Li wrote:
> A typical usage of hugetlbfs it's to reserve amount of memory
> during the kernel booting stage, and the reserved pages are
> unlikely to return to the buddy system. When application need
> hugepages, kernel will allocate them from the reserved pool.
> when application terminates, huge pages will return to the
> reserved pool and are kept in the free list for hugetlbfs,
> these free pages will not return to buddy freelist unless the
> size of reserved pool is changed. 
> Free page reporting only supports buddy pages, it can't report
> the free pages reserved for hugetlbfs. On the other hand,
> hugetlbfs is a good choice for system with a huge amount of RAM,
> because it can help to reduce the memory management overhead and
> improve system performance.
> This patch add the support for reporting hugepages in the free
> list of hugetlbfs, it can be used by virtio_balloon driver for
> memory overcommit and pre zero out free pages for speeding up
> memory population and page fault handling.

You should lay out the use case + measurements. Further you should
describe what this patch set actually does, how behavior can be tuned,
pros and cons, etc... And you should most probably keep this RFC.

> 
> Most of the code are 'copied' from free page reporting because
> they are working in the same way. So the code can be refined to
> remove duplication. It can be done later.

Nothing speaks about getting it right from the beginning. Otherwise it
will most likely never happen.

> 
> Since some guys have some concern about side effect of the 'buddy
> free page pre zero out' feature brings, I remove it from this
> serier.

You should really point out what changed size the last version. I
remember Alex and Mike had some pretty solid points of what they don't
want to see (especially: don't use free page reporting infrastructure
and don't temporarily allocate huge pages for processing them).

I am not convinced that we want to use the free page reporting
infrastructure for this (pre-zeroing huge pages). What speaks about a
thread simply iterating over huge pages one at a time, zeroing them? The
whole free page reporting infrastructure was invented because we have to
do expensive coordination (+ locking) when going via the hypervisor. For
the main use case of zeroing huge pages in the background, I don't see a
real need for that. If you believe this is the right thing to do, please
add a discussion regarding this.

-- 
Thanks,

David / dhildenb

