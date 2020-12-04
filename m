Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE92CF2E6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgLDRO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgLDRO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607101980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nag/x65iAPAl/1Alf3Nf9G48tZh8GI4qc8JEI5vv/wk=;
        b=eCRvq9VvhmKn/IDNz1UTyjX/PJQeFqPKiarAst/khoc8FW7PVF3V28VV/FRzr0ta08dOSh
        DkkS43cANssQVhrP5WHo1YeSa7CO4mByEkBR54blZTO4TkLIBo84OgjtOGpnRoluwfkV9d
        hStCmdChocSDIgQkcRh8Hvr8phF+msw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-oCOkwryzMNixMwsWKjQ0Hw-1; Fri, 04 Dec 2020 12:12:58 -0500
X-MC-Unique: oCOkwryzMNixMwsWKjQ0Hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1939AC7401;
        Fri,  4 Dec 2020 17:12:57 +0000 (UTC)
Received: from [10.36.112.162] (ovpn-112-162.ams2.redhat.com [10.36.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7CA310023AE;
        Fri,  4 Dec 2020 17:12:55 +0000 (UTC)
Subject: Re: [External] Re: [PATCH v2] mm/page_isolation: do not isolate the
 max order page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20201203162237.21885-1-songmuchun@bytedance.com>
 <46fcf0c1-7c38-723b-8905-953d72f1d6bc@redhat.com>
 <CAMZfGtVdFtLB8f2uDfJ1H-YG4CsJ+RxxFbAWzePDnqBB1MU0ig@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <49b09de4-4b21-e6a7-0730-e125fcb398b3@redhat.com>
Date:   Fri, 4 Dec 2020 18:12:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVdFtLB8f2uDfJ1H-YG4CsJ+RxxFbAWzePDnqBB1MU0ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.20 17:12, Muchun Song wrote:
> On Fri, Dec 4, 2020 at 12:28 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 03.12.20 17:22, Muchun Song wrote:
>>> The max order page has no buddy page and never merge to other order.
>>> So isolating and then freeing it is pointless. And if order == MAX_ORDER
>>> - 1, then the buddy can actually be a !pfn_valid() in some corner case?
>>> pfn_valid_within(buddy_pfn) that follows would only catch it on archs
>>> with holes in zone. Then is_migrate_isolate_page(buddy) might access an
>>> invalid buddy. So this is also a bug fix.
>>>
>>> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
>>
>> As just replied to v1, I don't think this is required and the patch
> 
> You mean we should remove the Fixes tag? Thanks.

As discussed in v1, I don't think we really have systems where this
applies, but could be in corner cases on MIPS or with FLATMEM. Let's
just leave it like that. :)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

