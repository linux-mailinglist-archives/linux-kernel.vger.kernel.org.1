Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1061E0720
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 08:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbgEYGiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 02:38:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:9308 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgEYGiC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:38:02 -0400
IronPort-SDR: HCbU+1sk4tPphCOgoYDizKrmc2UP2Ob8ziNA8kQQfpUeoqfD2Fxa7MX7ocDe6kF3fqUsjH0ftA
 SKbN88Q8mJKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 23:38:01 -0700
IronPort-SDR: hC9zYifF6s53x/pz76ljUc/OkaSeiTsfmRh8QJOCoY/cPtebh+upsDP83SSryHxoDdd/1xDP8z
 ZDHa0u+ZqIRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; 
   d="scan'208";a="375348644"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 24 May 2020 23:37:59 -0700
Subject: Re: [PATCH] perf evlist: Ensure grouped events with same cpu map
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200521062240.18865-1-yao.jin@linux.intel.com>
 <20200522095314.GD264196@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e42c13b5-8452-300f-6972-02bcdc46868f@linux.intel.com>
Date:   Mon, 25 May 2020 14:37:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522095314.GD264196@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/22/2020 5:53 PM, Jiri Olsa wrote:
> On Thu, May 21, 2020 at 02:22:40PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> ---
>>   tools/perf/builtin-stat.c |  3 +++
>>   tools/perf/util/evlist.c  | 32 ++++++++++++++++++++++++++++++++
>>   tools/perf/util/evlist.h  |  5 +++++
>>   3 files changed, 40 insertions(+)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 377e575f9645..0e4fc6b3323c 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -584,6 +584,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>   	if (affinity__setup(&affinity) < 0)
>>   		return -1;
>>   
>> +	if (!evlist__cpus_matched(evsel_list))
>> +		evlist__force_disable_group(evsel_list);
>> +
>>   	evlist__for_each_cpu (evsel_list, i, cpu) {
>>   		affinity__set(&affinity, cpu);
>>   
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 2a9de6491700..fc6e410ca63b 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -1704,3 +1704,35 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
>>   	}
>>   	return leader;
>>   }
>> +
>> +bool evlist__cpus_matched(struct evlist *evlist)
>> +{
>> +	struct evsel *prev = evlist__first(evlist), *evsel = prev;
>> +
>> +	if (prev->core.nr_members <= 1)
>> +		return true;
> 
> hum, this assumes there's only one group in evlist?
> 
> how about case like A,{B,C},D,{E,F}
> 

Yes, you are right, I need to consider the case such as A,{B,C},D,{E,F}. I will post v2.

> also please add automated tests for this
> 

I will add case for testing the group members.

>> +
>> +	evlist__for_each_entry_continue(evlist, evsel) {
>> +		if (evsel->core.cpus->nr != prev->core.cpus->nr)
>> +			return false;
>> +
>> +		for (int i = 0; i < evsel->core.cpus->nr; i++) {
>> +			if (evsel->core.cpus->map[i] != prev->core.cpus->map[i])
>> +				return false;
>> +		}
>> +
>> +		prev = evsel;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +void evlist__force_disable_group(struct evlist *evlist)
>> +{
>> +	struct evsel *evsel;
> 
> we need to put some warning for user in here
> 

Yes, agree. I will add warning in v2.

Thanks
Jin Yao

> thanks,
> jirka
> 
>> +
>> +	evlist__for_each_entry(evlist, evsel) {
>> +		evsel->leader = evsel;
>> +		evsel->core.nr_members = 0;
>> +	}
>> +}
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index b6f325dfb4d2..ea7a53166cbd 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -355,4 +355,9 @@ void perf_evlist__force_leader(struct evlist *evlist);
>>   struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
>>   						 struct evsel *evsel,
>>   						bool close);
>> +
>> +bool evlist__cpus_matched(struct evlist *evlist);
>> +
>> +void evlist__force_disable_group(struct evlist *evlist);
>> +
>>   #endif /* __PERF_EVLIST_H */
>> -- 
>> 2.17.1
>>
> 
