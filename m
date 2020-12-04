Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156782CF389
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgLDSDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:03:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbgLDSDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607104930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+BVWlwmMR3/aIwVc1YDREePfrqw3RI1zvIRL+z1PQU=;
        b=CN/S9OXXEezRQ18LU9n70IbARdk3xJf2pRSuZO+Uiv4mZBTmVe7+rYA8w6uhcrobNCCEDU
        yy+M2dSBcyLIks7FoWNKnXX5REgTQleThlNts6iWr6VQUQ2YfBUADYP5EAKdbDWjj9TK+L
        HmpBNQSyoS8hbdbeGvgI5RhIrI2Tuxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-PzeVPaOdO6GNlahLGsOC3w-1; Fri, 04 Dec 2020 13:02:06 -0500
X-MC-Unique: PzeVPaOdO6GNlahLGsOC3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ADAD1005513;
        Fri,  4 Dec 2020 18:02:03 +0000 (UTC)
Received: from [10.36.112.162] (ovpn-112-162.ams2.redhat.com [10.36.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76B7C5D6A1;
        Fri,  4 Dec 2020 18:01:59 +0000 (UTC)
Subject: Re: [PATCH 0/6] prohibit pinning pages in ZONE_MOVABLE
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        mike.kravetz@oracle.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201204035953.GA17056@js1304-desktop>
 <CA+CK2bCD7XYyJB9TNZZeUMAuntotZopVYNjDXnyVZyzKe2_A1Q@mail.gmail.com>
 <20201204161005.GD5487@ziepe.ca>
 <CA+CK2bCGGoBXg7FbhGMDdWRnePKFgvtsM_PJmA2qtMNsvPMZbg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <593822e5-4e1a-fdca-5500-4138d0f2b728@redhat.com>
Date:   Fri, 4 Dec 2020 19:01:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bCGGoBXg7FbhGMDdWRnePKFgvtsM_PJmA2qtMNsvPMZbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.20 18:50, Pavel Tatashin wrote:
>>> Yes, this indeed could be a problem for some configurations. I will
>>> add your comment to the commit log of one of the patches.
>>
>> It sounds like there is some inherent tension here, breaking THP's
>> when doing pin_user_pages() is a really nasty thing to do. DMA
>> benefits greatly from THP.
>>
>> I know nothing about ZONE_MOVABLE, is this auto-setup or an admin
>> option? If the result of this patch is standard systems can no longer
>> pin > 80% of their memory I have some regression concerns..
> 
> ZONE_MOVABLE can be configured via kernel parameter, or when memory
> nodes are onlined after hot-add; so this is something that admins
> configure. ZONE_MOVABLE is designed to gurantee memory hot-plug
> functionality, and not availability of THP, however, I did not know
> about the use case where some admins might configure ZONE_MOVABLE to
> increase availability of THP because pages are always migratable in
> them. The thing is, if we fragment ZONE_MOVABLE by pinning pages in
> it, the availability of THP also suffers.  We can migrate pages in
> ZONE_NORMAL, just not guaranteed, so we can create THP in ZONE_NORMAL
> as well, which is the usual case.

Right, we should document this at some place to make admins aware of
this. Something like

"Techniques that rely on long-term pinnings of memory (especially, RDMA
and vfio) are fundamentally problematic with ZONE_MOVABLE and,
therefore, memory hotunplug. Pinned pages cannot reside on ZONE_MOVABLE,
to guarantee that memory can still get hotunplugged - be aware that
pinning can fail even if there is plenty of free memory in ZONE_MOVABLE.
In addition, using ZONE_MOVABLE might make page pinning more expensive,
because pages have to be migrated off that zone first."

BTW, you might also want to update the comment for ZONE_MOVABLE in
include/linux/mmzone.h at the end of this series, removing the special
case of pinned pages (1.) and maybe adding what happens when trying to
pin pages on ZONE_MOVABLE.

-- 
Thanks,

David / dhildenb

