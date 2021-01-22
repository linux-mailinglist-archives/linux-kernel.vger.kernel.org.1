Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D57C2FFB22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 04:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbhAVDdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 22:33:47 -0500
Received: from foss.arm.com ([217.140.110.172]:55122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbhAVDdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:33:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6862E11D4;
        Thu, 21 Jan 2021 19:32:39 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 774FC3F68F;
        Thu, 21 Jan 2021 19:32:32 -0800 (PST)
Subject: Re: [PATCH RFC] virtio-mem: check against memhp_get_pluggable_range()
 which memory we can hotplug
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     Oscar Salvador <osalvador@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        teawater <teawaterz@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-5-git-send-email-anshuman.khandual@arm.com>
 <a1644ce0-427f-7a5c-b90a-547e61341a75@arm.com>
 <36a10a6f-a2c7-b108-5054-5e4f3e1a1daf@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <99c20d27-b759-73b3-c8a0-68365a3ef943@arm.com>
Date:   Fri, 22 Jan 2021 09:02:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <36a10a6f-a2c7-b108-5054-5e4f3e1a1daf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 3:27 PM, David Hildenbrand wrote:
> On 18.01.21 14:21, Anshuman Khandual wrote:
>>
>>
>> On 1/18/21 6:43 PM, Anshuman Khandual wrote:
>>> From: David Hildenbrand <david@redhat.com>
>>>
>>> Right now, we only check against MAX_PHYSMEM_BITS - but turns out there
>>> are more restrictions of which memory we can actually hotplug, especially
>>> om arm64 or s390x once we support them: we might receive something like
>>> -E2BIG or -ERANGE from add_memory_driver_managed(), stopping device
>>> operation.
>>>
>>> So, check right when initializing the device which memory we can add,
>>> warning the user. Try only adding actually pluggable ranges: in the worst
>>> case, no memory provided by our device is pluggable.
>>>
>>> In the usual case, we expect all device memory to be pluggable, and in
>>> corner cases only some memory at the end of the device-managed memory
>>> region to not be pluggable.
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Jason Wang <jasowang@redhat.com>
>>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: catalin.marinas@arm.com
>>> Cc: teawater <teawaterz@linux.alibaba.com>
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Cc: hca@linux.ibm.com
>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Heiko Carstens <hca@linux.ibm.com>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>
>> Hello David,
>>
>> As your original patch was in the RFC state, I have just maintained
>> the same here as well. But once you test this patch along with the
>> new series, please do let me know if this needs to be converted to
>> a normal PATCH instead. Thank you.
> 
> Yes, you can drop the RFC part. I assume you'll send another revision,
> I'll do another test there, thanks!

Sure, will drop the RFC in next version.
