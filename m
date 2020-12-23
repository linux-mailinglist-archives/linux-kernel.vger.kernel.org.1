Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A727E2E1823
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 05:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgLWEfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 23:35:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:56814 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgLWEf3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 23:35:29 -0500
IronPort-SDR: /9JdfNgUyKdyPVpq8q9d+XP4KIK3B0KQxNH4XGc9Fno/zeou2R2khImxU3h15dOq1ctutR0XEQ
 TUrab6yE2x3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="172451171"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="172451171"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 20:33:40 -0800
IronPort-SDR: SwjLrG5HOcJnMPnXqatX8Fnr7wBsgzrR/tnJ+cya6FzpADoKZajO/YzSPYXJiflrP3VBfWlBSG
 7MYciKdlfSlA==
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="373812390"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 20:33:38 -0800
Subject: Re: [PATCH] perf stat: Create '--add-default' option to append
 default list
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20201222011131.12326-1-yao.jin@linux.intel.com>
 <20201222161555.GD433286@kernel.org>
 <02c473b8-ea6c-1a19-6dd1-0041d8944303@linux.intel.com>
Message-ID: <5ce6a7fe-c0de-c56d-2923-74062eea6540@linux.intel.com>
Date:   Wed, 23 Dec 2020 12:33:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <02c473b8-ea6c-1a19-6dd1-0041d8944303@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/2020 8:56 AM, Jin, Yao wrote:
> Hi Arnaldo,
> 
> On 12/23/2020 12:15 AM, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Dec 22, 2020 at 09:11:31AM +0800, Jin Yao escreveu:
>>> The event default list includes the most common events which are widely
>>> used by users. But with -e option, the current perf only counts the events
>>> assigned by -e option. Users may want to collect some extra events with
>>> the default list. For this case, users have to manually add all the events
>>> from the default list. It's inconvenient. Also, users may don't know how to
>>> get the default list.
>>>
>>> It's better to add a new option to append default list to the -e events.
>>> The new option is '--add-default'.
>>>
>>> Before:
>>>
>>> root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a -- sleep 1
>>>
>>>   Performance counter stats for 'system wide':
>>>
>>>                2.05 Joules power/energy-pkg/
>>>
>>>         1.000857974 seconds time elapsed
>>>
>>> After:
>>>
>>> root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a --add-default -- sleep 1
>>
>> I thought about:
>>
>>      perf stat -e +power/energy-pkg/ -a -- sleep 1
>>
> 
> I was surprised to see that '+<event>' syntax had been supported.
> 
> root@kbl-ppc:~# ./perf stat -e +power/energy-pkg/ -a -- sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>                1.99 Joules +power/energy-pkg/
> 
>         1.000877852 seconds time elapsed
> 
> root@kbl-ppc:~# ./perf stat -e +power/energy-pkg/,+cycles -a -- sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>                2.00 Joules +power/energy-pkg/
>          13,780,620        +cycles
> 
>         1.001639147 seconds time elapsed
> 
> Are there any scripts or usages need the prefix '+' before event? I don't know. But if we append the 
> '+<event>' to the default event list, will break something potentially?
> 
>> Which would have its counterpart:
>>
>>      perf stat -e -cycles -0a --sleep 1
>>
>> To remove an event from the defaults, perhaps to deal with some specific
>> hardware where the default or what is in -d, -dd, -ddd, etc can't all be
>> counted. I.e. - and + would remove or add from whaver list was there at
>> that point.
>>
>> - Arnaldo
> 
> Yes, + and - are more flexible solution. Just for above question, will '+<event>' break existing 
> usage? And for '-', I don't know if user can remember clearly for what the events are in default list.
> 

For '-', another difficulty is it may conflict with the hardware cache event.

Say we remove the "-                      { return '-'; }" from parse-events.l, such as:

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 9db5097317f4..145653d1ce16 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -387,7 +387,6 @@ r{num_raw_hex}              { return raw(yyscanner); }
  {name}                 { return pmu_str_check(yyscanner, _parse_state); }
  {name_tag}             { return str(yyscanner, PE_NAME); }
  "/"                    { BEGIN(config); return '/'; }
