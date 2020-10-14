Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CF828E04C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgJNMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:09:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:55510 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgJNMJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:09:06 -0400
IronPort-SDR: jSoXj9Rmk5swizHfTOZdRbCNBcwDQTFH3Q1OqfYTB7wkQMaGVU5cK30OFbmqqZLr7IwT8a0APh
 gCT2PwKsDR2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145953659"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="145953659"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 05:09:05 -0700
IronPort-SDR: VHiQZi061gOdJ2cguYhr+PhjdOYUHuxbuF8Z+Wd7SboWu1nQa9UMqhWyo0dUwFUfvTlfVLmHpM
 0NILskVqq1DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="318634456"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2020 05:09:05 -0700
Received: from [10.249.230.73] (abudanko-mobl.ccr.corp.intel.com [10.249.230.73])
        by linux.intel.com (Postfix) with ESMTP id 828625808A3;
        Wed, 14 Oct 2020 05:09:02 -0700 (PDT)
Subject: Re: [PATCH v1 08/15] perf record: write trace data into mmap trace
 files
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <0652b8dd-e753-7c10-27e9-af9524e7ccc5@linux.intel.com>
 <CAM9d7cgrXsiPWuAYjg1og0N=03-mfx075-n7KUrvYyAMLZ8_7A@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <81ffefab-ac4e-c51c-809a-b9ba96d6d867@linux.intel.com>
Date:   Wed, 14 Oct 2020 15:09:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgrXsiPWuAYjg1og0N=03-mfx075-n7KUrvYyAMLZ8_7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14.10.2020 13:52, Namhyung Kim wrote:
> Hi,
> 
> On Mon, Oct 12, 2020 at 6:01 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>>
>> Write trace data into per mmap trace files located
>> at data directory. Streaming thread adjusts its affinity
>> according to mask of the buffer being processed.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
> [SNIP]
>> @@ -1184,8 +1203,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
>>         /*
>>          * Mark the round finished in case we wrote
>>          * at least one event.
>> +        *
>> +        * No need for round events in directory mode,
>> +        * because per-cpu maps and files have data
>> +        * sorted by kernel.
>>          */
>> -       if (bytes_written != rec->bytes_written)
>> +       if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
>>                 rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
> 
> This means it needs to keep all events in the ordered events queue
> when perf report processes the data, right?

Looks so.

Alexei
