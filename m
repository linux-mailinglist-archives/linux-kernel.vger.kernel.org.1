Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC49328BE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgJLQuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:50:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:12699 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgJLQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:50:18 -0400
IronPort-SDR: Rq9OZc+4BDgtWCFdYzPWMSOJn4B2cd/BSoqUz/OPercAs1Q2SeF2RfkOk50Zfdko+CcfZvlLwF
 RgmpaQAq/Tgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="163130782"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="163130782"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 09:50:16 -0700
IronPort-SDR: 4j0DTe0Ta5fiAnbmYr9NiHhWLK91F/kuyLIJhQaWAv9NMYTowLxbWnwFB68+9VgzijsbBE7703
 Gb738MOWjKSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="420277998"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2020 09:50:16 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id D185F5807A3;
        Mon, 12 Oct 2020 09:50:13 -0700 (PDT)
Subject: Re: [PATCH v1 05/15] perf session: introduce decompressor into trace
 reader object
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
 <a7fa42f9-a3a9-0ee0-4933-fe5d1d60176f@linux.intel.com>
 <20201012160523.GC466880@tassilo.jf.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d7560c8f-8149-b7a8-f501-9aff16546a8f@linux.intel.com>
Date:   Mon, 12 Oct 2020 19:50:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201012160523.GC466880@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.10.2020 19:05, Andi Kleen wrote:
> On Mon, Oct 12, 2020 at 11:57:00AM +0300, Alexey Budankov wrote:
>> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
>> index abdb8518a81f..4fc9ccdf7970 100644
>> --- a/tools/perf/util/session.h
>> +++ b/tools/perf/util/session.h
>> @@ -42,6 +42,7 @@ struct reader {
>>  	u64		 data_size;
>>  	u64		 data_offset;
>>  	reader_cb_t	 process;
>> +	struct zstd_data zstd_data;
> 
> Just to make sure, there is a suitable definition of zstd_data in case
> the Zstd library not available?

That's right.

Alexei

> 
> -Andi
> 
