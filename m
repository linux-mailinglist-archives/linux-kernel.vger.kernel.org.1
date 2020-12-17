Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3792DCF18
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgLQKHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:07:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726615AbgLQKHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608199569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5vV7dH1SnePNtrGf05LbaOirfK4B0ddR8xhlYZI8Btw=;
        b=VIWA+lVbSGpEOY/oEQ/3S90fVwC3jgF5Y4x5XoI4ZYr9BE8WmrJ54WKAU5sYXDKwuPEpF6
        pf+3snkw/0n4KceZGXpLbuXrMjKdjS+cmOxT25mMngBJ9csA0W/8nqGN2ZjOCOmKZqiHws
        6uNbzUgfsQTeZ5HWjsEWSWGBjmpdmjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Qi5-pcYrOEu36Ur8Ufv81g-1; Thu, 17 Dec 2020 05:06:03 -0500
X-MC-Unique: Qi5-pcYrOEu36Ur8Ufv81g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B381718C89DA;
        Thu, 17 Dec 2020 10:06:01 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E5C571C94;
        Thu, 17 Dec 2020 10:05:58 +0000 (UTC)
Subject: Re: [PATCH v2] mm/mmap: Don't unlock VMAs in remap_file_pages()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
References: <20201215155441.1497432-1-Liam.Howlett@Oracle.com>
 <413ffbe0-959d-c2ad-95d8-80104adac089@redhat.com>
 <20201216204252.vh3zadk4ghbzufqz@revolver>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <91483d71-a12d-1e52-e9c9-135404c5219f@redhat.com>
Date:   Thu, 17 Dec 2020 11:05:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201216204252.vh3zadk4ghbzufqz@revolver>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.12.20 21:42, Liam R. Howlett wrote:
> 
> Thank you for looking at this.  I appreciate the scrutiny.
> 
> * David Hildenbrand <david@redhat.com> [201216 09:58]:
>> On 15.12.20 16:54, Liam R. Howlett wrote:
>>> do_mmap() will unlock the necessary VMAs.  There is also a bug in the
>>> loop which will evaluate as false and not unlock any VMAs anyways.
>>
>> If there is a BUG, do we have a Fixes: tag? Also
> 
> The bug would never show up as it is masked by do_mmap() unlocking the
> necessary range.  Although there is a bug in this code, the code does
> not cause an issue as it won't execute so should I have a Fixes tag?
> The code works and what I've done is remove a chunk of code that never
> runs.
> 

Ok I see. The use of "bug" here is misleading. The unnecessary code is
simply not doing what it promised to do without doing any harm.

>>
>> 1. Can we fix the bug separately first?
> 
> I think it is safer to remove unexecuted code than enable it and then
> remove it.

I agree, as it is not actually a bug.

> 
>> 2. Can we have a better description on what the bug actually is
>> "evaluate as false"? What is the result of the bug?
> 
> The bug is in the for loop test expression that I removed in the patch.
> Here is the long explaination of why the loop has never run.
> 
> 
> Line 2982: if (start + size <= start
> Line 2983: 	goto out;
> 
> size is positive.
> 
> Line 2992: vma = find_vma(mm, start);
> Look up the first VMA which satisfies start < vm_end
> 
> Line 2997: if (start < vma->vm_start)
> Line 2998: 	goto out;
> 
> So now vma->vm_start >= start.
> If vma->vm_start > start, then there are no VMAs in that area, otherwise
> it would have been returned by find_vma().
> So we can say that vma->vm_start == start.
> 
> Line 3033: for (tmp = vma; tmp->vm_start >= start + size;
> Line 3034:                 tmp = tmp->vm_next) {
> This is the for loop with the error in the test expression.
> 
> tmp->vm_start == start which cannot be >= (start + size).
> 
> I believe the intention was to loop through vmas in the range of start
> to (start + size) and unlock them.
> 
> 
> The result of the bug is no VMA is unlocked in this fuction.  But that
> doesn't matter as they are unlocked later in the call chain - which is
> why this code works as intended.
> 

Thanks for clarifying!

> 
>>
>> CCing some people that might know if this is actually a sane change.
>> Skimming over do_mmap(), it's not immediately clear to me that
>> "do_mmap() will unlock the necessary VMAs".
> 
> Ah, yes.  That is understandable.
> 
> do_mmap() L1583 -> mmap_region() L1752 -> munmap_vma_range() ->
> do_munmap() -> __do_munmap() loop at 2891 to unlock the range.
> 
> Would you like me to add this call chain to the changelog?

Yes please, in a simplified form.

I suggest something like the following patch description:

"do_mmap(MAP_FIXED) will already unlock pages via munmap_vma_range(). We
can remove the superfluous manual unlocking in remap_file_pages().

Note that the manual unlocking is even incorrect, as it might miss
unlocking some pages - no harm done.
"

-- 
Thanks,

David / dhildenb

