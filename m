Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF302FB86F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392513AbhASMjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391227AbhASM37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611059286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AhjCwJFmaF4VoVFL0RJQTcNJ5s76fuD8bDbj/NSCKEs=;
        b=GySlUBP0nd2oIyaQptUylej2vKUSZD+HBOt6OnR8AiPgbeGiX4OXq6r1KJdyJZ41UYPOVA
        f8IE+wLeXrOHiK0cgsoX3IAMYUpdsqf5PXh7bRCJNKv4qe0Fl7/PYIwwEo9X0i38l8Yvsj
        xHH3pxQHjh5am+nN0BaaTn31OtQ5lic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-nrkVVke_PFu7qpYui4RBcQ-1; Tue, 19 Jan 2021 07:28:04 -0500
X-MC-Unique: nrkVVke_PFu7qpYui4RBcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7B5B10054FF;
        Tue, 19 Jan 2021 12:28:01 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DE255D9F8;
        Tue, 19 Jan 2021 12:27:53 +0000 (UTC)
Subject: Re: [PATCH RFC] virtio-mem: check against memhp_get_pluggable_range()
 which memory we can hotplug
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <630a8785-222d-26ed-a57a-ac5b58d7a04d@redhat.com>
Date:   Tue, 19 Jan 2021 13:27:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <a1644ce0-427f-7a5c-b90a-547e61341a75@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.21 14:21, Anshuman Khandual wrote:
> 
> 
> On 1/18/21 6:43 PM, Anshuman Khandual wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> Right now, we only check against MAX_PHYSMEM_BITS - but turns out there
>> are more restrictions of which memory we can actually hotplug, especially
>> om arm64 or s390x once we support them: we might receive something like
>> -E2BIG or -ERANGE from add_memory_driver_managed(), stopping device
>> operation.
>>
>> So, check right when initializing the device which memory we can add,
>> warning the user. Try only adding actually pluggable ranges: in the worst
>> case, no memory provided by our device is pluggable.
>>
>> In the usual case, we expect all device memory to be pluggable, and in
>> corner cases only some memory at the end of the device-managed memory
>> region to not be pluggable.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: catalin.marinas@arm.com
>> Cc: teawater <teawaterz@linux.alibaba.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: hca@linux.ibm.com
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Hello David,
> 
> As your original patch was in the RFC state, I have just maintained
> the same here as well. But once you test this patch along with the
> new series, please do let me know if this needs to be converted to
> a normal PATCH instead. Thank you.

I'll give it a churn on x86-64, where not that much should change. It
will be interesting to test with arm64 in such corner cases in the future.

Thanks

-- 
Thanks,

David / dhildenb

