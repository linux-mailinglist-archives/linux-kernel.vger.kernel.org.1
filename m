Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F99295209
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503956AbgJUSPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:15:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48360 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409610AbgJUSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:15:51 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id c132fe0aa49c926b; Wed, 21 Oct 2020 20:15:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        viresh.kumar@linaro.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] sched/fair: check for idle core
Date:   Wed, 21 Oct 2020 20:15:47 +0200
Message-ID: <20581608.8Dxr8OdOFj@kreacher>
In-Reply-To: <alpine.DEB.2.22.394.2010211422230.8475@hadrien>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <20201021121950.GF2628@hirez.programming.kicks-ass.net> <alpine.DEB.2.22.394.2010211422230.8475@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 21, 2020 2:42:20 PM CEST Julia Lawall wrote:
> 
> On Wed, 21 Oct 2020, Peter Zijlstra wrote:
> 
> > On Wed, Oct 21, 2020 at 01:56:55PM +0200, Julia Lawall wrote:
> > > Prior to 5.8, my machine was using intel_pstate and had few background
> > > tasks.  Thus the problem wasn't visible in practice.  Starting with 5.8
> > > the kernel decided that intel_cpufreq would be more appropriate, which
> > > introduced kworkers every 0.004 seconds on all cores.
> >
> > That still doesn't make any sense. Are you running the legacy on-demand
> > thing or something?
> >
> > Rafael, Srinivas, Viresh, how come it defaults to that?
> 
> The relevant commits are 33aa46f252c7, and 39a188b88332 that fixes a small
> bug.  I have a Intel(R) Xeon(R) CPU E7-8870 v4 @ 2.10GHz that does not
> have the HWP feature, even though the cores seemed to be able to change
> their frequencies at the hardware level.

That's in the range of "turbo" P-states (if a P-state above a certain threshold
is requested by the governor, the processor has a license to choose P-states
in the range above this threshold by itself).

Cheers!



