Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F70295DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897771AbgJVMC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503613AbgJVMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:02:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38DFC0613CE;
        Thu, 22 Oct 2020 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gTvwyP4W6lMb1iDzrz192ROjJ8CmrjSNmaU03xagOrU=; b=vglESL+rFHLeeSzkcYF+jhH4T+
        JKZjPxQZO+Bbc9ELF+X2ImWPdgF5pnprHBVaQFmgK1WXteBPWt0iPnravt93FIRZiPeoi/Tm+NhDD
        Royjc9fay9qrD5B5jiqpVgi9HijdZMTlhX7IXvq8KPqupJXroRQ5ObD9lvZJGyh6GEVUTuP26xwb8
        RvpWGz2JX4shWecvEpiQv9IrlGT4PgGIwTlG3uO3wblAH2WtFgHh28FVvGocBX58yXbLf+P5C0Wbh
        kPMgyoO2AtY3QJ4ghUcpChKq5knPIC7L94QPH5a8+UWL8NSGYflMr3QTJUBsWRqByDNcl1uoovLVs
        tlaIGjzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVZIM-00085y-0A; Thu, 22 Oct 2020 12:02:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46E06305CC3;
        Thu, 22 Oct 2020 14:02:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36CD0203CC4B2; Thu, 22 Oct 2020 14:02:13 +0200 (CEST)
Date:   Thu, 22 Oct 2020 14:02:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
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
        srinivas.pandruvada@linux.intel.com
Subject: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
Message-ID: <20201022120213.GG2611@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201022071145.GM2628@hirez.programming.kicks-ass.net>
 <20201022104703.nw45dwor6wfn4ity@vireshk-i7>
 <34115486.YmRjPRKJaA@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34115486.YmRjPRKJaA@kreacher>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:45:25PM +0200, Rafael J. Wysocki wrote:
> On Thursday, October 22, 2020 12:47:03 PM CEST Viresh Kumar wrote:
> > On 22-10-20, 09:11, Peter Zijlstra wrote:
> > > Well, but we need to do something to force people onto schedutil,
> > > otherwise we'll get more crap like this thread.
> > > 
> > > Can we take the choice away? Only let Kconfig select which governors are
> > > available and then set the default ourselves? I mean, the end goal being
> > > to not have selectable governors at all, this seems like a good step
> > > anyway.
> > 
> > Just to clarify and complete the point a bit here, the users can still
> > pass the default governor from cmdline using
> > cpufreq.default_governor=, which will take precedence over the one the
> > below code is playing with. And later once the kernel is up, they can
> > still choose a different governor from userspace.
> 
> Right.
> 
> Also some people simply set "performance" as the default governor and then
> don't touch cpufreq otherwise (the idea is to get everything to the max
> freq right away and stay in that mode forever).  This still needs to be
> possible IMO.

Performance/powersave make sense to keep.

However I do want to retire ondemand, conservative and also very much
intel_pstate/active mode. I also have very little sympathy for
userspace.

We should start by making it hard to use them and eventually just delete
them outright.

