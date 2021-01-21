Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5576B2FE6F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbhAUJ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728834AbhAUJ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611223066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjsx8NNg7QU5UqLR81grwFscZo5YAJDDorGAAazwLP4=;
        b=ShddcMC+V0whUSJwY8/uedipZO4iFTAaoKY9908dJZVNgWXDh2flcJen2VmexRwXlcRN8z
        wm29mN6dCYctzCBa1+DRISKarR/eDLOv83WorRptQ9vN/3bCKKgzVQATuqzJ+Bks5CKYUX
        41pHa5PpXjLff9huhMTKEs1gU4+DF4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-qVKfsRoLMJKyWRy80DNzPw-1; Thu, 21 Jan 2021 04:57:44 -0500
X-MC-Unique: qVKfsRoLMJKyWRy80DNzPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14B9A107ACF6;
        Thu, 21 Jan 2021 09:57:41 +0000 (UTC)
Received: from [10.36.115.70] (ovpn-115-70.ams2.redhat.com [10.36.115.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FB0319D9B;
        Thu, 21 Jan 2021 09:57:32 +0000 (UTC)
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
Message-ID: <36a10a6f-a2c7-b108-5054-5e4f3e1a1daf@redhat.com>
Date:   Thu, 21 Jan 2021 10:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <a1644ce0-427f-7a5c-b90a-547e61341a75@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Yes, you can drop the RFC part. I assume you'll send another revision,
I'll do another test there, thanks!


-- 
Thanks,

David / dhildenb

