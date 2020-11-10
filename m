Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2E32AD326
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgKJKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJKGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:06:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB7BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AiYQx2/W48bocrVfmfNOIV8CGrpg/36Uno8XRiWA07w=; b=F0a3XSfk4Aiz2SJvGAUQga/ZP3
        saYnp7cnOaBwC8kkGTsRs5bDuqQe7fHjnIxGO1nXon71UOyX/hJo45ja5VNoZdS4yoGdtGfRdk/qu
        54LNl0eIv3n7A4WntMG7/QtbY4BnIU5Fv+etaRitS94dPainn04TOC0GGxscM33i3F0MtDiBoWn6X
        l+hLnSsHrswI+KgeQ738PsXzqr55BzClVimcc3xIemFrv6NgMBPBDyGEukXzi7iWnxKVVL0CJYcFY
        baoMrayGNDSIroCKK7g6GjImKFQnCJydEELEu+84H4fvDN/fkHiRqrhimGDQqFm4VXDHj+HyCcyO0
        0axOdjwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcQXu-0000WE-Cu; Tue, 10 Nov 2020 10:06:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FD7E307197;
        Tue, 10 Nov 2020 11:06:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 226D9203DBF59; Tue, 10 Nov 2020 11:06:35 +0100 (CET)
Date:   Tue, 10 Nov 2020 11:06:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 1/7] static_call/x86: Add __static_call_returnl0()
Message-ID: <20201110100635.GB2594@hirez.programming.kicks-ass.net>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110005609.40989-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:56:03AM +0100, Frederic Weisbecker wrote:

> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index 695da4c9b338..055544793430 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -136,6 +136,9 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
>  
>  #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
>  
> +extern int __static_call_return0(void);
> +extern long __static_call_returnl0(void);
> +
>  extern int __init static_call_init(void);
>  
>  struct static_call_mod {
> @@ -187,6 +190,9 @@ extern int static_call_text_reserved(void *start, void *end);
>  
>  #elif defined(CONFIG_HAVE_STATIC_CALL)
>  
> +extern int __static_call_return0(void);
> +extern long __static_call_returnl0(void);
> +
>  static inline int static_call_init(void) { return 0; }
>  
>  struct static_call_key {
> @@ -234,6 +240,9 @@ static inline int static_call_text_reserved(void *start, void *end)
>  
>  #else /* Generic implementation */
>  
> +static inline int __static_call_return0(void) { return 0; }
> +static inline long __static_call_returnl0(void) { return 0; }
> +
>  static inline int static_call_init(void) { return 0; }
>  
>  struct static_call_key {
> diff --git a/kernel/static_call.c b/kernel/static_call.c
> index 84565c2a41b8..3cb371e71be6 100644
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -438,6 +438,16 @@ int __init static_call_init(void)
>  }
>  early_initcall(static_call_init);
>  
> +int __static_call_return0(void)
> +{
> +	return 0;
> +}
> +
> +long __static_call_returnl0(void)
> +{
> +	return 0;
> +}
> +
>  #ifdef CONFIG_STATIC_CALL_SELFTEST
>  
>  static int func_a(int x)

So yes, we need the out of line copy, but why do we need the int/long
variants?

AFAICT we only need the long version and can cast it to whatever we need
(provided the return value is no bigger than long).
