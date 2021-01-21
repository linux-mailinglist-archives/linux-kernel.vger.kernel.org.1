Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF942FE8B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbhAUL0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbhAULWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:22:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F51C0617BB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WqyNpXI5pmXHjcYlLaaycMpQoGvzt5SeeKBz6CK9jCI=; b=uNJUY6vur+KShXtcvcl0JkKTH6
        uQ5C2vQfecaFSiumG/gAoAgO420EEc/WIdLjhUkZSo5ASTR1Ukin8yk6GIM80Gbqh2zBG9dgmil12
        JrfXY+K2BF2MsB+rJBInM8JqCN2ZzPPsoJfIwirGmcpKXXD1Up3WUJrN7ke9T5mXrrI9chKeUUJoz
        EUw1/egd7orKJcxkOzE4SzG62+YUJjrXHrD+5vIhtcrEresP1QcnOfqfq5475VSJ4/DE3KVlx8uH7
        eTZ84wiXGboB/CpKgCvXv/D/qiIkMGS6LNK/pXiQB4ER0w0s1fbNJLVTVCyI07Ad3m9UHzbEiv8Su
        t3lSmkHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2Xz0-00Gxt2-CM; Thu, 21 Jan 2021 11:18:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF74A303271;
        Thu, 21 Jan 2021 12:18:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB6542028D4B7; Thu, 21 Jan 2021 12:18:33 +0100 (CET)
Date:   Thu, 21 Jan 2021 12:18:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 3/4] cpu/hotplug: Add cpuhp_invoke_callback_range()
Message-ID: <YAljCQZf+ZqB3S4K@hirez.programming.kicks-ass.net>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
 <1610385047-92151-4-git-send-email-vincent.donnefort@arm.com>
 <YAhsLPLXg37fs/BA@hirez.programming.kicks-ass.net>
 <YAhuHdcfKnyWKdka@hirez.programming.kicks-ass.net>
 <20210121105756.GA312559@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121105756.GA312559@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 10:57:57AM +0000, Vincent Donnefort wrote:
> On Wed, Jan 20, 2021 at 06:53:33PM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 20, 2021 at 06:45:16PM +0100, Peter Zijlstra wrote:
> > > On Mon, Jan 11, 2021 at 05:10:46PM +0000, vincent.donnefort@arm.com wrote:
> > > > @@ -475,6 +478,11 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
> > > >  static inline void
> > > >  cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
> > > >  {
> > > > +	st->target = prev_state;
> > > > +
> > > > +	if (st->rollback)
> > > > +		return;
> > > 
> > > I'm thinking that if we call rollback while already rollback we're hosed
> > > something fierce, no?
> > > 
> > > That like going up, failing, going back down again, also failing, giving
> > > up in a fiery death.
> > 
> > Ooh, is this a hack for _cpu_down():
> > 
> > 	ret = cpuhp_down_callbacks(cpu, st, target);
> > 	if (ret && st->state == CPUHP_TEARDOWN_CPU && st->state < prev_state) {
> > 		cpuhp_reset_state(st, prev_state);
> > 		__cpuhp_kick_ap(st);
> > 	}
> > 
> > Where cpuhp_down_callbacks() can already have called cpuhp_reset_state() ?
> 
> Yes, it is now possible that this function will be called twice during the
> rollback. Shall I avoid this and treat the case above differently ? i.e. "if we
> are here, state has already been reset, and we should only set st->target".

Not sure, but a comment would be useful :-)
