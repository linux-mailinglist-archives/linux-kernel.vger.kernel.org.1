Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD38C26E545
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIQTRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgIQQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:18:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB5EC061355
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hSnz+23COfeSjN/62Urx3BsW/vPBbP67EbWGZophf4Q=; b=T9xqcvop0dh6dHsCjx6U+kG4ou
        I9s7n6jedGM1kL+raItlgC1+HPwi/EvQUdGMwSaeLSuFZHpBk1jPZyQRd6VfyE99TakP+e1Nc+kTv
        b0yquF5xdTs27TcfNfYvym4EBsxAPpMZxposa9XJKci2rvkRkkaYx3vYFWrZZd4fr0dWxBp25OouG
        ygrpHasuF+pJI7bLfHdx3rZDw6yb0rD4O1mx5GabWH8eg8pFGUTbGrfglz6+AtFISW5ZQJD2A2F0B
        jmVoXRewoGl+lTXXjTJEfPL/3RO8KF1LrW9XecB7le6URosk48vmRD9BmvXZbJSStUUlx1nP7aPO8
        Vp2VuY2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIwEf-0004Aw-JP; Thu, 17 Sep 2020 15:54:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 973EF3019CE;
        Thu, 17 Sep 2020 17:54:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79D222BCBFCFC; Thu, 17 Sep 2020 17:54:10 +0200 (CEST)
Date:   Thu, 17 Sep 2020 17:54:10 +0200
From:   peterz@infradead.org
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [patch 09/10] sched/core: Add migrate_disable/enable()
Message-ID: <20200917155410.GK1362448@hirez.programming.kicks-ass.net>
References: <20200917094202.301694311@linutronix.de>
 <20200917101624.813835219@linutronix.de>
 <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
 <20200917143850.25akkvr32ojtwohy@linutronix.de>
 <20200917144937.GI1362448@hirez.programming.kicks-ass.net>
 <20200917151341.2ilqamtnc6hperix@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917151341.2ilqamtnc6hperix@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 05:13:41PM +0200, Sebastian Siewior wrote:
> On 2020-09-17 16:49:37 [+0200], peterz@infradead.org wrote:
> > I'm aware of the duct-tape :-) But I was under the impression that we
> > didn't want the duct-tape, and that there was lots of issues with the
> > FPU code, or was that another issue?
> 
> Of course it would be better not to need the duct tape. 
> Also symmetrical locking is what you want but clearly futex is one of
> a kind.
> 
> I'm currently not aware of any issues in the FPU code in regard to this.
> A few weeks ago, I was looking for this kind of usage and only futex
> popped up.

I'm not sure what the problem with FPU was, I was throwing alternatives
at tglx to see what would stick, in part to (re)discover the design
constraints of this thing.

One reason for not allowing migrate_disable() to sleep was: FPU code.

Could it be it does something like:

	preempt_disable();
	spin_lock();

	spin_unlock();
	preempt_enable();

Where we'll never get preempted while migrate_disable()'d and thus never
trigger any of the sleep paths?
