Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E792AD80F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgKJNxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:53:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/C4iu3Yy2tDaDWFCW7MkzfeRGvHzVl77Kf41stSo9uM=; b=eb6P/gsXFXuyFBnomD95KO75q0
        IQvIQ/mFOvGSCXYn/36oewHdlm2Vst7ULnNyH0/+azw0ZG6v2IcZZJU/t3KcFNhSgioQEO6lXvLbN
        flZPpl/c0Te8eWMXuR6zVpw9GAvlcBk1ojjYpMgLZ1OXXK5TPpcOJpB86DB4ssSDdT9/Bvln3voFy
        M0Ozkr2Gly8PsYevwKjs0r58wyGgLwzKkG+b75cErWrxGVK18/mtjFj0TpIJi1PxWzA2hrxRWvYem
        c+xpLW4QY6/fGa0KzUMGq2X+m7bT4edSKrCQ3O89HghoMQfuqWWr1tqgLN6Y5dsVP4tSuxd4jMAfd
        mhufrKpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcU5G-0001PS-PP; Tue, 10 Nov 2020 13:53:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D5E8301E02;
        Tue, 10 Nov 2020 14:53:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90CE729A566CB; Tue, 10 Nov 2020 14:53:15 +0100 (CET)
Date:   Tue, 10 Nov 2020 14:53:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 1/7] static_call/x86: Add __static_call_returnl0()
Message-ID: <20201110135315.GO2611@hirez.programming.kicks-ass.net>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-2-frederic@kernel.org>
 <20201110095515.GA2594@hirez.programming.kicks-ass.net>
 <20201110101307.GO2651@hirez.programming.kicks-ass.net>
 <20201110134223.GB48886@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110134223.GB48886@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:42:23PM +0100, Frederic Weisbecker wrote:
> On Tue, Nov 10, 2020 at 11:13:07AM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 10, 2020 at 10:55:15AM +0100, Peter Zijlstra wrote:
> > > On Tue, Nov 10, 2020 at 01:56:03AM +0100, Frederic Weisbecker wrote:
> > > 
> > > > [fweisbec: s/disp16/data16, integrate into text_get_insn(), elaborate
> > > >  comment on the resulting insn, emulate on int3 trap, provide validation,
> > > >  uninline __static_call_return0() for HAVE_STATIC_CALL]
> > 
> > > Why did you add full emulation of this? The patch I send to you used the
> > > text_poke_bp(.emulate) argument to have it emulate an actual call to the
> > > out-of-line version of that function.
> > > 
> > > That should work fine and is a lot less code.
> > 
> > For reference; the below is what I send you. Actually doing the
> > __static_call_return0() call while we poke the magic XOR instruction is
> > much simpler.
> 
> Ok I'll get back to that. I'll just tweak a bit static_call_validate()
> so that it is aware of that instruction.

Ah yes indeed!
