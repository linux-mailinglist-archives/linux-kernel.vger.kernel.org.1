Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5F29599A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507565AbgJVHuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:50:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:25651 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440683AbgJVHuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:50:23 -0400
IronPort-SDR: lS3/1YjygRt2pdURCrlDg2eRvC+uEROrLorNkcGT/YWka2fN/f8ZUOZdnqFl/WPvGjeyDACG0J
 nFALhEw8qwEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="154441789"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="154441789"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 00:50:22 -0700
IronPort-SDR: jtR6437IXpCU+H6DPCfYdtkozVitBIfopm+gfWrIEW284irYtzdboWsCCQEaVZIwrt81roZKem
 HAVfS5KpR05g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="348648693"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 22 Oct 2020 00:50:22 -0700
Received: from [10.249.228.198] (unknown [10.249.228.198])
        by linux.intel.com (Postfix) with ESMTP id F10C3580720;
        Thu, 22 Oct 2020 00:50:19 -0700 (PDT)
Subject: Re: [PATCH v2 03/15] perf data: open data directory in read access
 mode
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <dc78ce8b-664c-45b9-ad44-4faaeb5d544f@linux.intel.com>
 <CAM9d7cg7iU5sY0u0AgWhFddzCMT3vuS-SgDePENP6kQm0w5J6w@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <258b35e5-03ed-ad2f-c3a8-7df2c36cef6b@linux.intel.com>
Date:   Thu, 22 Oct 2020 10:50:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cg7iU5sY0u0AgWhFddzCMT3vuS-SgDePENP6kQm0w5J6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.10.2020 7:31, Namhyung Kim wrote:
> On Thu, Oct 22, 2020 at 12:58 AM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>>
>> Open files located at trace data directory in case read access
>> mode is requested. File are opened and its fds assigned to
>> perf_data dir files especially for loading data directories
>> content in perf report mode.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/data.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
>> index c47aa34fdc0a..6ad61ac6ba67 100644
>> --- a/tools/perf/util/data.c
>> +++ b/tools/perf/util/data.c
>> @@ -321,6 +321,10 @@ static int open_dir(struct perf_data *data)
>>                 return -1;
>>
>>         ret = open_file(data);
>> +       if (!ret && perf_data__is_dir(data)) {
> 
> I think this __is_dir() check is unnecessary since it's checked
> from the caller side already.

Corrected in v3. Thanks!

Alexei
