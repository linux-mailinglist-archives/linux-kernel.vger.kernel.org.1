Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4822FFE50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbhAVIhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbhAVIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611304500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVitVAJl3hHbeQ/YCugHZFgFD5Qd1FjfqKbNs20MdNY=;
        b=YjzGCtrfMw5J0X9z3W/PIZI4GqvzWx5OgncvFueySdxyF2GDL1pbT3+G9sJzJbEXAB6neH
        6DwbJYBM8SVp3GobgBKx18b5jYdDn2wD9XcBj9sm/Vs5jwozyMT3CZVjFiYIuOi6b5Byoo
        IppkYEdp2QA1Hlo6gJ3HsnxIy6sbbhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-4xCFFHO6PICB43D3JhZ8xQ-1; Fri, 22 Jan 2021 03:34:55 -0500
X-MC-Unique: 4xCFFHO6PICB43D3JhZ8xQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88203800D55;
        Fri, 22 Jan 2021 08:34:53 +0000 (UTC)
Received: from [10.36.114.142] (ovpn-114-142.ams2.redhat.com [10.36.114.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4A8E5D9E8;
        Fri, 22 Jan 2021 08:34:50 +0000 (UTC)
Subject: Re: [PATCH V3 0/3] mm/memory_hotplug: Pre-validate the address range
 with platform
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <d57036a1-de12-2d32-be65-daaa3dc5b772@redhat.com>
 <20210119134016.GA23408@linux> <8df4e1e1-1ddd-398e-c9a6-17a67d8a95bc@arm.com>
 <1c8c204d-1f96-d3aa-1b7b-ec4cc7b1b79b@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c37de2d0-28a1-4f7d-f944-cfd7d81c334d@redhat.com>
Date:   Fri, 22 Jan 2021 09:34:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1c8c204d-1f96-d3aa-1b7b-ec4cc7b1b79b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.21 07:04, Anshuman Khandual wrote:
> 
> On 1/20/21 2:07 PM, Anshuman Khandual wrote:
>>
>>
>> On 1/19/21 7:10 PM, Oscar Salvador wrote:
>>> On Tue, Jan 19, 2021 at 02:33:03PM +0100, David Hildenbrand wrote:
>>>> Minor thing, we should make up our mind if we want to call stuff
>>>> internally "memhp_" or "mhp". I prefer the latter, because it is shorter.
>>>
>>> I would rather use the latter as well. I used that in [1].
>>
>> Okay, will change all that is 'memhp' as 'mhp' instead.
>>
>>> MEMHP_MERGE_RESOURCE should be renamed if we agree on that.
>>>
>>> [1] https://patchwork.kernel.org/project/linux-mm/cover/20201217130758.11565-1-osalvador@suse.de/
>>>
> 
> While replacing 'memhp' as 'mhp' in this series, noticed there are
> some more 'memhp' scattered around the code from earlier. A mix of
> both 'memhp' and 'mhp' might not be a good idea. Hence should we
> just change these remaining 'memhp' as 'mhp' as well and possibly
> also MEMHP_MERGE_RESOURCE as suggested earlier, in a subsequent

As mentioned in another thread to Oscar, I already have a cleanup patch
for that one lying around, part of a bigger series. Might just send that
one out separately earlier.

> clean up patch ? Would there be a problem with memhp_default_state
> being a command line parameter ?

Yes, that one we should not change, to not break existing cmdlines
without good reason. We could change the
memhp_default_online_type/memhp_online_type_from_str/... thingies, though.

Feel free to send a patch, thanks!

-- 
Thanks,

David / dhildenb

