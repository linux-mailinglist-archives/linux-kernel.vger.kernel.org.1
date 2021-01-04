Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D7B2E9903
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbhADPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:41:42 -0500
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:35891 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726300AbhADPlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:41:42 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 2184117E0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:40:40 +0000 (GMT)
Received: (qmail 30420 invoked from network); 4 Jan 2021 15:40:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Jan 2021 15:40:39 -0000
Date:   Mon, 4 Jan 2021 15:40:12 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC][PATCH 0/5] select_idle_sibling() wreckage
Message-ID: <20210104154012.GA3592@techsingularity.net>
References: <20201214164822.402812729@infradead.org>
 <d2359aa2-1771-30f1-1fe4-4f07c6083b2c@linux.intel.com>
 <CAKfTPtAvTwsPypaTy-UaxACV1xDB-JpyNrNeSBCnHaZjf-V7VA@mail.gmail.com>
 <CAKfTPtAgaK-EtQp_tzxM5Rcw=LORnrrZBbh24C8bqQ4m1u_-rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAgaK-EtQp_tzxM5Rcw=LORnrrZBbh24C8bqQ4m1u_-rQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 02:23:41PM +0100, Vincent Guittot wrote:
> > Tests are still running on my side but early results shows perf
> > regression for hackbench
> 
> Few more results before being off:
> On small embedded system, the problem seems to be mainly a matter of
> setting the right number of loops.
> 
> On large smt system, The system on which  I usually run my tests  if
> off for now so i haven't been able to finalize tests yet but the
> problem might be that we don't loop all core anymore with this
> patchset compare to current algorithm
> 

Tests ran over the holidays and are available at http://www.skynet.ie/~mel/postings/peterz-20210104/dashboard.html

I am thrawling through the data but by and large the two main
observations I've had so far are

1. The last patch seems the most problematic and the most likely to make
   a large change, particularly to hackbench. For example;
   http://www.skynet.ie/~mel/postings/peterz-20210104/scheduler-unbound/bing2/index.html#hackbench-thread-pipes

   The idle cpu cutoff is reasonably effective even though it triggers a
   lot of false positives meaning that it may be better to treat that in
   isolation

2. The cost accounting one had variable impact. Generally it was small
   gains and losses but tbench for low client counts is an exception as
   low thread counts say variable impact. Some big losses although EPYC1
   is a counter-example (toto in the dashboard)

The second issue might be responsible for the first issue, not sure.
However, it does not suprise me that properly accounting would have an
impact on the SMT depth search and likely needs tweaking.

-- 
Mel Gorman
SUSE Labs
