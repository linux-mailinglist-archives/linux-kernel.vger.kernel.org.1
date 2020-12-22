Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E342E0767
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgLVItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:49:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLVItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608626863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMcP2wLii6Kjvj+3Y3lAFZyeOUTv8mMHwaZj9JwWr84=;
        b=CI6JuIch0eBFzyXXNaM5eLj18jnMjs/EZ+Cu/fsxCWf8Qnw9Ts+7wqWOQGbklwiNBTMkvF
        mlCAmpQE2xBfyxfZWdmjmNlLh1Rk8vG7dj5szdqGi6ZEfNrfCWMAy6HykAyUFsPFexS8ur
        gttUN1z1aV4+krO/iyuCMJ3m2WkE044=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-qwENkSFTNHmswTNiqYGdzw-1; Tue, 22 Dec 2020 03:47:39 -0500
X-MC-Unique: qwENkSFTNHmswTNiqYGdzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B73F107ACE8;
        Tue, 22 Dec 2020 08:47:37 +0000 (UTC)
Received: from [10.36.113.220] (ovpn-113-220.ams2.redhat.com [10.36.113.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A2C75D9F8;
        Tue, 22 Dec 2020 08:47:27 +0000 (UTC)
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20201221162519.GA22504@open-light-1.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7bf0e895-52d6-9e2d-294b-980c33cf08e4@redhat.com>
Date:   Tue, 22 Dec 2020 09:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201221162519.GA22504@open-light-1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.20 17:25, Liang Li wrote:
> The first version can be found at: https://lkml.org/lkml/2020/4/12/42
> 
> Zero out the page content usually happens when allocating pages with
> the flag of __GFP_ZERO, this is a time consuming operation, it makes
> the population of a large vma area very slowly. This patch introduce
> a new feature for zero out pages before page allocation, it can help
> to speed up page allocation with __GFP_ZERO.
> 
> My original intention for adding this feature is to shorten VM
> creation time when SR-IOV devicde is attached, it works good and the
> VM creation time is reduced by about 90%.
> 
> Creating a VM [64G RAM, 32 CPUs] with GPU passthrough
> =====================================================
> QEMU use 4K pages, THP is off
>                   round1      round2      round3
> w/o this patch:    23.5s       24.7s       24.6s
> w/ this patch:     10.2s       10.3s       11.2s
> 
> QEMU use 4K pages, THP is on
>                   round1      round2      round3
> w/o this patch:    17.9s       14.8s       14.9s
> w/ this patch:     1.9s        1.8s        1.9s
> =====================================================
> 

I am still not convinces that we want/need this for this (main) use
case. Why can't we use huge pages for such use cases (that really care
about VM creation time) and rather deal with pre-zeroing of huge pages
instead?

If possible, I'd like to avoid GFP_ZERO (for reasons already discussed).

> Obviously, it can do more than this. We can benefit from this feature
> in the flowing case:
> 
> Interactive sence
> =================
> Shorten application lunch time on desktop or mobile phone, it can help
> to improve the user experience. Test shows on a
> server [Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz], zero out 1GB RAM by
> the kernel will take about 200ms, while some mainly used application
> like Firefox browser, Office will consume 100 ~ 300 MB RAM just after
> launch, by pre zero out free pages, it means the application launch
> time will be reduced about 20~60ms (can be visual sensed?). May be
> we can make use of this feature to speed up the launch of Andorid APP
> (I didn't do any test for Android).

I am not really sure if you can actually visually sense a difference in
your examples. Startup time of an application is not just memory
allocation (page zeroing) time. It would be interesting of much of a
difference this actually makes in practice. (e.g., firefox startup time
etc.)

> 
> Virtulization
> =============
> Speed up VM creation and shorten guest boot time, especially for PCI
> SR-IOV device passthrough scenario. Compared with some of the para
> vitalization solutions, it is easy to deploy because it’s transparent
> to guest and can handle DMA properly in BIOS stage, while the para
> virtualization solution can’t handle it well.

What is the "para virtualization" approach you are talking about?

> 
> Improve guest performance when use VIRTIO_BALLOON_F_REPORTING for memory
> overcommit. The VIRTIO_BALLOON_F_REPORTING feature will report guest page
> to the VMM, VMM will unmap the corresponding host page for reclaim,
> when guest allocate a page just reclaimed, host will allocate a new page
> and zero it out for guest, in this case pre zero out free page will help
> to speed up the proccess of fault in and reduce the performance impaction.

Such faults in the VMM are no different to other faults, when first
accessing a page to be populated. Again, I wonder how much of a
difference it actually makes.

> 
> Speed up kernel routine
> =======================
> This can’t be guaranteed because we don’t pre zero out all the free pages,
> but is true for most case. It can help to speed up some important system
> call just like fork, which will allocate zero pages for building page
> table. And speed up the process of page fault, especially for huge page
> fault. The POC of Hugetlb free page pre zero out has been done.

Would be interesting to have an actual example with some numbers.

> 
> Security
> ========
> This is a weak version of "introduce init_on_alloc=1 and init_on_free=1
> boot options", which zero out page in a asynchronous way. For users can't
> tolerate the impaction of 'init_on_alloc=1' or 'init_on_free=1' brings,
> this feauture provide another choice.

"we don’t pre zero out all the free pages" so this is of little actual use.

-- 
Thanks,

David / dhildenb