--                      { return '-'; }
  ,                      { BEGIN(event); return ','; }
  :                      { return ':'; }
  "{"                    { BEGIN(event); return '{'; }

The syntax of '-<event>' is supported.

root@kbl-ppc:~# ./perf stat -e -cycles -a -- sleep 1

  Performance counter stats for 'system wide':

         14,008,859      -cycles

        1.001471494 seconds time elapsed

But the parsing of hardware cache event would be failed. :(

root@kbl-ppc:~# ./perf stat -e LLC-stores -a -- sleep 1
event syntax error: 'LLC-stores'
                         \___ parser error

That complicates things. :(

Thanks
Jin Yao

> Thanks
> Jin Yao
> 
>>>   Performance counter stats for 'system wide':
>>>
>>>                2.10 Joules power/energy-pkg/         #    0.000 K/sec
>>>            8,009.89 msec   cpu-clock                 #    7.995 CPUs utilized
>>>                 140        context-switches          #    0.017 K/sec
>>>                   9        cpu-migrations            #    0.001 K/sec
>>>                  66        page-faults               #    0.008 K/sec
>>>          10,671,929        cycles                    #    0.001 GHz
>>>           4,736,880        instructions              #    0.44  insn per cycle
>>>             942,951        branches                  #    0.118 M/sec
>>>              76,096        branch-misses             #    8.07% of all branches
>>>
>>>         1.001809960 seconds time elapsed
>>>
>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>> ---
>>>   tools/perf/Documentation/perf-stat.txt | 5 +++++
>>>   tools/perf/builtin-stat.c              | 4 +++-
>>>   tools/perf/util/stat.h                 | 1 +
>>>   3 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>>> index 5d4a673d7621..75a83c2e4dc5 100644
>>> --- a/tools/perf/Documentation/perf-stat.txt
>>> +++ b/tools/perf/Documentation/perf-stat.txt
>>> @@ -438,6 +438,11 @@ convenient for post processing.
>>>   --summary::
>>>   Print summary for interval mode (-I).
>>> +--add-default::
>>> +The default event list includes the most common events which are widely
>>> +used by users. But with -e option, the perf only counts the events assigned
>>> +by -e option. This options appends the default event list to the -e events.
>>> +
>>>   EXAMPLES
>>>   --------
>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>> index 89c32692f40c..6ac7b946f9a7 100644
>>> --- a/tools/perf/builtin-stat.c
>>> +++ b/tools/perf/builtin-stat.c
>>> @@ -1173,6 +1173,8 @@ static struct option stat_options[] = {
>>>                  "print summary for interval mode"),
>>>       OPT_BOOLEAN(0, "quiet", &stat_config.quiet,
>>>               "don't print output (useful with record)"),
>>> +    OPT_BOOLEAN(0, "add-default", &stat_config.add_default,
>>> +               "add default events"),
>>>   #ifdef HAVE_LIBPFM
>>>       OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
>>>           "libpfm4 event selector. use 'perf list' to list available events",
>>> @@ -1755,7 +1757,7 @@ static int add_default_attributes(void)
>>>           free(str);
>>>       }
>>> -    if (!evsel_list->core.nr_entries) {
>>> +    if (!evsel_list->core.nr_entries || stat_config.add_default) {
>>>           if (target__has_cpu(&target))
>>>               default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
>>> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
>>> index 9979b4b100f2..6ccc6936348c 100644
>>> --- a/tools/perf/util/stat.h
>>> +++ b/tools/perf/util/stat.h
>>> @@ -123,6 +123,7 @@ struct perf_stat_config {
>>>       bool             metric_no_merge;
>>>       bool             stop_read_counter;
>>>       bool             quiet;
>>> +    bool             add_default;
>>>       FILE            *output;
>>>       unsigned int         interval;
>>>       unsigned int         timeout;
>>> -- 
>>> 2.17.1
>>>
>>
