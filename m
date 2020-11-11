Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E12AEDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgKKJb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKKJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:31:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFBC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2YkmMhJ09hnzxbUnSI5lLRNzDfT7Lw3gnyWLwkokhfw=; b=i6F5sxBUAdPFcVZ6f22ZizTPrC
        6FsgtZuI+BbMesbsvaquyqANJE+/RAujuHmsDZIbXlholrkKxT48OrbjMTg12FK0iY5yDfAZqTc93
        ehtpiBIdqE8jmNmUyTz9aUHdpZDeeH5GQgib9J/D/r9QCmOJbeMsfhd+EaV4LjITk1kV4jYp/YRu6
        KpY77QNly5vD3QYTiwasdxcrls12Pn1glMUKVg+PtJatl/sMyLNFF7xtJN7iYVXUXq9McrpUV0aP+
        85Sfl7EDRTkTMpFC0iwXCZod7GJL5qmEAgdo7NVDC/uTggYjcIowc4WqME7L9ZH+Ivu4GNStdZymx
        QbC+Cdzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcmTY-00046y-RC; Wed, 11 Nov 2020 09:31:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1B84305C16;
        Wed, 11 Nov 2020 10:31:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66C742CB07571; Wed, 11 Nov 2020 10:31:34 +0100 (CET)
Date:   Wed, 11 Nov 2020 10:31:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] sched/topology: Warn when NUMA diameter > 2
Message-ID: <20201111093134.GR2594@hirez.programming.kicks-ass.net>
References: <20201110184300.15673-1-valentin.schneider@arm.com>
 <20201111084331.GJ3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111084331.GJ3371@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:43:31AM +0000, Mel Gorman wrote:
> On Tue, Nov 10, 2020 at 06:43:00PM +0000, Valentin Schneider wrote:
> > NUMA topologies where the shortest path between some two nodes requires
> > three or more hops (i.e. diameter > 2) end up being misrepresented in the
> > scheduler topology structures.
> > 
> > This is currently detected when booting a kernel with CONFIG_SCHED_DEBUG=y
> > + sched_debug on the cmdline, although this will only yield a warning about
> > sched_group spans not matching sched_domain spans:
> > 
> >   ERROR: groups don't span domain->span
> > 
> > Add an explicit warning for that case, triggered regardless of
> > CONFIG_SCHED_DEBUG, and decorate it with an appropriate comment.
> > 
> > The topology described in the comment can be booted up on QEMU by appending
> > the following to your usual QEMU incantation:
> > 
> >     -smp cores=4 \
> >     -numa node,cpus=0,nodeid=0 -numa node,cpus=1,nodeid=1, \
> >     -numa node,cpus=2,nodeid=2, -numa node,cpus=3,nodeid=3, \
> >     -numa dist,src=0,dst=1,val=20, -numa dist,src=0,dst=2,val=30, \
> >     -numa dist,src=0,dst=3,val=40, -numa dist,src=1,dst=2,val=20, \
> >     -numa dist,src=1,dst=3,val=30, -numa dist,src=2,dst=3,val=20
> > 
> > A somewhat more realistic topology (6-node mesh) with the same affliction
> > can be conjured with:
> > 
> >     -smp cores=6 \
> >     -numa node,cpus=0,nodeid=0 -numa node,cpus=1,nodeid=1, \
> >     -numa node,cpus=2,nodeid=2, -numa node,cpus=3,nodeid=3, \
> >     -numa node,cpus=4,nodeid=4, -numa node,cpus=5,nodeid=5, \
> >     -numa dist,src=0,dst=1,val=20, -numa dist,src=0,dst=2,val=30, \
> >     -numa dist,src=0,dst=3,val=40, -numa dist,src=0,dst=4,val=30, \
> >     -numa dist,src=0,dst=5,val=20, \
> >     -numa dist,src=1,dst=2,val=20, -numa dist,src=1,dst=3,val=30, \
> >     -numa dist,src=1,dst=4,val=20, -numa dist,src=1,dst=5,val=30, \
> >     -numa dist,src=2,dst=3,val=20, -numa dist,src=2,dst=4,val=30, \
> >     -numa dist,src=2,dst=5,val=40, \
> >     -numa dist,src=3,dst=4,val=20, -numa dist,src=3,dst=5,val=30, \
> >     -numa dist,src=4,dst=5,val=20
> > 
> > Link: https://lore.kernel.org/lkml/jhjtux5edo2.mognet@arm.com
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks!
