Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891582F39D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406659AbhALTPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:15:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:62358 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbhALTPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:15:32 -0500
IronPort-SDR: jDMAi8MhEqPfKOQ+0Sax510H3MARt7WIl8XAjW/k8W8/B8I+K+zPYAv/e0f9g7ZIPCFLVP/zxQ
 A16Tv2x4WMFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="157272331"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="157272331"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 11:13:47 -0800
IronPort-SDR: VS2hOt0hHHehWXVlRGNmpnBvf+z4R8Od1Y9UJ//JETgmKtM8FsPwB9+g73fpO+16ffXKN2Umin
 XkepVrR9B39w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="381539456"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2021 11:13:47 -0800
Received: from [10.255.230.93] (kliang2-MOBL.ccr.corp.intel.com [10.255.230.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C39055808F1;
        Tue, 12 Jan 2021 11:13:45 -0800 (PST)
Subject: Re: [PATCH V4 0/6] Add the page size in the perf record (user tools)
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au,
        Peter Zijlstra <peterz@infradead.org>
References: <20210105195752.43489-1-kan.liang@linux.intel.com>
 <0F170D59-1C3D-4719-BF51-9AC306DB862D@linux.vnet.ibm.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <1f45cebf-1f89-2c4c-f2b3-dbdb623576ae@linux.intel.com>
Date:   Tue, 12 Jan 2021 14:13:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0F170D59-1C3D-4719-BF51-9AC306DB862D@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2021 12:24 AM, Athira Rajeev wrote:
> 
> 
>> On 06-Jan-2021, at 1:27 AM, kan.liang@linux.intel.com wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Changes since V3:
>> - Rebase on top of acme's perf/core branch
>>   commit c07b45a355ee ("perf record: Tweak "Lowering..." warning in record_opts__config_freq")
>>
>> Changes since V2:
>> - Rebase on top of acme perf/core branch
>>   commit eec7b53d5916 ("perf test: Make sample-parsing test aware of PERF_SAMPLE_{CODE,DATA}_PAGE_SIZE")
>> - Use unit_number__scnprintf() in get_page_size_name()
>> - Emit warning about kernel not supporting the code page size sample_type bit
>>
>> Changes since V1:
>> - Fix the compile warning with GCC 10
>> - Add Acked-by from Namhyung Kim
>>
>> Current perf can report both virtual addresses and physical addresses,
>> but not the page size. Without the page size information of the utilized
>> page, users cannot decide whether to promote/demote large pages to
>> optimize memory usage.
>>
>> The kernel patches have been merged into tip perf/core branch,
>> commit 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
>> commit 76a5433f95f3 ("perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE")
>> commit 4cb6a42e4c4b ("powerpc/perf: Support PERF_SAMPLE_DATA_PAGE_SIZE")
>> commit 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")
>> commit 51b646b2d9f8 ("perf,mm: Handle non-page-table-aligned hugetlbfs")
>>
>> and Peter's perf/core branch
>> commit 524680ce47a1 ("mm/gup: Provide gup_get_pte() more generic")
>> commit 44a35d6937d2 ("mm: Introduce pXX_leaf_size()")
>> commit 2f1e2f091ad0 ("perf/core: Fix arch_perf_get_page_size()")
>> commit 7649e44aacdd ("arm64/mm: Implement pXX_leaf_size() support")
>> commit 1df1ae7e262c ("sparc64/mm: Implement pXX_leaf_size() support")
>>
>> This patch set is to enable the page size support in user tools.
> 
> Hi Kan Liang,
> 
> I am trying to check this series on powerpc.
> 
> # perf mem --phys-data --data-page-size record <workload>
> 
> To my observation, some of the samples returned zero size and comes as ’N/A’ in the perf report
> 
> # perf mem --phys-data --data-page-size report
> 
> For fetching the page size, though initially there was a weak function added ( as arch_perf_get_page_size ) here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=51b646b2d9f84d6ff6300e3c1d09f2be4329a424
> 
> later I see it got removed here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=8af26be062721e52eba1550caf50b712f774c5fd
> 
> I picked kernel changes from git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git , or I am missing something ?

I believe all the kernel changes have been merged.

According to the commit message of the recent changes, only Power/8xxx 
is supported for power for now. I guess that may be the reason of some 
'N/A's.
https://lore.kernel.org/patchwork/cover/1345521/

Thanks,
Kan


> 
> Thanks
> Athira
> 
>>
>> Kan Liang (3):
>>   perf mem: Clean up output format
>>   perf mem: Support data page size
>>   perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>>
>> Stephane Eranian (3):
>>   perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>>   perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>>   perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE
>>
>> tools/perf/Documentation/perf-mem.txt     |   3 +
>> tools/perf/Documentation/perf-record.txt  |   3 +
>> tools/perf/Documentation/perf-report.txt  |   1 +
>> tools/perf/Documentation/perf-script.txt  |   2 +-
>> tools/perf/builtin-mem.c                  | 111 +++++++++++-----------
>> tools/perf/builtin-record.c               |   2 +
>> tools/perf/builtin-script.c               |  13 ++-
>> tools/perf/tests/sample-parsing.c         |   4 +
>> tools/perf/util/event.h                   |   1 +
>> tools/perf/util/evsel.c                   |  18 +++-
>> tools/perf/util/evsel.h                   |   1 +
>> tools/perf/util/hist.c                    |   2 +
>> tools/perf/util/hist.h                    |   1 +
>> tools/perf/util/perf_event_attr_fprintf.c |   2 +-
>> tools/perf/util/record.h                  |   1 +
>> tools/perf/util/session.c                 |   3 +
>> tools/perf/util/sort.c                    |  26 +++++
>> tools/perf/util/sort.h                    |   2 +
>> tools/perf/util/synthetic-events.c        |   8 ++
>> 19 files changed, 144 insertions(+), 60 deletions(-)
>>
>> -- 
>> 2.25.1
>>
>>
>>
> 
