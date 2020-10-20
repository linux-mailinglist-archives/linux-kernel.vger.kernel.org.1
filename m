Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAAD293D73
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407531AbgJTNjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407502AbgJTNjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603201143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VQMvJLX2BrM7Ofm/MK81zOtT07moMREVSxUbza9t1T8=;
        b=ghVLRWnLOjT20XaOonPD5lCDxlnsLmVuBUg8yp7Qw/lsBEO4+4gYyIKyTwZUNM387r/BU7
        6idE7KW5If9QWNBhvA1t6d3bkRlKGkS3lFvftaI9tr9CMgc6ytJ+ScYJ+Q3HMKMGaSHcq1
        16V02It6vu5OWT57j/K13doPscbq6e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-yeLC_vgmOsOZJqBBgaZjPg-1; Tue, 20 Oct 2020 09:38:59 -0400
X-MC-Unique: yeLC_vgmOsOZJqBBgaZjPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4473A1006C8A;
        Tue, 20 Oct 2020 13:38:58 +0000 (UTC)
Received: from [10.36.114.141] (ovpn-114-141.ams2.redhat.com [10.36.114.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 841FA5C1C2;
        Tue, 20 Oct 2020 13:38:53 +0000 (UTC)
Subject: Re: cgroup and FALLOC_FL_PUNCH_HOLE: WARNING: CPU: 13 PID: 2438 at
 mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Privoznik <mprivozn@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <c1ea7548-622c-eda7-66f4-e4ae5b6ee8fc@redhat.com>
 <563d1eef-b780-835a-ebf0-88ae111b20c2@redhat.com>
 <CAHS8izPEHZunoeXYS5ONfRoSRMpC7DQwtpjJ8g4nXiddTfNoaA@mail.gmail.com>
 <65a1946f-dbf9-5767-5b51-9c1b786051d1@redhat.com>
 <5f196069-8b98-0ad3-55e8-19af03d715cd@oracle.com>
 <c78634ee-0d6f-c98c-3c2a-8cb500c0ae47@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b24380ad-b87c-a3a1-d25e-ee30c10ed0d2@redhat.com>
Date:   Tue, 20 Oct 2020 15:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <c78634ee-0d6f-c98c-3c2a-8cb500c0ae47@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.20 01:14, Mike Kravetz wrote:
> On 10/14/20 11:31 AM, Mike Kravetz wrote:
>> On 10/14/20 11:18 AM, David Hildenbrand wrote:
>>
>> FWIW - I ran libhugetlbfs tests which do a bunch of hole punching
>> with (and without) hugetlb controller enabled and did not see this issue.
>>
> 
> I took a closer look after running just the fallocate_stress test
> in libhugetlbfs.  Here are the cgroup counter values:
> 
> hugetlb.2MB.failcnt 0
> hugetlb.2MB.limit_in_bytes 9223372036854771712
> hugetlb.2MB.max_usage_in_bytes 209715200
> hugetlb.2MB.rsvd.failcnt 0
> hugetlb.2MB.rsvd.limit_in_bytes 9223372036854771712
> hugetlb.2MB.rsvd.max_usage_in_bytes 601882624
> hugetlb.2MB.rsvd.usage_in_bytes 392167424
> hugetlb.2MB.usage_in_bytes 0
> 
> We did not hit the WARN_ON_ONCE(), but the 'rsvd.usage_in_bytes' value
> is not correct in that it should be zero.   No huge page reservations
> remain after the test.
> 
> HugePages_Total:    1024
> HugePages_Free:     1024
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> Hugetlb:         2097152 kB
> 
> To try and better understand the reservation cgroup controller, I addded
> a few printks to the code.  While running fallocate_stress with the
> printks, I can consistently hit the WARN_ON_ONCE() due to the counter
> going negative.  Here are the cgroup counter values after such a run:
> 
> hugetlb.2MB.failcnt 0
> hugetlb.2MB.limit_in_bytes 9223372036854771712
> hugetlb.2MB.max_usage_in_bytes 209715200
> hugetlb.2MB.rsvd.failcnt 3
> hugetlb.2MB.rsvd.limit_in_bytes 9223372036854771712
> hugetlb.2MB.rsvd.max_usage_in_bytes 251658240
> hugetlb.2MB.rsvd.usage_in_bytes 18446744073487253504
> hugetlb.2MB.usage_in_bytes 0
> 
> Again, no reserved pages after the test.
> 
> HugePages_Total:    1024
> HugePages_Free:     1024
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> Hugetlb:         2097152 kB
> 
> I have some basic hugetlb hole punch functionality tests.  Running
> these on the kernel with added printk's does not cause any issues.
> In order to reproduce, I need to run fallocate_stress test which
> will cause hole punch to race with page fault.  Best guess at this
> time is that some of the error/race detection reservation back out
> code is not properly dealing with cgroup accounting.
> 
> I'll take a look at this as well.
> 

I'm bisecting the warning right now. Looks like it was introduced in v5.7.

-- 
Thanks,

David / dhildenb

