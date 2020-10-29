Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328C829F0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgJ2QOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2QOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:14:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3350C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LhuofQkAKGd/YF/+qRDWxyj17oCuNKJrfx9ycxD07Lk=; b=AyWh4JweZ+X78boxL+Gz3V2hhf
        5NkWEVf85MVmpe4TVtaHVW2zsciTXnaTLIuxbepQrxTrLrP6LIje7GRtPp3XWEe8ZRW8KP0ijTMSn
        xJu3BSHgPt8F3QTowwKFayvT4lrlF/cT1PfF1NqqKrV7e4vXjSH8iRMHK+D/0VC7SfNRiZZuUKreg
        EJZBLthsmLTlaaW2UtHZNb/pjT//thfXMQ4dbCg79ZffWZp1+eWusqDtyIyg2QvcZXYXAToRbbwOm
        rpZeXy8f9xC3P6cIHW0KuBjYvPs3VEuCRSBy4lGWKCBOJ1dRr6ogr8bOFvtuTPcUMqRl/reNO8cMM
        yLoMuFGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYAZN-0001Ig-TT; Thu, 29 Oct 2020 16:14:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6EB5300446;
        Thu, 29 Oct 2020 17:14:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C30320409A7D; Thu, 29 Oct 2020 17:14:31 +0100 (CET)
Date:   Thu, 29 Oct 2020 17:14:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v3 6/6] rcu/tree: Use irq_work_queue_remote()
Message-ID: <20201029161431.GR2628@hirez.programming.kicks-ass.net>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.584884062@infradead.org>
 <20201028145428.GE2628@hirez.programming.kicks-ass.net>
 <20201028200243.GJ2651@hirez.programming.kicks-ass.net>
 <20201028201554.GE3249@paulmck-ThinkPad-P72>
 <20201029091053.GG2628@hirez.programming.kicks-ass.net>
 <20201029160448.GL3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029160448.GL3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 09:04:48AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 29, 2020 at 10:10:53AM +0100, Peter Zijlstra wrote:

> > Dang, clearly TREE01 didn't actually hit any of this code :/ Is there
> > another test I should be running?
> 
> TREE01 is fine, but you have to tell rcutorture to actually generate an
> RCU CPU stall warning.  Like this for a 25-second stall with interrupts
> disabled:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --configs "10*TREE04" --bootargs "rcutorture.stall_cpu=25 rcutorture.stall_cpu_irqsoff=1" --trust-make

> Of course, to test your change, you also need the grace-period kthread to
> migrate to the stalled CPU just after interrupts are enabled.  For this,
> you need something like an 11-second stall plus something to move the
> grace-period kthread at the right (wrong?) time.  Or just run the above
> commands in a loop on a system with ample storage over night or some such.
> I see about 70MB of storage per run, so disk size shouldn't be too much
> of a problem.

Thanks!, I'll make the above run over night in a loop.
