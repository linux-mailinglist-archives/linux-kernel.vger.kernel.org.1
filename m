Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80822FA25F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404658AbhARN7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392516AbhARN65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:58:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDB3F221F8;
        Mon, 18 Jan 2021 13:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610978296;
        bh=Jv+/ic8MieJ+imJs/fPrDMAK7Rsj4IywG6Sv8RufHjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JW/WYsnGqy3pyHXPjuT/NK/TcYZtoJzWZOoIQH4TDZqcwOC5yzmD5gyBTfOZSU/5t
         vNGGOmyf0CrmicKTMMfQNeXJ4txRu97rIJOZv9bu2Lfn6qpfvdlFYml3WlW6yezXKS
         /nb6mpAIJT7YCgv+QejO0OuQ1QR5fVyKuXSCUqRttStO6tFS79PyGXnpZK0LWAD9Ep
         PWC+1faTVtDe2BzcD8Yxk2C+DcSEwGEZmm8qQrFePiBw04FWUVQxer+aFfp/JzSM29
         Dn7b56cKhUMH9hewOZijt4dVrU7ougU0OOXX8PZvlfDNj1od/SLt1jA+MUiqhe5w0c
         it4pUdNACuBkA==
Date:   Mon, 18 Jan 2021 14:58:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 4/7] preempt/dynamic: Provide cond_resched() and
 might_resched() static calls
Message-ID: <20210118135814.GB123015@lothringen>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-5-frederic@kernel.org>
 <20201110103909.GD2594@hirez.programming.kicks-ass.net>
 <20201110104833.GP2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110104833.GP2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:48:33AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 10, 2020 at 11:39:09AM +0100, Peter Zijlstra wrote:
> > Subject: static_call: EXPORT_STATIC_CALL_TRAMP()
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Tue Nov 10 11:37:48 CET 2020
> > 
> > For when we want to allow modules to call the static_call() but not
> > change it.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> > @@ -269,6 +281,9 @@ static inline int static_call_text_reser
> >  	return 0;
> >  }
> >  
> > +#define EXPORT_STATIC_CALL_TRAMP(name)
> > +#define EXPORT_STATIC_CALL_TRAMP_GPL(name)
> > +
> >  #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
> >  #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
> 
> Hurmph, this hunk is wrong, it should export the KEY in both cases :/
> 
> That's unfortunate but unavoidable I suppose.

Right, AFAICT static_call() refers to both key and tramp in any case.
