Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6163E2E09E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 13:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgLVL7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 06:59:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbgLVL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 06:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608638288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2qf5gIhcMVQKS3hR+V8X3H/dCp3GvNlzpFYpp+NKNs=;
        b=KWsIq3ETq7JinqnJVkQF2kCdpiMoD5BIp96GJ43HAkL+cWDAG+lYdbpEp52rgDjcK2YezO
        Qce44mlBM6hqpOF3J5RDxI/v51Z6Qxmiizp3WVxQwYGAVDdDl0w5wgsgqt/RL0/JVKMqlL
        952hUBnCyhyAdm3vK2Ws9pZUIGOLV7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-gXb2fMU9PgO7SaOF_AZm0g-1; Tue, 22 Dec 2020 06:58:04 -0500
X-MC-Unique: gXb2fMU9PgO7SaOF_AZm0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B30F1084C89;
        Tue, 22 Dec 2020 11:58:02 +0000 (UTC)
Received: from [10.36.113.220] (ovpn-113-220.ams2.redhat.com [10.36.113.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FDC75E1B4;
        Tue, 22 Dec 2020 11:57:55 +0000 (UTC)
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To:     Liang Li <liliang324@gmail.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
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
 <7bf0e895-52d6-9e2d-294b-980c33cf08e4@redhat.com>
 <CA+2MQi89v=DZJZ7b-QaMsU2f42j4SRW47XcZvLtBj10YeqRGgQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <840ff69d-20d5-970a-1635-298000196f3e@redhat.com>
Date:   Tue, 22 Dec 2020 12:57:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+2MQi89v=DZJZ7b-QaMsU2f42j4SRW47XcZvLtBj10YeqRGgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>>>
>>> Virtulization
>>> =============
>>> Speed up VM creation and shorten guest boot time, especially for PCI
>>> SR-IOV device passthrough scenario. Compared with some of the para
>>> vitalization solutions, it is easy to deploy because it’s transparent
>>> to guest and can handle DMA properly in BIOS stage, while the para
>>> virtualization solution can’t handle it well.
>>
>> What is the "para virtualization" approach you are talking about?
> 
> I refer two topic in the KVM forum 2020, the doc can give more details :
> https://static.sched.com/hosted_files/kvmforum2020/48/coIOMMU.pdf
> https://static.sched.com/hosted_files/kvmforum2020/51/The%20Practice%20Method%20to%20Speed%20Up%2010x%20Boot-up%20Time%20for%20Guest%20in%20Alibaba%20Cloud.pdf
> 
> and the flowing link is mine:
> https://static.sched.com/hosted_files/kvmforum2020/90/Speed%20Up%20Creation%20of%20a%20VM%20With%20Passthrough%20GPU.pdf

Thanks for the pointers! I actually did watch your presentation.

>>
>>>
>>> Improve guest performance when use VIRTIO_BALLOON_F_REPORTING for memory
>>> overcommit. The VIRTIO_BALLOON_F_REPORTING feature will report guest page
>>> to the VMM, VMM will unmap the corresponding host page for reclaim,
>>> when guest allocate a page just reclaimed, host will allocate a new page
>>> and zero it out for guest, in this case pre zero out free page will help
>>> to speed up the proccess of fault in and reduce the performance impaction.
>>
>> Such faults in the VMM are no different to other faults, when first
>> accessing a page to be populated. Again, I wonder how much of a
>> difference it actually makes.
>>
> 
> I am not just referring to faults in the VMM, I mean the whole process
> that handles guest page faults.
> without VIRTIO_BALLOON_F_REPORTING, pages used by guests will be zero
> out only once by host. With VIRTIO_BALLOON_F_REPORTING, free pages are
> reclaimed by the host and may return to the host buddy
> free list. When the pages are given back to the guest, the host kernel
> needs to zero out it again. It means
> with VIRTIO_BALLOON_F_REPORTING, guest memory performance will be
> degraded for frequently
> zero out operation on host side. The performance degradation will be
> obvious for huge page case. Free
> page pre zero out can help to make guest memory performance almost the
> same as without
> VIRTIO_BALLOON_F_REPORTING.

Yes, what I am saying is that this fault handling is no different to
ordinary faults when accessing a virtual memory location the first time
and populating a page. The only difference is that it happens
continuously, not only the first time we touch a page.

And we might be able to improve handling in the hypervisor in the
future. We have been discussing using MADV_FREE instead of MADV_DONTNEED
in QEMU for handling free page reporting. Then, guest reported pages
will only get reclaimed by the hypervisor when there is actual memory
pressure in the hypervisor (e.g., when about to swap). And zeroing a
page is an obvious improvement over going to swap. The price for zeroing
pages has to be paid at one point.

Also note that we've been discussing cache-related things already. If
you zero out before giving the page to the guest, the page will already
be in the cache - where the guest directly wants to access it.

[...]

>>>
>>> Security
>>> ========
>>> This is a weak version of "introduce init_on_alloc=1 and init_on_free=1
>>> boot options", which zero out page in a asynchronous way. For users can't
>>> tolerate the impaction of 'init_on_alloc=1' or 'init_on_free=1' brings,
>>> this feauture provide another choice.
>> "we don’t pre zero out all the free pages" so this is of little actual use.
> 
> OK. It seems none of the reasons listed above is strong enough for

I was rather saying that for security it's of little use IMHO.
Application/VM start up time might be improved by using huge pages (and
pre-zeroing these). Free page reporting might be improved by using
MADV_FREE instead of MADV_DONTNEED in the hypervisor.

> this feature, above all of them, which one is likely to become the
> most strong one?  From the implementation, you will find it is
> configurable, users don't want to use it can turn it off.  This is not
> an option?

Well, we have to maintain the feature and sacrifice a page flag. For
example, do we expect someone explicitly enabling the feature just to
speed up startup time of an app that consumes a lot of memory? I highly
doubt it.

I'd love to hear opinions of other people. (a lot of people are offline
until beginning of January, including, well, actually me :) )

-- 
Thanks,

David / dhildenb

