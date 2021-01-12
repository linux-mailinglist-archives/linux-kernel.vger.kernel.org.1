Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C316B2F2C58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404467AbhALKLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:11:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391148AbhALKLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610446184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DOMRwNgT9qr+9pqPfBttykBmS2K+2o6KQydrMDGzqpk=;
        b=KQ8uEsYAyvLKrk779W2oHlHXzqcS03NHjwhsgIv+sgRjZn9yjoaFH8uZwqa7CWduXyYsHO
        vcLblHlGzXj/vzeon8gNxbHp5AatkrWYOqjm83Atq+Jne+JDl/G4pOziRuNCBTKrmLYfdu
        Iij4QeEgxfchIVvRRyuh3c/k0tmMlAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-Bi2gpNL4Orq9i6DussAoYA-1; Tue, 12 Jan 2021 05:09:40 -0500
X-MC-Unique: Bi2gpNL4Orq9i6DussAoYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB2C31800D42;
        Tue, 12 Jan 2021 10:09:38 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB9B56A8FD;
        Tue, 12 Jan 2021 10:09:35 +0000 (UTC)
Subject: Re: [PATCH V2 1/3] mm/hotplug: Prevalidate the address range being
 added with platform
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
 <1608218912-28932-2-git-send-email-anshuman.khandual@arm.com>
 <10e733fa-4568-d38f-9b95-2ccc5dc627b8@redhat.com>
 <20210111134303.GA3031@linux> <e2b53f0a-482d-2045-6162-6de2510c9690@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <556a8a62-7bb2-d16b-67ea-57c87c1a6aa7@redhat.com>
Date:   Tue, 12 Jan 2021 11:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <e2b53f0a-482d-2045-6162-6de2510c9690@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.21 04:51, Anshuman Khandual wrote:
> 
> 
> On 1/11/21 7:13 PM, Oscar Salvador wrote:
>> On Mon, Jan 11, 2021 at 11:51:47AM +0100, David Hildenbrand wrote:
>>> AFAIKs, all memhp_get_pluggable_range() users pass "1".
>>>
>>> What about the "add_pages()-only" path?
>>
>> I guess you refer to memremap_pages(), right?
> 
> Right, via pagemap_range().
> 
>> If so, moving the added memhp_range_allowed() check above the if-else might do
>> the trick
>>
> We had that code in the earlier version. But dropped it, as we did
> not want to add any new checks in the generic code. Can add it back
> if that is preferred.

I remember discussing replacing the check in __add_pages() instead. But
I don't really care where the check ends up being. As discussed, at some
point, we should provide versions of add_pages() and arch_add_pages()
that don't immediately end in arch-code.

-- 
Thanks,

David / dhildenb

