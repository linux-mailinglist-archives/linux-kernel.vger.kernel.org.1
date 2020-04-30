Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5A1BF41C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 11:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD3J1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 05:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgD3J1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:27:13 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDBCC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7cPRxJu+EyhIAY+ftHuzc0AbhzQQwoOVPsr7HZ0bIDM=; b=ffzpgUFUKJ0+SYn01RB34WtWAp
        JBBdeuxuwp84NG/VuXaYYndIfklyTRcbe1MKAY+NWgF82Q30KlKWzYYd2ISXjU2GT7kZNp9mdodKw
        SiVapQcR9WAn6kz+ihwRTMEOe5NqDJdI5aroWPse6Ei7A3Uw8ijT1rFaLX+31rLGIEOO079UElyIH
        UG740O68etbTKvVOAudavegXtJh+0RMgLyU1+7qCfzvpzHRnQ8S2xbrSCLCoskwT9nU99dmX5ndtF
        BMc55wpC0hMh4IpNOIvJEMQsRkig/OQsYLxSfw/sxqnOjYEOdJaGiL5z7VXiowlWWPO3zt7hgZKa/
        rtgXjOcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jU5T0-0002CN-In; Thu, 30 Apr 2020 09:26:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06189301224;
        Thu, 30 Apr 2020 11:26:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEC99213923B9; Thu, 30 Apr 2020 11:26:48 +0200 (CEST)
Date:   Thu, 30 Apr 2020 11:26:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH 1/7] rbtree: Add generic add and find helpers
Message-ID: <20200430092648.GB13616@hirez.programming.kicks-ass.net>
References: <20200429153258.563269446@infradead.org>
 <20200429153549.006661686@infradead.org>
 <20200430010405.GA237715@google.com>
 <20200430084617.GQ13592@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430084617.GQ13592@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:46:17AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 29, 2020 at 06:04:05PM -0700, Michel Lespinasse wrote:

> > - Have you considered passing a cmp() function to rb_add() and
> >   rb_add_cached(), and having these test cmp() < 0 rather than less() ?
> >   I figure every user will need to have a cmp() function, so it'd be
> >   nicer if they didn't also need a less() function, if the generated
> >   code is similar (if you checked and rejected it because of bad code,
> >   please just say so).
> 
> I did consider it; in fact I my original helpers had that.
> 
> The reaosn I went with less() over cmp() is that the add() vs find()
> function signatures:
> 
>   bool (*less)(struct rb_node *, const struct rb_node *);
>   int (*cmp)(const void *, const struct rb_node *);
> 
> differ anyway in the left-hand argument; this is 'fixable' when you
> use an (on-stack) dummy object for find (as uprobes does), but that
> doesn't always work, esp. when the object is big. And given you need two
> functions anyway, I figured it was useful to name them differently.
> 
> If you've looked at the other patches a bit, you'll see I've implemented
> both functions as 'trivial' wrappers around a single compare function in
> many cases.

I just realized I'd already done all this at some point ;-) See
rbtree_latch.h. Clearly I failed to realize the full potential back when
I did that.
