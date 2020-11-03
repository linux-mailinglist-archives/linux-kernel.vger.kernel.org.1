Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23042A3A86
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgKCClr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:41:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:64732 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgKCClr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:41:47 -0500
IronPort-SDR: HSPhAwLuNlDfQn6/uDKAUOgVWUNhsc93Xsmtly94tBLxexv/+ynVA+aNIHUdFFX3agwCyIw8F2
 eMs41RtLJhDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="230617642"
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="230617642"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 18:41:45 -0800
IronPort-SDR: pMCcW3vEUvHSzX/Ock69kEE8byVAxVvfoV2A2WPoGKJnKpPVPddXvRd2hKg4NRwuvbelKFfkqQ
 EtASVpEFLAAw==
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="528240587"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 18:41:45 -0800
Date:   Mon, 2 Nov 2020 18:41:43 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2 0/4] perf: Fix perf_event_attr::exclusive rotation
Message-ID: <20201103024143.GK466880@tassilo.jf.intel.com>
References: <20201029162719.519685265@infradead.org>
 <20201031234418.GE3380099@krava>
 <20201102035238.GI466880@tassilo.jf.intel.com>
 <20201102141625.GX2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102141625.GX2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 03:16:25PM +0100, Peter Zijlstra wrote:
> On Sun, Nov 01, 2020 at 07:52:38PM -0800, Andi Kleen wrote:
> > The main motivation is actually that the "multiple groups" algorithm
> > in perf doesn't work all that great: it has quite a few cases where it
> > starves groups or makes the wrong decisions. That is because it is very
> > difficult (likely NP complete) problem and the kernel takes a lot
> > of short cuts to avoid spending too much time on it.
> 
> The event scheduling should be starvation free, except in the presence
> of pinned events.
> 
> If you can show starvation without pinned events, it's a bug.
> 
> It will also always do equal or better than exclusive mode wrt PMU
> utilization. Again, if it doesn't it's a bug.

Simple example (I think we've shown that one before):

(on skylake)
$ cat /proc/sys/kernel/nmi_watchdog
0
$ perf stat -e instructions,cycles,frontend_retired.latency_ge_2,frontend_retired.latency_ge_16 -a sleep 2

 Performance counter stats for 'system wide':

       654,514,990      instructions              #    0.34  insn per cycle           (50.67%)
     1,924,297,028      cycles                                                        (74.28%)
        21,708,935      frontend_retired.latency_ge_2                                     (75.01%)
         1,769,952      frontend_retired.latency_ge_16                                     (24.99%)

       2.002426541 seconds time elapsed

The second frontend_retired should be both getting 50% and the fixed events should be getting
100%. So several events are starved.

Another similar example is trying to schedule the topdown events on Icelake in parallel to other
groups. It works with one extra group, but breaks with two.

(on icelake)
$ cat /proc/sys/kernel/nmi_watchdog
0
$ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,topdown-retiring},{branches,branches,branches,branches,branches,branches,branches,branches},{branches,branches,branches,branches,branches,branches,branches,branches}' -a sleep 1

 Performance counter stats for 'system wide':

        71,229,087      slots                                                         (60.65%)
         5,066,320      topdown-bad-spec          #      7.1% bad speculation         (60.65%)
        35,080,387      topdown-be-bound          #     49.2% backend bound           (60.65%)
        22,769,750      topdown-fe-bound          #     32.0% frontend bound          (60.65%)
         8,336,760      topdown-retiring          #     11.7% retiring                (60.65%)
           424,584      branches                                                      (70.00%)
           424,584      branches                                                      (70.00%)
           424,584      branches                                                      (70.00%)
           424,584      branches                                                      (70.00%)
           424,584      branches                                                      (70.00%)
           424,584      branches                                                      (70.00%)
           424,584      branches                                                      (70.00%)
           424,584      branches                                                      (70.00%)
         3,634,075      branches                                                      (30.00%)
         3,634,075      branches                                                      (30.00%)
         3,634,075      branches                                                      (30.00%)
         3,634,075      branches                                                      (30.00%)
         3,634,075      branches                                                      (30.00%)
         3,634,075      branches                                                      (30.00%)
         3,634,075      branches                                                      (30.00%)
         3,634,075      branches                                                      (30.00%)

       1.001312511 seconds time elapsed

A tool using exclusive hopefully will be able to do better than this.

-Andi
