Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E61298855
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771764AbgJZIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1771757AbgJZIbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603701100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HjcMnaBG2Hq0ZrxFvhtUnCFEdIr2XRoW6RllRpXIEpg=;
        b=QzpHLHQDoZfxIA4gfJ3c3C0eWImZHApU2qNI9pwKombvPifn0L/0/xZurg6R1WXkapWUaa
        03qQ39kHC74BZFqUsndn2Pz27yPnaFs6zbZL2Ss53OL9qv0hHxS9i0P7Vm8ZEKkaADeaNI
        /vrt4Gb/0NwPm2mW1t+yCY5NNeEuuFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-rhdfStStNCy25j5SCPnWLw-1; Mon, 26 Oct 2020 04:31:35 -0400
X-MC-Unique: rhdfStStNCy25j5SCPnWLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB3861009E3E;
        Mon, 26 Oct 2020 08:31:31 +0000 (UTC)
Received: from [10.36.113.62] (ovpn-113-62.ams2.redhat.com [10.36.113.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C48755772;
        Mon, 26 Oct 2020 08:31:25 +0000 (UTC)
Subject: Re: [mm/page_alloc] 7fef431be9: vm-scalability.throughput 87.8%
 improvement
To:     Axel Rasmussen <axelrasmussen@google.com>,
        David Rientjes <rientjes@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Kevin Ko <kevko@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
References: <20201021092417.GP11647@shao2-debian>
 <alpine.DEB.2.23.453.2010231226310.1686635@chino.kir.corp.google.com>
 <CAJHvVcicEcMw=0SL2cF1RR7-E_5RRfXa+PnChob7K7ujL4Y_6w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <cb2f9d93-2d4e-e1ce-6d9a-0ff0e9ce400e@redhat.com>
Date:   Mon, 26 Oct 2020 09:31:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAJHvVcicEcMw=0SL2cF1RR7-E_5RRfXa+PnChob7K7ujL4Y_6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.20 21:44, Axel Rasmussen wrote:
> On Fri, Oct 23, 2020 at 12:29 PM David Rientjes <rientjes@google.com> wrote:
>>
>> On Wed, 21 Oct 2020, kernel test robot wrote:
>>
>>> Greeting,
>>>
>>> FYI, we noticed a 87.8% improvement of vm-scalability.throughput due to commit:
>>>
>>>
>>> commit: 7fef431be9c9ac255838a9578331567b9dba4477 ("mm/page_alloc: place pages to tail in __free_pages_core()")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>>
>>> in testcase: vm-scalability
>>> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
>>> with following parameters:
>>>
>>>       runtime: 300s
>>>       size: 512G
>>>       test: anon-wx-rand-mt
>>>       cpufreq_governor: performance
>>>       ucode: 0x5002f01
>>>
>>> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
>>> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
>>>
>>
>> I'm curious why we are not able to reproduce this improvement on Skylake
>> and actually see a slight performance degradation, at least for
>> 300s_128G_truncate_throughput.
>>
>> Axel Rasmussen <axelrasmussen@google.com> can provide more details on our
>> results.
> 
> Right, our results show a slight regression on a Skylake machine [1],
> and a slight performance increase on a Rome machine [2]. For these
> tests, I used Linus' v5.9 tag as a baseline, and then applied this
> patchset onto that tag as a test kernel (the patches applied cleanly
> besides one comment, I didn't have to do any code fixups). This is
> running the same anon-wx-rand-mt test defined in the upstream
> lkp-tests job file:
> https://github.com/intel/lkp-tests/blob/master/jobs/vm-scalability.yaml

Hi,

looking at the yaml, am I right that each test is run after a fresh boot?

As I already replied to David, this patch merely changes the initial
order of the freelists. The general end result is that lower memory
addresses will be allocated before higher memory addresses will be
allocated - within a zone, the first time memory is getting allocated.
Before, it was the other way around. Once a system ran for some time,
freelists are randomized.

There might be benchmarks/systems where this initial system state might
now be better suited - or worse. It doesn't really tell you that core-mm
is behaving better/worse now - it merely means that the initial system
state under which the benchmark was started affected the benchmark.

Looks like so far there is one benchmark+system where it's really
beneficial, there is one benchmark+system where it's slightly
beneficial, and one benchmark+system where there is a slight regression.


Something like the following would revert to the previous behavior:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 23f5066bd4a5..fac82420cc3d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1553,7 +1553,9 @@ void __free_pages_core(struct page *page, unsigned
int order)
         * Bypass PCP and place fresh pages right to the tail, primarily
         * relevant for memory onlining.
         */
-       __free_pages_ok(page, order, FPI_TO_TAIL);
+       __free_pages_ok(page, order,
+                       system_state < SYSTEM_RUNNING ? FPI_NONE :
+                                                       FPI_TO_TAIL);
 }

 #ifdef CONFIG_NEED_MULTIPLE_NODES


(Or better, passing the expected behavior via MEMINIT_EARLY/... to
__free_pages_core().)


But then, I am not convinced we should perform that change: having a
clean (initial) state might be true for these benchmarks, but it's far
from reality. The change in numbers doesn't show you that core-mm is
operating better/worse, just that the baseline for you tests changed due
to a changed initial system state.

Thanks!

-- 
Thanks,

David / dhildenb

