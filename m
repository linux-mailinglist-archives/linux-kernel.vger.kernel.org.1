Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD92C3F40
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKYLmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:42:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728515AbgKYLmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606304524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kcga+3U3k+ggBjhVVfMJediaLV/QYUipju37iPGkLXg=;
        b=eCAuAmVOS+FlPRhGnNgpX9dTLG81YJPGF80vwQYZT1Z+ZFOW1JY5RZodUk6OWzTCa2Zcxh
        QKLm/5b18Xowjjf2KvCft4+rafp0pTBw27utLieodlf/2r/9dfBXA7fcOYChaV0dZy2V/e
        kTBFRDc+e8UYTP1zjYp7q2EgzW7vgnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-UaTaFx1OOpiQPcHNG11D1g-1; Wed, 25 Nov 2020 06:42:00 -0500
X-MC-Unique: UaTaFx1OOpiQPcHNG11D1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AB0A1E7CE;
        Wed, 25 Nov 2020 11:41:58 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9F415D9C2;
        Wed, 25 Nov 2020 11:41:56 +0000 (UTC)
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
From:   David Hildenbrand <david@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <20201125103933.GM3306@suse.de>
 <5f01bde6-fe31-9b0e-f288-06b82598a8b3@redhat.com>
Organization: Red Hat GmbH
Message-ID: <33612969-92a1-6c49-a2e0-3a95715b1e7f@redhat.com>
Date:   Wed, 25 Nov 2020 12:41:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5f01bde6-fe31-9b0e-f288-06b82598a8b3@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.20 12:04, David Hildenbrand wrote:
> On 25.11.20 11:39, Mel Gorman wrote:
>> On Wed, Nov 25, 2020 at 07:45:30AM +0100, David Hildenbrand wrote:
>>>> Something must have changed more recently than v5.1 that caused the
>>>> zoneid of reserved pages to be wrong, a possible candidate for the
>>>> real would be this change below:
>>>>
>>>> +               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
>>>>
>>>
>>> Before that change, the memmap of memory holes were only zeroed out. So the zones/nid was 0, however, pages were not reserved and had a refcount of zero - resulting in other issues.
>>>
>>> Most pfn walkers shouldn???t mess with reserved pages and simply skip them. That would be the right fix here.
>>>
>>
>> Ordinarily yes, pfn walkers should not care about reserved pages but it's
>> still surprising that the node/zone linkages would be wrong for memory
>> holes. If they are in the middle of a zone, it means that a hole with
>> valid struct pages could be mistaken for overlapping nodes (if the hole
>> was in node 1 for example) or overlapping zones which is just broken.
> 
> I agree within zones - but AFAIU, the issue is reserved memory between
> zones, right?

Double checking, I was confused. This applies also to memory holes
within zones in x86.

-- 
Thanks,

David / dhildenb

