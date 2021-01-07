Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024132ECD91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbhAGKL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbhAGKL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610014231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIyRMBmfpZSOyDFJxrKDFgdNsAHsXw3CVOoTMrY/anI=;
        b=UQbGgrnOZyqDOB/oqeiPJH9ONJ4LHMQf0JytCNHdXKInaP8c5fuY7d93mobJzho3wJ/Fgb
        PgjxJTS6qD9S3cC/9jnTckLo0rSV4/JlBFnrMBbgyba8VQybIpoGFmOfSrX8knREoHoNWd
        zV7wJsHbIzfEMw+7bFY2p3NugIQGTUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-nvTtQH3bMQqFqMuE_rcvzw-1; Thu, 07 Jan 2021 05:10:27 -0500
X-MC-Unique: nvTtQH3bMQqFqMuE_rcvzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9382B101AFB0;
        Thu,  7 Jan 2021 10:10:24 +0000 (UTC)
Received: from [10.36.114.161] (ovpn-114-161.ams2.redhat.com [10.36.114.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92F805D9D7;
        Thu,  7 Jan 2021 10:10:22 +0000 (UTC)
Subject: Re: [External] Re: [PATCH v2 0/6] Fix some bugs about HugeTLB code
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <7b44eddc-cbae-92b6-5ac7-765cad2a6326@redhat.com>
 <CAMZfGtUcGLZjesq4ztqHXG2PekmJ2q60s3ymjBRmiJ141syK3A@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7971c96c-6b96-2dca-b9d9-d3828b117e66@redhat.com>
Date:   Thu, 7 Jan 2021 11:10:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtUcGLZjesq4ztqHXG2PekmJ2q60s3ymjBRmiJ141syK3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.01.21 10:40, Muchun Song wrote:
> On Thu, Jan 7, 2021 at 5:30 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 06.01.21 09:47, Muchun Song wrote:
>>> This patch series aims to fix some bugs and add some improvements.
>>>
>>> Changelog since v1 -> v2:
>>>   - Export set_page_huge_active() in patch #2 to fix.
>>>   - Using head[3].mapping to indicate the page is freed in patch #3.
>>>   - Flush @free_hpage_work in patch #4.
>>>
>>> Muchun Song (6):
>>>   mm: migrate: do not migrate HugeTLB page whose refcount is one
>>>   mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
>>>   mm: hugetlb: fix a race between freeing and dissolving the page
>>>   mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
>>>   mm: hugetlb: fix a race between isolating and freeing page
>>>   mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active
>>>
>>>  fs/hugetlbfs/inode.c    |  3 ++-
>>>  include/linux/hugetlb.h |  2 ++
>>>  mm/hugetlb.c            | 69 +++++++++++++++++++++++++++++++++++++++++++------
>>>  mm/migrate.c            |  6 +++++
>>>  4 files changed, 71 insertions(+), 9 deletions(-)
>>>
>>
>> Repeating my question regarding ccing stable on selected fixes.
>>
> 
> Just add a CC tag in the commit log of the fix patches? Right?
> Sorry, I'm a novice about this. Thanks.

Sure, here is some information:

https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html

Applicable patches should be moved to the beginning of the series.

Add "Cc: stable@vger.kernel.org" similar to "Fixes:" to the respective
patches. In the ideal case, indicate the applicable earliest stable
release where it applies.

E.g., take a look at (random commit)

commit 20b329129009caf1c646152abe09b697227e1c37
Author: Bob Peterson <rpeterso@redhat.com>
Date:   Wed Nov 18 08:54:31 2020 -0500

    gfs2: Fix regression in freeze_go_sync
...
    Fixes: 541656d3a513 ("gfs2: freeze should work on read-only mounts")
    Cc: stable@vger.kernel.org # v5.8+
...


Consequently, actually cc when sending out these patches (e.g., let "git
send-email" do it automatically).

-- 
Thanks,

David / dhildenb

