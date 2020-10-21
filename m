Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E1294D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442803AbgJUNCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:02:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:30673 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436655AbgJUNCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:02:08 -0400
IronPort-SDR: 0CieSr7bZzgiFuF6T6f9q8RFE6vGuRf8a9W6eVESfpbZCDY2ONPgngHaNMJRROwfB8U62F9gxQ
 oDYX5xB3WJhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="147218500"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="147218500"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 06:01:53 -0700
IronPort-SDR: ipvoXnmWSFnE/aqd0cSCrICD5g7Ye0Igemz0t31O2yWPHkzDS8RX7DyeDU7Sz2NUMjn7H17Puf
 iyLtV49iY6Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="533519579"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 21 Oct 2020 06:01:52 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id 59FBC580720;
        Wed, 21 Oct 2020 06:01:50 -0700 (PDT)
Subject: Re: [PATCH v1 06/15] perf session: load data directory into tool
 process memory
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <39cf6164-f3be-ae34-292a-94faef32fdb9@linux.intel.com>
 <20201012160921.GD466880@tassilo.jf.intel.com>
 <8f90c785-8bdc-e7cd-a6d9-7eed0fb2c6b3@linux.intel.com>
 <7216a411-a635-4fcc-b10d-afe1f75509d3@linux.intel.com>
 <CAM9d7cjJzHr7BZ2LVFuG4dnk=i+LmP_TCb9J8FTO0w1w=KG1WQ@mail.gmail.com>
 <351d6f3a-7c2a-85d7-4b07-4b0468e6c887@linux.intel.com>
 <CAM9d7ciRu09bRNLbR19m2BjuM46vN6ubf7CUFELeR5-W61O3yA@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d4829840-d765-0aee-2314-c4c2292f3386@linux.intel.com>
Date:   Wed, 21 Oct 2020 16:01:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7ciRu09bRNLbR19m2BjuM46vN6ubf7CUFELeR5-W61O3yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21.10.2020 13:57, Namhyung Kim wrote:
> On Wed, Oct 21, 2020 at 7:25 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>>
>> On 21.10.2020 9:54, Namhyung Kim wrote:
>>> Hi,
>>>
>>> On Tue, Oct 13, 2020 at 8:30 PM Alexey Budankov
>>> <alexey.budankov@linux.intel.com> wrote:
>>>> On 12.10.2020 19:49, Alexey Budankov wrote:
>>>>> On 12.10.2020 19:09, Andi Kleen wrote:
>>>>>> On Mon, Oct 12, 2020 at 11:58:58AM +0300, Alexey Budankov wrote:
>>>>>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>>>>>> index 6afc670fdf0c..0752eec19813 100644
>>>>>>> --- a/tools/perf/util/session.c
>>>>>>> +++ b/tools/perf/util/session.c
>>>>>>> @@ -2212,6 +2212,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>>>>>>>             goto more;
>>>>>>>
>>>>>>>  out:
>>>>>>> +   if (rd->unmap_file) {
>>>>>>> +           int i;
>>>>>>> +
>>>>>>> +           for (i = 0; i < NUM_MMAPS; i++) {
>>>>>>> +                   if (mmaps[i]) {
>>>>>>> +                           munmap(mmaps[i], mmap_size);
>>>>>>> +                           mmaps[i] = NULL;
>>>>>>
>>>>>> Okay so where is the mmap? Would make more sense to put that
>>>>>> into the same patch as who adds the mmap. Or is the mmap
>>>>>> code already in the perf source? In that case it should
>>>>>> probably be some common helper with the existing users.
>>>>>
>>>>> That mmap is already in the code. Agree, this part of the patch
>>>>> can be applied prior the whole patch set.
>>>>
>>>> I take it back. Single trace file can't be unmapped yet since it also
>>>> contains not only compressed records but also other records backing
>>>> the data for aggregated analysis.
>>>
>>> Are you talking about the auxtrace?
>>>
>>> I thought everything will be compressed when it's enabled.
>>> But if it's only for the auxtrace, maybe we can unmap them
>>> with checking it as it's not the common case?
>>
>> I am about primary trace file. Together with PERF_RECORD_COMPRESSED
>> records it contains the other records with uncompressed data (MMAP,
>> FORk, COMM etc.) so it is still unsafe to unmap the trace file after
>> loading.
> 
> Oh, I think all the events coming from the kernel share the mmap
> buffer so they will be compressed with SAMPLEs.  Note that
> synthesized events have 0 timestamp which means that they
> are not queued in the ordered events and processed immediately.

Yes, they are and it will work as expected with this patch changes.

> 
> IIUC, here we unmap the original mmap buffer and the actual data
> in MMAP/FORK/... is kept in the decomp data buffer, no?

Correct. It unmaps trace file from memory after COMPRESSED records
are decompressed into separately allocated decomp objects.

Alexei

> 
> Thanks
> Namhyung
> 
