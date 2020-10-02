Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20E62814D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbgJBOR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387688AbgJBOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:17:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B216CC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jgsX8gPeom1s3mUVmZBADIBIDjRhafLLwkFMJD6kiPY=; b=Dt8f4MZD3FydC6BquvlZkallP6
        LVlyOaro4hl+X9qVb9nR5cw0qiEBTPkl6je9G9ImzEpG5Zt98282y/9+VZbIcS81rYYTsOr5mqgVi
        06NNlVtr7yAIxsmxJfTkYuI+3RfA0FuOJ3VjS/mtodjnQaowGHCK377zA8+11WRnuuFIRScUbVGBR
        UmPs7H28CT5cWQ3cun9HQ0I9vmZklF1HnCoZcSvqPUji39c5Puam4NYA/PqnHfI+L6ohDRy1Q3czD
        L7x3Gif6NI3aazXeL9KOo8Kynqqcqe/N+6u42E7pAEeSDh0twtGS0I94s78tpVTtpBBFc6PpDMtrX
        2VK+UqVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOLs1-0007aB-QE; Fri, 02 Oct 2020 14:17:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 513103006D0;
        Fri,  2 Oct 2020 16:17:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37E43203A8F66; Fri,  2 Oct 2020 16:17:09 +0200 (CEST)
Date:   Fri, 2 Oct 2020 16:17:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: [PATCH 5/9] sched/hotplug: Consolidate task migration on CPU
 unplug
Message-ID: <20201002141709.GX2628@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.644634229@infradead.org>
 <20201001171138.GA299736@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001171138.GA299736@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 06:12:30PM +0100, Vincent Donnefort wrote:
> On Mon, Sep 21, 2020 at 06:36:02PM +0200, Peter Zijlstra wrote:
> 
> [...]
> 
> > +
> > +     [CPUHP_AP_SCHED_WAIT_EMPTY] = {
> > +             .name                   = "sched:waitempty",
> > +             .startup.single         = NULL,
> > +             .teardown.single        = sched_cpu_wait_empty,
> > +     },
> > +
> >       /* Handle smpboot threads park/unpark */
> 
> Unless I missed something, now that the wait has its own HP step, this
> patch can probably also get rid of the balance_hotplug_wait() in
> sched_cpu_deactivate() introduced by: 
> 
>   [PATCH 4/9] sched/core: Wait for tasks being pushed away on hotplug

I'd think so. Consider it gone.
