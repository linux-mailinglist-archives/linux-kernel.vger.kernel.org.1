Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F304D2F34AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392149AbhALPwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392116AbhALPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:52:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD54FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gim+qVUIy+YTuGbuf9gtf9FkJhhXyt5UHhPAjQDuG0Q=; b=GvaZoBBCHnTovmb2kCHXIDg2yI
        fqdDk8VFVdxvIZI2hB2zlRJw6vxIbRdnLNw3fzSBAe82dlDmB5ovke4Fc8l6Xa+yC3L9bIW3apdro
        LTgNzijrHiYCVAzDkWY+6WxUn2chSHr0KKWx+JJX/RTK1U/VCSxfM9p6iBn1qi2W6AunFe1mOgmUd
        33dznP3iYL/WMQTt7yMvupuNcPm2SFr816U66yHld6vuh/5CC2lbqAyjg1uwKApyEfe6O/cdXXJuQ
        ArA4OmK3CshRnCJLduWhfUdBrLNZA71E6gbR1miLBYbyvbUrDE2PS1yoynAfymcmj2nuP9gnsJf2e
        oMaix2cg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzLwp-004zBk-7n; Tue, 12 Jan 2021 15:51:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FA5C30015A;
        Tue, 12 Jan 2021 16:51:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1124520C228D1; Tue, 12 Jan 2021 16:51:06 +0100 (CET)
Date:   Tue, 12 Jan 2021 16:51:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <X/3FaoV0K/U7ZuY4@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
 <jhj7doj1dr1.mognet@arm.com>
 <f5b0f650-5dc1-c67d-f548-340e7ca54d41@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b0f650-5dc1-c67d-f548-340e7ca54d41@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 07:57:26AM -0700, Jens Axboe wrote:
> On 1/11/21 12:21 PM, Valentin Schneider wrote:
> > On 11/01/21 18:16, Peter Zijlstra wrote:
> >> Sadly it appears like io_uring() uses kthread_create_on_cpu() without
> >> then having any hotplug crud on, so that needs additinoal frobbing.
> >>
> > 
> > I noticed that as well sometime ago, and I believed then (still do) this
> > usage is broken. I don't think usage of kthread_create_on_cpu() outside
> > of smpboot makes sense, because without any hotplug step to park the
> > thread, its affinity can end up being reset after its dedicated CPU gets
> > offlined.
> > 
> > I'm clueless about io_uring, but if it *actually* has a good reason to
> > use some pcpu kthreads (it seems it doesn't have to be on all CPUs?),
> > then it needs to register some hotplug step to park them / do something
> > sensible on hotplug.
> 
> For io_uring, it's purely used by the SQPOLL mode, which sets aside a
> kernel thread for submissions so the application doesn't have to do
> anything but write new SQE entries to submit. The thread then notices
> these, and submits them. There's an option to affinitize that thread
> to a single CPU, which often makes sense for setups like that. Think
> of it like a strong hint.

OK, that matches what I could make of it earlier today.

> Things aren't going to break if this CPU goes away and we end up being
> affinitized to some other CPU, though it is suboptimal. So I guess we
> might need some notifiers to ensure that we reset the CPU back again
> if it's gone offline+online again? I can take a look at that.

Indeed, that would make sense.

Thanks!
