Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C2B2AD40D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgKJKsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:48:40 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6AEC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7hRiO61jTd6++gC2sRoNgPRXgLjsaHKspPuBUlYCNJ8=; b=GSPXiRXWBe4NcDHmVnY4GkXZ88
        RVIIAr5CFlGhJ7c0GJRo6PBkjFb3qnS+Vm2cQEyOYPHzhVae7fOkkvU/904x+A7kuGwXpn8HWqqYZ
        Fx5eCJSbqIk8a0YOwH/13dVi0M73aiQnmvetprD5iha9tnElkmoiagnUn7FELcd6Iy+t+xhF5VNfc
        ogls8Hw++GQDTFoFPP379wOMygf3XvERJRS0KKMlNBoMwPslW+nIjbAtcmPZ0i6YLlgKJUB0Kpvu1
        RygGGcbEUiPzK/axqljtIzhgoN3YWacyYY1kObMnbiOcCATlBI8etdarvt5fVajZJsweus25ER44O
        6Wib08vA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcRCU-0006uG-Ef; Tue, 10 Nov 2020 10:48:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3452F3006E0;
        Tue, 10 Nov 2020 11:48:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 201442B81AAA5; Tue, 10 Nov 2020 11:48:33 +0100 (CET)
Date:   Tue, 10 Nov 2020 11:48:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 4/7] preempt/dynamic: Provide cond_resched() and
 might_resched() static calls
Message-ID: <20201110104833.GP2651@hirez.programming.kicks-ass.net>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-5-frederic@kernel.org>
 <20201110103909.GD2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110103909.GD2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:39:09AM +0100, Peter Zijlstra wrote:
> Subject: static_call: EXPORT_STATIC_CALL_TRAMP()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Nov 10 11:37:48 CET 2020
> 
> For when we want to allow modules to call the static_call() but not
> change it.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> @@ -269,6 +281,9 @@ static inline int static_call_text_reser
>  	return 0;
>  }
>  
> +#define EXPORT_STATIC_CALL_TRAMP(name)
> +#define EXPORT_STATIC_CALL_TRAMP_GPL(name)
> +
>  #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
>  #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))

Hurmph, this hunk is wrong, it should export the KEY in both cases :/

That's unfortunate but unavoidable I suppose.
