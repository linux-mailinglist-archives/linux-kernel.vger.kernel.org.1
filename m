Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B01D458B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 08:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgEOGFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 02:05:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:57237 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgEOGFC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:05:02 -0400
IronPort-SDR: sbaE17+1t7W2UJGE5oa4uNCzVYarWht/ShcXKcXPgF/0jfvyPHvBsTMmVSw/0zcoKKsmey2AwU
 FM1eR6Ka3ACw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 23:05:00 -0700
IronPort-SDR: eplvvqQbWgQQvQ18zp+IDJIZFd1LJdzTngUEs49aSU47UVmxTlyi37eTJlVXeSobR27DXqfHB1
 vxpdPtB9UlJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="372588618"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 14 May 2020 23:04:57 -0700
Subject: Re: [PATCH] perf evsel: Get group fd from CPU0 for system wide event
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200430013451.17196-1-yao.jin@linux.intel.com>
 <20200501102337.GA1761222@krava>
 <b799b66a-42aa-6c55-647e-7b718473632a@linux.intel.com>
 <20200505000352.GH1916255@krava>
 <3e813227-4954-0d4b-bc7a-ca272b18454a@linux.intel.com>
Message-ID: <68e53765-6f45-9483-7543-0a2f961cdc62@linux.intel.com>
Date:   Fri, 15 May 2020 14:04:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3e813227-4954-0d4b-bc7a-ca272b18454a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/9/2020 3:37 PM, Jin, Yao wrote:
> Hi Jiri,
> 
> On 5/5/2020 8:03 AM, Jiri Olsa wrote:
>> On Sat, May 02, 2020 at 10:33:59AM +0800, Jin, Yao wrote:
>>
>> SNIP
>>
>>>>> @@ -1461,6 +1461,9 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>>>>>        BUG_ON(!leader->core.fd);
>>>>>        fd = FD(leader, cpu, thread);
>>>>> +    if (fd == -1 && leader->core.system_wide)
>>>>
>>>> fd does not need to be -1 in here.. in my setup cstate_pkg/c2-residency/
>>>> has cpumask 0, so other cpus never get open and are 0, and the whole thing
>>>> ends up with:
>>>>
>>>>     sys_perf_event_open: pid -1  cpu 1  group_fd 0  flags 0
>>>>     sys_perf_event_open failed, error -9
>>>>
>>>> I actualy thought we put -1 to fd array but couldn't find it.. perhaps we should od that
>>>>
>>>>
>>>
>>> I have tested on two platforms. On KBL desktop fd is 0 for this case, but on
>>> oncascadelakex server, fd is -1, so the BUG_ON(fd == -1) is triggered.
>>>
>>>>> +        fd = FD(leader, 0, thread);
>>>>> +
>>>>
>>>> so how do we group following events?
>>>>
>>>>     cstate_pkg/c2-residency/ - cpumask 0
>>>>     msr/tsc/                 - all cpus
>>>>
>>>
>>> Not sure if it's enough to only use cpumask 0 because
>>> cstate_pkg/c2-residency/ should be per-socket.
>>>
>>>> cpu 0 is fine.. the rest I have no idea ;-)
>>>>
>>>
>>> Perhaps we directly remove the BUG_ON(fd == -1) assertion?
>>
>> I think we need to make clear how to deal with grouping over
>> events that comes for different cpus
>>
>>     so how do we group following events?
>>
>>        cstate_pkg/c2-residency/ - cpumask 0
>>        msr/tsc/                 - all cpus
>>
>>
>> what's the reason/expected output of groups with above events?
>> seems to make sense only if we limit msr/tsc/ to cpumask 0 as well
>>
>> jirka
>>
> 
> On 2-socket machine (e.g cascadelakex), "cstate_pkg/c2-residency/" is per-socket event and the 
> cpumask is 0 and 24.
> 
> root@lkp-csl-2sp5 /sys/devices/cstate_pkg# cat cpumask
> 0,24
> 
> We can't limit it to cpumask 0. It should be programmed on CPU0 and CPU24 (the first CPU on each 
> socket).
> 
> The "msr/tsc" are per-cpu event, it should be programmed on all cpus. So I don't think we can limit 
> msr/tsc to cpumask 0.
> 
> The issue is how we deal with get_group_fd().
> 
> static int get_group_fd(struct evsel *evsel, int cpu, int thread)
> {
>          struct evsel *leader = evsel->leader;
>          int fd;
> 
>          if (evsel__is_group_leader(evsel))
>                  return -1;
> 
>          /*
>           * Leader must be already processed/open,
>           * if not it's a bug.
>           */
>          BUG_ON(!leader->core.fd);
> 
>          fd = FD(leader, cpu, thread);
>          BUG_ON(fd == -1);
> 
>          return fd;
> }
> 
> When evsel is "msr/tsc/",
> 
> FD(leader, 0, 0) is 3 (3 is the fd of "cstate_pkg/c2-residency/" on CPU0)
> FD(leader, 1, 0) is -1
> BUG_ON asserted.
> 
> If we just return group_fd(-1) for "msr/tsc", it looks like it's not a problem, is it?
> 
> Thanks
> Jin Yao

I think I get the root cause. That should be a serious bug in get_group_fd, access violation!

For a group mixed with system-wide event and per-core event and the group leader is system-wide 
event, access violation will happen.

perf_evsel__alloc_fd allocates one FD member for system-wide event (only FD(evsel, 0, 0) is valid).

But for per core event, perf_evsel__alloc_fd allocates N FD members (N = ncpus). For example, for 
ncpus is 8, FD(evsel, 0, 0) to FD(evsel, 7, 0) are valid.

get_group_fd(struct evsel *evsel, int cpu, int thread)
{
     struct evsel *leader = evsel->leader;

     fd = FD(leader, cpu, thread);    /* access violation may happen here */
}

If leader is system-wide event, only the FD(leader, 0, 0) is valid.

When get_group_fd accesses FD(leader, 1, 0), access violation happens.

My fix is:

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 28683b0eb738..db05b8a1e1a8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1440,6 +1440,9 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
         if (evsel__is_group_leader(evsel))
                 return -1;

+       if (leader->core.system_wide && !evsel->core.system_wide)
+               return -2;
+
         /*
          * Leader must be already processed/open,
          * if not it's a bug.
@@ -1665,6 +1668,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
                                 pid = perf_thread_map__pid(threads, thread);

                         group_fd = get_group_fd(evsel, cpu, thread);
+                       if (group_fd == -2) {
+                               errno = EINVAL;
+                               err = -EINVAL;
+                               goto out_close;
+                       }
  retry_open:
                         test_attr__ready();

It enables the perf_evlist__reset_weak_group. And in the second_pass (in __run_perf_stat), the 
events will be opened successfully.

I have tested OK for this fix on cascadelakex.

Thanks
Jin Yao
