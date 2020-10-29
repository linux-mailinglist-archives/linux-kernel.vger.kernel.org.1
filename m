Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5129F3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgJ2R7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgJ2R7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:59:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08407C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yYXY2ccmYEcpBjZVaiEIq5/m8qPCIZAO5UGU1CEFvAU=; b=2VqY6xxt+stJ3pGPjJ3+NuU0xP
        ERk+etg1R4P8v60qjKT9vh0EgGLSGIKW393MT01NZmdIlCmU7FjfUwizXFzkLfzmYiV3dJmBp4AgD
        YsXnStBMIItPTbUN5CGoqN070WASOisv1s5Awo8Mda9R+86beuSWpTeMZGtkwtsTxoNFqZSMn+FjH
        Clgxz482Hl+uImjeYE8LElBOteo3tWsIBeljvCvdbFHcscVkb3A596qttVqi4oSfMFNHchd/0BG0l
        m0Pc2cslfYXE2xFrvTIkAmG+vQlhmWcZywK7KNfoNqgH0Y612zWM8jxIngWtGkNU7R+bIVZMqBkFt
        omlKEeFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYCCq-00052W-QB; Thu, 29 Oct 2020 17:59:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41DDC300455;
        Thu, 29 Oct 2020 18:59:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E35A203C534D; Thu, 29 Oct 2020 18:59:23 +0100 (CET)
Date:   Thu, 29 Oct 2020 18:59:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 17/19] sched: Add migrate_disable() tracepoints
Message-ID: <20201029175923.GF2611@hirez.programming.kicks-ass.net>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.697960969@infradead.org>
 <jhja6w5ov4h.mognet@arm.com>
 <20201029174302.GV2628@hirez.programming.kicks-ass.net>
 <jhj5z6sq5kz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj5z6sq5kz.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 05:56:12PM +0000, Valentin Schneider wrote:
> 
> On 29/10/20 17:43, Peter Zijlstra wrote:
> > On Thu, Oct 29, 2020 at 04:27:26PM +0000, Valentin Schneider wrote:
> >> Don't you want those directly after the ->migration_disabled write?
> >> esp. for migrate_enable(), if that preempt_enable() leads to a context
> >> switch then the disable->enable deltas won't reflect the kernel view.
> >> 
> >> That delta may indeed include the time it took to run the stopper and
> >> fix the task's affinity on migrate_enable(), but it could include all
> >> sorts of other higher-priority tasks.
> >
> > I can put them in the preempt_disable() section I suppose, but these
> > tracers should be looking at task_sched_runtime(), not walltime, and
> > then the preemption doesn't matter.
> >
> 
> True. I was thinking of how to process it downstream, and the first thing
> that came to mind was that rd->overutilized flag which we do monitor
> fairly closely; however that is system-wide while migrate_disable() is
> task-specific.
> 
> > Also, a distinct lack of actual users atm.. :/
> 
> If you'd rather ditch this one altogether until someone asks for it, that
> also works for me.

Yeah, I can pull this patch until we get someone that actually needs it.
