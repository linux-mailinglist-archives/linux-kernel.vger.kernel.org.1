Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B42FD7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404105AbhATSA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389565AbhATRyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:54:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0949BC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UaCoCKDs1OtKoxMLsbGvffQe4BHvSYXwY3luYlOzauA=; b=ddBRiym1BIuFobGhRcJ5btSCOJ
        RUxiKGRfr++ywkVjyJy7u343stDzM21MbgYWafKfK+NZP80waHz08h5uj0C7/y0eQkPnSaPJlSL8o
        rMynpDfbnJLGI0oP+sxTLPZnU1pObctxB+PNy8MUmd/m1Akf7CP0Uc6Xk/BA57mjEiTTPCaaPTFEg
        xb82SkWzI0Nu9MdBjoDvHQOAr/D1OfULnARkwqnCCpS3HpKdUa4Crn1GCEdMX0PzrEgQHFhirgDe5
        qp0m352zJglZ5PU1PxCmykHxd6R1YBdSetXrdUQmYveekASbWw+stFxY0eOTjLJ8MXetxBspQ7zS4
        WF7erbSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2Hfh-00G12j-Jo; Wed, 20 Jan 2021 17:53:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EA1C303271;
        Wed, 20 Jan 2021 18:53:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30C4C2CEAD1A3; Wed, 20 Jan 2021 18:53:33 +0100 (CET)
Date:   Wed, 20 Jan 2021 18:53:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     vincent.donnefort@arm.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 3/4] cpu/hotplug: Add cpuhp_invoke_callback_range()
Message-ID: <YAhuHdcfKnyWKdka@hirez.programming.kicks-ass.net>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
 <1610385047-92151-4-git-send-email-vincent.donnefort@arm.com>
 <YAhsLPLXg37fs/BA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAhsLPLXg37fs/BA@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 06:45:16PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 11, 2021 at 05:10:46PM +0000, vincent.donnefort@arm.com wrote:
> > @@ -475,6 +478,11 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
> >  static inline void
> >  cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
> >  {
> > +	st->target = prev_state;
> > +
> > +	if (st->rollback)
> > +		return;
> 
> I'm thinking that if we call rollback while already rollback we're hosed
> something fierce, no?
> 
> That like going up, failing, going back down again, also failing, giving
> up in a fiery death.

Ooh, is this a hack for _cpu_down():

	ret = cpuhp_down_callbacks(cpu, st, target);
	if (ret && st->state == CPUHP_TEARDOWN_CPU && st->state < prev_state) {
		cpuhp_reset_state(st, prev_state);
		__cpuhp_kick_ap(st);
	}

Where cpuhp_down_callbacks() can already have called cpuhp_reset_state() ?
