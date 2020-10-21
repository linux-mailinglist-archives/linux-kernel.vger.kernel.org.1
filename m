Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCCC294D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442675AbgJUMw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440686AbgJUMw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:52:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB12C0613CE;
        Wed, 21 Oct 2020 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uq5uoGCfFjFseaKYtetVeX6eT0EP/TsERuBq6LOZk28=; b=Viwr+En7j03ibYqEEkgIXLWjwm
        uoFtHwXEVjyaPwD5mUXxPpH/k55ZSM2o+5sGbVHB477cW8yBE2SigNf+qDScZPo9e5HT4fDjzbODM
        KQ84HwFNcF3jovtgNhIV/gYosM632W3GCdZGJVDpCEkItzhZ9dXCmMvOK6iU99AQwXB4aCbDsqi+n
        0Qj88YRBZV+rjtuuWW2IeGyyLavF1iszNTKlyVwfQEBSf1Bs4c4y2yyUghgoFNKOiOWrxdtaL2FSv
        eeHD/W66+MnL/9vzKvoBJAw0at/KEAy/cQltrbMHyzIpZG1DA8mh16lATxDCSTJZyUV53r9BGPkWq
        lew1craw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVDb3-0007Bh-1V; Wed, 21 Oct 2020 12:52:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5619302753;
        Wed, 21 Oct 2020 14:52:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 717C82BA9E6D3; Wed, 21 Oct 2020 14:52:03 +0200 (CEST)
Date:   Wed, 21 Oct 2020 14:52:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20201021125203.GG2628@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021112038.GC32041@suse.de>
 <alpine.DEB.2.22.394.2010211336410.8475@hadrien>
 <20201021121950.GF2628@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2010211422230.8475@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2010211422230.8475@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:42:20PM +0200, Julia Lawall wrote:
> 
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

That just makes intel_pstate not prefer active mode. With the clear
intent that it should then go use schedutil, but somehow it looks like
you landed on ondemand, which is absolutely atrocious.

What's:

  $ for i in /sys/devices/system/cpu/cpu0/cpufreq/scaling_*; do echo -n $i ": "; cat $i; done

say, for you? And if you do:

  $ for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor ; do echo schedutil > $i; done

Are the kworkers gone?


