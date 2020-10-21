Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DE8294CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440746AbgJUMmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:42:49 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:46320 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390624AbgJUMmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:42:49 -0400
X-IronPort-AV: E=Sophos;i="5.77,401,1596492000"; 
   d="scan'208";a="473679023"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 14:42:21 +0200
Date:   Wed, 21 Oct 2020 14:42:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Julia Lawall <julia.lawall@inria.fr>, Mel Gorman <mgorman@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] sched/fair: check for idle core
In-Reply-To: <20201021121950.GF2628@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.22.394.2010211422230.8475@hadrien>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <20201021112038.GC32041@suse.de> <alpine.DEB.2.22.394.2010211336410.8475@hadrien> <20201021121950.GF2628@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Oct 2020, Peter Zijlstra wrote:

> On Wed, Oct 21, 2020 at 01:56:55PM +0200, Julia Lawall wrote:
> > Prior to 5.8, my machine was using intel_pstate and had few background
> > tasks.  Thus the problem wasn't visible in practice.  Starting with 5.8
> > the kernel decided that intel_cpufreq would be more appropriate, which
> > introduced kworkers every 0.004 seconds on all cores.
>
> That still doesn't make any sense. Are you running the legacy on-demand
> thing or something?
>
> Rafael, Srinivas, Viresh, how come it defaults to that?

The relevant commits are 33aa46f252c7, and 39a188b88332 that fixes a small
bug.  I have a Intel(R) Xeon(R) CPU E7-8870 v4 @ 2.10GHz that does not
have the HWP feature, even though the cores seemed to be able to change
their frequencies at the hardware level.

julia
