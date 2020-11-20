Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7A2BA638
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgKTJbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:31:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727646AbgKTJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605864671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aBIYZe6QvsR3R+sgcDGxOKiaDPY1p+gBWyXVlapmTM=;
        b=XhGLEFw5MXcPbaiNnsbxJC3qVhayRgjkUN6ZQmn9dEl3bluVfo01q2o7alUYTbRv15we9I
        /Hv73L+/ko0BL/qY1aupSk6bye1QlYjLFggL5h3RFGJ4J6KrgWD5S46/wONU7E8b2WS6t+
        5acoCO2IxeszyRfIQyzUnzrs3HI9+qE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-fkKSvjRaPlGNpOkGzmTmJg-1; Fri, 20 Nov 2020 04:31:08 -0500
X-MC-Unique: fkKSvjRaPlGNpOkGzmTmJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8853D8144E1;
        Fri, 20 Nov 2020 09:31:07 +0000 (UTC)
Received: from [10.36.114.78] (ovpn-114-78.ams2.redhat.com [10.36.114.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5993460854;
        Fri, 20 Nov 2020 09:31:06 +0000 (UTC)
Subject: Re: [RFC PATCH 3/3] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201022125835.26396-1-osalvador@suse.de>
 <20201022125835.26396-4-osalvador@suse.de>
 <3cc37927-538e-ae7d-27bc-45aaabe06b3a@redhat.com>
 <20201119104847.GA5281@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ddcb1d70-2e4b-a185-b749-d4f300feec18@redhat.com>
Date:   Fri, 20 Nov 2020 10:31:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201119104847.GA5281@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> -	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
>>> +	move_pfn_range_to_zone(zone, pfn, nr_pages, nr_vmemmap_pages, NULL,
>>> +			       MIGRATE_ISOLATE);
>>
>> As mentioned, I'd suggest properly initializing the memmap here
>>
>> if (nr_vmemmap_pages) {
>> 	move_pfn_range_to_zone(zone, pfn, nr_vmemmap_pages, NULL,
>> 			       MIGRATE_UNMOVABLE);
>> }
>> move_pfn_range_to_zone(zone, valid_start_pfn, valid_nr_pages, NULL,
> 
> Sure, agreed.
> 
>>> +	if (!support_memmap_on_memory(size))
>>> +		mhp_flags &= ~MEMHP_MEMMAP_ON_MEMORY;
>>
>> Callers (e.g., virtio-mem) might rely on this. We should reject this with
>> -EINVAL and provide a way for callers to test whether this flag is possible.
> 
> Uhm, we might want to make "support_memmap_on_memory" public, and
> callers who might want to it use can check its return value?
> Or do you have something else in mind?

Right, a way for callers to check if it's supported. 
"mhp_supports_memmap_on_memory" or sth. like that.

Thanks!

-- 
Thanks,

David / dhildenb

