Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D9328CC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgJMLaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:30:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:11797 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJMLa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:30:29 -0400
IronPort-SDR: UCx5oS4bbq73H9gNHjTsrlNwRgXX+jJch9tKdV/Sx61m0DV+9CS9H9ZvtfJgVZEcY/uqtFrL9t
 Z3yBE8PMlhrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="152824146"
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; 
   d="scan'208";a="152824146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 04:30:26 -0700
IronPort-SDR: it32su5GUBbJH9ywAvXqDoIN0jAAijF28LOINouse3MoBquhd64muMBhJDzIdM7Rjgb/JgeGHf
 BhIaUmevcMUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; 
   d="scan'208";a="299531051"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 13 Oct 2020 04:30:25 -0700
Received: from [10.249.226.135] (abudanko-mobl.ccr.corp.intel.com [10.249.226.135])
        by linux.intel.com (Postfix) with ESMTP id EFCD858073D;
        Tue, 13 Oct 2020 04:30:21 -0700 (PDT)
Subject: Re: [PATCH v1 06/15] perf session: load data directory into tool
 process memory
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <39cf6164-f3be-ae34-292a-94faef32fdb9@linux.intel.com>
 <20201012160921.GD466880@tassilo.jf.intel.com>
 <8f90c785-8bdc-e7cd-a6d9-7eed0fb2c6b3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7216a411-a635-4fcc-b10d-afe1f75509d3@linux.intel.com>
Date:   Tue, 13 Oct 2020 14:30:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <8f90c785-8bdc-e7cd-a6d9-7eed0fb2c6b3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.10.2020 19:49, Alexey Budankov wrote:
> 
> On 12.10.2020 19:09, Andi Kleen wrote:
>> On Mon, Oct 12, 2020 at 11:58:58AM +0300, Alexey Budankov wrote:
>>>
>>> Read trace files located at data directory into tool process memory.
>>> Basic analysis support of data directories is provided for report
>>> mode. Raw dump (-D) and aggregated reports are available for data
>>> directories, still with no memory consumption optimizations. However
>>> data directories collected with --compression-level option enabled
>>> can be analyzed with little less memory because trace files are
>>> unmaped from tool process memory after loading collected data.
>>> The implementation is based on the prototype [1], [2].
>>
>> Should credit the author(s) of the prototypes.
> 
> Sure. Will explicitly add:
>  
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> 
> here and [PATCH v2 15/15], additionally to [1], [2] below.
> 
> Thanks for pointing this out!
> 
>>>
>>> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
>>> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
>>>
>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> ---
>>>  tools/perf/util/session.c | 48 +++++++++++++++++++++++++++++++++++++++
>>>  tools/perf/util/session.h |  1 +
>>>  2 files changed, 49 insertions(+)
>>>
>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>> index 6afc670fdf0c..0752eec19813 100644
>>> --- a/tools/perf/util/session.c
>>> +++ b/tools/perf/util/session.c
>>> @@ -2212,6 +2212,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>>>  		goto more;
>>>  
>>>  out:
>>> +	if (rd->unmap_file) {
>>> +		int i;
>>> +
>>> +		for (i = 0; i < NUM_MMAPS; i++) {
>>> +			if (mmaps[i]) {
>>> +				munmap(mmaps[i], mmap_size);
>>> +				mmaps[i] = NULL;
>>
>> Okay so where is the mmap? Would make more sense to put that
>> into the same patch as who adds the mmap. Or is the mmap
>> code already in the perf source? In that case it should
>> probably be some common helper with the existing users.
> 
> That mmap is already in the code. Agree, this part of the patch
> can be applied prior the whole patch set.

I take it back. Single trace file can't be unmapped yet since it also
contains not only compressed records but also other records backing
the data for aggregated analysis.

Alexei
