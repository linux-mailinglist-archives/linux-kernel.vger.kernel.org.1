Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339692F7504
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbhAOJOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbhAOJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:14:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25066C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 01:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SIFhfiL1Z14MrasYfZQFoTuOWX0kSO+EDmZivWAJL+Y=; b=Kzv0oyyN8iRAtbg02Mi9CDFixF
        v5jLs4InC1GkjgDaLa/sIFLu13F4e0+6vldWXJO33U0fyh1eGwNuiFegTFI5gOoHe9lHUmkLpVI5b
        12Kl7SFVZlB2dBACHI+tyLmBkcT4iuaxbKkNOCz8dDtXjD7Y2Z5F+DuKwF3s0TrcreW19mPuKNypV
        IebG+hHy1PFCx8jOWcDlyZY+d9/KBES59NP25hgBaHIe4z/eFEOmMq9w/g+c7B3Mtx/dH9SL89yGV
        ioODbl68y438EZ491aUsKm4WmLndwcYwfnCfbxGaqKuGCRRJlGW+69I1EwF9n5DRyK6sTNsrCw4Ya
        Ywps2Jvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0L97-008iCQ-CA; Fri, 15 Jan 2021 09:11:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9B20305815;
        Fri, 15 Jan 2021 10:11:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80C20200E0BD2; Fri, 15 Jan 2021 10:11:51 +0100 (CET)
Date:   Fri, 15 Jan 2021 10:11:51 +0100
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
Message-ID: <YAFcVy9wIezTa2mM@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
 <20210111180907.GE2743@paulmck-ThinkPad-P72>
 <20210111215052.GA19589@paulmck-ThinkPad-P72>
 <20210112171411.GA22823@paulmck-ThinkPad-P72>
 <20210112235324.GA17895@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112235324.GA17895@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 03:53:24PM -0800, Paul E. McKenney wrote:
> An SRCU-P run on the new series reproduced the warning below.  Repeat-by:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10 --configs "112*SRCU-P" --bootargs "rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutree.softirq=0" --trust-make

Lemme go wake up an EX ;-)

Anyway, I've folded my patch:

  https://lkml.kernel.org/r/YABknAqDe4h35+GY@hirez.programming.kicks-ass.net

back into the series, so be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent

and will start testing on that while I continue to ponder the rescuer
mysteries.
