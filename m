Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302AD2CB685
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgLBIOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:14:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D3BC0613CF;
        Wed,  2 Dec 2020 00:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=goXv1X55FeNcthEXSTM2hTNgFnrwc8DRA9NRAxxJ9fY=; b=MWJQph8oF76dxZGMyk2WAci2tN
        EgRW9hCKEAH405eSqlzCKoWkXKOIU0ug+Pj+sAAJpUOLOnhVMjlepNsVFqAuZydtOuu7hyvFSFyg6
        LLQK2jrxyGM2OAewJos+4ITQ7YsuEGtTZEufSDgNGRfzZ0DTiGJpQt1tXOwFpg+7c4HSBF611bSaH
        xbfZMOzCqC8KW2mdTj7voJNFC3EodSosa9/YqqGkVJXQwP7ieeCjpIrqIFhBtXh2fAYCIx8D5pzVR
        VTxD+7Lcl2bk1qjqbz1zqpLG85bHEb0ke/lWo5+gghFX9JS6uVP7dRJGqqiITT2bKEm2Mw0cycdN2
        0081ECBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkNG8-0004uk-S3; Wed, 02 Dec 2020 08:13:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 941303035D4;
        Wed,  2 Dec 2020 09:13:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B8442C87A737; Wed,  2 Dec 2020 09:13:07 +0100 (CET)
Date:   Wed, 2 Dec 2020 09:13:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/16] completion: drop init_completion define
Message-ID: <20201202081307.GE3021@hirez.programming.kicks-ass.net>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
 <e657bfc533545c185b1c3c55926a449ead56a88b.1606823973.git.mchehab+huawei@kernel.org>
 <20201201125445.GW2414@hirez.programming.kicks-ass.net>
 <20201201150249.56132775@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201150249.56132775@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 03:03:01PM +0100, Mauro Carvalho Chehab wrote:

> [PATCH] completion: drop init_completion define
> 
> Changeset cd8084f91c02 ("locking/lockdep: Apply crossrelease to completions")
> added a CONFIG_LOCKDEP_COMPLETE (that was later renamed to
> CONFIG_LOCKDEP_COMPLETIONS).
> 
> Such changeset renamed the init_completion, and add a macro
> that would either run a modified version or the original code.
> 
> However, such code reported too many false positives. So, it
> ended being dropped later on by
> changeset e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks").
> 
> Yet, the define remained there as just:
> 
> 	 #define init_completion(x) __init_completion(x)
> 
> Get rid of the define, and return __init_completion() function
> to its original name.
> 
> Fixes: e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks")

Thanks! should show up in tip/locking/core soonish..

> diff --git a/include/linux/completion.h b/include/linux/completion.h
> index bf8e77001f18..51d9ab079629 100644
> --- a/include/linux/completion.h
> +++ b/include/linux/completion.h
> @@ -28,8 +28,7 @@ struct completion {
>  	struct swait_queue_head wait;
>  };
>  
> -#define init_completion_map(x, m) __init_completion(x)
> -#define init_completion(x) __init_completion(x)
> +#define init_completion_map(x, m) init_completion(x)
>  static inline void complete_acquire(struct completion *x) {}
>  static inline void complete_release(struct completion *x) {}
>  
> @@ -82,7 +81,7 @@ static inline void complete_release(struct completion *x) {}
>   * This inline function will initialize a dynamically created completion
>   * structure.
>   */
> -static inline void __init_completion(struct completion *x)
> +static inline void init_completion(struct completion *x)
>  {
>  	x->done = 0;
>  	init_swait_queue_head(&x->wait);
> 
