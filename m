Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B906C29E4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbgJ2HtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731776AbgJ2HtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603957756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLhofHK1Sb/YOJxGC+CQPMO1TDqN1agIRTokGdH7Zn4=;
        b=VjV4I+bu76VmeNEyWXiI5ir1SKtpqMaZ3Rydq1wei2uzWmi0kX5rfEtgJi0k+HHWBbJak5
        JrmoyDhAfGKANxjD50Z7ufZ56F9PoCC4bRKKxjt1uiTtZeluPjAbJrFrz1HN2nVXU/UqZ/
        VL9PIZswkIBqlQRqUJxoKkdLvVqVaZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-BvaEgVzcP1aW1CB9H7UtOw-1; Thu, 29 Oct 2020 03:49:14 -0400
X-MC-Unique: BvaEgVzcP1aW1CB9H7UtOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1639D803F51;
        Thu, 29 Oct 2020 07:49:13 +0000 (UTC)
Received: from [10.36.112.181] (ovpn-112-181.ams2.redhat.com [10.36.112.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7132362A0B;
        Thu, 29 Oct 2020 07:49:11 +0000 (UTC)
Subject: Re: [RFC PATCH 0/3] Allocate memmap from hotadded memory (per device)
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201022125835.26396-1-osalvador@suse.de>
 <3c18e078-25df-3fd4-9988-1b7677d8e05f@redhat.com>
 <20201027154031.GA11489@linux>
 <daedbc08-7275-40ad-0d07-007ef89ca25f@redhat.com>
 <20201027155851.GA11785@linux>
 <259889fb-f01b-9537-7948-f1a75a372617@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <cce0ad6f-8078-b486-62ad-b75269fd734e@redhat.com>
Date:   Thu, 29 Oct 2020 08:49:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <259889fb-f01b-9537-7948-f1a75a372617@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.10.20 19:47, Mike Kravetz wrote:
> On 10/27/20 8:58 AM, Oscar Salvador wrote:
>> On Tue, Oct 27, 2020 at 04:44:33PM +0100, David Hildenbrand wrote:
>>> I'm planning on looking into patch #2/3 later this or next week (this week
>>> is open source summit / KVM Forum).
>>
>> Sure, aprecciated the time ;-)
>>
>>>
>>> One thing to look into right now is how to make this fly this with vmemmap
>>> optimizations for hugetlb pages.
>>>
>>> https://lkml.kernel.org/r/20201026145114.59424-1-songmuchun@bytedance.com
>>
>> I was about to have a look at that series eitherway, but good you mentioned.
>>
> 
> More eyes on that series would be appreciated.
> 
> That series will dynamically free and allocate memmap pages as hugetlb
> pages are allocated or freed.  I haven't looked through this series, but
> my first thought is that we would need to ensure those allocs/frees are
> directed to the device.  Not sure if there are interfaces for that.

Directing to the device might be part of the solution, but does not have 
to be. You really want to free the pages to the OS in the end, otherwise 
you lose the whole benefit of the vmemmap optimization.

You would want to actually free the pages (making sure whatever 
generic_online_page() does was done to these special vmemmap pages). But 
then, you cannot simply skip all X first pages of a memory block when 
offlining, you can only skip the once that are still vmemmap pages 
(e.g., marked via page type), and have to isolate/migrate off the 
no-longer vmemmap pages.

-- 
Thanks,

David / dhildenb

