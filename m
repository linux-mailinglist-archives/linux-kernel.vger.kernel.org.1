Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62928CFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbgJMOJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgJMOJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:09:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7FCC0613D0;
        Tue, 13 Oct 2020 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RNXfW7bYul2Z/mtjXLdjVi6iWtUSkZlWaQ+v8KBn4Fk=; b=IK7mrbZFjQLDdDpSvV3gsLJXmh
        GVLHH/oF51gzt7h1QYJ6663ShxzQZKGnQY7clmJ7yeuYGa0+7+9C3miPFYram+16nDjzrZIVn2fTI
        Pec+FD7hkbjNbwKX6Xtgxw1dX4YW4XqX6gIi15/rh0EPkYsOqwALBLF4WS6eHvp60s7kjC6tfp2CC
        igHQwKA4SNDk4AMbqpsaWWLBhF8w6H7lDUgekDuM5b7Wv7/zfSQEfBI7Q7hBUTS/phs2p666SIMCL
        vGO+eG+hXZJtUGlRVtcwj+iqi/xPv3Lf/QvFZhZgqhyqaDFi9Xe0iKi6UDVmWHdA2jwj99Vlkp0Dg
        w/kBBHOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSKzn-0003uh-Vg; Tue, 13 Oct 2020 14:09:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51E90300DB4;
        Tue, 13 Oct 2020 16:09:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EA042C619756; Tue, 13 Oct 2020 16:09:41 +0200 (CEST)
Date:   Tue, 13 Oct 2020 16:09:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/24] docs: lockdep-design: fix some warning issues
Message-ID: <20201013140941.GC2594@hirez.programming.kicks-ass.net>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <c76318f859a78adb80a6eef63c5c777d05501198.1602590106.git.mchehab+huawei@kernel.org>
 <20201013125206.GU2611@hirez.programming.kicks-ass.net>
 <20201013131116.GG20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013131116.GG20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:11:16PM +0100, Matthew Wilcox wrote:
> On Tue, Oct 13, 2020 at 02:52:06PM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 13, 2020 at 02:14:31PM +0200, Mauro Carvalho Chehab wrote:
> > > +   =====  ===================================================
> > > +   ``.``  acquired while irqs disabled and not in irq context
> > > +   ``-``  acquired in irq context
> > > +   ``+``  acquired with irqs enabled
> > > +   ``?``  acquired in irq context with irqs enabled.
> > > +   =====  ===================================================
> >
> > NAK!
> 
> You're seriously suggesting that:
> 
> -   ===  ===================================================
> -   '.'  acquired while irqs disabled and not in irq context
> -   '-'  acquired in irq context
> -   '+'  acquired with irqs enabled
> -   '?'  acquired in irq context with irqs enabled.
> -   ===  ===================================================
> +   =====  ===================================================
> +   ``.``  acquired while irqs disabled and not in irq context
> +   ``-``  acquired in irq context
> +   ``+``  acquired with irqs enabled
> +   ``?``  acquired in irq context with irqs enabled.
> +   =====  ===================================================
> 
> this change makes the lockdep docs less readable?

Definitely makes it harder to read for me. My C trained eyes go WTF at
seeing it, which breaks the flow. ',' is a regular single character
constant, '','' a syntax error.

> It's not the markup that makes the lockdep documentation hard to
> understand.

I'm not sure what you're alluding to, the subject just isn't easy to
begin with.

Over all I'm tempted to just convert the whole thing to .txt and avoid
all the RST shit entirely.
