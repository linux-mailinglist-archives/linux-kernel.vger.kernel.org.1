Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9702F4A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbhAMLow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbhAMLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:44:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3EFC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LZbT2EChGstixseu6dKSG3YNQf13dsBbFP2f3mtwFtE=; b=qd2BmLcUJ6TUOCV2N/qasmmqiI
        T5ngTjbi5PHqm2VQ1Bh0GWsnlEofAxrQruNyxEQQPHUJOB/D3Hfrdhfn1NGtgxiYjmHE/0YuIxWhp
        zON3xZOmDgG49ml38kwsH4r6jy+DobPDOrHqBZTj+d9t/g5PZdBa3Y2tOJ8KGl8DlKGdX5ghavZex
        Sp95CLlY+KADUxQ52Lq8V8kX1acBoLbu1u8SsMN6tk/2iHVooU7K+KsjuupLOPue7maZeAkIFBxDz
        qoVJJvSX21+RLqfiwBHeZTFjxpDTutD1pqCrmOMVGErQsM2mAaFnc2779v4+zSWhx9BFWZSEYawEj
        O8d/BRqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzeZD-0004Zq-Pv; Wed, 13 Jan 2021 11:43:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 790FF3059DE;
        Wed, 13 Jan 2021 12:43:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DF7E211618C8; Wed, 13 Jan 2021 12:43:56 +0100 (CET)
Date:   Wed, 13 Jan 2021 12:43:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
Message-ID: <X/7c/PZbzFCO8tfe@hirez.programming.kicks-ass.net>
References: <20210112144344.850850975@infradead.org>
 <20210112144843.849135905@infradead.org>
 <CAJhGHyDWn91eH7-ZPj-utuaugz3UEdGXSKgLYHkdwBr5op=8iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDWn91eH7-ZPj-utuaugz3UEdGXSKgLYHkdwBr5op=8iA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 12:36:55AM +0800, Lai Jiangshan wrote:
> On Tue, Jan 12, 2021 at 10:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Mark the per-cpu workqueue workers as KTHREAD_IS_PER_CPU.
> >
> > Workqueues have unfortunate semantics in that per-cpu workers are not
> > default flushed and parked during hotplug, however a subset does
> > manual flush on hotplug and hard relies on them for correctness.
> >
> > Therefore play silly games..
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> 
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> 
> I like this patchset in that the scheduler takes care of the
> affinities of the tasks when we don't want it to be per-cpu.

Thanks! A possibly even simpler approach would be to have
rebind_workers() kill all workers and have create_worker() spawn us new
ones.

That avoids ever having to use set_cpus_allowed_ptr() on per-cpu
kthreads.... with the exception of rescuer.. still pondering that.
