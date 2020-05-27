Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD4C1E3944
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 08:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgE0GbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 02:31:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:57167 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgE0GbH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:31:07 -0400
IronPort-SDR: BRz5MZMQnvI4nRBN/xc0vBsMelCYOlw8EpZzQVxn1k3OpKncgwTlicqO7kCjZfYUqFiUCcZGZC
 BSALCp7SbTzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 23:31:06 -0700
IronPort-SDR: aR1qW7a7nJ+0R8gC5zNBvxg5jKW205prOvVa7RoSOa4aXsZThBK/C/yG7M4/7gptp1Or1yyoZQ
 gmZCyEf32kLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,440,1583222400"; 
   d="scan'208";a="375935788"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2020 23:31:04 -0700
Subject: Re: [PATCH v2 1/2] perf evlist: Ensure grouped events with same cpu
 map
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200525065559.6422-1-yao.jin@linux.intel.com>
 <20200526115155.GE333164@krava>
 <32c4663a-6934-2a2d-79e2-7a335e3629a2@linux.intel.com>
Message-ID: <d6986a15-1e21-3414-9d68-c265e7db03f4@linux.intel.com>
Date:   Wed, 27 May 2020 14:31:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <32c4663a-6934-2a2d-79e2-7a335e3629a2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/27/2020 11:20 AM, Jin, Yao wrote:
> Hi Jiri,
> 
> On 5/26/2020 7:51 PM, Jiri Olsa wrote:
>> On Mon, May 25, 2020 at 02:55:58PM +0800, Jin Yao wrote:
>>
>> SNIP
>>
>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>> index 2a9de6491700..1161cffc0688 100644
>>> --- a/tools/perf/util/evlist.c
>>> +++ b/tools/perf/util/evlist.c
>>> @@ -1704,3 +1704,52 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
>>>       }
>>>       return leader;
>>>   }
>>> +
>>> +static bool cpus_map_matched(struct evsel *prev, struct evsel *evsel)
>>> +{
>>> +    if (evsel->core.cpus->nr != prev->core.cpus->nr)
>>> +        return false;
>>> +
>>> +    for (int i = 0; i < evsel->core.cpus->nr; i++) {
>>> +        if (evsel->core.cpus->map[i] != prev->core.cpus->map[i])
>>> +            return false;
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +bool evlist__cpus_map_matched(struct evlist *evlist)
>>> +{
>>> +    struct evsel *prev = evlist__first(evlist), *evsel = prev;
>>> +    int nr_members = prev->core.nr_members;
>>> +
>>> +    evlist__for_each_entry_continue(evlist, evsel) {
>>> +        if (nr_members <= 1) {
>>> +            prev = evsel;
>>> +            nr_members = evsel->core.nr_members;
>>> +            continue;
>>> +        }
>>> +
>>> +        nr_members--;
>>> +
>>> +        if (!cpus_map_matched(prev, evsel))
>>> +            return false;
>>> +
>>> +        prev = evsel;
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +void evlist__force_disable_group(struct evlist *evlist)
>>> +{
>>> +    struct evsel *evsel;
>>> +
>>> +    pr_warning("WARNING: event cpu maps are not fully matched, "
>>> +           "stop event grouping\n");
>>> +
>>> +    evlist__for_each_entry(evlist, evsel) {
>>> +        evsel->leader = evsel;
>>> +        evsel->core.nr_members = 0;
>>> +    }
>>> +}
>>
>> I think this is too much, we need to disable only groups with not
>> matching cpus, not all of them, how about something like this
>>
> 
> Yes, that's too much.
> 
>>
>>          struct evsel *pos;
>>
>>          evlist__for_each_entry(evlist, evsel) {
>>                  if (evsel->leader == evsel)
>>                          continue;
>>                  if (!cpus_map_matched(evsel->leader, evsel))
>>                          continue;
>>                  pr_warn("Disabling group...
>>
>>                  for_each_group_member(pos, evsel->leader) {
>>                          pos->leader = pos;
>>                          evsel->core.nr_members = 0;
>>                  }
>>          }
>>
>> jirka
>>
> 
> Hmm, change "!cpus_map_matched()" to "cpus_map_matched()"? and use for_each_group_evsel() to replace 
> for_each_group_member()?
> 
> How about something like following?
> 
> void evlist__check_cpu_maps(struct evlist *evlist)
> {
>      struct evsel *evsel, *pos;
> 
>      evlist__for_each_entry(evlist, evsel) {
>          if (evsel->leader == evsel)
>              continue;
> 
>          if (cpu_maps_matched(evsel->leader, evsel))
>              continue;
> 
>          pr_warning("WARNING: event cpu maps are not fully matched, "
>                 "disable group\n");
> 
>          for_each_group_evsel(pos, evsel->leader) {
>              pos->leader = pos;
>              pos->core.nr_members = 0;
>          }
> 
>          /*
>           * For core & uncore mixed event group, for example,
>           * '{cycles,unc_cbo_cache_lookup.any_i}',
>           * In evlist:
>           * cycles,
>           * unc_cbo_cache_lookup.any_i,
>           * unc_cbo_cache_lookup.any_i,
>           * unc_cbo_cache_lookup.any_i,
>           * unc_cbo_cache_lookup.any_i,
>           *
>           * cycles is leader and all unc_cbo_cache_lookup.any_i
>           * point to this leader. But for_each_group_evsel can't
>           * iterate all members from cycles. It only iterates
>           * cycles and one unc_cbo_cache_lookup.any_i. So we
>           * set extra evsel here.
>           */
>          evsel->leader = evsel;
>          evsel->core.nr_members = 0;
>      }
> }
> 
> Thanks
> Jin Yao

Issue is found!

It looks we can't set "pos->leader = pos" in either for_each_group_member() or in 
for_each_group_evsel() because it may exit the iteration immediately.

	evlist__for_each_entry(evlist, evsel) {
		if (evsel->leader == evsel)
			continue;

		if (cpu_maps_matched(evsel->leader, evsel))
			continue;

		pr_warning("WARNING: event cpu maps are not fully matched, "
			   "disable group\n");

		for_each_group_member(pos, evsel->leader) {
			pos->leader = pos;
			pos->core.nr_members = 0;
		}

Let me use the example of '{cycles,unc_cbo_cache_lookup.any_i}' again.

In evlist:
cycles,
unc_cbo_cache_lookup.any_i,
unc_cbo_cache_lookup.any_i,
unc_cbo_cache_lookup.any_i,
unc_cbo_cache_lookup.any_i,

When we reach the for_each_group_member at first time, evsel is the first unc_cbo_cache_lookup.any_i 
and evsel->leader is cycles. pos is same as the evsel (the first unc_cbo_cache_lookup.any_i).

Once we execute "pos->leader = pos;", it's actually "evsel->leader = evsel". So now evsel->leader is 
changed to the first unc_cbo_cache_lookup.any_i.

In next iteration, pos is the second unc_cbo_cache_lookup.any_i. pos->leader is cycles but 
unfortunately evsel->leader has been changed to the first unc_cbo_cache_lookup.any_i. So iteration 
stops immediately.

I'm now thinking if we can solve this issue by an easy way.

Thanks
Jin Yao
