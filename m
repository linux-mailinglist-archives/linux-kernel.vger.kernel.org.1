Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6652FE25B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbhAUGL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:11:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:53169 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbhAUGKr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:10:47 -0500
IronPort-SDR: Vk0lv9WRYIe/MLvRI8iX4LlWzAWMwazWqifGEfmrvDPs97UmDQIDgEu/63QclyaMj8KhrMksA3
 grA8d8YySqsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="178443922"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="178443922"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 22:08:58 -0800
IronPort-SDR: XbEDPYkz3aJXFPY9AQ3J+Ar8WQoBejE/2/kZVv9LpxhQVke9EVILyf0aBK/Q/S916AyZ70x6jf
 vLDrSFmWwEtA==
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="385170189"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 22:08:54 -0800
Subject: Re: [PATCH v2] perf stat: Append to default list if use -e +event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210104021837.30473-1-yao.jin@linux.intel.com>
 <20210112100807.GB1273297@krava>
 <64dba2a3-0bf2-3af3-6f54-6e200840017d@linux.intel.com>
 <20210120212553.GA1798087@krava> <20210121000355.GB106434@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <2d2c8e32-53f2-560d-3f69-a0ed7c3810e6@linux.intel.com>
Date:   Thu, 21 Jan 2021 14:08:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121000355.GB106434@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 1/21/2021 8:03 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jan 20, 2021 at 10:25:53PM +0100, Jiri Olsa escreveu:
>> On Mon, Jan 18, 2021 at 12:54:37PM +0800, Jin, Yao wrote:
>>> root@kbl-ppc:# ./perf stat -e +power/energy-pkg/ -a -- sleep 1
> 
>>>   Performance counter stats for 'system wide':
> 
>>>                2.02 Joules +power/energy-pkg/
> 
>>>         1.000859434 seconds time elapsed
> 
>>> The '+' prefix is printed. So I finally decide not to remove the '+' prefix
>>> in order to keep original behavior.
>   
>> hm, originaly there's no purpose for the '+', right?
>> it seems it's more like bug then anything else
>   
>> you added function to the '+' to add default events to specified event,
>> which I think is good idea, but I don't think we should display the
>> extra '+' in output
> 
> The value would be to stress that that is an event added to the ones
> without the + prefix, i.e. the default ones.
> 
> But by having the command line copied over and the added events at the
> first lines we should have that abundantly clear.
> 
> Also we won't print removed events (using -), is that available already?
> 

Sorry, the '-' support is not available in this patch. Can I do the patch for '+' first and then do 
a follow up patch for '-' at next step?

> Nope:
> 
> [root@quaco ~]# perf stat -e -cycles sleep
> event syntax error: '-cycles'
>                       \___ parser error
> Run 'perf list' for a list of valid events
> 
>   Usage: perf stat [<options>] [<command>]
> 
>      -e, --event <event>   event selector. use 'perf list' to list available events
> [root@quaco ~]#
> 
> Like with:
> 
> [root@quaco ~]# perf stat -d sleep 1
>  >   Performance counter stats for 'sleep 1':
> 
>                0.80 msec task-clock                #    0.001 CPUs utilized
>                   1      context-switches          #    0.001 M/sec
>                   0      cpu-migrations            #    0.000 K/sec
>                  59      page-faults               #    0.073 M/sec
>           2,215,522      cycles                    #    2.757 GHz                      (7.40%)
>           1,073,189      instructions              #    0.48  insn per cycle           (80.59%)
>             203,615      branches                  #  253.392 M/sec
>               8,309      branch-misses             #    4.08% of all branches
>             245,866      L1-dcache-loads           #  305.972 M/sec
>              14,024      L1-dcache-load-misses     #    5.70% of all L1-dcache accesses  (92.60%)
>       <not counted>      LLC-loads                                                     (0.00%)
>       <not counted>      LLC-load-misses                                               (0.00%)
> 
>         1.001887261 seconds time elapsed
> 
>         0.000000000 seconds user
>         0.001413000 seconds sys
> 
> 
> Some events weren't counted. Try disabling the NMI watchdog:
> 	echo 0 > /proc/sys/kernel/nmi_watchdog
> 	perf stat ...
> 	echo 1 > /proc/sys/kernel/nmi_watchdog
> [root@quaco ~]# perf stat -e -LLC* -d sleep 1
> event syntax error: '-LLC*'
>                       \___ parser error
> Run 'perf list' for a list of valid events
> 
>   Usage: perf stat [<options>] [<command>]
> 
>      -e, --event <event>   event selector. use 'perf list' to list available events
> [root@quaco ~]#
> 
> - Arnaldo
> 

So if we just want to append the default list, we only need to set detailed_run=1, then ideally 
perf-stat will print the default list.

But for now, there are no task-clock, context-switches, cpu-migrations, page-faults, instructions, 
branches and branch-misses displayed.

root@kbl-ppc:~# ./perf stat -e cycles -d -a -- sleep 1

  Performance counter stats for 'system wide':

        124,178,207      cycles                                                        (80.02%)
          6,444,490      L1-dcache-loads                                               (80.01%)
          1,043,169      L1-dcache-load-misses     #   16.19% of all L1-dcache accesses  (80.02%)
            564,474      LLC-loads                                                     (80.02%)
             49,262      LLC-load-misses           #    8.73% of all LL-cache accesses  (79.92%)

        1.001614947 seconds time elapsed

Do we still need the '+' prefix to add the specified event on top of default list? It looks current 
syntax should already support that feature, but just need to fix some issues.

Thanks
Jin Yao
