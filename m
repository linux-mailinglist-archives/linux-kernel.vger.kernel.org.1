Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1F2FFA1B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbhAVBpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:45:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:36854 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbhAVBpS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:45:18 -0500
IronPort-SDR: uOr8p+WjBQr3v/cUJ1/ZjEHOawrbCOkHATRs3JYqpKGcz9/UQjLMQWQRtA7/Ay5OKHv18rm8HG
 InFIehyq+k3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="175864425"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="175864425"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 17:43:27 -0800
IronPort-SDR: h/CqtFPFwmhIBXcs38DsWZYmslf/Q0jJSmMvJnsocBeee7QWMsAXzkWhS5cCrjtu2Kloy2pspI
 Uv+ErP3G5DvA==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="385560002"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 17:43:25 -0800
Subject: Re: [PATCH v2] perf stat: Append to default list if use -e +event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210104021837.30473-1-yao.jin@linux.intel.com>
 <20210112100807.GB1273297@krava>
 <64dba2a3-0bf2-3af3-6f54-6e200840017d@linux.intel.com>
 <20210120212553.GA1798087@krava> <20210121000355.GB106434@kernel.org>
 <2d2c8e32-53f2-560d-3f69-a0ed7c3810e6@linux.intel.com>
 <20210121130225.GV12699@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a15ff775-4d92-4f02-6be9-47c87d062ecd@linux.intel.com>
Date:   Fri, 22 Jan 2021 09:43:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121130225.GV12699@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 1/21/2021 9:02 PM, Arnaldo Carvalho de Melo wrote:
>> So if we just want to append the default list, we only need to set
>> detailed_run=1, then ideally perf-stat will print the default list.
>   
>> But for now, there are no task-clock, context-switches, cpu-migrations,
>> page-faults, instructions, branches and branch-misses displayed.
>   
>> root@kbl-ppc:~# ./perf stat -e cycles -d -a -- sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>>         124,178,207      cycles                                                        (80.02%)
>>           6,444,490      L1-dcache-loads                                               (80.01%)
>>           1,043,169      L1-dcache-load-misses     #   16.19% of all L1-dcache accesses  (80.02%)
>>             564,474      LLC-loads                                                     (80.02%)
>>              49,262      LLC-load-misses           #    8.73% of all LL-cache accesses  (79.92%)
>>
>>         1.001614947 seconds time elapsed
>>
>> Do we still need the '+' prefix to add the specified event on top of default
>> list? It looks current syntax should already support that feature, but just
>> need to fix some issues.
> I think we can do away with that '+' when showing the added events and
> its counts.
> 
> - Arnaldo

Can you help to look at my v3 (I will post it soon)? It only has one line change but it can achieve 
the goal. Another advantage is it can append the metrics to the default event list easily.

For example,

root@kbl-ppc:~# ./perf stat -M Page_Walks_Utilization -d -a -- sleep 1

  Performance counter stats for 'system wide':

          1,417,358      itlb_misses.walk_pending  #    0.177 M/sec
                                                   #     0.05 Page_Walks_Utilization   (30.44%)
          1,145,481      dtlb_store_misses.walk_pending #    0.143 M/sec                    (30.85%)
        126,098,937      cycles                    #    0.016 GHz                      (31.25%)
          9,069,839      dtlb_load_misses.walk_pending #    1.132 M/sec                    (31.64%)
                  0      ept.walk_pending          #    0.000 K/sec                    (31.61%)
           8,009.41 msec cpu-clock                 #    7.994 CPUs utilized
                300      context-switches          #    0.037 K/sec
                  8      cpu-migrations            #    0.001 K/sec
                  3      page-faults               #    0.000 K/sec
        124,456,362      cycles                    #    0.016 GHz                      (31.20%)
         23,924,628      instructions              #    0.19  insn per cycle           (38.79%)
          4,532,511      branches                  #    0.566 M/sec                    (38.39%)
            650,797      branch-misses             #   14.36% of all branches          (38.00%)
          6,332,823      L1-dcache-loads           #    0.791 M/sec                    (37.95%)
          1,056,199      L1-dcache-load-misses     #   16.68% of all L1-dcache accesses  (37.95%)
            572,791      LLC-loads                 #    0.072 M/sec                    (30.36%)
             52,025      LLC-load-misses           #    9.08% of all LL-cache accesses  (30.36%)

        1.001966758 seconds time elapsed

It appends the metric 'Page_Walks_Utilization' to the default event list.

Anyway, if you think it's not a good solution, I'd like to change it. :)

Thanks
Jin Yao
