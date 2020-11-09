Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450252AC035
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgKIPrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:47:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgKIPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604936839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8pWVQ7yikgeD6/Dj3AtdD+oKfX4f+7x9yI7P3tKNho=;
        b=FZkBDn2T2hAOfqb+pCZG6gNO2VimLUG8IxiGc5jZwtyLOpVpcDf8hx1juivzFSvJSJziDg
        VyIK+/ET34huKnRbmvrrLJHYly7oYldPCUepZvn+7HLSdeK/V+VeSvUqIhVshzaA+5uT7/
        fmpbkhjb30CpfQkidv4m8y+h5v64/P4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-YFCQLnURMoW6RXST7tsAJg-1; Mon, 09 Nov 2020 10:47:17 -0500
X-MC-Unique: YFCQLnURMoW6RXST7tsAJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B214210866D2;
        Mon,  9 Nov 2020 15:47:15 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-32.phx2.redhat.com [10.3.113.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B543C277D5;
        Mon,  9 Nov 2020 15:47:09 +0000 (UTC)
Date:   Mon, 9 Nov 2020 10:47:07 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Foley <robert.foley@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v1] sched/fair: update_pick_idlest() Select group with
 lowest group_util when idle_cpus are equal
Message-ID: <20201109154707.GC610888@lorien.usersys.redhat.com>
References: <20200714125941.4174-1-peter.puhov@linaro.org>
 <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com>
 <20201104094205.GI3306@suse.de>
 <20201106120303.GE3371@techsingularity.net>
 <CAKfTPtDbyrcZtzPPsdQFOxOkreg-ejn=ABGOGqYjdVpeFPEzPw@mail.gmail.com>
 <20201106160010.GF3371@techsingularity.net>
 <20201109152411.GA610888@lorien.usersys.redhat.com>
 <20201109153815.GH3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109153815.GH3371@techsingularity.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 03:38:15PM +0000 Mel Gorman wrote:
> On Mon, Nov 09, 2020 at 10:24:11AM -0500, Phil Auld wrote:
> > Hi,
> > 
> > On Fri, Nov 06, 2020 at 04:00:10PM +0000 Mel Gorman wrote:
> > > On Fri, Nov 06, 2020 at 02:33:56PM +0100, Vincent Guittot wrote:
> > > > On Fri, 6 Nov 2020 at 13:03, Mel Gorman <mgorman@techsingularity.net> wrote:
> > > > >
> > > > > On Wed, Nov 04, 2020 at 09:42:05AM +0000, Mel Gorman wrote:
> > > > > > While it's possible that some other factor masked the impact of the patch,
> > > > > > the fact it's neutral for two workloads in 5.10-rc2 is suspicious as it
> > > > > > indicates that if the patch was implemented against 5.10-rc2, it would
> > > > > > likely not have been merged. I've queued the tests on the remaining
> > > > > > machines to see if something more conclusive falls out.
> > > > > >
> > > > >
> > > > > It's not as conclusive as I would like. fork_test generally benefits
> > > > > across the board but I do not put much weight in that.
> > > > >
> > > > > Otherwise, it's workload and machine-specific.
> > > > >
> > > > > schbench: (wakeup latency sensitive), all machines benefitted from the
> > > > >         revert at the low utilisation except one 2-socket haswell machine
> > > > >         which showed higher variability when the machine was fully
> > > > >         utilised.
> > > > 
> > > > There is a pending patch to should improve this bench:
> > > > https://lore.kernel.org/patchwork/patch/1330614/
> > > > 
> > > 
> > > Ok, I've slotted this one in with a bunch of other stuff I wanted to run
> > > over the weekend. That particular patch was on my radar anyway. It just
> > > got bumped up the schedule a little bit.
> > >
> > 
> > 
> > We've run some of our perf tests against various kernels in this thread.
> > By default RHEL configs run with the performance governor.
> > 
> 
> This aspect is somewhat critical because the patches affect CPU
> selection. If a mostly idle CPU is used due to spreading load wider,
> it can take longer to ramp up to the highest frequency. It can be a
> dominating factor and may account for some of the differences.
> 
> Generally my tests are not based on the performance governor because a)
> it's not a universal win and b) the powersave/ondemand govenors should
> be able to function reasonably well. For short-lived workloads it may
> not matter but ultimately schedutil should be good enough that it can
> keep track of task utilisation after migrations and select appropriate
> frequencies based on the tasks historical behaviour.
>

Yes, I suspect that is why we don't see the more general performance hits
you're seeing.

I agree that schedutil would be nice. I don't think it's quite there yet, but
that's anecdotal. Current RHEL configs don't even enable it so it's harder to
test. That's something I'm working on getting changed. I'd like to make it
the default eventually but at least we need to have it available...

Cheers,
Phil


> -- 
> Mel Gorman
> SUSE Labs
> 

-- 

