Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503772DC0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgLPNBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:01:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:49343 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgLPNBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:01:45 -0500
IronPort-SDR: E6evPb+e+h8/AzB+rrMkZn46rmsIno8vZyrFkM0w+FPALAUH0j6Yu1/e0IMR0Kb0kp5SiHCwPa
 7qqzkdLK45vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="172486564"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="172486564"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 05:00:00 -0800
IronPort-SDR: sQKQ139n++Ht1f0zX7jnFE/HNyMvElPDc5DkGKcZsX3hXlMNxdeP4cnRw20apgnNgLguTQc3NM
 XXrkHBqLnQiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="384548392"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 16 Dec 2020 04:59:57 -0800
Subject: Re: [RFC][PATCH 0/5] select_idle_sibling() wreckage
To:     Peter Zijlstra <peterz@infradead.org>, mgorman@techsingularity.net,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com, benbjiang@gmail.com
References: <20201214164822.402812729@infradead.org>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <d2359aa2-1771-30f1-1fe4-4f07c6083b2c@linux.intel.com>
Date:   Wed, 16 Dec 2020 20:59:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201214164822.402812729@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2020/12/15 0:48, Peter Zijlstra wrote:
> Hai, here them patches Mel asked for. They've not (yet) been through the
> robots, so there might be some build fail for configs I've not used.
> 
> Benchmark time :-)
> 

Here is the data on my side, benchmarks were tested on a x86 4 sockets system
with 24 cores per socket and 2 hyperthreads per core, total 192 CPUs.

uperf throughput: netperf workload, tcp_nodelay, r/w size = 90

  threads	baseline-avg	%std	patch-avg	%std
  96		1		0.78	1.0072		1.09
  144		1		0.58	1.0204		0.83
  192		1		0.66	1.0151		0.52
  240		1		2.08	0.8990		0.75

hackbench: process mode, 25600 loops, 40 file descriptors per group

  group		baseline-avg	%std	patch-avg	%std
  2(80)		1		10.02	1.0339		9.94
  3(120)	1		6.69	1.0049		6.92
  4(160)	1		6.76	0.8663		8.74
  5(200)	1		2.96	0.9651		4.28

schbench: 99th percentile latency, 16 workers per message thread

  mthread	baseline-avg	%std	patch-avg	%std
  6(96)		1		0.88	1.0055		0.81
  9(144)	1		0.59	1.0007		0.37
  12(192)	1		0.61	0.9973		0.82
  15(240)	1		25.05	0.9251		18.36

sysbench mysql throughput: read/write, table size = 10,000,000

  thread	baseline-avg	%std	patch-avg	%std
  96		1               6.62	0.9668		4.04
  144		1		9.29	0.9579		6.53
  192		1		9.52	0.9503		5.35
  240		1		8.55	0.9657		3.34

It looks like 
- hackbench has a significant improvement of 4 groups
- uperf has a significant regression of 240 threads

Please let me know if you have any interested cases I can run/rerun.

Thanks,
-Aubrey
