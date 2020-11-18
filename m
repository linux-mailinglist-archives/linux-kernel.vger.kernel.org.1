Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF52B7F07
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgKROFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKROFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:05:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B5C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 06:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SRmITErRt273liPjxpQOr8k10eGyCVQd+oV0RHOfBgg=; b=Lc+iP3vYX/J/TWn3D4stEmb+V5
        ttvAK1YsmPryTwE0+L1P/jjlGcNq8vgv0SSqiTHmWIjLP3k/wGrHQzs9MaAmQIqjZSwvwNHT1TRez
        4d24VAkkv9AJoIAXUJvfY8+4WhrUsgQbueGve5RMuxjBWwq/cOunRXTqXG8JZgYm7V4m4fEG2F8QH
        lc2vXMkQRdEAqlbwnVVftOdDsNCE0Mm0vlqDRaFmdmlocKf2LfZ/u+uW/LmFA9whT9mDO3WFeet7v
        LZSgBCiZvN+3hhPZXPVD5HVeYkEJC0yIP1sjtHib+QDPREIX8hj46kbZhonfmI1Snq7nMlwGsZXco
        IPV8+qqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfO53-0003sB-2h; Wed, 18 Nov 2020 14:05:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A58933012C3;
        Wed, 18 Nov 2020 15:05:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FCFA2BC27D38; Wed, 18 Nov 2020 15:05:03 +0100 (CET)
Date:   Wed, 18 Nov 2020 15:05:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/5] context_tracking: Flatter archs not using
 exception_enter/exit() v3
Message-ID: <20201118140503.GU3121392@hirez.programming.kicks-ass.net>
References: <20201117151637.259084-1-frederic@kernel.org>
 <20201118073947.GQ3121392@hirez.programming.kicks-ass.net>
 <20201118134826.GA279436@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118134826.GA279436@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 02:48:26PM +0100, Frederic Weisbecker wrote:
> On Wed, Nov 18, 2020 at 08:39:47AM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 17, 2020 at 04:16:32PM +0100, Frederic Weisbecker wrote:
> > > Frederic Weisbecker (5):
> > >       context_tracking: Introduce HAVE_CONTEXT_TRACKING_OFFSTACK
> > >       context_tracking:  Don't implement exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
> > >       sched: Detect call to schedule from critical entry code
> > >       context_tracking: Only define schedule_user() on !HAVE_CONTEXT_TRACKING_OFFSTACK archs
> > >       x86: Support HAVE_CONTEXT_TRACKING_OFFSTACK
> > 
> > Thanks!
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks! Probably this should go through your branches?

Fair enough; these are now headed for tip/core/entry.
