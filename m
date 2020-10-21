Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E79294B32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441696AbgJUKZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:25:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:55077 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441689AbgJUKZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:25:13 -0400
IronPort-SDR: 2KChMacfzRI3uu4hdmtTFDQbmqcU8jadCMTrB3O/V9Ur8C6wLUDYI9vEbughnlumyivvnSJVhq
 sEkHgRuN05LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="167435187"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="167435187"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 03:25:12 -0700
IronPort-SDR: Bg4FumSZkt8UV0vchNybvzf1+oornW9L+O2A9LIOpSuyxl+35/EIpgWnB9CJfyw05qRaSzJARb
 E2BtcM1H5M7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="422774675"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2020 03:25:12 -0700
Received: from [10.249.225.226] (abudanko-mobl.ccr.corp.intel.com [10.249.225.226])
        by linux.intel.com (Postfix) with ESMTP id B6111580720;
        Wed, 21 Oct 2020 03:25:09 -0700 (PDT)
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <351d6f3a-7c2a-85d7-4b07-4b0468e6c887@linux.intel.com>
Date:   Wed, 21 Oct 2020 13:25:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjJzHr7BZ2LVFuG4dnk=i+LmP_TCb9J8FTO0w1w=KG1WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21.10.2020 9:54, Namhyung Kim wrote:
> Hi,
> 
> On Tue, Oct 13, 2020 at 8:30 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>> On 12.10.2020 19:49, Alexey Budankov wrote:
>>> On 12.10.2020 19:09, Andi Kleen wrote:
>>>> On Mon, Oct 12, 2020 at 11:58:58AM +0300, Alexey Budankov wrote:
>>>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>>>> index 6afc670fdf0c..0752eec19813 100644
>>>>> --- a/tools/perf/util/session.c
>>>>> +++ b/tools/perf/util/session.c
>>>>> @@ -2212,6 +2212,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>>>>>             goto more;
>>>>>
>>>>>  out:
>>>>> +   if (rd->unmap_file) {
>>>>> +           int i;
>>>>> +
>>>>> +           for (i = 0; i < NUM_MMAPS; i++) {
>>>>> +                   if (mmaps[i]) {
>>>>> +                           munmap(mmaps[i], mmap_size);
>>>>> +                           mmaps[i] = NULL;
>>>>
>>>> Okay so where is the mmap? Would make more sense to put that
>>>> into the same patch as who adds the mmap. Or is the mmap
>>>> code already in the perf source? In that case it should
>>>> probably be some common helper with the existing users.
>>>
>>> That mmap is already in the code. Agree, this part of the patch
>>> can be applied prior the whole patch set.
>>
>> I take it back. Single trace file can't be unmapped yet since it also
>> contains not only compressed records but also other records backing
>> the data for aggregated analysis.
> 
> Are you talking about the auxtrace?
> 
> I thought everything will be compressed when it's enabled.
> But if it's only for the auxtrace, maybe we can unmap them
> with checking it as it's not the common case?

I am about primary trace file. Together with PERF_RECORD_COMPRESSED
records it contains the other records with uncompressed data (MMAP,
FORk, COMM etc.) so it is still unsafe to unmap the trace file after
loading.

Alexei
