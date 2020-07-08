Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC85C218CC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbgGHQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgGHQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:18:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFDDC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i483IMQSRtR6J+n94GaZZET/X/lONTUJSH/4pcYK8jY=; b=J+G840SUfei8u8CJZHruj5Kw3p
        3y3+AoKYPTFfOxz+GtgBh8qi5jW2iVlbQtmMzRgMr8RoWJGpSOD3lE/c6dMxbVmcyfqLr9DeNlura
        II877bwwbuswXMUl+ISOTvxAZYOiL3Orzu68MXsAaeIazcS9JkP9PTjoHGOTIDypClGe+hKmJMDW6
        A6CxpOLrhZNabtMyC9ytQN/33EdSvvx3maKfW4G2qYb98v9IOvS5F8XSlYG8hYnIhvYg4rR74i+PC
        bz21rFdzdPwUxh+AxTCFWQx34PXItOHPW6s+4udZK6FsVezO/xdoP52liLVhHV+wYvnm+ONGHGpWP
        DWRPLizw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtCll-0000lM-Bq; Wed, 08 Jul 2020 16:18:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E4EE3006D0;
        Wed,  8 Jul 2020 18:18:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C3C4214ECDA9; Wed,  8 Jul 2020 18:18:00 +0200 (CEST)
Date:   Wed, 8 Jul 2020 18:18:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/20] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200708161800.GT4800@hirez.programming.kicks-ass.net>
References: <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
 <20200708103314.GB4151780@debian-buster-darwi.lab.linutronix.de>
 <20200708122938.GQ4800@hirez.programming.kicks-ass.net>
 <20200708150930.GA147323@debian-buster-darwi.lab.linutronix.de>
 <20200708153522.GR4800@hirez.programming.kicks-ass.net>
 <20200708155813.GA147953@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708155813.GA147953@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 05:58:13PM +0200, Ahmed S. Darwish wrote:
> > I even considered:
> >
> > #define __SEQPROP(name, prop, expr) \
> > static __always_inline __seqprop_##prop##_t \
> > __seqprop##name##_##prop(seqcount##name##_t *s) \
> > { \
> > 	expr; \
> > }
> >
> > Such that we could write:
> >
> > __SEQPROP(, ptr, return s)
> > __SEQPROP(, preempt, return false)
> > __SEQPROP(, assert, )
> >
> > __SEQPROP(_##locktype, ptr, return &s->seqcount) \
> > __SEQPROP(_##locktype, preempt, return preempt) \
> > __SEQPROP(_##locktype, assert, __SEQCOUNT_LOCKDEP(lockdep_assert_held(s->lockmember))) \
> >
> > But I figured _that_ might've been one step too far ;-)
> 
> Initially I implemented something like this during internal,
> pre-upstream, versions of this patch series. We've decided afterwards
> that the macro compression level is so high that the whole thing is not
> so easily understandable.

I've been reading too much tracing code lately... :-) This is only 2
levels of expansion and fits on a single screen.
