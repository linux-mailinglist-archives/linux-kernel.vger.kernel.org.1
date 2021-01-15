Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751B82F7BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbhAONHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732778AbhAONH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:07:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C48C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4hCJR1XpGxzoY7Z8SGdX7VVnmJPSGSe1Nv9um16SGP8=; b=AE05uDUwr/LXFSxo8iOKuv+SZY
        W3+NTFISAtuSbotoa8GSl/lhs+843JIjrCtTFn/Vqe61GcALdaKJNe1fVRLBEfhsK83XYv4nEUUC+
        VPG+oPy1ZYKru9wdepbl7eSEutue7qN1T3IAf8Sdfhig8ok25oRXKbaPxEGvwZXbbvoN35/gtlJYy
        fXHAv4KZw/IOtkd3u+QHwo2ELtuTY4oFH/UN+0ijTR3VJJf81V6m9WEPlG7OcobuHWSz8+ICMDf1F
        1at+Ao/ZVcJ9dFOsTbrGIOMPuJh0w1aBOx9B5gwpWHbUaSuqMhnO/kd8gGskFiNEYlo218OXmHBqd
        U89qWqyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0OmD-008xXB-Rw; Fri, 15 Jan 2021 13:04:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FC3530791E;
        Fri, 15 Jan 2021 14:04:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CC2823654448; Fri, 15 Jan 2021 14:04:27 +0100 (CET)
Date:   Fri, 15 Jan 2021 14:04:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <YAGS2mulIw6o+sY5@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
 <20210111180907.GE2743@paulmck-ThinkPad-P72>
 <20210111215052.GA19589@paulmck-ThinkPad-P72>
 <20210112171411.GA22823@paulmck-ThinkPad-P72>
 <20210112235324.GA17895@paulmck-ThinkPad-P72>
 <YAFcVy9wIezTa2mM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAFcVy9wIezTa2mM@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:11:51AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 12, 2021 at 03:53:24PM -0800, Paul E. McKenney wrote:
> > An SRCU-P run on the new series reproduced the warning below.  Repeat-by:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10 --configs "112*SRCU-P" --bootargs "rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutree.softirq=0" --trust-make
> 
> Lemme go wake up an EX ;-)

Whee, rescuer thread goes wobbly... took a few hours but there you have
it.

All I've got so far is fugly, gotta think harder.
