Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8429944C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788518AbgJZRux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:50:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:53190 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1788510AbgJZRuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:50:52 -0400
IronPort-SDR: SjydEuHEnF4i4WC5d15XMN//ZCz1hNZgVZ1EgtvJLqBmdVbS6eZfKIG+UTmNXW1sTX+ImzLLVy
 GBHMN/8zysbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168087670"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168087670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 10:50:51 -0700
IronPort-SDR: x+1d3ogF+kdLIrWccz/Z91OFRbfQxgN6zBdB5T+zyvuQviQbaMCUX8vVblUCUcA0HdSywi3QD2
 FxpxjaoouOtQ==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="535450069"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.226.224]) ([10.249.226.224])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 10:50:49 -0700
Subject: Re: [PATCH v2 04/15] perf session: move reader object definition to
 header file
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <635d39aa-5ce8-2c0b-9b12-952b95ed22da@linux.intel.com>
 <20201024154447.GJ2589351@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d108b214-43f3-dfc4-dc27-7d882e692130@linux.intel.com>
Date:   Mon, 26 Oct 2020 20:50:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201024154447.GJ2589351@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.10.2020 18:44, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 06:59:48PM +0300, Alexey Budankov wrote:
>>
>> Move definition of reader to session header file to be shared
>> among different source files. Introduce reference to active
>> reader object from session object.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/session.c | 27 ---------------------------
>>  tools/perf/util/session.h | 25 +++++++++++++++++++++++++
>>  2 files changed, 25 insertions(+), 27 deletions(-)
>>
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 6f09d506b2f6..911b2dbcd0ac 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -2110,33 +2110,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>>  	return 0;
>>  }
>>  
>> -/*
>> - * On 64bit we can mmap the data file in one go. No need for tiny mmap
>> - * slices. On 32bit we use 32MB.
>> - */
>> -#if BITS_PER_LONG == 64
>> -#define MMAP_SIZE ULLONG_MAX
>> -#define NUM_MMAPS 1
>> -#else
>> -#define MMAP_SIZE (32 * 1024 * 1024ULL)
>> -#define NUM_MMAPS 128
>> -#endif
>> -
>> -struct reader;
>> -
>> -typedef s64 (*reader_cb_t)(struct perf_session *session,
>> -			   union perf_event *event,
>> -			   u64 file_offset,
>> -			   const char *file_path);
>> -
>> -struct reader {
>> -	int		 fd;
>> -	const char	 *path;
>> -	u64		 data_size;
>> -	u64		 data_offset;
>> -	reader_cb_t	 process;
>> -};
>> -
>>  static int
>>  reader__process_events(struct reader *rd, struct perf_session *session,
>>  		       struct ui_progress *prog)
>> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
>> index 378ffc3e2809..abdb8518a81f 100644
>> --- a/tools/perf/util/session.h
>> +++ b/tools/perf/util/session.h
>> @@ -20,6 +20,30 @@ struct thread;
>>  struct auxtrace;
>>  struct itrace_synth_opts;
>>  
>> +/*
>> + * On 64bit we can mmap the data file in one go. No need for tiny mmap
>> + * slices. On 32bit we use 32MB.
>> + */
>> +#if BITS_PER_LONG == 64
>> +#define MMAP_SIZE ULLONG_MAX
>> +#define NUM_MMAPS 1
>> +#else
>> +#define MMAP_SIZE (32 * 1024 * 1024ULL)
>> +#define NUM_MMAPS 128
>> +#endif
>> +
>> +typedef s64 (*reader_cb_t)(struct perf_session *session,
>> +			   union perf_event *event,
>> +			   u64 file_offset, const char *file_path);
>> +
>> +struct reader {
>> +	int		 fd;
>> +	const char	 *path;
>> +	u64		 data_size;
>> +	u64		 data_offset;
>> +	reader_cb_t	 process;
>> +};
> 
> I wasn't able to find where is this used ouf of session.c ?

I will double check and adjust appropriately.

> 
> 
>> +
>>  struct perf_session {
>>  	struct perf_header	header;
>>  	struct machines		machines;
>> @@ -41,6 +65,7 @@ struct perf_session {
>>  	struct zstd_data	zstd_data;
>>  	struct decomp		*decomp;
>>  	struct decomp		*decomp_last;
>> +	struct reader		*reader;
> 
> please define it in the patch where it's actualy used

Corrected in v3.

Alexei

> 
> thanks,
> jirka
> 
