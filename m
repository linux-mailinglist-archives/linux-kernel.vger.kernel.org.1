Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE402DAD69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgLOMnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:43:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:9726 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgLOMnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:43:19 -0500
IronPort-SDR: sN/E17DB0Ubawkb+N2ehUyS0ruFr0X4gOaZY7PeJ/YevAaafmwdU7CLrBCct3F+dNOprNh6WT3
 LFVu6u13AFkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="154676546"
X-IronPort-AV: E=Sophos;i="5.78,421,1599548400"; 
   d="scan'208";a="154676546"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 04:41:33 -0800
IronPort-SDR: JQH/VKg4GHrjW4sezgAupb89KUGTgyJWtElAGFvuzhZJlE5SwXipLWkPTBiBB66s2Nk6M7db2e
 qt9tJSYCbWGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,421,1599548400"; 
   d="scan'208";a="383522124"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2020 04:41:30 -0800
Subject: Re: [RFC PATCH v8] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
References: <20201210014359.183771-1-aubrey.li@linux.intel.com>
 <CAKfTPtAVC-ZJYexcYvVdO5gOJ2aXKzRpjLC797xoh5n4TWGU=Q@mail.gmail.com>
 <26c69935-e53d-32dc-0366-a1fb7f3c3d56@linux.intel.com>
 <CAKfTPtCrMAft5t8BrLxgLVoaLHoAmhTp3zgeB8Cu-7+fMSd2zw@mail.gmail.com>
 <698a61bf-6eea-8725-95c0-a5ea811e2bb4@linux.intel.com>
 <121565627e944f8e9dde4080d19d5b02@hisilicon.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <d3184ead-b82f-f784-4c07-9e36d4cc630c@linux.intel.com>
Date:   Tue, 15 Dec 2020 20:41:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <121565627e944f8e9dde4080d19d5b02@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bao Hua,

Sorry I almost missed this message, :(

On 2020/12/14 7:29, Song Bao Hua (Barry Song) wrote:
> 
> Hi Aubrey,
> 
> The patch looks great. But I didn't find any hackbench improvement
> on kunpeng 920 which has 24 cores for each llc span. Llc span is also
> one numa node. The topology is like:
> # numactl --hardware
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
> node 0 size: 128669 MB
> node 0 free: 126995 MB
> node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
> 43 44 45 46 47
> node 1 size: 128997 MB
> node 1 free: 127539 MB
> node 2 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66
> 67 68 69 70 71
> node 2 size: 129021 MB
> node 2 free: 127106 MB
> node 3 cpus: 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90
> 91 92 93 94 95
> node 3 size: 127993 MB
> node 3 free: 126739 MB
> node distances:
> node   0   1   2   3
>   0:  10  12  20  22
>   1:  12  10  22  24
>   2:  20  22  10  12
>   3:  22  24  12  10
> 
> Benchmark command:
> numactl -N 0-1 hackbench -p -T -l 20000 -g $1
> 
> for each g, I ran 10 times to get the average time. And I tested
> g from 1 to 10.
> 
> g     1      2      3      4      5      6       7     8        9       10
> w/o   1.4733 1.5992 1.9353 2.1563 2.8448 3.3305 3.9616 4.4870 5.0786 5.6983
> w/    1.4709 1.6152 1.9474 2.1512 2.8298 3.2998 3.9472 4.4803 5.0462 5.6505
> 
> Is it because the core number is small in llc span in my test?

I guess it is with SIS_PROP, when the system is very busy that idle cpu scan
loop is throttled by nr(4). The patch actually reduces 4 times scan so the
data change looks marginal. Vincent mentioned a notable change at here:
	
	https://lkml.org/lkml/2020/12/14/109

Maybe you can increase the group number to see if it can be reproduced on
your side.

Thanks,
-Aubrey
