Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90DA2FEC35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbhAUNph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:45:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:4383 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731284AbhAUNj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:39:57 -0500
IronPort-SDR: 4ZKaunXOMN67AbL6vcE+doKPgf55JmSiBxftQwy11Reaxi3PZKkHBvrhsdCbMgFSSg0lAfTk//
 lJah4RCVk7bQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="175762032"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="175762032"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 05:39:00 -0800
IronPort-SDR: 3XudVQHQ8K9uErqPdMO293SZWfsaHmy6Oj9dem3nM4Kd+a83gWtzmNB11ffd5ayP0wtYUuYU9q
 v81FWlO6oN/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="385311757"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2021 05:38:57 -0800
Subject: Re: [PATCH] perf evlist: Fix id index for heterogeneous systems
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>
References: <20210121125446.11287-1-adrian.hunter@intel.com>
 <20210121131901.GA345740@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <eb24747b-0b93-6373-cb84-52596ef3fc89@intel.com>
Date:   Thu, 21 Jan 2021 15:39:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210121131901.GA345740@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 3:19 pm, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 21, 2021 at 02:54:46PM +0200, Adrian Hunter escreveu:
>> perf_evlist__set_sid_idx() updates perf_sample_id with the evlist map
>> index, cpu number and tid. It is passed indexes to the evsel's cpu and
>> thread maps, but references the evlist's maps instead. That results in
>> using incorrect cpu numbers on heterogeneous systems. Fix by using evsel
>> maps.
>>
>> The id index (PERF_RECORD_ID_INDEX) is used by AUX area tracing when in
>> sampling mode. Having an incorrect cpu number causes the trace data to
>> be attributed to the wrong cpu, and can result in decoder errors because
>> the trace data is then associated with the wrong process.
> 
> Can you please provide a Fixes: tag so that the stable@kernel.org guys
> can apply where appropriate?

Oops sorry missed that.  Here it is:

Fixes: 3c659eedada2 ("perf tools: Add id index")
