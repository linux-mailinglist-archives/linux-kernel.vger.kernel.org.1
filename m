Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0ADE2DA97A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgLOIuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgLOIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:50:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC95C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J2eBeW472pFxNO/q1MbXbCxNyCuXy31uhoKzTCDt0M8=; b=TzeZmCI9STPaFOzUQyaoaLU9Ps
        lXiJ3PMImFgOqrDSpIHeqU9TgWj0draK7qL8IAuXfQnNOsTunk033S0+lmJN2I9/IGMyAEVGf+9Ph
        uflaRrSEu0hTq8ZSVvTuaAnhGZgmCmsgB91dqFhEgRZzJLWTmrsQKNilSWxxa5b0YU+AuALor73cG
        OxhzlairuS3ikb88PbEktXVMHqjbbtVXMG412GfuheZXILMrcuHMW5YV3y5Bz89UVxN8OLf7X9Y/c
        2ESAXyPdKUKkejYZjmzY2e57hGKjkeznMU4CoQRPkas3dXiOapPhrGsBeElqx4c9NLi2ud30NQow4
        EjFGDIbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kp61D-0004NO-HW; Tue, 15 Dec 2020 08:49:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA5CC304D28;
        Tue, 15 Dec 2020 09:49:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FED820218DB9; Tue, 15 Dec 2020 09:49:14 +0100 (CET)
Date:   Tue, 15 Dec 2020 09:49:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 00/10] workqueue: break affinity initiatively
Message-ID: <20201215084914.GD3040@hirez.programming.kicks-ass.net>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
 <X9eirnnrD/+VqqEo@hirez.programming.kicks-ass.net>
 <CAJhGHyDYbU2=dQyiyx-AC+wu9=B7mTvsbU=QYPyV4xTE8PFPog@mail.gmail.com>
 <20201215075044.GZ3040@hirez.programming.kicks-ass.net>
 <CAJhGHyA=8vbamdFKwPGFHtL4iObJ929DR+iasVhmODV-u5UNfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyA=8vbamdFKwPGFHtL4iObJ929DR+iasVhmODV-u5UNfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 04:14:26PM +0800, Lai Jiangshan wrote:
> On Tue, Dec 15, 2020 at 3:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Dec 15, 2020 at 01:44:53PM +0800, Lai Jiangshan wrote:
> > > I don't know how the scheduler distinguishes all these
> > > different cases under the "new assumption".
> >
> > The special case is:
> >
> >   (p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1
> >
> >
> 
> So unbound per-node workers can possibly match this test. So there is code
> needed to handle for unbound workers/pools which is done by this patchset.

Curious; how could a per-node worker match this? Only if the node is a
single CPU, or otherwise too?

> Is this the code of is_per_cpu_kthread()? I think I should have also
> used this function in workqueue and don't break affinity for unbound
> workers have more than 1 cpu.

Yes, that function captures it. If you want to use it, feel free to move
it to include/linux/sched.h.

This class of threads is 'special', since it needs to violate the
regular hotplug rules, and migrate_disable() made it just this little
bit more special. It basically comes down to how we need certain per-cpu
kthreads to run on a CPU while it's brought up, before userspace is
allowed on, and similarly they need to run on the CPU after userspace is
no longer allowed on in order to bring it down.

(IOW, they must be allowed to violate the active mask)

Due to migrate_disable() we had to move the migration code from the very
last cpu-down stage, to earlier. This in turn brought the expectation
(which is normally met) that per-cpu kthreads will stop/park or
otherwise make themselves scarce when the CPU goes down. We can no
longer force migrate them.

Workqueues are the sole exception to that, they've got some really
'dodgy' hotplug behaviour.

